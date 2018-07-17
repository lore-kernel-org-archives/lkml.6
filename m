Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F688ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C79E20673
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryJiadnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C79E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbeGQTic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 15:38:32 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:46544 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbeGQTic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 15:38:32 -0400
Received: by mail-yb0-f193.google.com with SMTP id c3-v6so844432ybi.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 12:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lBETwYl6sQZqmoDy1zjuIPcg5WaSGPdo5PIiwZ9uDTQ=;
        b=ryJiadnfJViqMZMoWqSCin8XJVV3KI7qe7cdK4jTB5GDBKdsDz4qww0/9nPFzVXKau
         hwfsAUsNuVCMDEvY0XzitZPmcBUiMTSjhy4KEV8qceX2a1D12HkTjOwfGfeuVB58D74/
         CGZGLVezm6bXbVfX3d2uUB77FwF6Rm+kbnnHtcdt0wuDpRNfbB0Yy57ILKAGSFD2tr6S
         OL+YOg5bqRi6Shkegi64rWNpeUCljOVdfPk1kTIAQptPvxo2l900MQFWr40wBZ7ChpTm
         84ErNlhD2pWt7Ra3Iz5g4UBvU4u7C4dUlvZpNygAwGDkeZ18Idd/0LeNqyYeb3zOKaDD
         /UFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lBETwYl6sQZqmoDy1zjuIPcg5WaSGPdo5PIiwZ9uDTQ=;
        b=HgSdqR4jtNq6bcFbctqwo+AfZOgLJuV9nv32FTSQcaq6et1fJvdXfNQEq5FvDnalJV
         3d/UdUQE0ml4aFupx01+yQq6lvmQ3FxdHWzL0d9TzME8La5+o1SJl1TwVgsovBTbKxey
         9QzBFE4vw9KPp+kuEtUHUu5g5c+JtT2Zw823URVU4rHq+HfVbVRyv/RqOgOVyN1C7pXL
         4W6IqbstPhlnVm2GOY1BCSl/hktCj6fGF1J95abIkhY7B9X+ha92qresPw/0t3QWIJhu
         q7DMLy40O4Zy0527opmI+4EmdaCs3D84P1NEw/TNpS68RVNOm8NawBtk49hi9BgKs5tk
         IVxw==
X-Gm-Message-State: AOUpUlHAOlM2b19mtvsrl7hTbp2/W87U4lqKOCWObMGBd9XcSAvobt/9
        Pi7e/xs6kWNYc/5Muj44NDBdMmksQhJKNElKLsM=
X-Google-Smtp-Source: AAOMgpfo86+0GJLydJj+7kIyzbhPJMkjNfwKKaZC+riZdupxsLRIcrsF2vY2ANAr2iO8g4fdS7ZYeFoWlRekrnlyxQ4=
X-Received: by 2002:a25:30d6:: with SMTP id w205-v6mr1637266ybw.52.1531854271880;
 Tue, 17 Jul 2018 12:04:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5e42:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 12:04:31
 -0700 (PDT)
In-Reply-To: <5c8b56fabd1644b50dd7ca14d8e7e49aa92750a7.camel@perches.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com> <20180717020926.176408-17-toddpoynor@gmail.com>
 <20180717102234.3spplwaf5n5wmpcl@mwanda> <5c8b56fabd1644b50dd7ca14d8e7e49aa92750a7.camel@perches.com>
From:   Todd Poynor <toddpoynor@gmail.com>
Date:   Tue, 17 Jul 2018 12:04:31 -0700
Message-ID: <CAO3upoZ5dCZpA9H7NBFgi=neofZnOjRmyNbGUeu75J37EhxWcQ@mail.gmail.com>
Subject: Re: [PATCH 16/32] staging: gasket: always allow root open for write
To:     Joe Perches <joe@perches.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Zhongze Hu <frankhu@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 11:50 AM, Joe Perches <joe@perches.com> wrote:
> On Tue, 2018-07-17 at 13:22 +0300, Dan Carpenter wrote:
>> On Mon, Jul 16, 2018 at 07:09:10PM -0700, Todd Poynor wrote:
>> > --- a/drivers/staging/gasket/apex_driver.c
>> > +++ b/drivers/staging/gasket/apex_driver.c
>> > @@ -630,13 +630,10 @@ static bool is_gcb_in_reset(struct gasket_dev *gasket_dev)
>> >  static uint apex_ioctl_check_permissions(struct file *filp, uint cmd)
>>
>> This function name is a bit of out of date.
>>
>> >  {
>> >     struct gasket_dev *gasket_dev = filp->private_data;
>> > -   int root = capable(CAP_SYS_ADMIN);
>> > -   int is_owner = gasket_dev->dev_info.ownership.is_owned &&
>> > -                  current->tgid == gasket_dev->dev_info.ownership.owner;
>> > +   fmode_t write;
>> >
>> > -   if (root || is_owner)
>> > -           return 1;
>> > -   return 0;
>> > +   write = filp->f_mode & FMODE_WRITE;
>> > +   return write;
>>
>> This doesn't match the comment because it returns 0x2 or zero.

Will fix, I noticed this earlier and forgot to address it.

>>
>>       return !!(filp->f_mode & FMODE_WRITE);
>
> Or maybe change the functions to return bool

And there's another patch farther down in the stack that does that,
too, will keep them separate and fix up this intermediate patch for
now.

Thanks -- Todd
