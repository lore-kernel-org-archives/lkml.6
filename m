Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414370-2-12859140014381474810
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414369; b=HlADInCvKAgoohWbpZRSjFndut9xhMpDDaz3PNE/blRzum0
    zLJ3EmUb8hkPf2OJ5uEHLx5Pbv3INXwsm9Ayv7+F0DVTRwI/4YM6TxYbLMdsKGyr
    16UPdOHKSCWH+1KPWo0undR4YZ2Scix6CnCNudUPxVCLPXgRPqrf6KtltFNbL4kL
    zh5Ynk6RFZBrb4dytwnJ+4Uu/+YjbApTu1JsgCP09ORsSx9UqEpbo3Vk8cL56QEY
    XE1SlA2yYcY7z/gpZgHdPwyRC5Cwp+6GExPQNDQ0VkPsrrL6qxPnxwMvaBuOs+vT
    Pa/1nMV4obrBPNm3ojyyrj03Ho1RzQxPG6IxhLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414369; bh=Q+YyTAyfFZ7pLir7CwVjMA3qeG
    ekPN8cCJy6avLkJoo=; b=rchDwNBZT93f88KgqxEx3nZSBToc+FRN8LdFwnfJC1
    yVJSsVdQ5yM93MOpxf3G1HNGRR3jh2/FM15t69IfaWE9ZTNWoVnTXBlo8bPihrIx
    Nej+6HZFgNNHvtbRpCiw0ml7ajRw/Wc9GEA/FTlhllOfr8/r2SWetWv2SMk5QqHl
    INQcLTI73FHwZU7GVKJGrktx9PPu7nTflzKaSdDEiPPJJYuMKXf3789YGToRwCDm
    EfA81k6UN2d/qLvP9oZu7k13/+y1RMqdx2iwTYyUPNCltKTqUImKuzmG8if9P9wG
    Nr8R2kcsQYn3/EhbHuUHd9JgyJpwUlL954PwCWyCTDfw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934935AbeBWSvT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:51:19 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45990 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934934AbeBWSvS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:51:18 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH 4.14 048/159] arm64: dts: add #cooling-cells to CPU nodes
Date: Fri, 23 Feb 2018 19:25:56 +0100
Message-Id: <20180223170749.303009855@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit acbf76ee05067c3942852019993f7beb69a0f45f upstream.

dtc complains about the lack of #coolin-cells properties for the
CPU nodes that are referred to as "cooling-device":

arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu@0 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map@0:cooling-device[0])
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu@100 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map@1:cooling-device[0])

Apparently this property must be '<2>' to match the binding.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
[arnd: backported to 4.15]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -81,6 +81,7 @@
 			reg = <0x000>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -97,6 +98,7 @@
 			reg = <0x100>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@101 {
