Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81725C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AFF206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48AFF206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeJDXSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:18:31 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:60435 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbeJDXSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:18:31 -0400
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.184]) with ESMTPSA (Nemesis)
 id 1MplsZ-1fN9cJ1Y57-00qCmk; Thu, 04 Oct 2018 18:23:58 +0200
Received: from evilbit.green-communications.fr ([92.154.77.116]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.184]) with ESMTPSA (Nemesis)
 id 1MplsZ-1fN9cJ1Y57-00qCmk; Thu, 04 Oct 2018 18:23:58 +0200
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC UGLY 2/2] arm: Re-enable interrupts after shutting down non-boot CPUs.
Date:   Thu,  4 Oct 2018 18:23:39 +0200
Message-Id: <20181004162339.19493-3-nicolas.cavallari@green-communications.fr>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004162339.19493-1-nicolas.cavallari@green-communications.fr>
References: <20181004162339.19493-1-nicolas.cavallari@green-communications.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:J2JJBOXLdWMTs9GeNXaIdK09iynujUFT7O/BQ0rcpZcevf/zkBd
 UPTpP4CYXjzE5Fxhg0DOKrkos6gywaJWj30LtLiomZRiGcWy1v9mOiGEHT0hkGZnNKWjLlL
 uXHBMdPAhDR6DG+8r7Hg3veElYti3tcp+nNHFkkjX6FaP3byrQzjWTV+z5tMjO05gwyp8hB
 CH2eBRDIZTcto1Rmno2Sw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eee4qCK3uFs=:2xKKoZlHsAFg8KRt33XJg0
 kEMZxQ/eKOfjjmeNSkzn4zviSnXhbyTZeikZDPtrkuV2466t0E88l0DqOZUdySiNMuxCzd8/t
 7JXyaBK5mY7u7MuuihhNtGLAK+CzuDkACMQHWGnkwwLGuzbQh1gaycYTXGvH1zBPlft12rS/B
 R4R/T+f18BK2q79NQ1VEEhNbOT6AT0jQcw2KMmBLiGvM2Vm+QXmHpgMYJ0rwpr4n10BndGQe2
 ozqatkiGkVUHB0+IhTteyD2Qp9Y+nZqqaW7SbwQUXtO4G3WKHV0jchVsn3uKypHMvZoVfNJFy
 9OYKlYhYNVFsdAR8adT2vsas73PuivD6688kEl5hYOY/y6aUoBTuXGTBfJW/e5D15bz1r3qAb
 Mv7b9By9jMKhg4CasjV2fIIOCNgfKkYGTYPWr2VO8Ep+j48qUET2vXm5rMhQWnywm7gE7sRRN
 eSQnHcVGfYbv9zt+KSREfspZeA7OHxpcceDYH1NMuhytU6ay7Kui9HsW9Tblav4+Ta0dDXUyf
 rOy2M5jr1ZoGkUgqvLtVD90/8Kp2+d1gBN6qMCFUOaf2nVJW7wQmTqj1pXnPp0z5UI/tyy3Cg
 V40R41KpNAOOFLI1r+XroPnqROMKF5dy3EzFn9FwGe/uvjqYj9c83XNeZbibcZ+lvl2ttR8Ns
 8O000r516DASE1JD7+h2gehJpMdskYl54uLLUNBrWevtR+mmvowMMv5Z6AsCRxPnR+LQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some system power controller are behind bus like i2c, whose
controller driver requires interrupts to work.

Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
---
 arch/arm/kernel/reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
index 3b2aa9a9fe26..2773068c0d67 100644
--- a/arch/arm/kernel/reboot.c
+++ b/arch/arm/kernel/reboot.c
@@ -140,6 +140,7 @@ void machine_restart(char *cmd)
 {
 	local_irq_disable();
 	smp_send_stop();
+	local_irq_enable();
 
 	if (arm_pm_restart)
 		arm_pm_restart(reboot_mode, cmd);
-- 
2.19.0

