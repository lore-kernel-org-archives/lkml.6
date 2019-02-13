Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA942C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6433222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hl26d5gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732764AbfBMGZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:25:41 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35931 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfBMGZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:25:40 -0500
Received: by mail-qk1-f194.google.com with SMTP id o125so726758qkf.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 22:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9td7SaZowoxwpxDBzINQYd3AMI0Umbla/WBrP6WTjrE=;
        b=Hl26d5gxMg0jpbhaN2Ia64nmuwMGxMNgN1s81jWmq1pgpl0ydsixKVCGBdZ5OINGlG
         s/Npj1NExXDo3iPWeiQ1Tijid73noBfsL2/F8p2XXABK2FpPcgriCV9NbGwmlow7UZ97
         nKuvS/DolnYHnP7bMeayVLu5US9zQILiyOHlJ0I5wdfJLDJBBInAYNbxyrLFybQHn3YQ
         MNuwooUcZ95wT3E6wFeIezQWEbO5EqIu0d5gtcY+uuLw0BRhsfJINrHTKlAgKOEslCff
         uabBH4QMsTJGDtX8RzPIMK/bPjOMl3e3NUjnu1Jv9cnSHYDnRsWqy0tXC2r4CV6OjVlm
         zNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9td7SaZowoxwpxDBzINQYd3AMI0Umbla/WBrP6WTjrE=;
        b=Ap8MdRh+fzS57/9dZ+Vk2oD5TrYZusiy5Xy2cSVJ6OAAmluGvsVXMHagxE9EFOxwNE
         Q9OROcHey69UEGrvMqEC4rN0Mv4pnt3FftP18WENdFCWzfrh0Th+m7bgkQRaRTQEoPBb
         D2OnUoA5YDu5w//9VrXxN2KfGaeeciiwVIbaRPjyNowGSB0E6JWevjbJb8VN8SUmZjZU
         hlZRxo606KgZJ/ZT6fjAa9fKGCoUmGoK3K3QkmUKX3gm0U2ab3FxkHuvNAxeegJ5RRKW
         4a+aB0dJLAAT3SgoJ2hJx+br6bIUYJDtdDqwxor6d8IGGPR+D0EoF9G2sP8YwyNBvm8A
         LYrA==
X-Gm-Message-State: AHQUAuaTwBrtWnFiEsxLELUIYJcwlQ/XqoH3utoqGv8wUct3cdNlEW0P
        7bu1vLZbkPELj+aS7p5IPU1rjheu7NF3ejpsZLo=
X-Google-Smtp-Source: AHgI3IZwmQ1rV1Nap5BzztBmJUilEi8167VG4sAdzS/VYCwYH2NJo5Jt0+K/+ysJzqL8jqoPrkqsDBrO3G9uVw6Orrs=
X-Received: by 2002:a37:c554:: with SMTP id p81mr5349380qki.337.1550039139893;
 Tue, 12 Feb 2019 22:25:39 -0800 (PST)
MIME-Version: 1.0
References: <1549995065-27597-1-git-send-email-xiaoxiang@xiaomi.com> <20190213004804.GA2992@jagdpanzerIV>
In-Reply-To: <20190213004804.GA2992@jagdpanzerIV>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Wed, 13 Feb 2019 14:25:20 +0800
Message-ID: <CAH2Cfb909YCOtb+iob18QhY7Ze8AP0-5Ofdkr7i+xRVJi-yk1Q@mail.gmail.com>
Subject: Re: [PATCH] printk: add KERN_NOTIME to skip the timestamp
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Xiang Xiao <xiaoxiang@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 8:48 AM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (02/13/19 02:11), Xiang Xiao wrote:
> >
> > Because log may already add the timestamp sometime
> >
>
> We have module_param(printk_time) which enables/disables
> timestamps. And a .config option. And a kernel boot param.
> Why would you want KERN_NOTIME?
>

Because I need control whether append timestamp per message:
1.message come from kernel add the timestamp
2.message come from remote skip the timestamp
Like my previous reply case.

>         -ss
