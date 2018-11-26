Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB8EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C761B21104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQ8ZejE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C761B21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbeKZVvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:51:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbeKZVvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:51:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06E4921473;
        Mon, 26 Nov 2018 10:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229844;
        bh=KBsmA8s+FX6UGZ9yE+Cnayq6+oR/VcQIqY2HNbZs3Mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQ8ZejE68s01vvRVoZfLMxCpTEbgYTf9XQ4WyFVHwIWScjjy+tlRO5wB1H2COJFWG
         O1A5Q3lupGqNwjNN5VZgm0YiM9f6X7ZUANix4wmE9AUSHCd6TLRpbjWF1i/RML+YzE
         Yy1iZctgzBPQGdk6y9g7uMRMpnEKFZ76T6+Wv8nw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vignesh R <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 22/46] i2c: omap: Enable for ARCH_K3
Date:   Mon, 26 Nov 2018 11:51:11 +0100
Message-Id: <20181126105048.294975867@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105045.447291262@linuxfoundation.org>
References: <20181126105045.447291262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5b277402deac0691226a947df71c581686bd4020 ]

Allow I2C_OMAP to be built for K3 platforms.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d252276feadf..94669d96bd19 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -706,7 +706,7 @@ config I2C_OCORES
 
 config I2C_OMAP
 	tristate "OMAP I2C adapter"
-	depends on ARCH_OMAP
+	depends on ARCH_OMAP || ARCH_K3
 	default y if MACH_OMAP_H3 || MACH_OMAP_OSK
 	help
 	  If you say yes to this option, support will be included for the
-- 
2.17.1



