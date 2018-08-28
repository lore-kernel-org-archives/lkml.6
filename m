Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52D4C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BDD2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cnImqPoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BDD2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeH2AkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:40:24 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40344 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbeH2AkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:40:24 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so4348124ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Rsh/5B8MCx0EoOpmW2PcOgRXeZN8CwjLcuWhyYiLVI=;
        b=cnImqPoHdgZ7A/C4rpmMQ+QZWkZvouhXcMwUoBaNkYHWWedjwtQ2/BUofNUhrdir0T
         1zqD0APxW5zSjpMPPYgZCZP3th6BF8Pne6EqmivquvaXmAsT3M4ep79maZTv+Jl4RmSQ
         wW6vaiQyd/G/uuNmlQXC44xDGBN2uzt5FEPeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Rsh/5B8MCx0EoOpmW2PcOgRXeZN8CwjLcuWhyYiLVI=;
        b=A9a9e1Mpe7rivnNy/YXjhUKgXPW9D4n9d/yJR427qBqGBEnItbf2mRA7oQ9uSMFDgC
         lxDwxn3etdxjEtXmJ+sQZveBI/R6YtTo/RYcOGwlcwJI/bxeR9X6+dvyWtdMhfeTeNVL
         C71shVhEO4hI50m2JtAWTZCqexjkkqpyMMAqodq65Yj/IT32sVE9BB4d54S/ugerRINg
         XoRoKqbvY6XUbSvJC4cIOZqA2K95ATCjCmA/h/IK6z4NRMJPb9AEBSAyS9TK7Sd3fUIQ
         E6FDY+CZNxFMkZWQFnNwjka3DQkI4p0uRUKd+esAkr56kBkmVzfEnYgMOlld4jA6XDKE
         xdlA==
X-Gm-Message-State: APzg51DAjYJ+VHPGITUlnbk4qx5TGXWuEN9d0F3RiSVeAwbfF+kmk5Ol
        jQNttoVX93v9umTLW5IlAdycr8U56gITPLMqHhwyUA==
X-Google-Smtp-Source: ANB0VdZSaHLR831rO+r8zWf6c0qhO7F+sxjUQVV0UO3t0nkcUpueHGzKGLkFc22kYXrO4cZtZmS8LKy9nChYcEDaw30=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr2864181itk.62.1535489221652;
 Tue, 28 Aug 2018 13:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180821105407.2318-1-colin.king@canonical.com> <5B7E9774.7010500@huawei.com>
In-Reply-To: <5B7E9774.7010500@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Aug 2018 22:46:49 +0200
Message-ID: <CACRpkdYOMDRZROVYES=8RYAQ99qW1EVrSi6AMxM2sSoWiGk_9A@mail.gmail.com>
Subject: Re: [PATCH] drm/pl111: add in missing sentinel to a of_device_id array
To:     zhongjiang@huawei.com
Cc:     Colin King <colin.king@canonical.com>,
        Eric Anholt <eric@anholt.net>, Dave Airlie <airlied@linux.ie>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 1:16 PM zhong jiang <zhongjiang@huawei.com> wrote:

> I has posted the same patch about a month ago. but it seems to be ignored.:-(
>
> https://lore.kernel.org/patchwork/patch/971652/

I applied your patch and pushed it.

Yours,
Linus Walleij
