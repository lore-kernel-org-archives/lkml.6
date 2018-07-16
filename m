Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EE2ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8512098A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvKLqHfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8512098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbeGPVsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:48:12 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:46041 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeGPVsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:48:12 -0400
Received: by mail-yb0-f194.google.com with SMTP id h127-v6so15993763ybg.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 14:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LTJDll4DeaxHH2pBvgHfTa15N7od/nEhh36vPRD+geg=;
        b=jvKLqHfn/NyQVzOPGuPVC1rI4F0S/A+XWB3mfoaTtuWkZFzz9P/ZREtXl6w8jF23Lq
         tVBtQlFqKlqkCzIT6BS13fR4DeVtwsKd2+TM+DeWisMcj40rtUssaHJba5u1mvsz1Gb7
         GSmOucxy2HCdZ05j/EAggiOvPjeklw3NGASAbYV0dFGdkxnDDQeE3CAsAAY/yZAiye2c
         TgRF8bqEk1RzVAZh8rYOUIC5X/ue7gmzFYEtQ+bMrm4YWcnixrfqXTGp3BGE1T2MRkbG
         u/Q64Y3r7X4cWRyBhhW/mwuFB9Dp4h1Hn0po26T5LjwhOlDY/ZUe0DpOhUuZQtNk5WRs
         R12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LTJDll4DeaxHH2pBvgHfTa15N7od/nEhh36vPRD+geg=;
        b=hi9EULf0IMKK7wnCMJC345x/cnQtLoQ8ksPOcuV9u060Y3oLcWZT1TrNJys/AXUrn7
         UujKvewFUZYpoWkaRYL3SXkYS5x7T3799/bthATU4EpDNjNqPD7YLXggVghH10POIbNT
         o71czxxGWWly/T730vbHKsrsw6YMQSuIWFIHgl6/fT38A63S6Ll09N3eaizTrhjumc0b
         qDyfuppxxTqii+Wo3qdsLEgIDTKd6SBc53t6T6DEy8Q5Mv8/RhNa5z8aL3BHicsdED4l
         9Hm4m6FfMi3MTNFZoAe3BpkoDIgZpqCuY7y92kQIhUXky1mp36LL7Hqq7W9iZB3CHq2C
         /1Mg==
X-Gm-Message-State: AOUpUlE6ZIYzJbXX40ik+QIkM3MSNawOdg9nDdK4TYPaJsMfKZtgS0Jc
        zx24znuCKc1szc/GSG5SU2vJWmn127lAdfvbFTY=
X-Google-Smtp-Source: AAOMgpergXuWjQ+Gk6v9Fu/hUyWNyDt5nVPPfCU5yVQIRVBk0zxwBWSczDLmxnIn9b0L+lNrzzAHMZ1uPNMKbF8e8ks=
X-Received: by 2002:a25:d181:: with SMTP id i123-v6mr4846482ybg.489.1531775937573;
 Mon, 16 Jul 2018 14:18:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5e42:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 14:18:57
 -0700 (PDT)
In-Reply-To: <CAE_wzQ_b5QLn7Fs_YDoOXSt=c+_uJobtG=fSda84qcwWfe2fTQ@mail.gmail.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com> <20180714055816.223754-11-toddpoynor@gmail.com>
 <CAE_wzQ_b5QLn7Fs_YDoOXSt=c+_uJobtG=fSda84qcwWfe2fTQ@mail.gmail.com>
From:   Todd Poynor <toddpoynor@gmail.com>
Date:   Mon, 16 Jul 2018 14:18:57 -0700
Message-ID: <CAO3upoaVndarVwJMFAedM8hUSW_swEZc0oRMd1UWjZb8hMeq4Q@mail.gmail.com>
Subject: Re: [PATCH 10/18] staging: gasket: gasket_open use container_of()
To:     Dmitry Torokhov <dtor@chromium.org>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhongze Hu <frankhu@chromium.org>,
        Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
        Todd Poynor <toddpoynor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2018 at 1:15 AM, Dmitry Torokhov <dtor@chromium.org> wrote:
> On Sat, Jul 14, 2018 at 8:58 AM Todd Poynor <toddpoynor@gmail.com> wrote:
>>
>> From: Todd Poynor <toddpoynor@google.com>
>>
>> Use container_of(), drop unnecessary NULL check.
>>
>> Reported-by: Dmitry Torokhov <dtor@chromium.org>
>> Signed-off-by: Zhongze Hu <frankhu@chromium.org>
>> Signed-off-by: Todd Poynor <toddpoynor@google.com>
>> ---
>>  drivers/staging/gasket/gasket_core.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
>> index ffd6ce801313..0c45c54254fb 100644
>> --- a/drivers/staging/gasket/gasket_core.c
>> +++ b/drivers/staging/gasket/gasket_core.c
>> @@ -1099,12 +1099,9 @@ static int gasket_open(struct inode *inode, struct file *filp)
>>         const struct gasket_driver_desc *driver_desc;
>>         struct gasket_ownership *ownership;
>>         char task_name[TASK_COMM_LEN];
>> -       struct gasket_cdev_info *dev_info = gasket_cdev_get_info(inode->i_cdev);
>
> Are there other users of gasket_cdev_get_info()? if this was the only
> one we should remove the macro,otherwise we should convert them as
> well.

No other users, I'll add a patch to remove it, thanks.

>
>> +       struct gasket_cdev_info *dev_info =
>> +           container_of(inode->i_cdev, struct gasket_cdev_info, cdev);
>>
>> -       if (!dev_info) {
>> -               gasket_nodev_error("Unable to retrieve device data");
>> -               return -EINVAL;
>> -       }
>>         gasket_dev = dev_info->gasket_dev_ptr;
>>         driver_desc = gasket_dev->internal_desc->driver_desc;
>>         ownership = &dev_info->ownership;
>> --
>> 2.18.0.203.gfac676dfb9-goog
>>



-- 
Todd
