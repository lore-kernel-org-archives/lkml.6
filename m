Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851E7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DCB20989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBAF1ec/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DCB20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbeKUUpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:45:49 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38641 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeKUUpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:45:49 -0500
Received: by mail-io1-f65.google.com with SMTP id l14so3495506ioj.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 02:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sIhEzfzmVtc7JOHUaKshHMCch3YD98pZCL+beHOX75c=;
        b=dBAF1ec/qr6VRgYnpq6cUWHZT+K1UHbsqXJyQRilonT+xt0luIEAReySurFShiWFBC
         FcfUHotuQ6lMa32EOu+gkyaTcZ/ZzxJlZF7eVwR/dUoF14m2jI1hZNsv2PhgUzEblS/6
         rLfbCW0obHmsWr81moi2JMwJvP4yriFJHL2AqV1PC5S+HvzWVFy+GzDPGQAHjyGyNFvf
         il/wOxf1a3wLzbMBLnE08od7hDjlD3Ymw7GhSdWjq4Li/vhlBXWrxnYpZG/RC3YcwzBV
         69Ru2+rAHB5pXXZ7ol/GdgpN9zULz67MZd7FnHJOoZFIchLGEYr4t+ZhKnLYQtNmRYGb
         mCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sIhEzfzmVtc7JOHUaKshHMCch3YD98pZCL+beHOX75c=;
        b=rs/y0ojJGJT0d4Gk0uiLPRu9uVksG7OKvNYARE+S6HNhTJGNAreKO4bZ6SDLE822iy
         wTVFZ8F+mziesQIW1KWzTXj2gYE7XjFEiHo4xRlG9rMejpuTYu5g6qinwoA6TaH2fSV7
         87VZGstvkmkyD/wXx4dkRgu226AEo8IADzwW69+ZaV2cns6cJvNY6tfAwCtWy81U91S8
         ldrr3gMKXJOxAaukUk43ImEbXHj3oqCDJdkJoazMaBjoBHH4d5/jAmXkXvxEmAgrLI4M
         BO8Puz4pyxo8pqg9qIPwIn/J9hmN5H/SW2mltNOPMzIoG2XwQ+fCm2hEnTZCj4DFMzOa
         oTvQ==
X-Gm-Message-State: AA+aEWZokYDcU4epTXyiazdoPIsij5ZsfCOeTDzRCxot/qAJphUIsVQT
        KO1ex8DNmUW5yKVnGS5h1FGDEVHH4d5t7Q41bks=
X-Google-Smtp-Source: AFSGD/Xako6gKOmcTcINlCQkm3P41MlFB5j2Ak2V030eTwMGOtsMmPsWAy/hQEGAKhW2UDAcDP64q5WzezH+NZbhriM=
X-Received: by 2002:a6b:8e90:: with SMTP id q138-v6mr4778326iod.112.1542795119081;
 Wed, 21 Nov 2018 02:11:59 -0800 (PST)
MIME-Version: 1.0
References: <CAEAjamud-6uX8EmOZy7s6ubWNg=0E1YQZSGK2-SnfsomK8VnGw@mail.gmail.com>
 <CAK8P3a2SnRF9198W4W81WwzEX6yCKFjBLTtTo+97Qcym=99Akg@mail.gmail.com>
In-Reply-To: <CAK8P3a2SnRF9198W4W81WwzEX6yCKFjBLTtTo+97Qcym=99Akg@mail.gmail.com>
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Wed, 21 Nov 2018 05:11:47 -0500
Message-ID: <CAEAjamsAOJC_EqdX8nTddhN4Xis3d_D1L54Ry3sBdC8L84EdVg@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in write_port
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     gregkh@linuxfoundation.org,
        Byoungyoung Lee <lifeasageek@gmail.com>,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reply.
But I think this kind of crash can occur in real PC as well, and I'm
just thinking of some way to stop it in the first place (if possible).
because malicious users can use this, so as to make the whole system
(kernel) work incorrectly.

Thanks,
Kyungtae
