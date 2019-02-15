Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72259C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADF121B1A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kLZgpmGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394045AbfBOLMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 06:12:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43942 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389957AbfBOLMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 06:12:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id r2so9878848wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 03:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YXmDuuP3jHoilOmEftWxAROrXZ617W04HSxSZN9uecQ=;
        b=kLZgpmGWoIqtQmwbZNe2vQbr1qI5dQIhXhWPXKFR2ZGIastxfHiyMYj8IoUWhCf28D
         V0sQ1KYNxTIuZJJ5Lt/uuZXg/P0kTiHtbnZSTQPvzfX7tJusNVNfx2lqXwUn7p5K58lB
         +louPxlWfnNIE+MQ92k2/yGxV6lvBuNrOZ8gLvJ7ObMx3uAg7OU4x3GwOxHWZkFlI6Fo
         XVI86hhwSIwtHGO6cfFch6Ty0zon+WRQip1P1jAhFTgSMozPJvYX0sc3WErUHyzDbgW2
         40EutGKrgxPJAVf5jZKsNDavi8gxRBd4OfoiuJQ5EDZ7U6EgoaUYwV4Hx2ZFFFDH/w9B
         3OVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YXmDuuP3jHoilOmEftWxAROrXZ617W04HSxSZN9uecQ=;
        b=Z4x1gMeDQ0xjJJbFrhDENPUU8497/O6L+J44m7PqEr0waGdepiUxxVogusMiUJKYoJ
         bSY3dD1ZXB3dUmm0bGmoZ0Bn8c3MJuPPYAbALpt/Mn06SRvhl3GN3TOvh5NRzKMcPZSD
         nWs5x3nq6jZXCbTBfGx4N5U57oOOhprrPMghkATwrwJQI6CH0QpvsrVX2Kk3oW544X9w
         KNd7Mgi49BF+u1VuNey85YXq7P+xjWv5bg8bvK1DjremrI8CO66llb2BnbnyxGMuLA3X
         PcPXSS0hTihZPYC++ulCWHO+9cYnp9thSR6o1KOzu3EVSi5WcA/Hculv/mR5GkZ+Y/Tr
         z5tg==
X-Gm-Message-State: AHQUAuZ2UMnf+DQ2M9JyTQY50epEFnUuJ3mQ23zjLH7aQIqdFtJl235O
        tff+JTu5x4e9ITbEBVWZkrRs6K5V4Dr+lA==
X-Google-Smtp-Source: AHgI3IZRlYJN3hoJU2RxLmiIGcE13cTzmFxef/hTFDqCc9fKzKEy8V/WaBS1ohsWCWzvcFXw4EKopQ==
X-Received: by 2002:adf:efca:: with SMTP id i10mr6377789wrp.265.1550229150429;
        Fri, 15 Feb 2019 03:12:30 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id f187sm3810223wma.4.2019.02.15.03.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 03:12:29 -0800 (PST)
Date:   Fri, 15 Feb 2019 12:12:27 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        khilman@baylibre.com
Subject: Re: [PATCH v2 0/2] ARC: rework U-boot arguments handling
Message-ID: <20190215111227.GA24034@Red>
References: <20190214150745.18773-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214150745.18773-1-Eugeniy.Paltsev@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 06:07:43PM +0300, Eugeniy Paltsev wrote:
> Reworking U-boot args handling and enable uboot support
> unconditionally.
> 
> Changes v1->v2:
>  * Drop magic number check [in this patch series]
>  * Keep comment about cndline appending
> 
> Changes RFC->v1:
>  * Don't add new ABI contract between kernel and uboot
>  * Eliminate CONFIG_ARC_UBOOT_SUPPORT Kconfig option and
>    enable uboot support unconditionally
>  * Skip invalid U-boot args instead of panic
>  * Check existing U-boot magic value
>  * Improve uboot_arg validating
>  * Minor code changes
> 
> Eugeniy Paltsev (2):
>   ARC: U-boot: check arguments paranoidly
>   ARC: enable uboot support unconditionally
> 
>  arch/arc/Kconfig                        | 12 -----
>  arch/arc/configs/nps_defconfig          |  1 -
>  arch/arc/configs/vdk_hs38_defconfig     |  1 -
>  arch/arc/configs/vdk_hs38_smp_defconfig |  2 -
>  arch/arc/kernel/head.S                  |  7 ++-
>  arch/arc/kernel/setup.c                 | 96 +++++++++++++++++++++++----------
>  6 files changed, 70 insertions(+), 49 deletions(-)
> 
> -- 
> 2.14.5
> 

Hello

Tested-by: Corentin LABBE <clabbe@baylibre.com>

It worked on our LAVA lab  along with my "arc: hsdk_defconfig: Enable CONFIG_BLK_DEV_RAM" patch.

Regards
