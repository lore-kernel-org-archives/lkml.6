Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9703C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B99A246F6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SuTNk//k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B99A246F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933798AbeGDHrX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:47:23 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34259 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932322AbeGDHrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:47:21 -0400
Received: by mail-wr0-f194.google.com with SMTP id a12-v6so4291552wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 00:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=03jzD19jO5zuvY2ebaqJRqAoLE4Keg0WtzHCvlFVFZE=;
        b=SuTNk//k/lXzflPLUNv90GVAZW4i+IXYMDSvrI4loF/nBAaJkDwliHm/209/p8y9W0
         fYPthTCSjgOIVRIE/n4VgqWVltfaiBgPlk4JrtEu69Td2R7+u+N0piGqXVPjFbcCN/Fp
         U3SlHQWWbueCY+XJemwQ+L6neXd5LqI9JpWSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=03jzD19jO5zuvY2ebaqJRqAoLE4Keg0WtzHCvlFVFZE=;
        b=U5zU5mkVjoVn/bRaRXdCribLDgBJTdaR/bxShsaAVjTIujdlHrvwfB9+Td2Qs606SY
         Cy7yFQ2+2G4ew8Iqf/1TR4rue5lTbIkbibbnTHjzQQRdHj7xV0fb3BAtPG1fxtHKumjv
         CgUlYedjbDrBVfOYWXPtKdkLQ0a/d6TmNPP8WfDPBg1QaCpqp9/On+mTE4v8eBRK/vAw
         aNH3gBiATfshYZ4qij3wUSZ176aPl1dP0D7MPeiVU2B2Ktj+F3O90IjryhsY3cadRRwn
         vgswXN32vg1E/V+ieCgE+hgBF6mpCyj4rDmiLOBVNlssU6layDQFcuvELk1D2RvlWcY+
         O8qQ==
X-Gm-Message-State: APt69E2hs0Nsn4X7fl7/F/yct0S0hUI3raUmon2WT6TtiZuXdiDLKGMr
        zJR5JideQGAIsEaEdYIXyS5+zg==
X-Google-Smtp-Source: AAOMgpezey7Nhvos3bvGAXnpvYLEt9P9xYSya7t2mwCTfTmBAMS3JLGMsOLBeyWfR7vEHrecNwhYJA==
X-Received: by 2002:adf:a907:: with SMTP id u7-v6mr710252wrc.175.1530690440203;
        Wed, 04 Jul 2018 00:47:20 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id w21-v6sm4724497wmw.29.2018.07.04.00.47.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 00:47:19 -0700 (PDT)
Date:   Wed, 4 Jul 2018 08:47:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     airlied@linux.ie, hans.verkuil@cisco.com, olof@lixom.net,
        seanpaul@google.com, sadolfsson@google.com, felixe@google.com,
        bleung@google.com, darekm@google.com, marcheu@chromium.org,
        fparent@baylibre.com, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, eballetbo@gmail.com
Subject: Re: [PATCH v7 5/6] mfd: cros_ec_dev: Add CEC sub-device registration
Message-ID: <20180704074717.GP20176@dell>
References: <1527841154-24832-1-git-send-email-narmstrong@baylibre.com>
 <1527841154-24832-6-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1527841154-24832-6-git-send-email-narmstrong@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Jun 2018, Neil Armstrong wrote:

> The EC can expose a CEC bus, thus add the cros-ec-cec MFD sub-device
> when the CEC feature bit is present.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
> ---
>  drivers/mfd/cros_ec_dev.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
