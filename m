Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2658C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BD020871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8O8I9Xw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BD020871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733304AbeKLJjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:39:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733085AbeKLISn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:43 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CF8422443;
        Sun, 11 Nov 2018 22:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975327;
        bh=g+Xtx9KStyQcYKRrf1q0helOKbfW0OupZDF5TbDJLFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8O8I9XwcqFGGU2S515Y6/eVNsayv2Ov5si79Fkx90XqdxhdhcVvM7jC9vrggk/Sv
         U1BbXrnYQbE/Pnbb3HpOO8/zNdo3z4n8e4XjnSGcvESdDCcJrDqgx/iEG7RKKcPGoE
         nwy2OWMEGE2TYX6mODzwCfs1p7biJNI2EODtpfiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 4.19 320/361] arm64: dts: stratix10: Correct System Manager register size
Date:   Sun, 11 Nov 2018 14:21:07 -0800
Message-Id: <20181111221659.013969165@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thor Thayer <thor.thayer@linux.intel.com>

commit 74121b9aa3cd571ddfff014a9f47db36cae3cda9 upstream.

Correct the register size of the System Manager node.

Cc: stable@vger.kernel.org
Fixes: 78cd6a9d8e154 ("arm64: dts: Add base stratix 10 dtsi")
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -335,7 +335,7 @@
 
 		sysmgr: sysmgr@ffd12000 {
 			compatible = "altr,sys-mgr", "syscon";
-			reg = <0xffd12000 0x1000>;
+			reg = <0xffd12000 0x228>;
 		};
 
 		/* Local timer */


