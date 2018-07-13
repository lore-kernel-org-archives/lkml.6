Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E982ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77792084A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIwznp45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77792084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbeGMTNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 15:13:09 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35632 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731542AbeGMTNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 15:13:08 -0400
Received: by mail-lf0-f65.google.com with SMTP id f18-v6so11884673lfc.2;
        Fri, 13 Jul 2018 11:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=P5bwKP90FxuGsbIamriATsUfx03y6err+e3eZI9BP/s=;
        b=IIwznp45gcyz6TQtsRwi0gf4tJ1Ibl9s4U0M5EaG0+VbZ13pActolxSZgA8X54lUER
         VYOu6M1+GZ1HgMahMzVCt6MGVmb1HeOMO5iDliuqxlVrIFaTdtJrPNpuwuCXDd50dC8e
         SZor50z/ZkENUgPr8O/ok2MjVs5v6zr5UhcUZewaAYDbeJx0FQZxT/uQyElUGUUnPMuW
         M7xQhsrcdQw5eDI8ZgoHl+mqTqWmHc1VsDWDLQzuonkOh/avySLehPk2xeols7VzB7/T
         F5XvShcDGLlHC0iR5N5tlHVjyH9iGOfid7rfvcFoutYMayYDMWc4fMJbnPvieurzhtA3
         4aHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=P5bwKP90FxuGsbIamriATsUfx03y6err+e3eZI9BP/s=;
        b=F3XvtvlfbXwPY/Qs7GBFdyiUEXQl0YM5fbXPdJdjzU9ZFq4SfzCWCFdQqO3QvaTBAX
         XCW8di7QVpYcY0SRPeribpjTovSHUfSHOfTXqjIsDdNnxpsRIkW08f9q7PVxm1tuYSn1
         WjReABlWaec+iABboJgJtsersj/1SPla5IsXuUZysq320glBfs266My86CwbH9SkTfrI
         1OeB6BVXy250V7foNT0CJ4NYLsnAVChptNyCHleBH4SmJcuEk6O4JPdXds7OwVwr4IZu
         Gpi5MZqkZZXiOK97ocaJZJk2O3lVwei+scNXOxIZkdTbQA81c+L6gsaKZ4pyHlutA+99
         PTRw==
X-Gm-Message-State: AOUpUlF5K1TPAv1UO0oP21x1M8G2CIlZxdKJ2lHD/jcwVFya3svu0E9T
        ms4NXoVlrS1dMSNABx1Avlnb1tm1Dn8eyOx9bAU=
X-Google-Smtp-Source: AAOMgpfgH07CtoKj4rJhXgDXP8cyXoYWt9JB4wWRoSKWyZ9qq6guQS8UgLccvCGQoeE1Kr0EM1GqcG2VFagjBu7CqHg=
X-Received: by 2002:a19:a705:: with SMTP id q5-v6mr6201471lfe.148.1531508234518;
 Fri, 13 Jul 2018 11:57:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 11:57:13
 -0700 (PDT)
In-Reply-To: <83724892-de0f-40ff-e16a-792a90d77ff1@suse.de>
References: <20180622134907.227131-1-arnd@arndb.de> <b5de0a86-b3cd-9e45-ac39-9c4eb7611016@suse.de>
 <CAK8P3a3FULT7uakRyZ4Nfq3E-ij+Gkn06=XP4Rn2m9u4Wd2OWA@mail.gmail.com> <83724892-de0f-40ff-e16a-792a90d77ff1@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 Jul 2018 20:57:13 +0200
X-Google-Sender-Auth: AlGBCZrjuhL-Il6roEucg5M4dqY
Message-ID: <CAK8P3a0GDUpXQ8WnS6ake2AuAu0Q1gZg+hFQVPgXCBqQ1sS+jw@mail.gmail.com>
Subject: Re: [PATCH] [v2] bcache: stop using the deprecated get_seconds()
To:     Coly Li <colyli@suse.de>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Michael Lyle <mlyle@lyle.org>,
        Tang Junhui <tang.junhui@zte.com.cn>,
        Hannes Reinecke <hare@suse.com>, linux-bcache@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 5:34 PM, Coly Li <colyli@suse.de> wrote:
> On 2018/7/13 10:20 PM, Arnd Bergmann wrote:
>> On Sat, Jun 23, 2018 at 10:12 AM, Coly Li <colyli@suse.de> wrote:

>>> Added to 4.19 for-next.
>>
>> I noticed this isn't part of linux-next (yet). Did it get dropped?
>>
>>       Arnd
>>
> Hi Arnd,
>
> It is here,
> https://git.kernel.org/pub/scm/linux/kernel/git/colyli/bcache-patches.git/tree/for-next/0004-bcache-stop-using-the-deprecated-get_seconds.patch

Ok, thanks for the confirmation!

> It is for Linux v4.19, the merge window is not available yet, and I
> don't post them to Jens yet.

That sounds like an odd way to handle your patches. Normally all patches
should be part of linux-next *before* the merge window so they get tested
as part of the linux-next kernel before the pull request to Linus is sent.

It's not important for me for this particular patch, but generally speaking,
the Documentation/process/2.Process.rst states:

"all patches merged during a given merge window should really have found
their way into linux-next some time before the merge window opens."

      Arnd
