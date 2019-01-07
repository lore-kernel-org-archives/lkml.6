Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893F6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F50920665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865682;
	bh=FEtorfNJdDpRN+lgyGp92lFP+meoUjit+970Cz2PZTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bDkpXB8IkvvNvMyw0Cep1wnF9S31XJWFLTmAvmzLu6z+GePaH+D3KbTAFCtvdmr1S
	 GLV46ymAZ1BrnCasNUg5lI3Ur7kguXsulJwwfR5Ij7iWPMcVIW59fRIyDdVL/ES2j+
	 FwXaE20iCxIFMt2+f+EQJr2W2O2D341CAaK2qeIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfAGMsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:48:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728519AbfAGMsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:48:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D1D220651;
        Mon,  7 Jan 2019 12:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865315;
        bh=FEtorfNJdDpRN+lgyGp92lFP+meoUjit+970Cz2PZTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WniKY7xXZPp6tjwV7yxlui2Y9Ww9tWWLzTeDlyEYfEWZAdPVR/9xuIrVHC4M/EHnU
         Bt6fsmrqoioUxVcDmhwckS0zgF4YtKs/Oneq0SfoRK08FBUK51GsXoyqeZHaW7O3js
         8YaBZ430yta1OYxYV0JvwCn5dFxrcIkg+jhkYqi0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 052/170] qed: Fix command number mismatch between driver and the mfw
Date:   Mon,  7 Jan 2019 13:31:19 +0100
Message-Id: <20190107104459.252724763@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>

[ Upstream commit c3db8d531045774aeee6e0f731ab15b0c450de45 ]

The value for OEM_CFG_UPDATE command differs between driver and the
Management firmware (mfw). Fix this gap with adding a reserved field.

Fixes: cac6f691546b ("qed: Add support for Unified Fabric Port.")
Signed-off-by: Sudarsana Reddy Kalluru <Sudarsana.Kalluru@cavium.com>
Signed-off-by: Ariel Elior <ariel.elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_hsi.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_hsi.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
@@ -12669,8 +12669,9 @@ enum MFW_DRV_MSG_TYPE {
 	MFW_DRV_MSG_BW_UPDATE10,
 	MFW_DRV_MSG_TRANSCEIVER_STATE_CHANGE,
 	MFW_DRV_MSG_BW_UPDATE11,
-	MFW_DRV_MSG_OEM_CFG_UPDATE,
+	MFW_DRV_MSG_RESERVED,
 	MFW_DRV_MSG_GET_TLV_REQ,
+	MFW_DRV_MSG_OEM_CFG_UPDATE,
 	MFW_DRV_MSG_MAX
 };
 


