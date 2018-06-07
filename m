Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Av4IF2pcGVv8JAAAmS7hNA
	; Thu, 07 Jun 2018 16:25:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 40D52608BF; Thu,  7 Jun 2018 16:25:14 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQ1vj3P6"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 126A1607E7;
	Thu,  7 Jun 2018 16:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 126A1607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753778AbeFGQZG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:25:06 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35563 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbeFGQZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:25:04 -0400
Received: by mail-lf0-f65.google.com with SMTP id i15-v6so5315926lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 09:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XgnfgGQJtmPg/Jdscr83Nuy8q3IUy8cqBtuQBB5lXWc=;
        b=ZQ1vj3P614eR2kuMEQVcu5ekGY8CTbRdO/o71pE9CpQ8S8mzA7bZ51n0tfp1vo/Wrd
         N5EuEkJDP5oUcldI1cPjjvuHk05hMZB6KujpLOlPylPqDZNGZNJ1fkLbPW/xE07gNLG5
         8RrObJE1iCEZMG/51aLD6pQ6DAWlqeTDpeyVx4r2adD5vN82oJ+BXrBobEyuBLKil8Qw
         OpfHCIXNTrvoyesgA+xL0VUgY4MmrIXz1/zRu2O7hX5XecTAkP9YFHtWzqDKb1OlcCqi
         fNrJpKFrQGXSXIsJy+hwwGO9PhKZBnEkEBZiWKSABbNBeaRxIcLYleUzcLM9+VuqLFMK
         24ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XgnfgGQJtmPg/Jdscr83Nuy8q3IUy8cqBtuQBB5lXWc=;
        b=D3i1wuYyXjckhP+kQxUiUsusZRuyh4ZM4apsoNB0fBIdhu0MSO1RR9pSuWUiWeA98K
         DahFRJUFTg5GYrtJ5JNl/QTsJufVr+eyDbrXaWQthuyVcrMewkLIf4zDfqykG9ekByQ9
         W7KcXFkWLuf1FVx0ezDMbQyNKozzZ4TmxB6fRh0qqDF5JAZtbe8jlxGoYlc+fC1qC1uv
         pMhuD4rbv9nJE+aM4nryqPuLgZdiw6sbnsHY0YVRqv/9Jm0Kb7A7vh+7fcafsxJeWqP0
         0KHlje2DppslWKuZskDuw3Pw1/db/8HcS4qMA+pOSlHfXWuNfUOSNTR2dMQDfFzwGC1N
         d0FA==
X-Gm-Message-State: APt69E2MV7NYe0re84lUx8cmaihl/PeCZq8C2gRxIcWUpaMZwiAB44Vz
        HkuTB6xPwkXKYrDFg9abFb5yxKmEVxTlz0Poxg==
X-Google-Smtp-Source: ADUXVKIqNTc0JES+xa0akrwLIipPLOl7pBBfJRIYX1n1vFHroQpUqmhlGep/nBqsXSrnR/2IYT0gwIYlJSsXBIw28fw=
X-Received: by 2002:a2e:428e:: with SMTP id h14-v6mr2120895ljf.136.1528388703492;
 Thu, 07 Jun 2018 09:25:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:e45c:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 09:24:33 -0700 (PDT)
In-Reply-To: <CAEJqkggsjnod79HFvYQHRFEsFaN-bb27P8Xf79_9DmxhLKs_Og@mail.gmail.com>
References: <CAEJqkgiNVDzboDK1vsn9rYP0G=Q_mGDrkx1VVB8TUkm35Rs9fA@mail.gmail.com>
 <516cddbe-73c2-01f3-a552-0d9fd75ce63a@amd.com> <8f7d00f9-992f-cc07-6bd0-b1b47c5d2ccf@amd.com>
 <ae904954-18f7-180a-ce69-7e7618bd398f@daenzer.net> <CAEJqkgjErpxG44CZXn2BzvPES7Ptf24ae6748dAcYdg2n5HuZw@mail.gmail.com>
 <267c42ce-91e2-4843-3815-904ac74b2f44@amd.com> <CAEJqkggsjnod79HFvYQHRFEsFaN-bb27P8Xf79_9DmxhLKs_Og@mail.gmail.com>
From: Gabriel C <nix.or.die@gmail.com>
Date: Thu, 7 Jun 2018 18:24:33 +0200
Message-ID: <CAEJqkghgkDeZheZsFC3rJ3W5Z-5DYdqA0U+zas0voDp7kSdORg@mail.gmail.com>
Subject: Re: Kernel and ADM hardware roulette ( was AMD graphics performance
 regression in 4.15 and later )
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Jean-Marc Valin <jmvalin@mozilla.com>,
        Dave Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Well that is very interesting, you are the first one who reports that SME +
>> GFX works in some way. So far we only got negative reports for that.
>>
>>> There is a 4.16.13 boot dmesg which has no such issue:
>>>
>>>
>>> http://ftp.frugalware.org/pub/other/people/crazy/radeon/dmesg-radeon-SME-ON-kernel-4.16.txt
>>>
>>> With the setup as is booting 4.16.x works , while 4.17 trows the errors.
>>
>>
>> Please do the bisect if the patch I've mentioned above doesn't help.
>
> Ok done.. bisect points to:
>
> b468620f2a1dfdcfddfd6fa54367b8bcc1b51248 is the first bad commit
> commit b468620f2a1dfdcfddfd6fa54367b8bcc1b51248
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Mon Mar 19 11:38:19 2018 +0100
>
>    iommu/amd_iommu: Use CONFIG_DMA_DIRECT_OPS=y and dma_direct_{alloc,free}()
>
>    This cleans up the code a lot by removing duplicate logic.
>
>    Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
>    Tested-by: Joerg Roedel <jroedel@suse.de>
>    Signed-off-by: Christoph Hellwig <hch@lst.de>
>    Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>    Acked-by: Joerg Roedel <jroedel@suse.de>
>    Cc: David Woodhouse <dwmw2@infradead.org>
>    Cc: Joerg Roedel <joro@8bytes.org>
>    Cc: Jon Mason <jdmason@kudzu.us>
>    Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>    Cc: Linus Torvalds <torvalds@linux-foundation.org>
>    Cc: Muli Ben-Yehuda <mulix@mulix.org>
>    Cc: Peter Zijlstra <peterz@infradead.org>
>    Cc: iommu@lists.linux-foundation.org
>    Link: http://lkml.kernel.org/r/20180319103826.12853-8-hch@lst.de
>    Signed-off-by: Ingo Molnar <mingo@kernel.org>
>
>
> I'll try to revert this once I'm home.

I can confirm reverting b468620f2a1dfdcfddfd6fa54367b8bcc1b51248
fixes that issue for me.

The GPU is working fine with SME enabled.

Now with working GPU :) I can also confirm performance is back to normal
without doing any other workarounds.

The only app still acting up a bit is Firefox , just minor frame drops,
but nothing to bad.  ( probably an Firefox bug too )

crhomium/chrome is fine .. even with 10 tabs open , each one playing
an video on youtube no glitches at all.

Desktop is also fine now,  could not find anything wrong.


BR
