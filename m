Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D77C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CAF20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761819;
	bh=acz44doNhjXes3RN/JTw/zUGxTDj5oPjoRrVCpf26vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WtLwHUMLgD5a1v0ltsCLvyhUKkM/tCQA/r34jjgG/EkPL+CpmU+tOPh8toZgt4OIw
	 s/UzKohdrL1ux9y0x9Z1y/T9cxFym6STvcFx7lqc4IPzQijgmGfPfmonWY3BCqMGUL
	 S5cFS3/dsNNuWnmqAxtKtJpxQKL8rXVgFtE6zq/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfA2Lg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:36:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbfA2Lg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:36:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 435D520989;
        Tue, 29 Jan 2019 11:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761815;
        bh=acz44doNhjXes3RN/JTw/zUGxTDj5oPjoRrVCpf26vg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YzaHaV9OOWPHTRUpND2B2ZSN8uZgN2O0xpFaFD9Bh6ax9xVLy6R1+sTtdBGl6dbJt
         YdK4vfrUFc9ZA2mOzVQlUHQqBSHxjnjUHgX24jXI+N15sIVLy0n3jag3RRfYZsJU4d
         7cSgyMWGx02kWiQpPwfIbgkemY1eQl2Xc72PMcBk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nir Dotan <nird@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 011/117] mlxsw: pci: Increase PCI SW reset timeout
Date:   Tue, 29 Jan 2019 12:34:22 +0100
Message-Id: <20190129113208.126037363@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nir Dotan <nird@mellanox.com>

[ Upstream commit d2f372ba0914e5722ac28e15f2ed2db61bcf0e44 ]

Spectrum-2 PHY layer introduces a calibration period which is a part of the
Spectrum-2 firmware boot process. Hence increase the SW timeout waiting for
the firmware to come out of boot. This does not increase system boot time
in cases where the firmware PHY calibration process is done quickly.

Fixes: c3ab435466d5 ("mlxsw: spectrum: Extend to support Spectrum-2 ASIC")
Signed-off-by: Nir Dotan <nird@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/pci_hw.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci_hw.h
@@ -27,7 +27,7 @@
 
 #define MLXSW_PCI_SW_RESET			0xF0010
 #define MLXSW_PCI_SW_RESET_RST_BIT		BIT(0)
-#define MLXSW_PCI_SW_RESET_TIMEOUT_MSECS	5000
+#define MLXSW_PCI_SW_RESET_TIMEOUT_MSECS	13000
 #define MLXSW_PCI_SW_RESET_WAIT_MSECS		100
 #define MLXSW_PCI_FW_READY			0xA1844
 #define MLXSW_PCI_FW_READY_MASK			0xFFFF


