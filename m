Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9423C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF3320658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYqtzO7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF3320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbeH3WIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:08:43 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37080 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeH3WIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:08:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id v9-v6so8019469ljk.4;
        Thu, 30 Aug 2018 11:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sDZqQay6ciF2WLUaQBAG4CwLyQbKEA7+WWTKFXjMJcI=;
        b=WYqtzO7NKB48F6DFhfSj93EpUuygYoSAZu+1CbbTrObu6wpFwAPVcfTsmmMpHGnV0e
         7NPxXaoo/gHxF9/WentS0glgPfmX+hYlz93cezkIeEpISkL1TBmBc5eN8CL6adaxq92G
         1zr320KX9eVufn1lx/Gngthqjfdu7wVlasHBaQSYjLHauS7TzTrblYnAnuHj1W5/GlxS
         a43M/2a3Gyf7q34ujX1AbNZREjEb7pQi0iU+t+/CbnzJ1VVKhyvLwYnZeL7oxTlBJ7Pl
         BcQ0XH4tMnIiqmdCXF6ecqBBUt3PXJ3Ocv/3wrO8xCIbh+9dDEFCsdLRI38qMvGzPNmt
         vkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sDZqQay6ciF2WLUaQBAG4CwLyQbKEA7+WWTKFXjMJcI=;
        b=EJXtW1pD94oEzrcJ+cBih4mrEDnk6jGl249szwLF73RIpQqEpYjWtYiyNMMZIUld6Q
         jbjQSoLH/17UrSXQFR6FHATKGjd8hBV6K5pJa1lj/iWaWIVwVRhJeY/YdE7ojkpu9pzb
         ePtiwtOe/kMeferWWkNzvBQjs3zbM5NhJ8Qzo2EWWPQ4QbhY6rjLTIZGYwdpqlioU4Uq
         oqWr3vX7Y273UBm+gL/DVSwClcwvw4X/iSuBZZymxVFtwKu35QvPJxwrawyATv7nHsOb
         Xi9NgTIsfBENqT0MCPUsIW+AySJLFI41LqKBSUcWxcfV2iO5cPZMARGRaX/ztY5VHKBF
         FafQ==
X-Gm-Message-State: APzg51CnFJjPvBXF7SIgl6TbAK5WXHxziGw9ygBuuN76df7GTCJAcDUX
        zHsZIfE5TWvShAPaHMqpL7A=
X-Google-Smtp-Source: ANB0VdYNHV7Qi/XKX3aS7cTd0vCw5cddaED03yvem5AC/rXc3DtwqJvGT09kfvLr5ooqIsSc0chPqw==
X-Received: by 2002:a2e:2096:: with SMTP id g22-v6mr7959244lji.37.1535652321573;
        Thu, 30 Aug 2018 11:05:21 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1420789lfy.87.2018.08.30.11.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:05:20 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] Support Trusted Foundations firmware on Tegra30
Date:   Thu, 30 Aug 2018 21:04:13 +0300
Message-Id: <20180830180421.6415-1-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

All consumer-grade Tegra30 devices, like Nexus 7 tablet; Ouya console and
others, use Trusted Foundations firmware that doesn't allow CPU to access
secure registers directly from the Linux kernel, these accesses shall be
done via the firmware calls. This patch-series adds a full-featured support
of the Trusted Foundations firmware that opens the door for supporting of
various Tegra30-based devices in the upstream Linux kernel.

Changelog:

v3:	- Implemented suspend-resume support.

	- Reworked arm/firmware/trusted_foundations.c a tad. Now cache
	  is getting properly initialized, cache enabling / disabling is
	  supported.

v2:
	- The "Don't apply CPU erratas in insecure mode" patch got some
	  cleanup, in particular resolved the messiness in
	  __tegra_cpu_reset_handler_data.

	- Added a comment to tf_cache_write_sec(), justifying the warning
	  message.

Dmitry Osipenko (8):
  ARM: trusted_foundations: Implement L2 cache initialization callback
  ARM: trusted_foundations: Make prepare_idle call to take mode argument
  ARM: trusted_foundations: Provide information about whether firmware
    is registered
  ARM: tegra: Setup L2 cache using Trusted Foundations firmware
  ARM: tegra: Don't apply CPU erratas in insecure mode
  ARM: tegra: Always boot CPU in ARM-mode
  ARM: tegra: Support L2 cache maintenance done via firmware
  ARM: tegra: Add firmware calls required for suspend-resume

 arch/arm/firmware/trusted_foundations.c    | 80 +++++++++++++++++++++-
 arch/arm/include/asm/firmware.h            |  2 +-
 arch/arm/include/asm/trusted_foundations.h | 13 ++++
 arch/arm/mach-tegra/cpuidle-tegra114.c     |  3 +-
 arch/arm/mach-tegra/pm.c                   | 43 ++++++++++++
 arch/arm/mach-tegra/reset-handler.S        | 66 ++++++++++++++----
 arch/arm/mach-tegra/reset.c                |  3 +
 arch/arm/mach-tegra/reset.h                |  9 ++-
 arch/arm/mach-tegra/sleep-tegra20.S        |  4 ++
 arch/arm/mach-tegra/sleep.S                |  4 ++
 arch/arm/mach-tegra/tegra.c                | 10 +++
 11 files changed, 216 insertions(+), 21 deletions(-)

-- 
2.18.0

