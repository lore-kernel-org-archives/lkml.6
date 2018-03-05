Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELtoVXDBWvSEns9bTpp8zWe3loidiDvPcZtDlpTOrEbO44prfSIJAxZWwQZdbRuHR0TpO4Ko
ARC-Seal: i=1; a=rsa-sha256; t=1520260236; cv=none;
        d=google.com; s=arc-20160816;
        b=gMuAWhNZXdPh7LAR40XAYfMIxOcN4pzbIDQlSK66Cz6H4zrgApB4yWQqDZp+R4YvXZ
         kER43YbXKaAFcYlQXky5yaqNzzLMLspbXVtBqHSQr5LlDPJczhhyf2XekFiqZh8WRO96
         /g1GIK+V+c6mnhyVrSxntnuMANNaKWVHk35Hlc8j3IY3i1nZCevoH32AU7eAPmfnCqpI
         zNGKLgJGi9uHLutqoclS6rCBDAwRjlzH28PAzpQWguBR08Y62m8c5RzfMecS8M4SU7o3
         2U88XdtAiWprxly6GPtto18DC4r7tEyFuOpuQzRNwH41LWwe0f2hSgzGLyW8BLwNS4mu
         FdkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=SUf5fzxHILD12cg60g8iJPRnBHGWVHfU6wC/AaEFTVY=;
        b=Yq3zX++rQkazMZVluifxF7fvipltjN2oCq/JUKdZsdCGhtcgcESlckV7vla5y8CIvc
         eKreppqJ8P04v5u0jt3gDCsMoK25wMCZcGCMPsAG2jbEulHBccI1aabJV4WszwwTSnkU
         4sMnTp+G6GjY/KP7S5hGHMb7+PeLzBMm2qXDLI+BiAxF+j2KJ/RelZQE5K4Bf8IL+o0H
         7HyN04wXHHH3oDRzYg2sQpxzhfvmmuab/UDjZL7xZ/RIyqjvzvaf/Ddkje4yvF9D5TnQ
         mFRpWD6CyD1YP4C//nmLoyg5QZZVUK5AwtKglEyNwSbWZDnMg1VuYkFNhts2K/KfhYcY
         HxsA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=D4WE1VFW;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.0.58 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=D4WE1VFW;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.0.58 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: will.deacon@arm.com,
	robin.murphy@arm.com,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: iommu@lists.linux-foundation.org,
	robh+dt@kernel.org,
	hch@lst.de,
	m.szyprowski@samsung.com,
	gregkh@linuxfoundation.org,
	joro@8bytes.org,
	leoyang.li@nxp.com,
	shawnguo@kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	bharat.bhushan@nxp.com,
	stuyoder@gmail.com,
	laurentiu.tudor@nxp.com,
	Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 6/6] dts: fsl-ls208x: updated DT with SMMU support for fsl-mc
Date: Mon,  5 Mar 2018 19:59:26 +0530
Message-Id: <1520260166-29387-7-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::22) To HE1PR0401MB2425.eurprd04.prod.outlook.com
 (2603:10a6:3:25::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e94038e7-42a5-4226-3e5c-08d582a5a740
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0401MB2425;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;3:c97DW4EKMYiazHvCXKC1xeXI65mRM3Ow8/eWW/MypnypPHmkd9NKc1eUSxoagXbXu3ronHonKL7ZI/r0otvr346E7QWOHIWLCzMG6QwEOfWZ5/IrTa4GMWw+u+SfgG3Va8Cv/prw3yiWp6Tlef3cMQKuVCxydZI0wXGZ5jDDc+Powznm8smI2J9+dt7TzguNjIiqJd92kslgMOWrfx0qUYtWzaEuGht53catn53ivPztFWa0Hl+6qmxDm1PWxUCo;25:cG97GQewwG2Oj88fR97guvYbRBsPPubNkf7y34BYDe94huDwwAlLHpM572iBtqypC8GzC5UD5QBvrwPUXB0avKcibW7EIerQDvp8cYKE6fJaft16BDMXjWgNi3HbW3SKWwRyoRAYb0bFSoAZoILrkSlzAHwpa4T0kP916SoC1E0SW030Vtp52lAjadSdF0vlsiXYZgiKHHzwVLEBUC/sdXVxtF0UbG3KyLolPnxc8oR+XYenfzvUn3CExB8+nIsU2JUOsmMy8rPr+sfbGpNAgLZHsofkDrkniQodCDlMI6eMzlJOENBauFZ0XPNSmhJ1QeRjShT4bF5wUbPWFtZLcQ==;31:9uh4P7T5xTLxqQRmrJpYn53Neu3DSZeOgRs5XoHuUe64hgLqPKz1mCdTZEiLSMB1A58/2E2RhdMUWyIWsu4QcYUIM9Djxxc0RzmiJrhU2J+tOXKCHv3QGCpRIrot4u/hTiWQiAISRA7/xExC5ZiBBYhWkhx6EKTPFg11zljGcvrBOa6vUwN9NSjwiO13F4jvSDW81qiDUJ0of1b9cszPXOJCxi5qHGLjUOSsNefPglw=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2425:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;20:lC/wsKUPXRZlT717fSeEB2RUHCJlAjiqxOrcLjhEpc61RwcdKBzda/pFBV8CD/IBJJJB1NXr71GP9SMEMmIJg8wf7vHRSGCYsO/5ooCmQkr3K5OD+yosUMCpUGsbgFPPJwDGdNdNhl4k+gTyWQ7xNIr5HROEmV6A6uuJOcQUfDpJUObt+CuPPgamfQooo3Z1idLuhvjmrKznrZuggOejciPZPbSFVP0gBdWj9zqBRX34WoqYf0sUvmh9y5pz+Az0EPASQauCLq5MkZtVNv+RkEaVYTxKjepaPEUCEx1ewgmcG6SESp3JKoOn2zCpfsf6lN3ARwCv5CaQ/hcv+TYg4PDGHWLxkawPGQ29nLfh90nlCdcZYsMYJ+bF26MiTyvZJh8qGFmZeEQGpULuzn0QdoTT5mb80vuTk1UfrwEjUbLxDrS/NmTo5vA4ZHeN6+AQ2cDjpqI7LzlxIgbnUkTEfeLpC+VaBojFBTyixy6o7JNopjSb9BOPgH7YTbdBBp2D;4:RpXPyY2pFMlui366rkoXYwAhCd/HZXFjIRyFsHV5pLD+dIXtSSMaUBo8s0dcUw1DrPjI31Y9hbjkFI+eSxv7G+c7oVzVQT3MSNodGK3c7XbYmDKUpEoqb1Ze+KX66D0qTpSOEh6tmB3aoIMB252lj5H6fbxworh3iiW9Nk03UfxVxWFluzmZtuBJcYVUdOlYKb2WPIDYlETqZIls4t0uULJVvxGuAYF2uvdSnZzg4ThWMEc1nILGI7gmbVAKL+CXm9eWvYOIMGglwJkTQHjhK9USpvGnhD2IsDddWsbgDNhA6PLI3TShBj2942pUQSqoGYWJ72rki2c3K0tIoEOv46Hqrt0TU9iXbGNtZsZvQAw=
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2425DEA9114A3811D186E920E6DA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231220)(944501244)(52105095)(3002001)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0401MB2425;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2425;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(376002)(39380400002)(189003)(199004)(2906002)(47776003)(106356001)(6486002)(3846002)(4326008)(316002)(39060400002)(25786009)(5660300001)(6116002)(6512007)(53936002)(2950100002)(97736004)(8676002)(81166006)(50226002)(76176011)(8936002)(81156014)(5009440100003)(386003)(51416003)(6506007)(26005)(16586007)(48376002)(52116002)(478600001)(86362001)(50466002)(66066001)(7416002)(16526019)(59450400001)(36756003)(55236004)(186003)(7736002)(305945005)(105586002)(68736007)(575784001)(110426004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2425;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2425;23:7BBBHn1Lw+SipwpVIZ496ELQFpcUWzuiUq38RIP?=
 =?us-ascii?Q?/HPo7oZ4aOUbU4r3YA175iDD3VStutCDSQ5xhMnloMfmflIsp9LOnlyiuETp?=
 =?us-ascii?Q?zH+yzu3V2xKpu6IpOe1vg7ENuP8GZUrVbYD4z5GScQy+7XzTRKarWWDz80+f?=
 =?us-ascii?Q?8OGQtv7ew+rMljrk6qa6dppTsI7vwSRHnMEPIR52FiQwrT0O0d1dUasP08un?=
 =?us-ascii?Q?XbtJ0dp/xLEfhEtUZ6FTTP+WACMzfwrLJw38zZvWIdAQO0/qAhvyx6nenk0f?=
 =?us-ascii?Q?hrBHGdNaL6kkXSAcgAqemkUVEXj0BsEkVQMPqhFPR2U4UjCcYSF01+Qtd/rv?=
 =?us-ascii?Q?NlqQTih/5CrSWaxLFhteP8L4ulvFx0rt1FzbyUcP2Z+oOmsWIjUd4Wbq3FE4?=
 =?us-ascii?Q?ZbCahzp92tRDSDNUlEsJp19rN4aOA8qAVYQHyqFHgrFNjwPBdsFK0NuDlkba?=
 =?us-ascii?Q?EhUGsgoTDcS8/7ZVRup10k0l7MmG0yAtOB08epfivw+b32E1tXSfL8UJTjcQ?=
 =?us-ascii?Q?vto1iuqCNPmUymTMSp2DKYHRzaaBqkLtsIs9Ypvwqkm34Bv9vReYwiztBm9M?=
 =?us-ascii?Q?FupVlTdu2nNX3mVxgOwnuYAsYRimNLjoD42vYPjeyApsAdY8FVQi+DadyCcP?=
 =?us-ascii?Q?jU8TaIyzFElhbd8yelx7Wu7NHaC3W9BlgBqyJBzomMt/Pb7eWbg5yOgIb28N?=
 =?us-ascii?Q?hJ/7+dBjc8tuX+Gm8E1K624XdFxwAHabgUyfeFDOv8b/W25H0i9eVpgpyolP?=
 =?us-ascii?Q?BqVzosy1T9lAJZ7pP6BRL4mr7EQPwKrEZ4igD2Ph5VQt5yOL6idvpnkVzSf5?=
 =?us-ascii?Q?cGxnAp63QwAOUJAXnQ/i32Yi5L0+SwMp0+k94xrth+3n4NgkHWyk1ShUCEsX?=
 =?us-ascii?Q?hy6jV1JPTbacA/vEa9xlZIi8afLAkJdKPzfqJ0AinitSodDY9Rv58eNDawLn?=
 =?us-ascii?Q?65VCPW/lL9f7Dgl0umBnmOfYzmgC1FZrDARg7fBjhAqntynSR6nUd5cv5h08?=
 =?us-ascii?Q?W8ZevqCXew7NsqJObqMVnRW60qbogI2Dbqsqmf0TQ32WHt0xCVMDGDfmnksc?=
 =?us-ascii?Q?wTd8nBGvKMZtcpWb7kTgbdijVLfJTSBpjHDxuL4df+mDF486oFp90s5Kerap?=
 =?us-ascii?Q?ewsxGxffLkF8NWcxSmGqwYBaEa2oj/GOOPi/WsVl3y5CDkruTVNFDTArqW3E?=
 =?us-ascii?Q?M78rAYN3oGlqGdOUcVYnQ7hm6g5IHpjcQX5CHCRysBVjAsdj11130uoThqg?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: CJ8uAgazTUFnOB2wDKJ7spku/Jj7dBlotomrvRAm6W/soxIgD/4Yx5BQoQBWtpwp0eU23Qb638acZVrWDSE37JXPN2vIF3yn2yDoZ/Nn0BYyugCZSkCXBqE6jFLS3OVesJb1ZmJpBBzQRuhV3Q85TGpJUY1NYfEIUKZrZS3QAx36Dq4zjpCFWCWzCmAIWu7/
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;6:0gWk2j3H1eJi6SsPy3sbR8ap6/lUMMlcnh7QZmoRUfTmh9TnYdQ4KFP5C5JeKCR62LRW0iOqlXKi2AWCVxwOFHoZP0cdqihE6UelP588eZfB0tTwAIpXEXSfHq+dnBgLiZkifRTyicr3fV8M2UTI/eG7awb/au/+C9fMSjHHm8/pcUskJ34D04uFAFIU0DdwoHO5tuSN+AH0OtdG0whb8/JNnUczbEUmYfV8dMsFwyTj+dciZ9YVHOPDlj/ryQ8Th2+O9jxxGCyMrOaPWn5D/6GfcF0C/SuRRJb9i0iv+qyB63TNrIz9XyKd2yv3J1Wfi/UPjCLDBqBHoehHSmoJ7WI9ICwS8/cuQYhNKMaMpBk=;5:ZCpTrugp5140WPRQXxjDroGB6/UwuC/EXsh+XAQFRbDbR7rTy0JLJnJrOmrwqJSLtxWTOp4syPkHDfqnOjXQRXgw42HeHOKhbQOFl/Wuvvvi511D/k9s8VtCLQ7zzLZGAm2duT9cu0aYpk3dsDNscTV0CgOwWhUZ6I6vdRbF1os=;24:GzZAok9lt1H6qVocS4Z7nguuNfJID5/tnVn5yScCcrVUNhTMguAEvsFKrgj55fwx16Rhea9yqN3UQPZT3xI/yAR1kHUl/XxyA/RZjWQq7JY=;7:CiOUf1v2G1IhoevZLu1F6pvkhlsvGQN7GcHHimN89NvlOy1c6Csgp2YgktobGEkcpdab9pW+n7XH8pif3Zu6K06wySvzDX/KYDhBNHCu74JBKlXDbMuDEgISEla+XC+OKQBU5Vm21DUZXq8CoYIroqzZnGNRZl28I4/DE1MzvKV3DHm1JDYIPKqBJ05pdN3h3atgDEtRiQ3BF4TmfoGBaxzxij5wm2B9XPPomAQmCaAphMJrR9speRLYOETo4JF6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 14:30:28.9544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e94038e7-42a5-4226-3e5c-08d582a5a740
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2425
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108397712003936?=
X-GMAIL-MSGID: =?utf-8?q?1594108397712003936?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index f3a40af..1f15492 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -135,6 +135,7 @@
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
+		dma-ranges = <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
 
 		clockgen: clocking@1300000 {
 			compatible = "fsl,ls2080a-clockgen";
@@ -357,6 +358,8 @@
 			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
 			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
 			msi-parent = <&its>;
+			iommu-parent = <&smmu>;
+			dma-coherent;
 			#address-cells = <3>;
 			#size-cells = <1>;
 
@@ -460,6 +463,8 @@
 			compatible = "arm,mmu-500";
 			reg = <0 0x5000000 0 0x800000>;
 			#global-interrupts = <12>;
+			stream-match-mask = <0x7C00>;
+			dma-coherent;
 			interrupts = <0 13 4>, /* global secure fault */
 				     <0 14 4>, /* combined secure interrupt */
 				     <0 15 4>, /* global non-secure fault */
@@ -502,7 +507,6 @@
 				     <0 204 4>, <0 205 4>,
 				     <0 206 4>, <0 207 4>,
 				     <0 208 4>, <0 209 4>;
-			mmu-masters = <&fsl_mc 0x300 0>;
 		};
 
 		dspi: dspi@2100000 {
-- 
1.9.1
