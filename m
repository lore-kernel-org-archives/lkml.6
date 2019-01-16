Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0933C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEC62082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fseoQLOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388685AbfAPI2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:28:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46437 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388644AbfAPI2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:28:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so5798118wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 00:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qGf/4RtJ+w1K6Ynya8U+qD51awGcq+cek4wXVDUVu0I=;
        b=fseoQLOv2AramW2V6tnpGIUtwhXVZOOIRyFdcxUeSFzXM8RbDXOj82Igq0DXmy6pgu
         jZ1HAA5SqcOU7tDENphLSAjrm0GD1RQPzpPspvJHp60/9u5e8B3kAw9Mm8i08tXCeoes
         3pdwEAsu1HLVDrqip0Jq2Mad/r5Nx+Jc/Ocnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qGf/4RtJ+w1K6Ynya8U+qD51awGcq+cek4wXVDUVu0I=;
        b=iGyBqw1/XNy8JdylYZkAp3mmVr+MlcUilt6ZtJJTCsIp8SuAjVkVOLDEdekJyj1DIo
         9smu04oALIlUsA34mi0lrUFGb22goslrgzCNg1FuYfvYePv8V91HY564cjlh/fEVguAO
         gO7Vc47Kb6O50+nuSUovzzWuNHRoaIriY9zkkoyHAIsAjwo41zHrtnW/1FwiZgufI7aW
         kfZ/kf7us2PHxHVefGiiz0Lmv0LKvltSPQ/qF8qsIHYj4SaUFlxV2XkQ8rWTJrgBgjCA
         Pl9T07BqZuIErTKPY2LjqSGY6UyDyMpBFLWJl1KnIQUFC3SItEjVejWQ1kgFInCrJItq
         mYJw==
X-Gm-Message-State: AJcUukdjMMATlb444Foxb+3AJ6c5uCyvv4OVt7yWw8doCr+4C6kTqu0d
        t6htM7nt+n2Kjv2MoXjhNLA/Ww==
X-Google-Smtp-Source: ALg8bN7/LO4ytklWKby8tqnkHSkAYMLCjYaZqnza9awwOw2G4gXp7WnJKBD972I74641E6mSHgV5Wg==
X-Received: by 2002:adf:f605:: with SMTP id t5mr6046715wrp.229.1547627280549;
        Wed, 16 Jan 2019 00:28:00 -0800 (PST)
Received: from dell ([2.27.35.149])
        by smtp.gmail.com with ESMTPSA id o64sm31572522wmo.47.2019.01.16.00.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 00:27:59 -0800 (PST)
Date:   Wed, 16 Jan 2019 08:27:58 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v2 6/6] cros_ec: differentiate SCP from EC by feature bit.
Message-ID: <20190116082758.GB23399@dell>
References: <20190108052606.59426-1-pihsun@chromium.org>
 <20190108052606.59426-7-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190108052606.59426-7-pihsun@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Jan 2019, Pi-Hsun Shih wrote:

> Since a SCP and EC would both exist on a system, and use the cros_ec_dev
> driver, we need to differentiate between them for the userspace, or they
> would both be registered at /dev/cros_ec, causing a conflict.
> 
> Cc: Enric Balletbo Serra <eballetbo@gmail.com>
> Cc: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
> Changes from v1:
>  - New patch extracted from Patch 5.
> ---
>  drivers/mfd/cros_ec_dev.c            | 9 +++++++++
>  include/linux/mfd/cros_ec.h          | 1 +
>  include/linux/mfd/cros_ec_commands.h | 2 ++
>  3 files changed, 12 insertions(+)

The (other) Chromium guys are usually pretty active and are more
familiar with this hardware and group of (MFD/Platform) drivers than I
am.  Thus I'm waiting for one of them to provide their thoughts before
applying this.

Just make sure you Cc:ed enough of them!

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
