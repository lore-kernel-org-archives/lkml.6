Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B471FC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6CD2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544734622;
	bh=uj/xZEidF1ke+LGV6RZwcZMzxRmtBNv9eXwm5IcCaR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GaNQdd7ajT8meSD8vLiNIzc3WP6JJg9dpw8hpZ4laIm6pb8z38Kc3TRcvYeiNhP28
	 HvnUyl5dcDLV4ua6wKES6KNOosPHHRm1yB4zzKcTvxtOEv30AaY4nkn1E9yuyGQK1l
	 +HG1lVrUpWNKskaSlJ4JfoDyYaLecCsefi8r3yWQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6CD2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeLMU5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:57:01 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43861 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeLMU5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:57:00 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so3177064eds.10;
        Thu, 13 Dec 2018 12:56:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jiloVI4DrNhUNu7aY7/oZysl09FBOMw9CGKSD2mADwo=;
        b=rOl7wQiN1MdRnTzdR8JYu/JGECzmjwrBamgm+EmQfuqSGDzGvJYqWaeQrk138GVysq
         MqlmatqPag9Xh4oYOFTPRYVWIXpy61a6jBI3dQUqdaz0lITl+jRlF4yxA4RWnbIg1UT+
         kMl34GbtFVuv3HNy4TdxQw18OTVqedGlx1pcaSCyJ+8fI3+3saoij3hhfKhoRcCjMXit
         vBI+pDTdg+4yhgnQd2f/N5tfRIS/hKizn3C3lMdKBFepVLCB2g2gmfSl9bfR1rbjpMyh
         3vO41Ggb3rMk6wBJYwOAwKxvCYjyNsWn2SSZRJKcaEzhRr2rPs/CcGHr7yXMIKhqse9Y
         crzA==
X-Gm-Message-State: AA+aEWYsv4czv+QVI34R6NbdQtRoBfubk3TGj6tzD/g+SKxhmPd+ZPrp
        Y9axSyo3zTFui8n+f2cuLRfVLc/ofNA=
X-Google-Smtp-Source: AFSGD/U9XmS2tnwU7yZRrWHUL/Q2DnsFdknROFBl/iTeUqL5CbvUd+O1yT2s+TJNdtxoUQfsw4WV/Q==
X-Received: by 2002:a17:906:7692:: with SMTP id o18-v6mr524296ejm.63.1544734618522;
        Thu, 13 Dec 2018 12:56:58 -0800 (PST)
Received: from kozik-lap ([178.38.170.116])
        by smtp.googlemail.com with ESMTPSA id w24-v6sm497373eja.71.2018.12.13.12.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 12:56:57 -0800 (PST)
Date:   Thu, 13 Dec 2018 21:56:56 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: exynos: Specify I2S assigned clocks in proper
 node
Message-ID: <20181213205656.GA799@kozik-lap>
References: <CGME20181212175813epcas2p26f7ec0e0e5e90d1e9cb7aeccd273e0ab@epcas2p2.samsung.com>
 <20181212175744.8287-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181212175744.8287-1-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 06:57:44PM +0100, Sylwester Nawrocki wrote:
> The assigned parent clocks should be normally specified in the consumer
> device's DT node, this ensures respective driver always sees correct clock
> settings when required.
> 
> This patch fixes regression in audio subsystem on Odroid XU3/XU4 boards
> that appeared after commits:
> 
> 'commit 647d04f8e07a ("ASoC: samsung: i2s: Ensure the RCLK rate is properly determined")'
> 'commit 995e73e55f46 ("ASoC: samsung: i2s: Fix rclk_srcrate handling")'
> 'commit 48279c53fd1d ("ASoC: samsung: i2s: Prevent external abort on exynos5433 I2S1 access")'
> 
> Without this patch the driver gets wrong clock as the I2S function (op_clk)
> clock in probe() and effectively the clock which is finally assigned from DT
> is not being enabled/disabled in the runtime resume/suspend ops.
> 
> Without the above listed commits the EXYNOS_I2S_BUS clock was always set
> as parent of CLK_I2S_RCLK_SRC regardless of DT settings so there was no issue
> with not enabled EXYNOS_SCLK_I2S.
> 
> Cc: stable@vger.kernel.org # v4.17+

I gues your format would work (got recognized by stable scripts) but
strictly speaking format is different:

	Cc: <stable@vger.kernel.org> # 4.17.x

https://elixir.bootlin.com/linux/latest/source/Documentation/process/stable-kernel-rules.rst#L127

Thanks, fixed and applied.

Best regards,
Krzysztof

