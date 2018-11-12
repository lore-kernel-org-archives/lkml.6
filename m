Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C37C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7733C22504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7733C22504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbeKMGRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:17:55 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36658 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeKMGRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:17:55 -0500
Received: by mail-ed1-f66.google.com with SMTP id a2-v6so8486593edt.3;
        Mon, 12 Nov 2018 12:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z3nwaoqzW3DowhvR2zzUu/qK2xyNTRxEAOnb40IHVms=;
        b=Vkq+TEMnt07G1LzbNbZuhHj7CkidAe6dB+X+h/62/JAnkbxtwOQR0UN0pjaGKsUFaJ
         sDGDYAH5m8oLVParybpIbpjRumtZxrMBZpDvBo8gwhr8iimg32Rbwv4y7CMGKk5fDm5F
         YbnSUHZlLhsW3i8oShlzG5so/rSgIuxR8HSanTL2s3NGY4K5+9RTNA+SuBMonsvyiPWj
         C6T93SyKkDapJEFLPvHTj/i8RRKU8oexzoxloQosqtWPJC+KdsMLHAH9rCqO4oZcbXqU
         3X8xCgv9bCcHz4hC9NiVLr6kz1PX/iaxFxMYDjLE7kkXWWwaRkrLiJYzmZUTUDvMuU6C
         wdCQ==
X-Gm-Message-State: AGRZ1gLU/D7yZ8Eu/8N54iQPZExkA8+nlfWj+ctZV5oPqFO1dZ26PPyR
        Bj0gZIKrHj/+mMg6bK3EhWQ=
X-Google-Smtp-Source: AJdET5e+ktiVQewzYxS7iwJtmGd+oKH86DYlzcxuENmeOAd6xblfkP4aTsTm/AY4wuV/yx4dWIrsow==
X-Received: by 2002:a50:a307:: with SMTP id 7-v6mr13497802edn.231.1542054184293;
        Mon, 12 Nov 2018 12:23:04 -0800 (PST)
Received: from kozik-lap ([178.38.103.27])
        by smtp.googlemail.com with ESMTPSA id h51-v6sm4757018edh.91.2018.11.12.12.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 12:23:03 -0800 (PST)
Date:   Mon, 12 Nov 2018 21:23:01 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: EXYNOS: remove no longer needed s3c_pm_check_*()
 calls
Message-ID: <20181112202301.GA25275@kozik-lap>
References: <CGME20181015134828eucas1p1b0b3287b5a330591e0976a3a83edbf11@eucas1p1.samsung.com>
 <20181015134828eucas1p1b0b3287b5a330591e0976a3a83edbf11~dzFPt-ZL_1531815318eucas1p1t@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181015134828eucas1p1b0b3287b5a330591e0976a3a83edbf11~dzFPt-ZL_1531815318eucas1p1t@eucas1p1.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 03:48:27PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Since commit 6862fdf2201a ("ARM: samsung: Limit SAMSUNG_PM_CHECK
> config option to non-Exynos platforms") s3c_pm_check_*() calls
> are redundant and can be removed.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm/mach-exynos/suspend.c |    7 -------

Thanks, applied.

Best regards,
Krzysztof

