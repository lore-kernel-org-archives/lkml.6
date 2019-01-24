Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED025C282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD960218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548362766;
	bh=k0n/p5dJVlcUJ25hQ0Ry3uyFlaibpF4bv6ihmWJWKgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H2789Bm+dZVicsIa/ZLgDHpfDBnbrVEnGTbzg8Bus9Stujp5k3cVhw3KherAQ5WmW
	 XLlvhRhYkilLFWt6VpPdxVcTWiWgjDxqySTcVF06IQwCXyiLtPhth3x06X+5g++k3h
	 osYK/KkAkXHD4s2J8etkKAYUIj2059N8hKsowNfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfAXUqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:46:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:52488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbfAXUqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:46:03 -0500
Received: from atull-730U3E-740U3E.fm.intel.com (unknown [192.55.54.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53201218D3;
        Thu, 24 Jan 2019 20:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548362762;
        bh=k0n/p5dJVlcUJ25hQ0Ry3uyFlaibpF4bv6ihmWJWKgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FxjPl9xQAMMDkFV8+LLs4IG7ZVPGt/t2wYl5Ubo5dTDcXm9bzwI6kgLvR0o0xz6E8
         oETF3yG9QnXEA+kBc+r0doP1iYBzwv/DmQkEo/3zQoSOC/XJv6lqM5VQk9QvzNkc52
         s/m7gyXxRMttcaXEEJiXVdS36+bG/wFbfRZf8MDA=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
        Alan Tull <atull@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH 2/3] fpga: altera_freeze_bridge: remove restriction to socfpga
Date:   Thu, 24 Jan 2019 14:45:53 -0600
Message-Id: <20190124204554.5438-3-atull@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124204554.5438-1-atull@kernel.org>
References: <20190124204554.5438-1-atull@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Altera Freeze Bridge should not be restricted to ARCH_SOCFPGA
since it can be used on other platforms such as Stratix10.

Signed-off-by: Alan Tull <atull@kernel.org>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 0bb7b5c..c20445b 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -104,7 +104,7 @@ config SOCFPGA_FPGA_BRIDGE
 
 config ALTERA_FREEZE_BRIDGE
 	tristate "Altera FPGA Freeze Bridge"
-	depends on ARCH_SOCFPGA && FPGA_BRIDGE
+	depends on FPGA_BRIDGE && HAS_IOMEM
 	help
 	  Say Y to enable drivers for Altera FPGA Freeze bridges.  A
 	  freeze bridge is a bridge that exists in the FPGA fabric to
-- 
2.7.4

