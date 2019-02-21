Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1D3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25092218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GPTC1GiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfBUBXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:23:46 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33441 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfBUBXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:23:46 -0500
Received: by mail-vk1-f195.google.com with SMTP id l62so3654580vkh.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 17:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q9ICpafhgGzeqErvTe6lKiQENs0ImusOCchpoLeIwvo=;
        b=GPTC1GiSn7DAWecGYPibIpz+qk2/ekx2F0XryjEZwJvlqo2jVkScE18K85k/YCkb77
         l2zrKDYJC08FcSHRKMSZ5Ci5KmmfwwBEDz5sYxpUHCddoWj5lFJw/UPxpebunvzxg814
         8WlxkLlTvOfcWKTAQZ3UZ32yJQvn5nO05e/yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q9ICpafhgGzeqErvTe6lKiQENs0ImusOCchpoLeIwvo=;
        b=HSackuguhUoAUDbeDbRRwRt7WnZZRGOQuPFsW1qukKB+j4irYWGcldn265VplCOhid
         OzvRt5RD4xN3ocemfLUFF6W4Vo+LnjZtscXVPZ+WBpQfCroPG69cuZ80dkFg5S5l3yFE
         xQiuYSGIUYbYIKL26NtxRFnxQzoX+ud7CDUs4+OIMObRRdH5AtnVO6UAmvL4/yFzdd+/
         b+SmTTjYfHqPmd2cVue8rtmO1dqc5pmCprpp0U9D5kk+3jrkzVG/8avqiYyZxlpCNjGP
         1V4pobHa3UeiZ2KRDFg1DXmZ/kiNQUYIbV7DxnmZ4ihsli+NX8WkHMN1w7RsusEz+hmn
         l78w==
X-Gm-Message-State: AHQUAubz4gPZBn3w9Quhtjo2yJG3z54Z7h0EXaeOZDUbd0TDB4SLHQ8Z
        tLDMSps1oL6mVrHoRTvhmaFwJZEjvbU=
X-Google-Smtp-Source: AHgI3Ia9Iut1XKVuti/yFFpN0f7KQkdDUDVYaDlSwR00cPRjFS9ifVj5YiMDHYPKq0fQ2R9CBuz6Ew==
X-Received: by 2002:a1f:5145:: with SMTP id f66mr18621772vkb.69.1550712225061;
        Wed, 20 Feb 2019 17:23:45 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id r202sm4371135vke.12.2019.02.20.17.23.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 17:23:44 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id q17so8957688uam.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 17:23:43 -0800 (PST)
X-Received: by 2002:ab0:645:: with SMTP id f63mr18789241uaf.106.1550712223306;
 Wed, 20 Feb 2019 17:23:43 -0800 (PST)
MIME-Version: 1.0
References: <20181008172332.GA29816@embeddedor.com> <CAGXu5jLsQ_Uc4kp=md2SrOERopjZmnQK_fAsru4MQUqEHRvEeA@mail.gmail.com>
 <20190220183425.202d4d40@archlinux> <89471d5e-fab7-9d00-8b3e-562a5a510fa6@embeddedor.com>
In-Reply-To: <89471d5e-fab7-9d00-8b3e-562a5a510fa6@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Feb 2019 17:23:31 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLeYO4dNxs7n9Bt97A6N0b48uuXhLjq0bsfF=k5OaSrmA@mail.gmail.com>
Message-ID: <CAGXu5jLeYO4dNxs7n9Bt97A6N0b48uuXhLjq0bsfF=k5OaSrmA@mail.gmail.com>
Subject: Re: [PATCH] iio: cros_ec_accel_legacy: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:47 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Yeah. Actually, we can even take the switch and for out of the equation,
> and the code can be rewritten as follows:
>
> ec_accel_channels[X].scan_index = Y;
> ec_accel_channels[Y].scan_index = X;
> ec_accel_channels[Z].scan_index = Z;
>
> if (state->sensor_num == MOTIONSENSE_LOC_LID)
>         state->sign[X] = state->sign[Z] = -1;
> else
>         state->sign[X] = state->sign[Y] = state->sign[Z] = 1;

Actually, should be an unconditional "state->sign[Y] = 1", but
otherwise, yes. Can you send that patch?


> > Agreed, it's 'novel'.  Waiting for Gwendal or someone else to come
> > back and check it wasn't meant to be doing something else.
>
> We've been waiting 5 months for Gwendal. :/

I've looked at this enough. I'm happy to Ack it, if that helps. :)

-- 
Kees Cook
