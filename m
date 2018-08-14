Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FC7C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818BF2172C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818BF2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbeHNQyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:54:16 -0400
Received: from mout.perfora.net ([74.208.4.194]:33287 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731724AbeHNQyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:54:16 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LimxX-1gSE2Q2pif-00cy2j; Tue, 14 Aug 2018 16:06:28 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Joel Stanley <joel@jms.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [RESEND PATCH 1/6] ARM: config: multi_v5: enable dynamic debug
Date:   Tue, 14 Aug 2018 16:06:07 +0200
Message-Id: <20180814140612.12554-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:Ozygt/8dgZj9Biy2eebpCB6poDzrPak1kdqWv2STcEXJm+ZRYO3
 gg9NFDtJcjkO+a0NOOF7UPEBv/l7MBiXlKQxL3YFBqgX0JA4Kfy00l8y5lKOb7fpYvdBKbT
 F3F7yiH0UtkeLtuTNdBvprgvFK8FaQCy62RnLgGCSVY3s7IAagOz/xQ/d7jBCjoiFrNC4+1
 IVactaH46ZmdCMPS9Jq4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4VwhHlUm6/E=:Ackiv5BvWhAMbmjcjPKAf/
 EvDbwhKYQnPeQmnywTAkgHcoGbnIU6C6aa/cUoKpw0WKCfyJjKEuxGCN9pNHAUAz4h5I4YQaP
 KuLndQYbYOgHs2oYsnELab31h7DGsRwqSUyBLH8swrvDuWFiVgVgGwiCf1dEwpcl3/4CEsH7f
 9383/WyhM9SfJIVNqKaXlDDoai2JnJ1tYYZdz7Y+VvSj95JjwTkrbrzvVjdWAwhgepCiqkEjb
 +w1O6HLkeAiGHGFBCD+dDpX1gbxm+manMq1kkI2hUmVOu5XsNZarQWD9/P+1dnPMAYjYpLymV
 Ko0rnq/ozkVweiqXNFPHnJaHNb9cT0eX+Vgn3b/L+9aLUO5XX1XMv7qfHgkLHd7/ytcurt+n6
 zrIsh9ImKfk8f7y5NorqQpfoSKYPzJhTmdSUsZqdQn3Q2CdZrGhp+ImhAnRVCk67VLcAMjsNJ
 XKBmQzbTN7mCQ2E5IDmwpN7PJ8Go/nA/czjCR7okmguYRqBY+eqrg9RRYsrhfmEg3upI5tHrZ
 Nq9Iz3f6Bf0aKH3bSnWFAOiyw6+P+H7Eyz5F+22vP50iWXGvJcaaoo8LvMfarnwqLY8YXFEzM
 VIoIaLrmhBfw1b8gQ5cANLHSew0nTDLHQAvNQTNqh+f16dzeH+rFKIqDJvMopEtaHDAApiof7
 ELv/1cNE44VHunsH96wa3uWfx8kBLYEIFQ3nSnevQJIrsUSJO3Xq61vDYSWA8w/Nkdvs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Dynamic debug is really helpful.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/configs/multi_v5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 318b76fa26d1..b302ac68d587 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -275,6 +275,7 @@ CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_2=y
 CONFIG_NLS_UTF8=y
+CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
-- 
2.14.4

