Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A7FC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C57320989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzKZxbfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbfA3Sxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:53:35 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42151 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfA3Sxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:53:32 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so202470pga.9;
        Wed, 30 Jan 2019 10:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JdRCRq487oDYVK5T7WEHHUVxrhyS4KIgJxu85m+yKeA=;
        b=nzKZxbfjDltfulTUGbKH3XZT2DKvCoOCvUvatl3eW5NLjPUsA/+oIFiokitdCk9MDz
         xV7v1i2mhVuotD8fN1GBqj8WWtgWqcA+hWrSFM9ZF0ZIxQQyEh3fIBAT85z2apwEgdGS
         4QY4WzZEuY0OWJP9J5qv1r+nhQuRp72Yon5Cfbgjpy6bSWBxGFWEEmJOWclHkE+tKyox
         usFbGWZA6zkiMBbfccdEchApE/mzacRlIqQjmK6rZAIV7jeonncuh556zig9ycQjz6xp
         i/rN/meAtqqlhrw58hNqjIaDCn6tkQuHKhW4O0ZCYmWyad179/P/tknwz0a71zbL40xr
         OaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JdRCRq487oDYVK5T7WEHHUVxrhyS4KIgJxu85m+yKeA=;
        b=LcLJbeFDsou5vYtBujyGvZw7zvRmNnN5SlMTfSWQS/zfuXpffssZ0Fq+pvF9BgHN9V
         lV1lO/BllYpD/NKKzxakNa6pGkYPW2kWqNyJV5kko+KRy9ME77kW5++1Q9Fa1Q/9pLdz
         xNJga00AqnoRVw9ZnZFv9OtRGKdBsoo3S3n7U77PMg3TMvstScToTzuz2pa5v+NdU+5X
         e5IyYZrtyVKo9bstGG0482rEnKR7FKQio7g61ziht2WhZX4Boq8VCT1onksYwu6F4i/I
         hMmSXYPkzNQo7ldPy3TiUkpNGmhP/4jpd+sBYAsbV7nbwHlrHFHwbwoeV3JVk7vPew3R
         Zhwg==
X-Gm-Message-State: AJcUukdDLg9K8FJCoHNqTaH/bJnlcOOoLc4DaMWnHgOQW0LpoAuyiQgN
        Q2a8lvzGU677stCm5lZc/7I=
X-Google-Smtp-Source: ALg8bN60Zb1BiWHPbPz/MWhdH9IecTgVopemM5+hhSj6RV95JQg4QgduZbKc7xyUEilkTlXnDxNCQg==
X-Received: by 2002:a63:5346:: with SMTP id t6mr29011567pgl.40.1548874410950;
        Wed, 30 Jan 2019 10:53:30 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id e16sm3091637pfn.46.2019.01.30.10.53.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 10:53:30 -0800 (PST)
Date:   Wed, 30 Jan 2019 10:53:28 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 12/13] input: max77650: add onkey support
Message-ID: <20190130185328.GA149208@dtor-ws>
References: <20190129133545.1931-1-brgl@bgdev.pl>
 <20190129133545.1931-14-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129133545.1931-14-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 02:35:44PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add support for the push- and slide-button events for max77650.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please feel free to merge with other patches (MFD tree I suppose?).

Thanks.

-- 
Dmitry
