Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9B4C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C7A208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="C6JBQPe9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IMPWNJTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C7A208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966330AbeFOQsD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:48:03 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:42829 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966055AbeFOQsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:48:00 -0400
Received: by mail-yb0-f196.google.com with SMTP id d123-v6so3724278ybh.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MdbjkrNlpBXPNnY+rBhxVZ2CIA0vx8k+okf356JImyI=;
        b=C6JBQPe9/12RIa1Khcl9cEzXjkQzGx/WXORg/FyAknEE4nEsslnab/r9erWGAkDAmw
         ZanTlLwENXIDr30C0CbwlSy4TaLQvFuXReZHKNMVkDneCkDvZuz5iTvm0mwKjtaB6JIs
         viQIJkaRegVunK3HroIQjBg2vWrkj48aU9Wc7WMgKLP9WsXlNa2WiiO91Cd7lkwGgA2Y
         +/PXQQJXHmHbs3Fyt8O6OaMVgTdJyUlC5yBfwLdu4DWmSWYonrDNaqe0bFhf3js1IthM
         lZm7gxtp0Ea63r0M/yAsK/6gISU8RzqE+FKiz+V2P7zsEdNeJrKTybAD+29EVkuhUTwz
         vm3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MdbjkrNlpBXPNnY+rBhxVZ2CIA0vx8k+okf356JImyI=;
        b=IMPWNJTQqi8x+1gsO9aXIry/UfYU0P/19pZE48Ndw4qeznGRI/LmT8cwYduUFbSEZ5
         hhp3lpRlygTgROKAwKW8IZkohjJ7z1YBG/OIdBjHhuyzDDCp3qPC1HMrVx8SAlJxYGmM
         LY7i13giaaudwDaheC5ZoJjfxI94QyCbZFJ3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=MdbjkrNlpBXPNnY+rBhxVZ2CIA0vx8k+okf356JImyI=;
        b=thvx2KD+hBiY+ivMRT3pwoMlJfu3jSixDUjurZhBf7BblWKIUhSGmgzRpr4CQWkqwM
         /tOamIV+bqIJ3pgnkpWKKQGPTW6cQqFvziWWntE91EPftL4klZjMsdtnoGf/5+PyQmn4
         UQz2ERSeLHbhgq7DjzUftpoKyQUQtjrAYE0w/qpCvCaYddoTTpk+cmPlWqXajqe2STt3
         /+dLx4XDAVo6Pf4fQQyfXKa1iPe+tp5wBKFbPgfgHT13ffAYM26PzL4EAqlHaIFhrNju
         tzoionBRSJwdxXz8q/qWZBFZVWY5v/owHMMYcEVoh0LhBMYWYCE4raTmiq7d5NaA6vae
         MrMw==
X-Gm-Message-State: APt69E23QKAD4MCWmGq5WqKP6HcqVdnU1J6wQECB82eFslazOOUS3E0Y
        9DjWoSJmX892totAAOiyzDM2CilW/HmODn9fS6DQqw==
X-Google-Smtp-Source: ADUXVKJMU1awtPNblyVzp9H9NPvP5WMASh9DObAKzz85jOQbNxOF4kKP6NQAGGD/+M5e0aOYclTWKJ9Ulem2Qka8DFg=
X-Received: by 2002:a25:44a:: with SMTP id 71-v6mr1340793ybe.463.1529081279874;
 Fri, 15 Jun 2018 09:47:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 09:47:59
 -0700 (PDT)
In-Reply-To: <CAGXu5jJbwAZxCYMF=j2XQAhgKU90XaL2oRCG_sny_KBVcTJhOg@mail.gmail.com>
References: <1528705874-34845-1-git-send-email-jiazhouyang09@gmail.com>
 <1529079930-58587-1-git-send-email-jiazhouyang09@gmail.com>
 <20180615163322.GB11493@kroah.com> <CAGXu5jJbwAZxCYMF=j2XQAhgKU90XaL2oRCG_sny_KBVcTJhOg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 15 Jun 2018 09:47:59 -0700
X-Google-Sender-Auth: ZWxp1KpYS9fBLyl4Kdvtg4iDeQM
Message-ID: <CAGXu5jJofYcisFUiNavprO3Si3n=VXvabNrNzQcN0pcy_XQZtA@mail.gmail.com>
Subject: Re: [PATCH v2] staging: rtl8192u: add error handling for usb_alloc_urb
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Colin Ian King <colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 9:47 AM, Kees Cook <keescook@chromium.org> wrote:
> On Fri, Jun 15, 2018 at 9:33 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Sat, Jun 16, 2018 at 12:25:23AM +0800, Zhouyang Jia wrote:
>>> When usb_alloc_urb fails, the lack of error-handling code may
>>> cause unexpected results.
>>>
>>> This patch adds error-handling code after calling usb_alloc_urb.
>>>
>>> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
>>> ---
>>> v1->v2:
>>> - Fix memory leak.
>>> ---
>>>  drivers/staging/rtl8192u/r8192U_core.c | 18 +++++++++++++++---
>>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
>>> index 7a0dbc0..6afab4e 100644
>>> --- a/drivers/staging/rtl8192u/r8192U_core.c
>>> +++ b/drivers/staging/rtl8192u/r8192U_core.c
>>> @@ -1648,13 +1648,17 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
>>>  #ifndef JACKSON_NEW_RX
>>>       for (i = 0; i < (MAX_RX_URB + 1); i++) {
>>>               priv->rx_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
>>> -             if (!priv->rx_urb[i])
>>> +             if (!priv->rx_urb[i]) {
>>> +                     kfree(priv->rx_urb);
>
> You're freeing rx_urb, which holds all the pointers to allocated
> memory. You'll need to free each item of the array before freeing the
> array itself:
>
> for (i = 0; i < (MAX_RX_URB + 1); i++)
>     kfree(priv->rx_urb[i]);
> kfree(priv->rx_urb);
>
> I think you need some kind of helper to do this, and you can call into
> it from your error paths...

(Though if you do this, rx_urb must be zero-initialized, so change the
kmalloc_array() to kcalloc()...)

-Kees

>
> -Kees
>
>> {sigh}
>>
>> No, you are still leaking memory on all of these changes that you just
>> made :(
>>
>> greg k-h
>
>
>
> --
> Kees Cook
> Pixel Security



-- 
Kees Cook
Pixel Security
