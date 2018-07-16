Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089F6ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D322086E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3O/eEl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D322086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbeGPVnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:43:41 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:38164 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeGPVnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:43:41 -0400
Received: by mail-yw0-f196.google.com with SMTP id r3-v6so14721129ywc.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 14:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3yMCA1M2W7gMct2yGQkZobLd76tOdtLn1ILDE9Pbs5I=;
        b=l3O/eEl/TKgTgt7YX2M6OKah6N74o5WMf7U1EREDk3kOKDcvAqM2q/D2rz7mKJ9umc
         CE6lvbbs5MEA4petq4FA6rFLRxfbe+CxyZBQTbsReGTryYc3jqSWov83HNunqr+hYZ0i
         mLE7XEOqwtTtYC8u7SfHFwjyg8m/RNrJDRfIdwwIWxsS1EaLei4DM0OLkAz3jrJuS73E
         xWavlb3GOQruqWSfAmADTx0iY/IqZlGNX0AA9OW6EZBWdEu3wVgnP7X3Plzmq9FnbD1u
         iPz0l5VkaCHhV7kuW4NiNOYNpenjyRRCUS8dZdKXGgP8+zysUzTiEY1M1q/HqIZ2/DNH
         mERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3yMCA1M2W7gMct2yGQkZobLd76tOdtLn1ILDE9Pbs5I=;
        b=crdo3wK2obOg64rY3g5cJT8nKQhbjGS9LJKOv+gAd3pITyf5k3GeBCAZI03rvQ2WPR
         Ut9Ca4DSDH3mAJJvUHIMeIPxwByxSvgSqgx7uvl/q06sNXdHXq6Am7Jt8hXhlPb3MTp8
         9QvCE+8V+ub6hGapSx4x2S7rgHi/PFt1F0KrMr9UOhKv5536pfEYnaRRUAaxLHQmevqq
         dzFDmPUtKQZ+7fGchR9c+C+L0gEI5lI8t0BVzM9Fz5bvjU8LUJm8BXuHFPgjT+YDMgm3
         ZLwWXAvBEAvie/hZwicK3pSlg0dvK3UqWa3pGrbmVa9bI8kpmX8mBtazLguo8USHkLPu
         ecbw==
X-Gm-Message-State: AOUpUlE5LMvnDXUJjzOyU/wlPZuhD8JkKx1XoFRXloj31ppDvMgxkxNf
        lU63tCwRaNbxoqkvVYXmYnzhwgJ2sapmg7t+G3s=
X-Google-Smtp-Source: AAOMgpf1AhHMMUDiQenUBDcbEznB+feDPwqQgWragt0lZtp9ISjARXOThPXC+EWtpGcHRV+9n77UE3yeBiUQ6Ym3wNo=
X-Received: by 2002:a81:86c4:: with SMTP id w187-v6mr8968277ywf.424.1531775668534;
 Mon, 16 Jul 2018 14:14:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5e42:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 14:14:27
 -0700 (PDT)
In-Reply-To: <20180714063224.GD20451@kroah.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com> <20180714055816.223754-6-toddpoynor@gmail.com>
 <20180714063224.GD20451@kroah.com>
From:   Todd Poynor <toddpoynor@gmail.com>
Date:   Mon, 16 Jul 2018 14:14:27 -0700
Message-ID: <CAO3upoZQ0QXc5OjvhJbwN42QE71m6ABvLb2WM_iFVWd64iGgSg@mail.gmail.com>
Subject: Re: [PATCH 05/18] staging: gasket: sysfs mapping creation fixups
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        Zhongze Hu <frankhu@chromium.org>,
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

On Fri, Jul 13, 2018 at 11:32 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Jul 13, 2018 at 10:58:03PM -0700, Todd Poynor wrote:
>> From: Todd Poynor <toddpoynor@google.com>
>>
>> Return EBUSY for attempt to create a mapping already in use.
>
> Why?

The existing code returns EINVAL which often means something bogus was
requested, whereas EBUSY is sometimes used for requesting something
already in use.  If that's not an error typically returned in this
situation I'm happy to drop it.

>
>> Remove stale pointers on error allocating attr array.
>
> This should be a different patch.

Will do.

>
> thanks,
>
> greg k-h



-- 
Todd
