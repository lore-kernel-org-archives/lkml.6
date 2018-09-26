Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E523C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AF8214FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AF8214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeIZUPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:15:48 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33014 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbeIZUPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:15:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id i10-v6so17322287qtp.0;
        Wed, 26 Sep 2018 07:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pFvLeuWJCWrFfy+8e0vdWMNP8KvnZGaFZZjfIhQKoWs=;
        b=ei9+NQh1uagy9cX0a06MBXp9VtN0q7M6nKv5JY/yShaARFul8HFbJEUnnRWmbsJhc1
         +ArT08xgXvFgf2IphH8R+Vz+VkbMyuPC2GtqcG8gYHwsfjKxEJcwIhh8RIA3EtkIB/bd
         khqMpYC2nz8sR7pIeYZB4jpVZ2DKajegTC8Nw6xvYw89iKZBn7mi8uVgRu2gnpL1HRnb
         l0xU0BhrkTwG5U0V/k2YMi51PdCVvAC/rF2tufFG3RZQ3VPJRcwXIhWDakxGLWJVo6Kd
         YSJVCBf/2YdmQT6E1+xoWtsBrI1VzVlyKvN/w8m9/KCIRXGIeEJ2LGj1X+zGjQ3zu6dq
         9UTQ==
X-Gm-Message-State: ABuFfohrAEZlqZ+KAfMUKk3/d8vmS2tqRKlJbXAD7u++vcQ1tPTQA9jm
        4lNhspmveeg39GFBZ4OAEjD1vbSc/pDNZg0UjYoZnCp7
X-Google-Smtp-Source: ACcGV61m65LRHEgGV9QMjoVdol6ZsTQBUl4Je7bUtbUab0BisgW3cTFWCuKpBe5NmByGGRTddXaZQ2lZ5Xl7408dK6Q=
X-Received: by 2002:a0c:8b67:: with SMTP id d39-v6mr4282645qvc.180.1537970560711;
 Wed, 26 Sep 2018 07:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180926130139.2320343-1-arnd@arndb.de> <20180926133738.GA19690@pengutronix.de>
In-Reply-To: <20180926133738.GA19690@pengutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 26 Sep 2018 16:02:24 +0200
Message-ID: <CAK8P3a11n3yeU8=6ZEr+qSRr-hbvY3s5ayYjRriHcaaKcrp00A@mail.gmail.com>
Subject: Re: [PATCH] media: imx-pxp: include linux/interrupt.h
To:     pza@pengutronix.de
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 3:37 PM Philipp Zabel <pza@pengutronix.de> wrote:
>
> Hi Arnd,
>
> On Wed, Sep 26, 2018 at 03:01:26PM +0200, Arnd Bergmann wrote:
> > The newly added driver fails to build in some configurations due to a
> > missing header inclusion:
>
> Thank you, did you see this error on an older kernel version and rebase
> the patch afterwards?

Yes, sorry about that. I created my patch yesterday, but apparently
this was on next-20180913 rather than the current one.

     Arnd
