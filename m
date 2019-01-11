Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1361AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9942133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217345;
	bh=zICRb0ah12o3aMvKX9hlUGnY9X0qislh+nuQ5YS3tgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gJNkjIk6QIjpxIBbEyFNo4iO3M9pffc4k467QzmkDq55MH+Y21scpPo6cbMjZ4XLr
	 XD8dxgWh6dOGmNVEjtEj3dex3jaRTw8LiHeIdq5qXl+eHQBVobUJQILVJMwk6Q2q0U
	 qwlHF7wS2c6YctjyIaaeSAKJLnuVxyCZxws3oPu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390219AbfAKOfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:35:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:55924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389553AbfAKOfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:35:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D355B204EC;
        Fri, 11 Jan 2019 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217339;
        bh=zICRb0ah12o3aMvKX9hlUGnY9X0qislh+nuQ5YS3tgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fsdw40aCBdVTlVwvl+HSC5ax9lvCbZeSTFIYnHOulBBXyx6YRcG3GPFnqiSKOouvh
         5YYhWrEhFjxiwO4cyPmNclspelqu1J5l7l1uLX7+gx/dJrharpjQpneTlO001L9Jhg
         Os2qYIbYhjYsMfZdwOnGWpbjmQrnMzCngTE/TVFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 008/148] ARM: imx: update the cpu power up timing setting on i.mx6sx
Date:   Fri, 11 Jan 2019 15:13:06 +0100
Message-Id: <20190111131114.670014368@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1e434b703248580b7aaaf8a115d93e682f57d29f ]

The sw2iso count should cover ARM LDO ramp-up time,
the MAX ARM LDO ramp-up time may be up to more than
100us on some boards, this patch sets sw2iso to 0xf
(~384us) which is the reset value, and it is much
more safe to cover different boards, since we have
observed that some customer boards failed with current
setting of 0x2.

Fixes: 05136f0897b5 ("ARM: imx: support arm power off in cpuidle for i.mx6sx")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-imx/cpuidle-imx6sx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c b/arch/arm/mach-imx/cpuidle-imx6sx.c
index 243a108a940b..fd0053e47a15 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sx.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
@@ -110,7 +110,7 @@ int __init imx6sx_cpuidle_init(void)
 	 * except for power up sw2iso which need to be
 	 * larger than LDO ramp up time.
 	 */
-	imx_gpc_set_arm_power_up_timing(2, 1);
+	imx_gpc_set_arm_power_up_timing(0xf, 1);
 	imx_gpc_set_arm_power_down_timing(1, 1);
 
 	return cpuidle_register(&imx6sx_cpuidle_driver, NULL);
-- 
2.19.1



