Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64EAC46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6221220827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwOpwpeV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6221220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeKHSFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:05:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52745 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeKHSFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:05:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id r11-v6so344719wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 00:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LxAmM3G9OkFkIRy3Xv3CcBoUjJ+UpMu9hO52XJNc7/o=;
        b=AwOpwpeVV5E9Hf1AlRxT/Y65DaygmM1l0FxYn1psGU1rd9Q02LNEfpZq6oOykchIJg
         0hK15ngHI9/xFuUbUb2Cvc7xwTH6xanYRRHzewsPklWHoIbcJ8vhD5Xlorus8uPMWyii
         VDxok3xhAFiuzpbVl4X4U4bRKDjh95f9M7kPapfBqnJr+OVZxo9IwL9J+p6G0sF5XU1+
         9YWXuKQStdD/lQihqA4RP5unuOztOVW8KLzEj0EW9kehc3KlAV013LYAAKET77foIdyp
         6KpZOt4y2SYX0rpyMM09jfB0nLohSrste/+WYaWFiiPpYGwpiInED8W5GHRct3xIt2BJ
         n7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LxAmM3G9OkFkIRy3Xv3CcBoUjJ+UpMu9hO52XJNc7/o=;
        b=BDnpYSu1cULgbr1KlPVHGP+U0g/nFGqAFll0tptX3JSPefkL0qqpCLrt4Du1w/wJ8R
         h54cyMnSGCCZBTByXqiRdQ/XXogNDc1oJfj/2ATJvJN3vb7XvZF+azDhWPdFf34Q4/l0
         tl6CP12yUfeHF6ZynJTrY49UfLZntQTAQIpzSM3idMCj8in7OjmtbUiDyoC9Z4zmd3M6
         solIIsb1U3dNCyMtAyS36iy9i9NGemLrbr8D8WW5vmVFXcTCD7HRGXrXmRACj4xJTxkT
         GVPThVAuoWg6cnrHWVQjcmAUPDWI+pIgU7j4JT9Iwm8F8couQA845biE0K4Utz/BRySn
         unEQ==
X-Gm-Message-State: AGRZ1gJpIz3qMPVR5lWzeze2HYR+FkB/aU4hYYkX3wlSEZes0A3alkLy
        z8POg6Aoo/S25Qqsn+4SORQ=
X-Google-Smtp-Source: AJdET5dF1NizFK/hmb4V3B1JtV7XAdW72+w0m/Co2T+PaYvSNlPcz4wfxri8kVFPwmeOf7pRC7NFzw==
X-Received: by 2002:a1c:dc42:: with SMTP id t63-v6mr330185wmg.17.1541665854446;
        Thu, 08 Nov 2018 00:30:54 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e66-v6sm6116024wmf.40.2018.11.08.00.30.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 00:30:53 -0800 (PST)
Date:   Thu, 8 Nov 2018 09:30:51 +0100
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
Message-ID: <20181108083051.GI20032@gmail.com>
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

> +Line breaks
> +^^^^^^^^^^^
> +
> +Restricting line length to 80 characters makes deeply indented code hard to
> +read.  Consider breaking out code into helper functions to avoid excessive
> +line breaking.
> +
> +The 80 character rule is not a strict rule, so please use common sense when
> +breaking lines. Especially format strings should never be broken up.

Might make sense to explain that:

  + The reason for that rule is that if for example we have this printk line:
  +
  +		if (uh_oh()) {
  +			pr_info("Something really bad happened, danger"
  +				"danger, blue smoke reported!\n");
  +		}
  +
  + People would see this message in the syslog:
  +
  +   Thu Nov  8 09:22:33: Something really bad happened, dangerdanger, blue smoke reported!
  +
  + And chances are that in sheer panic they'd type the most distinctive 
  + part of that text as a search pattern for the kernel source tree:
  +
  +   $ git grep -i 'dangerdanger'
  +   $
  +
  + ... and they'd get absolutely no match on that string due to the 
  + col80 broken format string, and confusion and frustration would rise, 
  + in addition to growing amounts of blue smoke.
  +
  + We don't want that, so just write out the single line:

  +		if (uh_oh())
  +			pr_info("Something really bad happened, danger danger, blue smoke reported!\n");
  +
  + Also note two other advantages of writing it like this:
  +
  +  - We saved two curly braces.
  +  - We also added a proper space to 'danger danger' which was the original intended message.

?

> +
> +When splitting function declarations or function calls, then please align
> +the first argument in the second line with the first argument in the first
> +line::
> +
> +  static int long_function_name(struct foobar *barfoo, unsigned int id,
> +  				unsigned int offset)
> +  {
> +
> +  	if (!id) {
> +		ret = longer_function_name(barfoo, DEFAULT_BARFOO_ID,
> +					   offset);

BTW., in this particular case I think small violations of col80 rule are 
even more readable, i.e.:

> +		ret = longer_function_name(barfoo, DEFAULT_BARFOO_ID, offset);

And note that in this example we used 78 colums so we didn't even violate 
the col80 rule. ;-)

Thanks,

	Ingo
