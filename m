Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030F2C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B242F20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ML5e/bHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B242F20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeKHROa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:14:30 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:44709 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKHRO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:14:29 -0500
Received: by mail-wr1-f46.google.com with SMTP id j17-v6so14940943wrq.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 23:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E0zepbe2I6n9EZ/qXBTetrsRCKJL36jojbMpCxIqrlk=;
        b=ML5e/bHNeiYFg+hfKIJXU5ZSOkPJfbI8xhZNFyTXsI+f97FJd4k0r6ltUH9ciksLDJ
         viwx2Vsil30MwDa+tUiFBtLqo4iB6cCJIdTybQWGGqT/BLle/HYAUYhFtxNxsXuA60Ys
         CSJ5WSYSpRMhGh3hMLFAXtJSJV8LF8VGmksDtHdEcGQLlkEup8rYElMwsQv7Edq/MYRv
         W1CK4elUmV1MS0cp9UgLiMJb/suJbQfmko+xzGefY0XlLSWE2GiFBdEzLaF0Vng13f5v
         9tWldQIjzP7Q60uVv2spFhTXeiHXV2YjtgVH8hjb+u0VnpQcypcQzGrFXi+DLLcr2Ssx
         kpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=E0zepbe2I6n9EZ/qXBTetrsRCKJL36jojbMpCxIqrlk=;
        b=LpDCQljT5Vtfl0b04IwEdeLeGsQONDJZ+Xq2ioKAsE87CnjRjocOGJOBm6qa0xoIXE
         ZyrXkrf8II8V9FS4J4YDdoWOpWC9nZq5QfUTjxjgkuMpPgNe0c2eEWZgQ/J0wiBPUJai
         ZzMJXSk959EIJgU/9bkyAZelVp0Emi7UfBuvJJ3ZVg/ob77LzznTRz7c6u81U6k0Tc4v
         fmcUyR5qz2YF+5MDkhyw96IdHih3V1163OwohoWB5N8r0LaoDWSsb71uagmVnpUDgYjv
         j3XOz/aZulNbqjzhpBXn+U/LzTLjCz0YjO6qczzHIn6jn59TlDKFTlENrIaS3Qm30PWY
         7BUA==
X-Gm-Message-State: AGRZ1gJQ59hi7X3IXGfPCCFu3IMvjhXAzDDrv5Ok8sHtXR13RTnyZIHI
        nlYPZ9QKqQBWTWgO3hbTJK4=
X-Google-Smtp-Source: AJdET5fLtxRKtXs5HFwhqAfkB5FudanxnTh2XByubRs5MhH3vICVbbNyrwK9MLXdjtYthN5w5cBHFQ==
X-Received: by 2002:adf:b716:: with SMTP id l22-v6mr3243656wre.157.1541662815837;
        Wed, 07 Nov 2018 23:40:15 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e8-v6sm3449534wmf.22.2018.11.07.23.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 23:40:15 -0800 (PST)
Date:   Thu, 8 Nov 2018 08:40:12 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch 2/2] Documentation/process: Add tip tree handbook
Message-ID: <20181108074012.GD20032@gmail.com>
References: <20181107171010.421878737@linutronix.de>
 <20181107171149.165693799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107171149.165693799@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> + - Signed-off-by: ``Patch handler <handler@mail>``
> +
> +   SOBs after the author SOB are from people handling and transporting the
> +   patch, but were not involved in development. If the handler made
> +   modifications to the patch or the changelog, then this should be
> +   mentioned **after** the changelog text and **above** all commit tags in
> +   the following format::
> +
> +     ... changelog text ends.
> +
> +     [ handler: Replaced foo by bar and updated changelog ]
> +
> +     First-tag: .....
> +
> +   Note the two empty new lines which separate the changelog text and the
> +   commit tags from that notice.

Even after a decade of introducing Git I still see Signed-off-by used as 
an Acked-by or Reviewed-by substitutes, so I'd suggest adding this small 
explanation as well:

  +   SOB chains should reflect the *real* route a patch took as it was 
  +   propagated to us, with the first SOB entry signalling primary
  +   authorship of a single author. Acks should be given as Acked-by 
  +   lines and review approvals as Reviewed-by lines.


> +   If a patch is sent to the mailing list by a handler then the author has
> +   to be noted in the first line of the changelog with::
> +
> +     From: ``Author <author@mail>``
> +
> +     Changelog text starts here....
> +
> +   so the authorship is preserved. The 'From:' line has to be followed by a
> +   empty newline. If that 'From:' line is missing, then the patch would be
> +   attributed to the person who sent (transported) it. The 'From:' line is
> +   automatically removed when the patch is applied and does not show up in
> +   the final git changelog. It merely affects the authorship information of
> +   the resulting git commit.

s/(transported)
 /(transported, handled)

to connect the text with the whole 'handler' language used before?

and since we are not talking about the 'git command', maybe also:

s/git
 /Git

?

> + - Cc: ``cc-ed-person <person@mail>``
> +
> +   If the patch should be backported to stable, then please add a '``Cc:
> +   stable@vger.kernel.org``' tag, but do not Cc stable when sending your
> +   mail.

Can I suggest a more canonical form:

	Cc: <stable@vger.kernel.org> # v4.18 and later kernels

It would be nice if people adding Cc: stable lines would actually try to 
figure out which exact kernel versions are affected.

Also the '<>' form makes it easier to read and my email client will also 
syntax highlight it in that case. ;-)


> + - Link: ``https://link/to/information``
> +
> +   For referring to email on LKML or other kernel mailing lists, please use
> +   the lkml.kernel.org redirector URL::

s/referring to email
 /referring to an email

> +
> +     https://lkml.kernel.org/r/email-message@id
> +
> +   The kernel.org redirector is considered a stable URL unlike other email
> +   archives.

s/URL unlike
 /URL, unlike

?

Thanks,

	Ingo
