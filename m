Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AA8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7A020841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="mz00cNcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7A020841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbeGaRhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:37:20 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34923 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732333AbeGaRhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:37:20 -0400
Received: by mail-yw0-f180.google.com with SMTP id t18-v6so5962713ywg.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 08:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=pFjZod/eQ3B8gDCTUgXnTQTaFLTWF8ugwD5NcZ8TXTM=;
        b=mz00cNclEYdVBwDDvJJxlKlxbxzlpB6kROOsRGY+2T9ipnFUkIx1Qs/+hG9C4mcViL
         66gB+XYgrhtQ5UF8ep3EcX4DxhYcV0DhPX6TQMy/x0MZCYeqQS5bTeFP+nWJRR4VEd9U
         oDQGPk++C7DigbW8kr2CyAWTN0Qo+j2S94FdogI2XXVBnep9Ntm7Fj8uEWQ6d2hLMyGJ
         D4nw3Czru9Cfq9QrdKDbUzAMoZft4KFXRi+c55psLZw52Xu3btyrAavwoilUQ5y9o8Bw
         /UxytDxjB74RpfymhAseyUqrN1b5ALduJn3wCOjwVM2OeRXGo0m60cCQkpK9PcpWRaVt
         N/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pFjZod/eQ3B8gDCTUgXnTQTaFLTWF8ugwD5NcZ8TXTM=;
        b=hooZoLo6oXZwd4hPGKReir3FCWx74Ezg469M6DoJ0i/ynYBaNzwuJ8s2Gz8ScVN0zc
         Gz4sShmyWI2ahIEtKwsCSWOG0Dfh8WNIWfnq9W/zVKwuXSt6jy1P+V4sTS54BFlyL+ua
         DAT43qyBWWG+fYsD2dSVI20LnbgVpszk9sFqbLm+wN1Zq6b23A2O6GJsml9RWhXwwbzD
         ygwnXWMHTFP0AflmTdp0nVf5xoXd/QBKXFleFHwEg8EeGybBnlMa9Yik4Jl40ovHngIG
         /I92yVdifIFGtkMno/j1IxUyJgVE3OuP04sXw7xujSrtCJWN8rTT6JxzC6cNDM7lLz54
         OGjg==
X-Gm-Message-State: AOUpUlGXS9ZFTK/1Wwng38JEgXRU0PJk3ernzYy8C1qCtvkxE9d+ZVrH
        ilOxG1j5EpxtpTWLl6426HMqtQ==
X-Google-Smtp-Source: AAOMgpfQO+ow7ClZAPViDr4c3hb6kZuunMA0KLWApYb1ZDzofUzfiQ+ZQ1iQmPkbvEHKrux77Mx3bQ==
X-Received: by 2002:a81:9446:: with SMTP id l67-v6mr3161819ywg.117.1533052581933;
        Tue, 31 Jul 2018 08:56:21 -0700 (PDT)
Received: from graymalkin (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id i12-v6sm7415267ywa.35.2018.07.31.08.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 08:56:21 -0700 (PDT)
Received: by graymalkin (sSMTP sendmail emulation); Tue, 31 Jul 2018 11:56:19 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     David S Miller <davem@davemloft.net>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: change Exar/Neterion menu items to be alphabetical
Date:   Tue, 31 Jul 2018 11:56:19 -0400
Message-Id: <20180731155619.16310-1-jdmason@kudzu.us>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neterion was standalone for several years, then acquired by Exar and
shutdown in 11 months without ever making any new Exar branded adapters.
Users would probably think of them as Neterion and not Exar (as there
have been no follow-on adapters and the vast majority ever sold were
under the Neterion name).

6c541b4595a2 ("net: ethernet: Sort Kconfig sourcing alphabetically")
sorted Kconfig sourcing based on directory names, but in a couple cases,
the menu item text is quite different from the directory name and is not
sorted correctly:

  drivers/net/ethernet/neterion/Kconfig    => "Exar devices"

To address that and clear up any confusion about the name, "Exar" was
changed to "Neterion (Exar)" and the relevant entries in the Makefile
and Kconfig were reordered to match the alphabetical organization.

Inspired-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 drivers/net/ethernet/Kconfig          |  2 +-
 drivers/net/ethernet/Makefile         |  2 +-
 drivers/net/ethernet/neterion/Kconfig | 23 ++++++++++++++---------
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index af766fd61151..6fde68aa13a4 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -81,7 +81,6 @@ source "drivers/net/ethernet/huawei/Kconfig"
 source "drivers/net/ethernet/i825xx/Kconfig"
 source "drivers/net/ethernet/ibm/Kconfig"
 source "drivers/net/ethernet/intel/Kconfig"
-source "drivers/net/ethernet/neterion/Kconfig"
 source "drivers/net/ethernet/xscale/Kconfig"
 
 config JME
@@ -128,6 +127,7 @@ config FEALNX
 	  cards. <http://www.myson.com.tw/>
 
 source "drivers/net/ethernet/natsemi/Kconfig"
+source "drivers/net/ethernet/neterion/Kconfig"
 source "drivers/net/ethernet/netronome/Kconfig"
 source "drivers/net/ethernet/ni/Kconfig"
 source "drivers/net/ethernet/8390/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 22555e7fa752..b45d5f626b59 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -36,7 +36,6 @@ obj-$(CONFIG_NET_VENDOR_DEC) += dec/
 obj-$(CONFIG_NET_VENDOR_DLINK) += dlink/
 obj-$(CONFIG_NET_VENDOR_EMULEX) += emulex/
 obj-$(CONFIG_NET_VENDOR_EZCHIP) += ezchip/
-obj-$(CONFIG_NET_VENDOR_EXAR) += neterion/
 obj-$(CONFIG_NET_VENDOR_FARADAY) += faraday/
 obj-$(CONFIG_NET_VENDOR_FREESCALE) += freescale/
 obj-$(CONFIG_NET_VENDOR_FUJITSU) += fujitsu/
@@ -60,6 +59,7 @@ obj-$(CONFIG_NET_VENDOR_MOXART) += moxa/
 obj-$(CONFIG_NET_VENDOR_MYRI) += myricom/
 obj-$(CONFIG_FEALNX) += fealnx.o
 obj-$(CONFIG_NET_VENDOR_NATSEMI) += natsemi/
+obj-$(CONFIG_NET_VENDOR_NETERION) += neterion/
 obj-$(CONFIG_NET_VENDOR_NETRONOME) += netronome/
 obj-$(CONFIG_NET_VENDOR_NI) += ni/
 obj-$(CONFIG_NET_NETX) += netx-eth.o
diff --git a/drivers/net/ethernet/neterion/Kconfig b/drivers/net/ethernet/neterion/Kconfig
index 71899009c468..c26e0f70c494 100644
--- a/drivers/net/ethernet/neterion/Kconfig
+++ b/drivers/net/ethernet/neterion/Kconfig
@@ -2,8 +2,8 @@
 # Exar device configuration
 #
 
-config NET_VENDOR_EXAR
-	bool "Exar devices"
+config NET_VENDOR_NETERION
+	bool "Neterion (Exar) devices"
 	default y
 	depends on PCI
 	---help---
@@ -11,16 +11,19 @@ config NET_VENDOR_EXAR
 
 	  Note that the answer to this question doesn't directly affect the
 	  kernel: saying N will just cause the configurator to skip all
-	  the questions about Exar cards. If you say Y, you will be asked for
-	  your specific card in the following questions.
+	  the questions about Neterion/Exar cards. If you say Y, you will be
+	  asked for your specific card in the following questions.
 
-if NET_VENDOR_EXAR
+if NET_VENDOR_NETERION
 
 config S2IO
-	tristate "Exar Xframe 10Gb Ethernet Adapter"
+	tristate "Neterion (Exar) Xframe 10Gb Ethernet Adapter"
 	depends on PCI
 	---help---
 	  This driver supports Exar Corp's Xframe Series 10Gb Ethernet Adapters.
+	  These were originally released from S2IO, which renamed itself
+	  Neterion.  So, the adapters might be labeled as either one, depending
+	  on its age.
 
 	  More specific information on configuring the driver is in
 	  <file:Documentation/networking/s2io.txt>.
@@ -29,11 +32,13 @@ config S2IO
 	  will be called s2io.
 
 config VXGE
-	tristate "Exar X3100 Series 10GbE PCIe Server Adapter"
+	tristate "Neterion (Exar) X3100 Series 10GbE PCIe Server Adapter"
 	depends on PCI
 	---help---
 	  This driver supports Exar Corp's X3100 Series 10 GbE PCIe
-	  I/O Virtualized Server Adapter.
+	  I/O Virtualized Server Adapter.  These were originally released from
+	  Neterion, which was later acquired by Exar.  So, the adapters might be
+	  labeled as either one, depending on its age.
 
 	  More specific information on configuring the driver is in
 	  <file:Documentation/networking/vxge.txt>.
@@ -50,4 +55,4 @@ config VXGE_DEBUG_TRACE_ALL
 	  the vxge driver. By default only few debug trace statements are
 	  enabled.
 
-endif # NET_VENDOR_EXAR
+endif # NET_VENDOR_NETERION
-- 
2.14.4

