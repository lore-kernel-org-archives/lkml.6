Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471C2C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182232084A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNLk7eZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbfA3NHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:07:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37193 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3NHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:07:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so25970123wrt.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 05:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UeDNeUTSWkpbPeXhSl+suDO9SxNbnK7mIWzttylKNi0=;
        b=SNLk7eZjaaszko0mKEiGMiXA1Jn+xNzdDmjDVftHAMXnEtyT5t5R2oeCQEUAIFipZ4
         HTN66hvkYEZBykIdKj1IiJS+i1sWceG+NxYnS4oWg9QsMQ0vSFDn2wGWJ4Z4BRVVnjSu
         9sMveh/F3sj0DfKDS6bNQKvI0DRu4U8tjStaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UeDNeUTSWkpbPeXhSl+suDO9SxNbnK7mIWzttylKNi0=;
        b=rRv4p+avc1ivYCdF1GnbiKLweVlCdU2ZPTkN+vwAld83nN9fHuAMYyEPDZ7FlVLcPl
         5Dvuk9jn0HPM5M26dXvaQWwYlSt9CC43QgKMloCrrph1TnfHv2Z8H1ko5eFdhWtWRC8/
         qDWFg8T2KT4GSkVl7U+AIn54PUT2dvPe2BEWGHVFP/JgV2qt7ckUThdHa82oA7XsLGBS
         bqbsYWjVHVyt/Q8JdYCkqNWjgLYR7gP/l4H9m9/gBR14BnHdkPzYGmdo5bP2vM7wpaaW
         PW/SPq7PinXjBnl51peGqAoQGKrGlXyLqoIl6JitAFoVkCXO1yMbMf8+ksI4XLWNmPlf
         0u2g==
X-Gm-Message-State: AJcUuke6GCTwN3ejxA0ZBxRbSdGjhpNqVVrI7ABI7DNMJ3bEy3ErXL5a
        cSjSwMVjfdVIEyoOdMLczFf8Xg==
X-Google-Smtp-Source: ALg8bN644+mreZZgQwLVbE27YxEQy8s3S2RazbX1L3RXFf/Kjw3uNxFQQ3bZoHckPt5uIaWw4sXKUw==
X-Received: by 2002:a5d:6850:: with SMTP id o16mr30821645wrw.123.1548853660315;
        Wed, 30 Jan 2019 05:07:40 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id h10sm2037050wmf.44.2019.01.30.05.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 05:07:39 -0800 (PST)
Date:   Wed, 30 Jan 2019 13:07:38 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v3 5/5] cros_ec: differentiate SCP from EC by feature bit.
Message-ID: <20190130130738.GC4701@dell>
References: <20190121071833.43443-1-pihsun@chromium.org>
 <20190121071833.43443-6-pihsun@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190121071833.43443-6-pihsun@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019, Pi-Hsun Shih wrote:

> Since a SCP and EC would both exist on a system, and use the cros_ec_dev
> driver, we need to differentiate between them for the userspace, or they
> would both be registered at /dev/cros_ec, causing a conflict.
> 
> Cc: Enric Balletbo Serra <eballetbo@gmail.com>
> Cc: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
> Changes from v2:
>  - No change.
> 
> Changes from v1:
>  - New patch extracted from Patch 5.
> ---
>  drivers/mfd/cros_ec_dev.c            | 9 +++++++++
>  include/linux/mfd/cros_ec.h          | 1 +
>  include/linux/mfd/cros_ec_commands.h | 2 ++
>  3 files changed, 12 insertions(+)

Just to clarify to the new Cc'ed list, I'm waiting on one of the
Chromium guys to review before I put my mucky paws over it.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
