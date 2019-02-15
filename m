Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC210C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE1F2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJzsib64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbfBONtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:49:43 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:34965 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728867AbfBONtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:49:43 -0500
Received: by mail-pl1-f176.google.com with SMTP id p8so5004882plo.2;
        Fri, 15 Feb 2019 05:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DfqK7G6Z8uqxp4/+Vbn1rJPLtNBXQDBYtHyEFsqb8oo=;
        b=FJzsib64jvNe/JRzdrf+2t0nRqU4lw3YOwJSeecgF4LvYUcUDMUA2DsI4Z58sdP02i
         cyue7wLzqqfT7t5hB7fwSNCNcH1cDkS1exhCZuFjBWPtUDNbDvB+axgm4U1jiAIeInGD
         5jXYuUjq1dbCyD3CCZHGxaXgbW+pfVTHCAkuBhmnUw5MWZcP9NGkg7IDSFa4NVlqWsFk
         mkuOpLmYua1qEQuzkzfwMpUkiW72koZXsJxu1BRInx/Mie2t2TDCpi6LS+BZhK4rvucI
         ek3HbKxkU3X4VfBvyyZqY+2k2xKO6t7WDfN2QtoAlAkC76rUlentUYGUuEjWHOwLBxc6
         qAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DfqK7G6Z8uqxp4/+Vbn1rJPLtNBXQDBYtHyEFsqb8oo=;
        b=N2LiFrJ/MO6zf+AkcK3JpDV2d0xuX0TiIrd6vwvLxxUpMQekqbvnnxgJzOxYN2oZQL
         XkXI4UhXn2wcZZ7pMQ7R3Uxj/VE11uPpKvWqomdYpBGwZnMUWfNyQnf42rH8v+erY3I8
         LwiOMq2f3bajYfe1vrjruZMU5qx3NobmjZwpI6yPbhpO6Yr0eOdZGhBY7YX+tA6rs+Pl
         AzgwDVqqlH1NLstdiAtG04p911KEXG4ZUqhYIRCuAZtvyn+B1xnqLaYrYl75WfeiQbki
         wQ8bqm4gok7URZKfrp0LMvmzdvHNtzdEG/1jssHlCSSeEsCeMa3uGI57QsnQe0fg+hp0
         O3OA==
X-Gm-Message-State: AHQUAuZqmtXQmdDKrIULlnH8ENi/ufxTLNDlhnfMHsqk9ZeZegripqbe
        MH1dT8ImDwP9hmPoI+Ss0+s=
X-Google-Smtp-Source: AHgI3IZ0VknK1t7bstqX/OIsnOjFf4LazoS61AzAbDjQ+A/3knVbnBUNOAv9/kO2QKQf56iXhcnsdg==
X-Received: by 2002:a17:902:b494:: with SMTP id y20mr10554524plr.178.1550238582097;
        Fri, 15 Feb 2019 05:49:42 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id b24sm7365755pfe.136.2019.02.15.05.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 05:49:41 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATVH v2 0/4] arm64: dts: allwinner: h6: Enable CPU
Date:   Fri, 15 Feb 2019 08:49:33 -0500
Message-Id: <20190215134937.10259-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the cpufreq support of h6, source of information is as follows.

h6 cpu opp info:
https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/arch/arm64/boot/dts/sunxi/sun50iw6p1.dtsi

axp805 spec:
http://linux-sunxi.org/images/b/bc/AXP805_Datasheet_V1.0_en.pdf

Yangtao Li (4):
  arm64: dts: allwinner: h6: orangepi: Add CPU supply regulator
  arm64: dts: allwinner: h6: pine: Add CPU supply regulator
  arm64: dts: allwinner: h6: Add clock to CPU cores
  arm64: dts: allwinner: h6: Add CPU Operating Performance Points table

 .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  8 ++-
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  8 ++-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 63 +++++++++++++++++++
 3 files changed, 75 insertions(+), 4 deletions(-)

-- 
2.17.0

