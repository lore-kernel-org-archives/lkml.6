Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5148C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A31D2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ij8EUcAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A31D2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbeIJT5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:57:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33535 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbeIJT5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:57:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id v90-v6so22368121wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bkhv8MQABDqIh2buPfgqFTV+zrwqzW/aIGIoLp97Xms=;
        b=ij8EUcAA7uuablSvOQ0GgzzKCWohQW+xXEE5PhvgK/O2cCsGUEv2VcngMSL70pzppI
         9vnrnBM+175OpksJv7hi5WMjlFs5ErqR3uQJiKQ78YiXT80/hr6bjAk9kUlhz+wmsLVV
         w8sbLxT1AZVlKmgXKlxnB+uu+Jmz9xmRpwjgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bkhv8MQABDqIh2buPfgqFTV+zrwqzW/aIGIoLp97Xms=;
        b=Xz3/ul01YUaQKgRvyPX2bOmy03oXpmYx3O+JFNDRF+q+9AItjCyMf9h0nkOqwSSmKz
         pEOKaIEyUHEZlObjMXWDNheAW0bl+V6B+NnhcSlzJ3US0a8RQDLmhrx3NjrCVAF6TVjc
         /N3d4zk1G4R/uNqI7YBGB5/vSjB194Z99lxQGwve+ArHCW9SKPFNecgEwOIGiqJHK+gv
         IajT2lEVoeI7L/Fn/8vCzjTLUcPIcJHGYf4MW2IYIVo5E8ZNdMkPxUUzXVRNPfNyYDAO
         NbBNx4usmQFgQoRh2eYC11BADkwfVrU0HUE2wzSgwHn4Qe/DHdulqkJ8LsPmGRvhggx3
         3Phg==
X-Gm-Message-State: APzg51Av8AfOh3uNDO5cMxO62PXVX+b3uEzGLY46kODc5tQw+IzVQ0Vx
        LF6p1yAJ1613M7YNQ4DGk57oRQ==
X-Google-Smtp-Source: ANB0VdbHCOOLB6nzktB2fEDfTWZOPndKvfPIehbZMR12s59AOQtVL+iMr5DvbHAzjyBM8rQIlI6qoA==
X-Received: by 2002:adf:9a21:: with SMTP id z30-v6mr14219684wrb.47.1536591767731;
        Mon, 10 Sep 2018 08:02:47 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id i4-v6sm16291903wrs.85.2018.09.10.08.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 08:02:46 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:02:45 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     sapthagiri.baratam@gmail.com
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>
Subject: Re: [PATCH v2] mfd: arizona: Correct calling of runtime_put_sync
Message-ID: <20180910150245.GW28860@dell>
References: <5b7c2583.1c69fb81.c4b41.086e@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b7c2583.1c69fb81.c4b41.086e@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2018, sapthagiri.baratam@gmail.com wrote:

> From: Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>
> 
> Don't call runtime_put_sync when clk32k_ref is ARIZONA_32KZ_MCLK2
> as there is no corresponding runtime_get_sync call.
> 
> MCLK1 is not in the AoD power domain so if it is used as 32kHz clock
> source we need to hold a runtime PM reference to keep the device from
> going into low power mode.
> 
> fixes: cdd8da8cc66b ("mfd: arizona: Add gating of external MCLKn clocks")
> Signed-off-by: Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>
> ---
> Changes in v2:
> - changed signed-off in commit message to full name
> 
>  drivers/mfd/arizona-core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
