Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0409FC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D702087F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079250;
	bh=Nf8T2clMQ9EvfJD8J97l5jhybUurG8z3FtT/CZvTAjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sWMTYIgxNrtE20jrkHcUWYvsNNxjd85WSpw79cy4AropnVvj6IpkVRRyz+yzOh677
	 BilvmAeyF0hx8JncmPLq5j9zpT7qjfRm+owzsg4cUuDhA9W/alXKgafk3XTuBJ/nYF
	 axx/f/n6XCvsT8mYHJEodpvViomQ+iu7gl3k/sNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732509AbfAUOAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:00:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732036AbfAUOAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:00:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B917520879;
        Mon, 21 Jan 2019 14:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079246;
        bh=Nf8T2clMQ9EvfJD8J97l5jhybUurG8z3FtT/CZvTAjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZB/n5SmPLLUPl0/xx1kvPKNq8G5rL0AkzM6g7t0BeKJHt96OEcIdngo+oW1cE0I5S
         sAZ1vNaqLQDb7v2Lpn22J9n5HCulZpBulOOJOW5Glxah6Ei91BYpQM95xh5U1b9wg3
         4WOVhTNZn3/99rD8VW2xHzny2mMyQ8xqp0hPZ98c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 4.19 58/99] arm64: dts: marvell: armada-ap806: reserve PSCI area
Date:   Mon, 21 Jan 2019 14:48:50 +0100
Message-Id: <20190121134916.180717784@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

commit 132ac39cffbcfed80ada38ef0fc6d34d95da7be6 upstream.

The memory area [0x4000000-0x4200000[ is occupied by the PSCI firmware. Any
attempt to access it from Linux leads to an immediate crash.

So let's make the same memory reservation as the vendor kernel.

[gregory: added as comment that this region matches the mainline U-boot]
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -27,6 +27,23 @@
 		method = "smc";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * This area matches the mapping done with a
+		 * mainline U-Boot, and should be updated by the
+		 * bootloader.
+		 */
+
+		psci-area@4000000 {
+			reg = <0x0 0x4000000 0x0 0x200000>;
+			no-map;
+		};
+	};
+
 	ap806 {
 		#address-cells = <2>;
 		#size-cells = <2>;


