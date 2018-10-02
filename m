Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5244FC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19271206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19271206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeJBULf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:11:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60806 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbeJBULe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:11:34 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 518C0BF0;
        Tue,  2 Oct 2018 13:28:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 098/228] arm: dts: mediatek: Add missing cooling device properties for CPUs
Date:   Tue,  2 Oct 2018 06:23:15 -0700
Message-Id: <20181002132506.002267713@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit 0c7f7a5150023f3c6f0b27c4d4940ce3dfaf62cc ]

The cooling device properties, like "#cooling-cells" and
"dynamic-power-coefficient", should either be present for all the CPUs
of a cluster or none. If these are present only for a subset of CPUs of
a cluster then things will start falling apart as soon as the CPUs are
brought online in a different order. For example, this will happen
because the operating system looks for such properties in the CPU node
it is trying to bring up, so that it can register a cooling device.

Add such missing properties.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/mt7623.dtsi |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -92,6 +92,7 @@
 				 <&apmixedsys CLK_APMIXED_MAINPLL>;
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 			clock-frequency = <1300000000>;
 		};
 
@@ -103,6 +104,7 @@
 				 <&apmixedsys CLK_APMIXED_MAINPLL>;
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 			clock-frequency = <1300000000>;
 		};
 
@@ -114,6 +116,7 @@
 				 <&apmixedsys CLK_APMIXED_MAINPLL>;
 			clock-names = "cpu", "intermediate";
 			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>;
 			clock-frequency = <1300000000>;
 		};
 	};


