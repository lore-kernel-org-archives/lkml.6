Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051E8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09B020871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2Js1mZZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09B020871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733042AbeKLISk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733024AbeKLISj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:39 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB8AE21508;
        Sun, 11 Nov 2018 22:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975323;
        bh=IfMqtevymZZf/ey43tq66lw0O67I9lhL+wFEX6fTunQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Js1mZZSRDjlahiWc0WnTCbrp5ar5kGGJPC52psBoysRNi2p21U7MBwG7OgRNMgJd
         CKSt1/U/28owgWfcUmOb5kxKR0RTx4CZhTUapsH4GSKaYTdiIiTf0ufM6+64TpdsEJ
         eNHw636fA8oBugZf/JoEUuLRlBceQzDACYnIK+Vk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 4.19 319/361] ARM: dts: socfpga: Fix SDRAM node address for Arria10
Date:   Sun, 11 Nov 2018 14:21:06 -0800
Message-Id: <20181111221658.951487652@linuxfoundation.org>
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

commit ce3bf934f919a7d675c5b7fa4cc233ded9c6256e upstream.

The address in the SDRAM node was incorrect. Fix this to agree with the
correct address and to match the reg definition block.

Cc: stable@vger.kernel.org
Fixes: 54b4a8f57848b("arm: socfpga: dts: Add Arria10 SDRAM EDAC DTS support")
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/socfpga_arria10.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -613,7 +613,7 @@
 			status = "disabled";
 		};
 
-		sdr: sdr@ffc25000 {
+		sdr: sdr@ffcfb100 {
 			compatible = "altr,sdr-ctl", "syscon";
 			reg = <0xffcfb100 0x80>;
 		};


