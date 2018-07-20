Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89577ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F74620673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F74620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeGTImt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:42:49 -0400
Received: from mout.perfora.net ([74.208.4.196]:44057 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbeGTImt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:42:49 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MD7hi-1fo8yq294m-00GXbs; Fri, 20 Jul 2018 09:55:45 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] mfd: stmpe: honor gpio interrupt probe deferral
Date:   Fri, 20 Jul 2018 09:55:35 +0200
Message-Id: <20180720075535.26988-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:e0Apse07vyoJPmWNdZ7TSjBdtDUoThS3d+0NOsxjpCg06s8/vq5
 wGWN7rT4Jl8859nxrQemAFORuyuE2uOMnLtikKg91fozu+t+BdE4S1y0M5/RduLrnW9LuN6
 pnka0h4raeznkjkG7MVRpM8eHKT86iU3tYHaGLwp5GIoijShOTivYQ4UzY+8diMEI6KKd5n
 L+2JdltdZFRcc8ttI0WTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W74var+u0SE=:e5wYtkNwfqOVnc/8aSKk4S
 qCx1Iw/oWjQOZz1NWd/xxafRG2+1rtRogk8yc0WsHIMwZXeOQcU6r2DFFJ2FaX16cFK+9uqlt
 TqYpYiS7n1nExVLFKi/MKE9K9rAwkiGe+rv7AFPev91i9fTKGdXz4qARlr+TlBqdEr6t49Dxp
 +LOoI08wKyHsT5eIjOraAbw4COM+AqNmhw7D7VWZYDKXTjyj4A5uiifRxspAk+i4yQ48YBjJT
 ZO8t5YocEGwX+xI3rz0A7HvdgRNkTkyfYHiPlZsMPQIGSds3N440NeZH+UNTE29QIUGyOdJnF
 Gwn1pXi0jRnRqLBQGeTsNU7ZB3kkp2VZ7Spt+4T0R6Jh2vlxIpd5lwEetRymEOlwckaw/HyBh
 ACImyLWSQHjkXNZ8TOp+SthdPOwdROeCjIrrvYfT8BQtpORFIaf0Vhk5kNNSur57uYDYJJgJH
 jd9g0OCjJfh8eGAohxFcag6tvomPFnJ5Ka9A8xEt0RyD1eo23/txRqdefs41doDCPQmQ+9ScL
 gwVDNCGFNLTPyJiFde+AXkwHm1qR+Mix6fnNxvAGqFLYD3yTs8CRLRtK1fbDX9vSRAKqw4GfJ
 0vek9blBTNz+wIlSiItliaub/Hmxh6EXlpCSum+QYGEOsHweGkh97VRBcWo1nPoSWInpMRkTo
 p3hfsdTJAd3r/vsaHUAMbsnmVxkZ92iRvXr0uwRNboM/nL49hZVIbGeT31YSxsz04Hkc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Actually honor probe deferral in trying to get the GPIO interrupt as
of_get_named_gpio_flags() in stmpe_of_probe() may as well just do so.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/mfd/stmpe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 566caca4efd8..4d6ffd3ef398 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1331,6 +1331,8 @@ int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum partnum)
 		return -ENOMEM;
 
 	stmpe_of_probe(pdata, np);
+	if (-EPROBE_DEFER == pdata->irq_gpio)
+		return -EPROBE_DEFER;
 
 	if (of_find_property(np, "interrupts", NULL) == NULL)
 		ci->irq = -1;
-- 
2.14.4

