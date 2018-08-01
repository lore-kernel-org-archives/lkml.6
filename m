Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E16C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8203E20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgcfB+q4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8203E20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389201AbeHAO31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:29:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42563 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730355AbeHAO31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:29:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id f1-v6so16746599ljc.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 05:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=r27vBjxVaebcYLq40PuyIf5p2pYfNSWatlCjqcA9K8Y=;
        b=EgcfB+q4U4ezYXUmcbRBWTEuxmC4B+dWEQ935uWOn5XFNjqTxLY7fqi80+UUF3jR21
         +wE8OkJSzWCl5fkrus5DkDMj+ZgjQaH8zOd4NWlOM6RgQ2wgxgo5L2fZ7kylqdBlv8Sw
         RAjQnESrTnuOy85XiJmrYItChSNlQ7XLrT6uLoLRTxSbHllVw+rsg5IbEp7m/fut96kG
         U2YkUdSwMsjUIV76nVZXb9RW+bQQK6/qUIDSxxsc9TYL7OJy0FDgK8Cgtb09nFY8xlOy
         PZPbc1KBLz6Wcvnkmgy3nQB4o8tyxU+4Wm2iF0leWWq7f8BkhFYnmWhFlHX1DQ1wq5aX
         b4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=r27vBjxVaebcYLq40PuyIf5p2pYfNSWatlCjqcA9K8Y=;
        b=d8hSt+REEY0aEaJazasEMZNWs2xDUyvprC/3S/A9ihfNpr0C+dwqalgXJDtj6PWfDE
         gK5Wsn1POlraf999uLFdtWUDDw5Q+oQrvusu7kt6uiJkAaWnch284LQ3XJrR4BeBWJYQ
         TtJX+rpdgSzpRbbsL18UKuF+aoFIMzzGJmEwyvNKip0Exv4V8OwGHA+wvK8h1wGFKfae
         p+/w+pjIvFlrmkAnfRgzDQq/+VUlkzY4kBDlEQxcH19wF5cq7NuAeeWdnzGejE4Cl7f4
         tPpCgIdxP2bKtOfRD7z1sSvIOvcquUfKNQQk4WchaVcadYXe5P/id7f6a46/+Pk5S9mu
         PYNw==
X-Gm-Message-State: AOUpUlG5iiMKM2w8OEyKWd8vQNvCb5GUMV2IL74bdIedplkNMzUr10+7
        GIV2sQvhROwEVCu0TSgKKJqp+7N1V9/zqHoxrO4=
X-Google-Smtp-Source: AAOMgpf4w/moemdNfu9MdXdIx9OfWuUtg5yEHeqanZhc5m/WmIQOgtSHWHQ1Wbn+1Wssl8dPEgB/F3Ln/dT20zMoe1Y=
X-Received: by 2002:a2e:5243:: with SMTP id g64-v6mr18852146ljb.144.1533127428596;
 Wed, 01 Aug 2018 05:43:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 05:43:47 -0700 (PDT)
In-Reply-To: <16141309.kTfAWOe8rM@phil>
References: <20180731203430.GA30136@jordon-HP-15-Notebook-PC> <16141309.kTfAWOe8rM@phil>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 1 Aug 2018 18:13:47 +0530
Message-ID: <CAFqt6zZfLXuMUT75a3dWKeiCCmKZOfi=FdTeFRjcdFDZdfcRVQ@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: Convert drm_atomic_helper_suspend/resume()
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     hjc@rock-chips.com, airlied@linux.ie,
        Ajit Linux <ajitn.linux@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 6:03 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Hi Souptick,
>
> Am Dienstag, 31. Juli 2018, 22:34:30 CEST schrieb Souptick Joarder:
>> convert drm_atomic_helper_suspend/resume() to use
>> drm_mode_config_helper_suspend/resume().
>>
>> With this conversion, rockchip_drm_fb_resume() and
>> rockchip_drm_fb_suspend() will not be used anymore.
>> Both of these functions can be removed.
>>
>> Also, in struct rockchip_drm_private state will not be
>> used anymore. So this can be removed forever.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
>
> the patch itself looks great, just a simple bookkeeping question.
>
> What role did Ajit play in creating the patch? If I remember correctly
> it is meant to be
> - 1st Signed-off: Patch-Author
> - 2nd Signed-off: E-Mail sender + patch possibly patch changes
> (optional of course if the same)
>
> So was this meant to be a Reviewed-by from Ajit?

We both are working together for these patches to
convert drm_atomic_helper_suspend/resume().
That's the reason to add his name in 2nd Signed-off
in all similar patches.

Is it a incorrect way to put 2nd Signed-off here ?
