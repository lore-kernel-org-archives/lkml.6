Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC698C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967502075C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zcHjd9v9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfBHOtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:49:22 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40397 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfBHOtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:49:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id z25-v6so3198976ljk.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 06:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Cb+WbbNIXZZo932Z1h7VQNlmSddhkWXbmP+uV3czks=;
        b=zcHjd9v9b8+WOT1eJGp8ZrQN9Uo3FqZ2YucL5Dte/PFmjxJ4bxXLxUIkOJIolXt30J
         B5FlhDgVu4eBBIKvl/VXMYUcYXsp2lqB9k62D8q8UpZPMsUTl3szRGxXnujj46sJbzr+
         k+iQOazP6C7GYkL/0HvclTSw2GeRm8LIng4MIJwR9M0kuymJSBrwfhiG+JuLTnjD775j
         pg5HrfW6OKubi2LW6MkaAB7QZ04N1kmMJf5L+Qf9D4Te7e89V3mOndbTzGLeMMBB7t5N
         YoaDxDYKHWEcox/FYVChv9qTUqWuX+Cj9Il66mzmfKvg86zq6J9GpROSM/4R0yGLhwoW
         pO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Cb+WbbNIXZZo932Z1h7VQNlmSddhkWXbmP+uV3czks=;
        b=n2TdUs0ZpkQNKytm+eZND0X6UKC9J2CPUexQdVBXUtCRX6mbEgm2Ly9QhO1OZ4XM49
         dkAvsgYvzAxxpDsrnPeOwsT1aLUCrPu/wdTslwmi+VwAYFRBqWdyFV8X7kpT8cfbkbyR
         jvabZRAamtq95OVa1k1ziDhYHQcxmyVspxgnUlL8SeFvAVx5JfZS49QZmBhDW5LAnqxq
         TjV6k7bPx7dDWGOwgcDhVf3FyDrufPHColyXoXDqUP8bMLVu2W4eb0nyETUxEznFgJcf
         SxZHq0MboOGD4pkzLFFy+AhcKeJnWeaDwnmhZFKmlDQpeharqyM0q1PhI519YeDGL01j
         E+Kg==
X-Gm-Message-State: AHQUAuZTZCek2BLYyh1MWBEHAjCy06AcgrZR+WBA38UPy7MjSjR1PRJO
        Dsxw5u32mL1+55uCzSO65VVrCRlujMeHXMV2uI4fJQ==
X-Google-Smtp-Source: AHgI3IZ0ONeUtQse7hdRwhZNiZlrfB2o0JHPuAV3vbgLgduq/RwtsloqAwl/5ri3bZXh2RbDhldVNWuMGyutGPx2+Ac=
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr13498460ljb.126.1549637359440;
 Fri, 08 Feb 2019 06:49:19 -0800 (PST)
MIME-Version: 1.0
References: <20190208141152.13887-1-axel.lin@ingics.com>
In-Reply-To: <20190208141152.13887-1-axel.lin@ingics.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Feb 2019 15:49:08 +0100
Message-ID: <CACRpkdaKaTCg=JgiOY0UhzCApZLbsrqZncWnHq31RNqUW92xfA@mail.gmail.com>
Subject: Re: [PATCH] regulator: lm363x: Check return value of gpiod_get_index_optional
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 3:12 PM Axel Lin <axel.lin@ingics.com> wrote:

> gpiod_get_index_optional can return ERR_PTR, add IS_ERR checking for it.
> While at it, also remove a redundant NULL test for gpiod in error path.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
