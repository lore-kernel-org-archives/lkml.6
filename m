Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227DkSRdG+KdHUemaGUSD8aL5XBQNCYf6TA4cxqyd8kK/H3cCZBdtYRbAP3m8c+2MzieP8Gs
ARC-Seal: i=1; a=rsa-sha256; t=1519410817; cv=none;
        d=google.com; s=arc-20160816;
        b=PaoLOXGoVbGoRHH9Ggof62l9awNv8B5xwi24bxctVszR7TNvjGivRRAqNsCMYnR5Sc
         CmnnRMIjAA6XCfyp8JuHd97z1Pu68QjRRmY7x2SfkihsTePlo50/HphSyxlOe5EpLS5F
         lrJX6U3GeP4z9LKXsZNlHmtLTHYb3Gxj41eodRJvaCydi4UAFdW7UkvtWClLrsK6cFC9
         xLdt+kgwy216Qt6QkqLP99WH/Xcn4av6omB8BpIOLBzzNcLSGyk4kjhVPMdXSoQ+eASR
         EBRhqhO+qnphcr5FnBWx/5X10U5zT35VqlkzNpz+O8Ayd26IZp43zp9OEHzzsUslC6bv
         Ha1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bBQhwiQ7SMM4hmGgLM/yT8WFZwQBaFMmjmTXK56YrFY=;
        b=TL/Z+TM6mJH4jLzVPHs2EFh/UoynJbRk+gU77LDLsIfjt2cWLX/CzctIwQfzhRPg7q
         IyIlqSL78so6T7FGWq8Y8Y2QMwyOpi2NJ+lmZ6bc0UCNMlWrDdITLnLHI91olfVjeKmC
         o/H/s9bqssbhnB5vhLdQs7WcWYaAauTiersjp51JJkWLp5XKgpOJ4gAcR7AVs636EPvX
         9rv8+jw7G60lAGSUa3syNqjK/UbCI0O/IPSLBrhwq2wrDwT2FnF8YAygoB1TY+UQaMHC
         KEWDkbqThL+jBxx+9Qgw0Z2IXQRss8FiBnlRJuK6xJkaj6VD8TFdvypJuraM83BRaowE
         tA4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Olof Johansson <olof@lixom.net>
Subject: [PATCH 4.4 023/193] arm64: dts: add #cooling-cells to CPU nodes
Date: Fri, 23 Feb 2018 19:24:16 +0100
Message-Id: <20180223170329.692464278@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217717291983488?=
X-GMAIL-MSGID: =?utf-8?q?1593217717291983488?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -54,6 +54,7 @@
 			reg = <0x000>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -70,6 +71,7 @@
 			reg = <0x100>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@101 {
