Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B59DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C981421480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="pkOLwWAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C981421480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeIZJxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:53:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37771 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbeIZJxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:53:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id v9-v6so23793733ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 20:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LhiyKj3/zC7+le7iHTQaG67XX63HP8gylmbaTv/o3DQ=;
        b=pkOLwWAUI/GFQQ/g5bjhAELUDSO/3ByIlXFudt+90seidd0BNYBxufo+fqsFl59y3k
         fmAp9hrio0ysRCpzU7nyBNw8n08uEanSWWCKsTVV8xW1EAthEYgZpNEMXmheyHGq0yuA
         oMydc5zqqwpGf7EHwqJDfCaH9pDYpGDKFXvwS2MkDPGQO3aH+xAtT1WE8KmChoakcCwa
         gaVbgrKEVzrI7Y6lHG2CJhbO1Ov2mgfBrhFAAxCEEjlTu/dIR9feJa6TWcS71+0m3mVg
         v0wEzeoUdRHlGaEshMMYA0qW3W2QQ8xHrem1Vx3S7QcyVpO5R6t4WQaGnwhvdqtNdX/T
         9svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LhiyKj3/zC7+le7iHTQaG67XX63HP8gylmbaTv/o3DQ=;
        b=TALGlq8F9s5lDtKOLeT6zVd5kQ0ZCob4eloZ8+MxXYCj1m8pH3ITdG9dWmwNtl1010
         t/9BNfAMrgcQ6RLaOBKDgLnx3ZQz3hB2ro1TdEAd0XaIdpQFFtl6yuMF/sGdZDLZID1S
         cVs4kjh/z7bu8BZrR/o8FJhtIzC4EVoHeOVOKNPFZkzMgRw/LXUbMvUfaD46UiWBNNcb
         2YVTx8xO4pJT0eYSHeNNSJDuLl3Q3jjJYxm89NwzwNywQb4kOS/m9b5C+InRyiI/Msi9
         zm8xhL0Vy3AafKLdifCXFoS5rNrMghgT8QG3N9gK6cU5lT22bMMStD3zkHZi0ShUhhFi
         uF3g==
X-Gm-Message-State: ABuFfojYAt2aIYfp2EXgBAMHRuJe8Ypfy4Ja3NcDyLR11VtNddTb3IB+
        bXiwwpJ/YQNJmQhYt7gCHO334g==
X-Google-Smtp-Source: ACcGV62vhteUBnPyiqGmDRcm+na0IpE5zZM8jZssWQCN7yc5p2T1Pq4flXNHS6rV+7OsKzYu8LY5TQ==
X-Received: by 2002:a2e:924e:: with SMTP id v14-v6mr2795994ljg.24.1537933351678;
        Tue, 25 Sep 2018 20:42:31 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id y2-v6sm718136ljc.52.2018.09.25.20.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 20:42:30 -0700 (PDT)
Date:   Tue, 25 Sep 2018 13:50:51 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] ARM: dts: exynos: DT for v4.20 (or 5.0) (revised)
Message-ID: <20180925205051.gdk3jw7mwlom45ox@localhost>
References: <20180924172133.11786-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924172133.11786-1-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 07:21:33PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Pull request without ABI-stability patch.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.20-2
> 
> for you to fetch changes up to ff1e37c6809daab75f7b2dea1efe69330e8eb65b:
> 
>   ARM: dts: exynos: Correct audio subsystem parent clock on Peach Chromebooks (2018-09-24 18:55:16 +0200)
> 
> ----------------------------------------------------------------
> Samsung DTS ARM changes for v4.20
> 
> 1. Bring up DSI and HDMI on Exynos5250 Arndale.
> 2. Use the new way of setting external wakeup interrupts on S5Pv210.
> 3. Use proper cpufreq suspend OPP to fix suspend/wakeup from RAM on Snow
>    Chromebook (Exynos5250).
> 4. Fully describe regualtors on Odroid XU3-family boards.
> 5. Fix sound in Snow-rev5 Chromebook.
> 6. Fix regulators configuration on Peach Pi/Pit Chromebooks (Exynos5420)
>    which should be always on.
> 7. Fix pull control on PMIC interrupt lines on multiple boards which
>    essentially fixes waking up by RTC.
> 8. Add PMIC interrupts on Exynos4210 UniversalC210 board.
> 9. Add external SD card support for Trats board (Exynos4210).
> 10. Correct audio subsystem parent clock on Peach Chromebooks.
> 11. Minor cleanups.

Merged, thanks!


-Olof
