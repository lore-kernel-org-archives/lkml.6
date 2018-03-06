Return-Path: <ran.wang_1@nxp.com>
X-Google-Smtp-Source: AG47ELvrzAl25c50iiCQ/uC2qqMXeVyd85a5bov4NsAzW4LpeeB4MetKuRWoi65dGslLc5pIcgzv
ARC-Seal: i=1; a=rsa-sha256; t=1520340947; cv=none;
        d=google.com; s=arc-20160816;
        b=h6V6+9+08x0BFz5cDIAKl5ahEF2ONs2wuaptKbZj57QoBV4YcelnXZPSN3uc3xbjvb
         hq/TXeFJiZ0SQNUVkjKa7bvhuUJAx27jUOBWA3EY6xveurOFHUnsPGlIHrwgBPTlLqom
         sCvi3S2xVvsrRsNlHvQtLbpyV+zjntGnkGVewcJ15ZKsQ5EJfBB8iRItRvw6NevWij7E
         oUfSvq9jsdNyfETfUxtsXXV6JsatjBo8/myeaKWLE8EfMMZSyfLpNd+iaYTjQKKlIE/8
         aDeAycet8CmzxFQcICadl3PvRUEYZrBIOxcdlc9Hj2zXCMNCwtXijkwkhQGpLKAwiHmE
         MtFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=1hp2N17dfmAwEVYn/+n1iuMaXZ1souaCNtuDdSZARBs=;
        b=e2m0uGHUerVk+OeaEKbjGW8YvPUmOjH0xIvM537qfhF4wRBwz9lH4JmNd76kF7jAhy
         vVwFdSMUptydkrgyXzdU2nU3qNxCRvpkTVYNSBiylUB/d2JZpoch3yPIx1+NC8X6QIXV
         7FoLViwXFSBJ1xLJcQ6xIOA0am59vk2d+B9zLFyT7XwnrgnmUj4NKG3uAuCJ9ZoYFAG5
         DA0ZYO3MiIp8PFqnkPRZxtXlG0ha0jBgscOJ6X5LYZA5QEgtUvM8llNdf32i6okLsdos
         zSQKxA6Mugv8sZTSbjK23ALMhfxyTX2QCfEYksUC9z/r3hL4nHdCG3CncA9b8qTc2zAf
         8R6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ran.wang_1@nxp.com designates 104.47.33.58 as permitted sender) smtp.mailfrom=ran.wang_1@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ran.wang_1@nxp.com designates 104.47.33.58 as permitted sender) smtp.mailfrom=ran.wang_1@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=fail action=none
 header.from=nxp.com;
From: Ran Wang <ran.wang_1@nxp.com>
To: Felipe Balbi <balbi@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Li Yang <leoyang.li@nxp.com>
CC: <ran.wang_1@nxp.com>, <linux-usb@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 2/3] USB3/DWC3: Add property "snps,incr-burst-type-adjustment" for INCR burst type
Date: Tue, 6 Mar 2018 16:59:10 +0800
Message-ID: <20180306085911.5930-2-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180306085911.5930-1-ran.wang_1@nxp.com>
References: <20180306085911.5930-1-ran.wang_1@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131648145445349885;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(39860400002)(346002)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(26005)(104016004)(107886003)(6666003)(5660300001)(2950100002)(50466002)(305945005)(48376002)(6636002)(1076002)(356003)(2906002)(106466001)(105606002)(36756003)(4326008)(53936002)(498600001)(16586007)(85426001)(8676002)(575784001)(336012)(68736007)(81156014)(81166006)(77096007)(54906003)(316002)(110136005)(59450400001)(86362001)(76176011)(8936002)(97736004)(50226002)(47776003)(26826003)(51416003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0301MB1199;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD026;1:yqudH+279vmH/r9yWWUHnGuFV29cmfix5ZuPtIAJah3TwDaSMMfvuzusj4E88+RdxBfQa73sTlJkLnlWsfRVpQOr6YIp+13yXJso6Jz379EOVpXgVGvS8+LWZi58GmEB
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c317e404-f4ba-4f28-273b-08d58361930e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:DM2PR0301MB1199;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0301MB1199;3:oS4FZ6kCizSCF35FsgmUiTPws8vZyXtN/Ijve4rMuXrL+sltehG3mF6+Om5qU3gRVWqK5uATMjak2nbzhRdJl4TvsL+6lpXUTXt5QB5IXH7gcHxWWUbBcczJFA7jAbAijiN+rBWpTLyMljyftS8OGAO/stxiUKhoLAYcyTBOfhKUR9EXRjpTLnAvVzK6QcgncnClIUL1dBAaOCrTBnrLC3VNlhKf9BYXbgQGcTzrPGTOizKCgvsvbwRh+EEpbDEoLoExgjJ/Oo5bijuJ9L4MDUHnsQxlMacQeJR0ZTJLcUyAZiL1Kf8Bk02Y1vDQf1WPZU9MF4XnKHy0iZciXLYY0a4NzyoKdKBy8Huy7zLp3C4=;25:zsbkzus1ljTkf34n6XnN24Jd2tSnfTWtGFYj+vMYPts3/HFsfnmn5oC+4yCdGPK0LvypSiEzgScTWL/CyxjwgAnDQnPm0Z8gnyKsGtJrydb+HZii1cTrShwZmgmrvT/ZYleAr3WuAhkF4q588mCuK9t5WTLLO9lxL6aO75KwVbvhDz5NDWEONSeNRdnhINJYR77nW3nX+8RQHt2mvF6MVoKeeNUOShxfFaJ8PTpwv5duOcvrGCBDc+X9adznMOPuiUdX4EDUfEGme1w8fyfwUmTuEyCHPG18FMTKvZdZVA+e7RipwQKRwbYY/cLBNjF6FXSYmgGM/9HbRtOPZIkOHQ==
X-MS-TrafficTypeDiagnostic: DM2PR0301MB1199:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0301MB1199;31:/hXnChwyhz0ar8qnPa8ZNoxVOKeZvgYF+c7tR0jiQqhj8RXNu6T5o/XqDtKFZX/aJbHuGkujeZW34fDHoAUZ731x36a+s0sXtYeNJUtQrGlzk/g2YWl+C27wfqvhVlOKoVQmU8fxsGRckQw1X7Twm/z0rywjs2onQRtjDZzRV2FyoFpC51n/aOjIClOZ2c/X7z3ZzEB3uNKozqAiiI7rGB8ppJquMUb6Voti2MLbl5Q=;4:9l07FQDsQ7tBsM7oahRJYpccGs8byrkRJoS9vCauPybIJGgIxRv/6oR8NYn557toniQrBJBWOD2sZM4ju74XbV2C8QE8WWUgXp03Kulj9OCCoDjsRXM7D3gYKHbFJA0F2Bc/2rWVZL+FPWpMkJvhVs4GBCv6pYLSyMhe/ot+sD6ZJ7CAjSphpdXII4YpA2G6Cbz7wVy7QqvFbBtsMJd/LcLiXYugZleB3LPSL92FI2VpawNmDRhCdxc12VS14wX/1YjIO86naFa0k+OQ1oQcnsBkfdPO3TEybOnFO/VclmDoTlfrPt0tq2B24A0UL3H1
X-Microsoft-Antispam-PRVS: <DM2PR0301MB11990F81A8AB1A9FF2C9F7B1F1D90@DM2PR0301MB1199.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(6055026)(6096035)(20161123561025)(20161123565025)(20161123556025)(20161123563025)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011);SRVR:DM2PR0301MB1199;BCL:0;PCL:0;RULEID:(400006);SRVR:DM2PR0301MB1199;
X-Forefront-PRVS: 06036BD506
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR0301MB1199;23:81iblcfONnKLncTNkP8AwSjExyYqVetBXBlLjfi?=
 =?us-ascii?Q?g2jPbtwzzSLjW24y0eaoMWy9y5p0IXrruRLSrYTpQVzoKKQOXsl5zkNqlfLh?=
 =?us-ascii?Q?fNNMkpae/QEBPFq8HNoeL/W6/U8YaeIDOfYAftz7+7S7HISuXufnjL2zTnkK?=
 =?us-ascii?Q?k4U5rMelq4YeocYxA+FtzQvhE5p5RbN4J66xawMrk8MSCxudcoKM1VgPCsRa?=
 =?us-ascii?Q?duM9P9ebvVzc1X11kAtK9WtTr6qeeV+YI5Bv3EZBPFAmtUJXML5V3cm6669k?=
 =?us-ascii?Q?o1gO4sF078Z/2ZN6Qj+O771SS5zLXShdy916WWEtUdnlPn4E2obwv4GD7VE0?=
 =?us-ascii?Q?3abD4EGR05kvlUJ3qd6cHK0OgAVx/UQQNaZfW4qHlQPUYSH9DX2wpgJEUDNe?=
 =?us-ascii?Q?pVsBIs9MkKZlAhAEHPbFNhcLwTkLo4DRCVXINiOtwGs+UEwmBM05gfkNDaAw?=
 =?us-ascii?Q?6ealRlF2GcYb/JxV4jlMB7ijJJ1fsmMk7zawAh0c/gqANkAMc4t4AFm+EwMj?=
 =?us-ascii?Q?pN18QAHL1R+i4uL8MsMuKnGs5/Mo6AOkcA44Hqy4md4LZ5Y6UZVgSbh0v3sT?=
 =?us-ascii?Q?XPJYOUm/AsLmxmErla11+A+9GagjpSerOIE4INaH1biXqMTx0qhA5W4dkOMB?=
 =?us-ascii?Q?VAdH9X9HKvPyr1rEEsorp332b5hFUsqs8WITMDe1MEdTdzDPXaEclrlU/lQ1?=
 =?us-ascii?Q?KViPcDmjRhVZ+c+Z0yV/ifRenU5hhLL4FPP9uZVoVo+Ij+VX83wZ4uW2KFUO?=
 =?us-ascii?Q?ZNjJ0J9UvhP10DPNcSo+htcdO/n1nhMWQoLPqXapMjQYKjrXz5myNMWW8dup?=
 =?us-ascii?Q?99rfAX4SXB8veZztgjFiOS91Q70x+gRbQnKRqJctjT8XbQLLcvS41SlaXs/H?=
 =?us-ascii?Q?4ykSSZuoYa846V5nF+RTGtltx/XKvv8J6hu0rEraklIALotLLEejFYzEvc9u?=
 =?us-ascii?Q?FeIWFjYfgmR1Qbp2lT6cFvzVElk4TeM3Rnid5K1ErnrgVGPb5Z7JF5UvSWWF?=
 =?us-ascii?Q?LtOA7pPFN3HVyu8dBEm9XMUx5TWgAaJJy02tdebAixNWFuvJz9/vjV42mFSd?=
 =?us-ascii?Q?5Ym+oUxpAhvzkD7zY0rHsbVD/slMtD5hhnuKfQcyp6i6foZbxnxMvRUoRfdG?=
 =?us-ascii?Q?G5nkvu8HorU+MlPUIoQBpsO3l8L+No+JKLhS3tQrpr+Jp9D06dDiy/fhXK72?=
 =?us-ascii?Q?Ku8zdFQYyItpx9gjG/PCEBpI9Ue9ebXQNs8VL?=
X-Microsoft-Antispam-Message-Info: +Ofmm1bznVsy0dJGc08vNDCyR1C5mS2Zj9e4/5Qp2q3TuaGQ4l2B2nOUizOyERcUxVJaSRP6Y9s4oRjt/p/7diShUALrElzf3O8Qwn2a01E9tq6wjcjmdrNRGKaOIvDTT4YCz6wr/sYz0jXB0osx4vE9+psCDW3fw5r88I4O2igrpBb6RL3xUnYcJPpgtHB9
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0301MB1199;6:rOWKx29xp9Aqiz6jA/K6WhExuB5LLgUc1shNIo2i0l9fLDpavSxzH/O5sUIH+itCyAGH8vCtO4oMicn2oRoNN82oHjtqH/6I4v/ONlCGyY6FoiPf72Qo6UF7NIm8zw8TKFGoq3QXbLO8vlQ+thWRQJSZKOcBCE/PeqQ4DN7D6zTB6zncsiT/WjAsydVMbSpLSzG3DkeUAz2Fw/KHhH2lWZWiFHr3XdM2f7qzbvkWl63Wf+tjBhzpkFAevC+rhcBdKnhkiL1CKwMlO5+FPEmD4wMv4YqOhvJ03cJZI6uYfvOYjCMaZgyDo6urG2kVYarYItol5ILjZRqQ35MnaheYSQdFDQJlL/HlL2CTowADGYo=;5:eD1cTYjsHYzTfgVvhtLNxM6SaqJ25d7CE/o9H9T2PKDqWdwRSTLqZf0AP/EJEbUJqyIgK1r+Z5Mcv4tZ4GXLUd6yqzkyRy+q6R1+7dWeQj1sdbwdVOotO6mUOTqn7mrBWnbl/UPmEj1Ym+jmJtLWIm9AwufygdwajeJjg/8Q6bg=;24:pVC/1LkQoNEBPz69WokQ3bC4v5GWMPyzOvHCLueUcC/DNeWcR9NIZpxnjetX6zYMIkODf2tXV/oRU/nam48m8FMeJcTuJ2XWFx7aa4yCg5E=;7:Wf6ubVBQnwPzWIqpcCPTNf/xw6WFJK0WTQWjTuKwoIEMeC5vCkRDLjC5vczZvcgEYKgwiFZ7uGxtNMmXkBzprhN0ExVdpXocI9CizI8qmkHtBKo+HunLDurf4C4h8qjhozqLrkbbbQuxRP6aGQ1eSWPjTy/P1WT/ZifV91XnvWV7D3vKvTHJGr0UU9yUpgL0yjpJy7qdIlpJILsouxBL8DCGZMvQ5pRmK+rVnMPLU4WHunqO1aZ3ebMvhxTysBBB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2018 12:55:44.2853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c317e404-f4ba-4f28-273b-08d58361930e
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0301MB1199
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594193028837172806?=
X-GMAIL-MSGID: =?utf-8?q?1594193028837172806?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Property "snps,incr-burst-type-adjustment = <x>, <y>..." for USB3.0 DWC3.
When only one value means INCRx mode with fix burst type.
When more than one value, means undefined length burst mode, USB controller
can use the length less than or equal to the largest enabled burst length.

While enabling undefined length INCR burst type and INCR16 burst type,
get better write performance on NXP Layerscape platforms:
around 3% improvement (from 364MB/s to 375MB/s).

Signed-off-by: Changming Huang <jerry.huang@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Changes in v5:
  - add support for ls1021a, ls1012a, ls1046a, ls1088a, ls1021a
  - update ls208xa support according to code base change
Changes in v4:
  - change definition for this property.
Changes in v3:
  - add new property for INCR burst in usb node.

 Documentation/devicetree/bindings/usb/dwc3.txt |    6 ++++++
 arch/arm/boot/dts/ls1021a.dtsi                 |    1 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |    1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |    3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |    3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |    2 ++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi |    2 ++
 7 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 44e8bab..d1779b2 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -59,6 +59,11 @@ Optional properties:
 	fladj_30mhz_sdbnd signal is invalid or incorrect.
 
  - <DEPRECATED> tx-fifo-resize: determines if the FIFO *has* to be reallocated.
+ - snps,incr-burst-type-adjustment: Value for INCR burst type of GSBUSCFG0
+	register, undefined length INCR burst type enable and INCRx type.
+	When just one value, which means INCRX burst mode. When more than one
+	value, which means undefined length INCR burst type enabled.
+	The values can be 1, 4, 8, 16, 32, 64, 128 and 256.
 
  - in addition all properties from usb-xhci.txt from the current directory are
    supported as well
@@ -71,4 +76,5 @@ dwc3@4a030000 {
 	reg = <0x4a030000 0xcfff>;
 	interrupts = <0 92 4>
 	usb-phy = <&usb2_phy>, <&usb3,phy>;
+	snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 };
diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c31dad9..b0c3f4f 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -705,6 +705,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		pcie@3400000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 82b272f..4275a8f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -464,6 +464,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		sata: sata@3200000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 380e7c7..0067567 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -622,6 +622,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb1: usb3@3000000 {
@@ -631,6 +632,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb2: usb3@3100000 {
@@ -640,6 +642,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		sata: sata@3200000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 06b5e12..2bf6756 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -602,6 +602,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb1: usb@3000000 {
@@ -611,6 +612,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb2: usb@3100000 {
@@ -620,6 +622,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		sata: sata@3200000 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 4fc150c..c2b5b45 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -478,6 +478,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			status = "disabled";
 		};
 
@@ -488,6 +489,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index f3a40af..d5b25f2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -754,6 +754,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		usb1: usb3@3110000 {
@@ -764,6 +765,7 @@
 			dr_mode = "host";
 			snps,quirk-frame-length-adjustment = <0x20>;
 			snps,dis_rxdet_inp3_quirk;
+			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
 		ccn@4000000 {
-- 
1.7.1
