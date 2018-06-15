Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B59C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A71D208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jozJvKz5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EH4I3Vq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A71D208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966412AbeFOQrc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:47:32 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36600 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966388AbeFOQrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:47:17 -0400
Received: by mail-yw0-f194.google.com with SMTP id t198-v6so3556752ywc.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=C4yWl+FjQqS3jy6FxhKxiQw2Scy2HS26EiEKafxZJ8w=;
        b=jozJvKz5qEmci67/cy7X+AC1pZBj4LpASI6hXZCBwMriYgFoertH9cWFzfa6GhjdYR
         XR9zHWImI1sWPXfkU2BO4495mzq/8h9T2He9s+d0SBL8VtCPf8xTdxxZpBT/1cj/yZyb
         WcO4NWGq8qOhjhUDu7zBoklGrwiyoulmWj0UFcoYzGdMyYet/c8DCaYbhWACWmwxBOgn
         +x5rbed+XtJ+33ZVf8CMU6WLbs1MUMWyyoGAX2HRErv8hCqd5UCUCRg67L3vluXQuv7V
         4sbNZ12V1Rsn+9+E5pjd07TcMscN3acpxVdnxFUdGd1G9z/HTquSF6g9m9NKWxz0S9fD
         JjxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=C4yWl+FjQqS3jy6FxhKxiQw2Scy2HS26EiEKafxZJ8w=;
        b=EH4I3Vq66cLrtxPk0vUSrP5IVEXifoR/fxVcwvaZ7Xs2v4Kzi0zHznVQWwlklGlgkw
         uWDztmFic6UtXySNH4qxVx7Bi6elbAcViIrIy+ZRonyoNZo5joeCwrtKPLyCtpVHjshc
         7SNqj9QQ4xStKvaiAfRIXuGAXyWqb9d9PmeqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=C4yWl+FjQqS3jy6FxhKxiQw2Scy2HS26EiEKafxZJ8w=;
        b=Ynb8erLZ9iuyHfTzGl+iCImPAwJQHRVCB+jsq5Fn7L/cCzX+rplvoC+83UD0PkqS4k
         vBoT6DjiKktEGprAc2HeAj+lga4kt/FLQy7TensSr5OVvtWDQWoa6380W96cIe7j7R/P
         t4MUwdYRCmaFbzJwb8CTg/Wdzewm/zCDilLik8OGIMheNPbAsO8Xil87hLp+RMqfDwT5
         RwqPf0tZ+P43+lYsbKqh2Ph1MN1tdM2Obo0ISpovcHNfRvH0BFinttig2xkIdIGdpwwu
         EUkVofyyPi4a/HWpyk+rAsoGbCkLdlsOB6BWxnR/wGwQ0Wluvj1oVAn1tgFDU+xuosvO
         vPAA==
X-Gm-Message-State: APt69E2cpFzYo7eiH/VdbLbZM1SnB9YYI9YmIuWFSoynRoWFfLO5gJMT
        4ADZh4KTrI7hfUEUJySCTeQB4tWRwCa/ctVhUuegVQ==
X-Google-Smtp-Source: ADUXVKIHDw+nvfEH0Fk8xTJObwISbuIKgX6jX/djm8yAiUzrgNQQO5RJ2kl5EEsFVWp/i3O2SXvDOQ0FCyIolG4+Pz4=
X-Received: by 2002:a81:8743:: with SMTP id x64-v6mr1242496ywf.129.1529081236855;
 Fri, 15 Jun 2018 09:47:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 09:47:16
 -0700 (PDT)
In-Reply-To: <20180615163322.GB11493@kroah.com>
References: <1528705874-34845-1-git-send-email-jiazhouyang09@gmail.com>
 <1529079930-58587-1-git-send-email-jiazhouyang09@gmail.com> <20180615163322.GB11493@kroah.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 15 Jun 2018 09:47:16 -0700
X-Google-Sender-Auth: ZDp2blY8A-Wc4FpJ7clbWu5zKTE
Message-ID: <CAGXu5jJbwAZxCYMF=j2XQAhgKU90XaL2oRCG_sny_KBVcTJhOg@mail.gmail.com>
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

On Fri, Jun 15, 2018 at 9:33 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Jun 16, 2018 at 12:25:23AM +0800, Zhouyang Jia wrote:
>> When usb_alloc_urb fails, the lack of error-handling code may
>> cause unexpected results.
>>
>> This patch adds error-handling code after calling usb_alloc_urb.
>>
>> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
>> ---
>> v1->v2:
>> - Fix memory leak.
>> ---
>>  drivers/staging/rtl8192u/r8192U_core.c | 18 +++++++++++++++---
>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
>> index 7a0dbc0..6afab4e 100644
>> --- a/drivers/staging/rtl8192u/r8192U_core.c
>> +++ b/drivers/staging/rtl8192u/r8192U_core.c
>> @@ -1648,13 +1648,17 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
>>  #ifndef JACKSON_NEW_RX
>>       for (i = 0; i < (MAX_RX_URB + 1); i++) {
>>               priv->rx_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
>> -             if (!priv->rx_urb[i])
>> +             if (!priv->rx_urb[i]) {
>> +                     kfree(priv->rx_urb);

You're freeing rx_urb, which holds all the pointers to allocated
memory. You'll need to free each item of the array before freeing the
array itself:

for (i = 0; i < (MAX_RX_URB + 1); i++)
    kfree(priv->rx_urb[i]);
kfree(priv->rx_urb);

I think you need some kind of helper to do this, and you can call into
it from your error paths...

-Kees

> {sigh}
>
> No, you are still leaking memory on all of these changes that you just
> made :(
>
> greg k-h



-- 
Kees Cook
Pixel Security
