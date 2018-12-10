Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9481CC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A98A2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A98A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbeLJVBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:01:02 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:34119 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbeLJVBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:01:01 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MYvPq-1h1Cuy3AYa-00UuJb; Mon, 10 Dec 2018 22:00:36 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: shmobile: fix build regressions
Date:   Mon, 10 Dec 2018 22:00:23 +0100
Message-Id: <20181210210033.3276054-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dP0m1Lr68VWEmnpEQiiX5DpZfPi93rokPZF52SeRdzwu1eqQg7x
 L8O9gjgnmZCQA+FTohNwwJOwKPFaQr+IycHRx/0TdrNaTlLqqgXonSbgDl4LPTVg5cE+O8R
 y6TcLDpN8Eq8JZkvsiG6waajSVuJ3SgHXUhQFZZgoYN11ddoyP5FAlXD1LG61xyk64qKcva
 ebNcV7rOISwhtyEAQsvSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5ZBJWCYxsR4=:MglSuOS2QNtml4UUKFdfxG
 bIiduu1CDJ7c3KbOlQN9DZLMNCviekExhTKIyrvFSR1HpsyL4x2c9Ka5NwABkUuvdi+EgAOj6
 YV2JlV/74pa/uoYlkSQHYAIUKA9zv0wvcnu5BXrkph0KZWRmpKtmzYT5VIfUuYsaP21nhfCvl
 fxZCYq0XVjhJbIsw9ZUIvo10e0KQ41cX2SbjTgRi5GMnjD/cQJSW2mYQLi1QEjkT+Oevmc0Vd
 kb4WXdMvvaBx1E5EU1T1fV8fS7jqv3NoJjvll6ZB42kci9+397T8VFGwms8wix92iL3MC8Ujy
 0oZ4vlOHIgQp+ddH8OeMYnLFM4GTSkSVJ03TXBvPi0R3wr7MhWCGD//qfaZUys8SDCMu5eZew
 NPzg2ha8Tt9BQ6U4vsnmgAA/DMWDZHGTHVC4qemrWjELnKMt4k60//Nz/nwyb8BI7RgY9UaLf
 E4qtN0/skzHsTbpc4VdLnjJbVZV5/eNHxyk6ejtXHsYnhMNxT22GNy1agMcYbtoxOCx9FfJPX
 A953s784n9YI08x4u/7pWjogYZHJXyOmaPp5NcITzZhT24fFGMkqY2OgddP7R5gyuMQ8gBIdx
 PqtBf8EYDr+n3CinUQdJMFo8NOaWjfF97CwfzwX6I642bHwqhhc2IIAv9pnZIs3YYSsYTIkIe
 ZYdgtACMEK5HtMvG+ovAfvtwxkmpwyMp04IKQrJPR3KAANd1B4N0Hu8YgFFcPpaI8iIIB9hFw
 LoYeg4b5m4yZGRrXOfRqSpqdnykt5ToPHjtOfg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of Kconfig options have become available now to random ARM
platforms outside of ARCH_MULTIPLATFORM, which now causes Kconfig
warnings, and other build errors when those select options that
lack additonal dependencies, e.g.:

WARNING: unmet direct dependencies detected for HAVE_ARM_ARCH_TIMER
  Depends on [n]: CPU_V7 [=n]
  Selected by [y]:
  - ARCH_RCAR_GEN2 [=y] && SOC_RENESAS [=y]
  - ARCH_R8A73A4 [=y] && SOC_RENESAS [=y] && ARM [=y]

WARNING: unmet direct dependencies detected for SYS_SUPPORTS_EM_STI
  Depends on [n]: GENERIC_CLOCKEVENTS [=n]
  Selected by [y]:
  - ARCH_EMEV2 [=y] && SOC_RENESAS [=y] && ARM [=y]

Put the old dependency on ARCH_RENESAS back for the moment to restore
the previous behavior.

Fixes: 062887bf5ef7 ("ARM: shmobile: Move SoC Kconfig symbols to drivers/soc/renesas/")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/renesas/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 4d8012e1205c..68bfca6f20dd 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -44,7 +44,7 @@ config ARCH_RZN1
 	bool
 	select ARM_AMBA
 
-if ARM
+if ARM && ARCH_RENESAS
 
 #comment "Renesas ARM SoCs System Type"
 
-- 
2.20.0

