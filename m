Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D99EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6C920817
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEuGOnxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6C920817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390123AbeKLIV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:50534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390048AbeKLIVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:55 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 031B5216FD;
        Sun, 11 Nov 2018 22:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975518;
        bh=q/7t7v3I1oV1lNDWn2oXSVAM0C2dqhMWJqc4tH0JP8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dEuGOnxeoH3yF02zeOYOIniwTg5pWJNleMoJ6+Jh9K7655KwZETTBZ+lFM82IG5Mk
         XKpRcGj0+MYaP6LibxMzMaJDo58Bx56274MlxznQFyfz31DiJBzamkNwVuQUc0B9Bs
         qCzFenh5tasb/1wTHtG1XbTYAIhA6kDj3uzrJ4Vg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 4.18 310/350] ARM: dts: socfpga: Fix SDRAM node address for Arria10
Date:   Sun, 11 Nov 2018 14:22:54 -0800
Message-Id: <20181111221721.037778645@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -601,7 +601,7 @@
 			status = "disabled";
 		};
 
-		sdr: sdr@ffc25000 {
+		sdr: sdr@ffcfb100 {
 			compatible = "altr,sdr-ctl", "syscon";
 			reg = <0xffcfb100 0x80>;
 		};


