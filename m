Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12E2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DC1204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65DC1204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732790AbeGTPTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:19:51 -0400
Received: from mout.perfora.net ([74.208.4.196]:41521 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732163AbeGTPTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:19:50 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M6DSW-1fwFrM33G6-00yAJG; Fri, 20 Jul 2018 16:30:43 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Paul Kocialkowski <contact@paulk.fr>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Gilbert <benjamin.gilbert@coreos.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 4/6] ARM: defconfig: tegra: enable dynamic debug
Date:   Fri, 20 Jul 2018 16:30:10 +0200
Message-Id: <20180720143012.7740-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180720143012.7740-1-marcel@ziswiler.com>
References: <20180720143012.7740-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:LobQlTHUraj0kTsp1PL2pafoUNOH56BXmCCkEmVT6h6mc/QkywV
 Zuk/dEKJrmC/ipq3McrZ8m/hvy+AISc/QqAJ+VY0EOFAc5HiTjQ+Ok//qlfLCoyvmDhISs0
 4oA8aQZxR6TN3d1qTRns0mxv7fUo4QTQ16KjlsodXzbD+A3gzCDKKrjYYGe4HcBXBaT/mY5
 5GIJqOouRaNXLNUmTkOtw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5IgfVcw8sKI=:D3hZkmELtGcY9/LEjciJzE
 5QSG1X7LnVvJqeTbdpSGcAlLQtS1TCio3nzOcrsXLZ0iSOdixt0ZwT9SE7sEPyd9tYuGhPvyZ
 HZz1OMvA2HggaWCKsftxe2eDNmuHZZMpXNZQNetVILnIxRWHkoqZ62EjZVfzdbxrlU11RS+Fb
 /HzKLW4xqmZE1BXyDaOpar5a8dMjgLNwFhuQXrKoCYG7kdTiVG1VyMptW10tiFLcEiZARNrku
 Moj8XLR7OaEnimp6oqMVdFdVty0gx/nXgXvfk5df0Q9tQK04B3llFkiU6zRkWo1Ro8R3K8Spw
 UOzY4nIpVRunxy5G6nScfcrtSMrA70sO1A1pOu9ibt67pTyRdrbpTeLx4Qd0xr1rcWgRbTR3o
 4wiuJBm+SaNtoSh2sPX4jh5ECq4ejsEDbLWEySPMge7ifarCKdrq4ml8Js8TYsHNPUgScIAEX
 4BJMrfEjpColh5avMH5o33rgubCv2u8+JHDJF5nvoSztXNuAWx4uEsUlSi7DOKYVBnacO/YsW
 Z7EF89IqQ/8XGjnwpnApsXkfsRqTbnfYs7T7P527O3WY22Drw1vm4xbgg/Ap3S4UWoGKxCtdU
 RFXb8LmRr3O4xo5vMBzt8bnr55m2ofckzOioqdPFgnpmgmC5ogry+6a1WLhl+fPrcKlMwlkd5
 rGw+RuVYGsPB+ulMsznSGCwnuGDwGc6LVW115rAXdtpM/+uxiRWF4A2/Emf6hDvkRVKI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Dynamic debug is really helpful.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index c7b99ebf5fcf..24e297659b55 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -289,6 +289,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
+CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_SLAB=y
-- 
2.14.4

