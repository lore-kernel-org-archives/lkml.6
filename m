Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5bx9H9krHFv9ZgAAmS7hNA
	; Sat, 09 Jun 2018 19:34:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6294D608C1; Sat,  9 Jun 2018 19:34:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSnRzrsd"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EA8FE601D3;
	Sat,  9 Jun 2018 19:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA8FE601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753982AbeFITeq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 15:34:46 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35392 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753082AbeFITep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 15:34:45 -0400
Received: by mail-ua0-f194.google.com with SMTP id s13-v6so7621808uad.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 12:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kDW+NgGTNSxZVvWlzcqwPttXkR6x/1kngTaVgBWnfTw=;
        b=PSnRzrsdOtlGN7K1n8FiSH9PC31fzlYtwk1PGv2tROEiQAXN85d5QWDVxTJGquFREp
         Iwk/qrribbsEYD41EAyjcS2K/6Gl/Bbd19LLL3K18c5jaXXvdp/50fzCCAUwyDC73XpU
         W/wCyYvcMfkltsszm4uDcEABewjYyH3TlhKnUePTbQFvVlghUo0BDLtRJpPKYS6FHDjh
         pA8fvBoSfmWuKgaBf4fIy/oXt/UK15jQEy1TchH3Hko4Rl3VyIr/WBuOfpUEYp2rp8/u
         C1S4RDsO07dMJTxZwQa5lXGLtBHhA2Hj/+vznXIbyQCHD6tntbAjynM77jPssE8eQ+Tz
         yqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kDW+NgGTNSxZVvWlzcqwPttXkR6x/1kngTaVgBWnfTw=;
        b=IizCI8MgudeA2fo6q4G54Jwx8neiRrB1Ti011cYYgXHkec5zloFGO0l65IPGTDw3nx
         D9sa4H/mmwru0n+6NBev2Fe/W5FivHBAm+Yn5EpnoObK3N8y4iq3d63eF75MluFG66sr
         DNCgyXuykNkWiAH7dAZXiFn3ymFwivHZwDFJ9tPKzY0e+9ZXeDD6Efg1OkMCBHYSJguf
         whdFbz/B75Fg1Qt1H63SBAXRz4q0UBaFPpdKYHMMhF7p2xdtQSUKCoT0Y/4EaEfYYkQ/
         sddOqvv+723kuLPTcB6wwPzj9KeCIjcnfG2mjpmGxc32DXhpzQQZsL2AJIFJjHP/u3rP
         +raA==
X-Gm-Message-State: APt69E1kiowlwBPDcyXhnXNaiDRa4kpANIOwM/YBSSj113CLfaG5XgFc
        lXDmL0VhJjWYf9M+jbcWX61ZNyZLh/WHfQXF0dU=
X-Google-Smtp-Source: ADUXVKKeezEAOFJ95pdk6kvntmkU/+7gpMUeMa3Kyzw9wzmDsdky68dPPMqge4ApHs2ldwrp9m9s9dCZIU11A5BnM2w=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr7525557uae.12.1528572884419;
 Sat, 09 Jun 2018 12:34:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 12:34:43 -0700 (PDT)
In-Reply-To: <ddb00f65153abf3dfe81d9da86c9b98c@codeaurora.org>
References: <20180609163829.30619-1-vasilyev@ispras.ru> <ddb00f65153abf3dfe81d9da86c9b98c@codeaurora.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 9 Jun 2018 22:34:43 +0300
Message-ID: <CAHp75VdkDCCJCqBTGsPCzaCKfT_bqYNGDQekvr56U3fhR+uthA@mail.gmail.com>
Subject: Re: [PATCH] staging: rts5208: add check on NULL before dereference
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Gaurav Pathak <gauravpathak129@gmail.com>,
        Hannes Reinecke <hare@suse.de>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 9, 2018 at 7:58 PM,  <okaya@codeaurora.org> wrote:
> On 2018-06-09 12:38, Anton Vasilyev wrote:
>>
>> If rtsx_probe fails to allocate dev->chip, then NULL pointer
>> dereference occurs at rtsx_release_resources().
>>
>> Patch adds checks chip on NULL before its dereference at
>> rtsx_release_resources and passing with dereference inside
>> rtsx_release_chip.
>>
>> Found by Linux Driver Verification project (linuxtesting.org).

> I think you should bail out if dev->chip is null rather than adding
> conditiinals.

I'm wondering if it's false positive. At which circumstances that may happen?

-- 
With Best Regards,
Andy Shevchenko
