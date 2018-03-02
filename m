Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvY4Kqswr+jYn80XlTPnuGRSelOusjaM+rN4a+rqm9nxbrBd8BN+z521dsg1JGddSKYGyGv
ARC-Seal: i=1; a=rsa-sha256; t=1519981496; cv=none;
        d=google.com; s=arc-20160816;
        b=oZ46YQzgIMJhJ66vWHqXM+ha9n7HyyyZr5WXonjOXmcxoW72pi29YlggtvQf1RO/q2
         DbHTXU9/OIjfTCrzdO3lMRqV6UKU48ThsRHNOsPBVk30QhY4XAtGETHX6kmIdjvumX1s
         PQPTE81XwOKGucOcuFGpjOkLNim2vnMKGtPY6idWH9LEgzfLEjqkqrhj+BmuiA3/5B/V
         BeuDwHkq08QxfRJ+9m34BisfANaV26krcVC80ekGwEvFWSw2TybNRAtT5khOH1ZPRQsP
         twbVMscrxBPxz5msHuKUM6Hc+xvg/XJy/q4IZ0ZpfOA7Psa1RhnFITL+aI2bfGQMsctS
         +w/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1815cJjDkH0uKPZagu0lChAeByrei3s0esVyeEeHz/8=;
        b=I6JVjoFsG9vPrFgbEC8hrZpLq3FmFxMr33FGa+Wc6KSuN+JS/GdnyoJkL2dOm3//b8
         Ow435jqa6NwvXcm4ysUqrChzgx5SqRTqai0pRT1TAsmWhOsVNPpS1RUgiXnRdfibWsm9
         Cp3Gi0Z16JQ6WzRZfAXH26m+wAZJommLpS/mXVsc1MYJO1nfV13C27Vvzx+Dty2WZBJ4
         CvhrNzwZh1UQ+utRHaZaap+skjRNP1g6eYNAzE/13Tqiey7EilThnkttRJctZwBHfV5s
         h6Ct0peyk82Oxn1LcUEFGg6yrXW0Pcbm97vRZkhpwlEw8WDADAHOKC9tU/Kin0cn2t08
         Nprg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Antoine Tenart <antoine.tenart@free-electrons.com>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 4.14 110/115] arm64: dts: marvell: add comphy nodes on cp110 master and slave
Date: Fri,  2 Mar 2018 09:51:53 +0100
Message-Id: <20180302084508.290511460@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816118264195408?=
X-GMAIL-MSGID: =?utf-8?q?1593816118264195408?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <antoine.tenart@free-electrons.com>

commit 910d1bf2c68fa1d7dcde0316cb91f62758407e8d upstream.

This patch describes the comphy available in the cp110 master and slave.
This comphy provides serdes lanes used by various controllers such as
the network one.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi |   38 +++++++++++++++++++
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  |   38 +++++++++++++++++++
 2 files changed, 76 insertions(+)

--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -111,6 +111,44 @@
 				};
 			};
 
+			cpm_comphy: phy@120000 {
+				compatible = "marvell,comphy-cp110";
+				reg = <0x120000 0x6000>;
+				marvell,system-controller = <&cpm_syscon0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				cpm_comphy0: phy@0 {
+					reg = <0>;
+					#phy-cells = <1>;
+				};
+
+				cpm_comphy1: phy@1 {
+					reg = <1>;
+					#phy-cells = <1>;
+				};
+
+				cpm_comphy2: phy@2 {
+					reg = <2>;
+					#phy-cells = <1>;
+				};
+
+				cpm_comphy3: phy@3 {
+					reg = <3>;
+					#phy-cells = <1>;
+				};
+
+				cpm_comphy4: phy@4 {
+					reg = <4>;
+					#phy-cells = <1>;
+				};
+
+				cpm_comphy5: phy@5 {
+					reg = <5>;
+					#phy-cells = <1>;
+				};
+			};
+
 			cpm_mdio: mdio@12a200 {
 				#address-cells = <1>;
 				#size-cells = <0>;
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -111,6 +111,44 @@
 				};
 			};
 
+			cps_comphy: phy@120000 {
+				compatible = "marvell,comphy-cp110";
+				reg = <0x120000 0x6000>;
+				marvell,system-controller = <&cps_syscon0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				cps_comphy0: phy@0 {
+					reg = <0>;
+					#phy-cells = <1>;
+				};
+
+				cps_comphy1: phy@1 {
+					reg = <1>;
+					#phy-cells = <1>;
+				};
+
+				cps_comphy2: phy@2 {
+					reg = <2>;
+					#phy-cells = <1>;
+				};
+
+				cps_comphy3: phy@3 {
+					reg = <3>;
+					#phy-cells = <1>;
+				};
+
+				cps_comphy4: phy@4 {
+					reg = <4>;
+					#phy-cells = <1>;
+				};
+
+				cps_comphy5: phy@5 {
+					reg = <5>;
+					#phy-cells = <1>;
+				};
+			};
+
 			cps_mdio: mdio@12a200 {
 				#address-cells = <1>;
 				#size-cells = <0>;
