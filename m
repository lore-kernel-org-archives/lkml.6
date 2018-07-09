Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD1DC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E698F20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MsEip3xr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E698F20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933292AbeGILTw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:19:52 -0400
Received: from mail-eopbgr10071.outbound.protection.outlook.com ([40.107.1.71]:7218
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932984AbeGILTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSF6WsMiQFz9osmzQtZq5/GO4k6ZQuqdRQNL+BJQVlw=;
 b=MsEip3xrrJOheLV1kkVYAG6LduNo0uWMOFWoaR64Lzu7aDFCjrVQIvRw8qMC5pd2hcQ4c4yHYu/DrDAATWeXPCrF6EfZW+vYRToTXrvXeSb8+v7sSLZTmKBBxHk+43mvaKnJ26rfAiXAkmtSq3FVeIeKLPjrcjHnFQ/6vJyls5E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
Received: from b27504-OptiPlex-790.ap.freescale.net (14.142.187.166) by
 HE1PR0401MB2427.eurprd04.prod.outlook.com (2603:10a6:3:25::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 9 Jul 2018 11:19:35 +0000
From:   Nipun Gupta <nipun.gupta@nxp.com>
To:     robin.murphy@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
        robh@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
        bhelgaas@google.com, hch@lst.de
Cc:     joro@8bytes.org, m.szyprowski@samsung.com, shawnguo@kernel.org,
        frowand.list@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 7/7 v6] arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc
Date:   Mon,  9 Jul 2018 16:48:23 +0530
Message-Id: <1531135103-10699-8-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
References: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::30) To HE1PR0401MB2427.eurprd04.prod.outlook.com
 (2603:10a6:3:25::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e77f9660-6a60-4fe4-2a13-08d5e58ddcdd
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2427;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;3:y4aiRNijK3QnwTk/zcKKRaJte4Pc2ut/078cbTVoMdVDtHq2pgi/IhPWcev5EaG7Ny9tRypxCGKDUIQomiAxue/QWl+Wk4aVC28YyvCnEueW6rHMP6XxHCAkzbn8nprSW6zta2pwPmaWhiihDK14cTTVznbwWBbOo0oBgrEYete3EiRolgwGJvG3aHWthgKbFlQgZy7W2n62GMjEKd382xejvsUljbUqFB8AvGcwr009MIKBWheo/9RCyycJeCQr;25:VFa93EDAfdOCQQAO5DUF3mQ+5ekS5GcQ2D37SyZIA3183+mvgZUSznBPRrn307KeViyDNPo1vngyTTdcz/Z6rQ3Hv52QXRrR0xzxl0wYJnTrfafCWyn3DZd4jJKMGOoF0wPcjs2uAkMR2ctY4wCB8N29yhadYhvHOKDZbXrELKIlv777e04XWn1878fnPkCLZWSoPdgcNlkNiaqD016Fp3dSCetSvbUbC1u/PgLwuFL7yn9o96ApX+SbjPnD6qCn3jP5W2CamXrTTpgV0Rr+qlgngG8kCVC8JRaWUCYcqnrLPa1Ib2hNeX7hQRLXAtQv5El2ghC5J9/e591/ARArgw==;31:i1maHVIHavrGo3ZB8WdIr5Cddk1dfvDGdIKtd4/gvLrm0S28CtF9Li5OfFDku9p54Z1X01s/Z5yz481pUoKYtdpqJ2bknWlZEvooAxEjOahN4MOXpL+DRQ3ycG68RbYcOYxtVUO8rQamAYkziJofD1rKwWZD5JRFymbhedZMmV0XGiuvRS1remCy5NC4gYNP/tnsPyS5oDT9yGeg4V8pDShEMNCzdKUx7M9eIRHosaY=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2427:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;20:qFrxG8xZ54zDfowUQ9aQNkjuf1H8DFmh7b4fewbNZgYbl2JIhiO/EEkvwJBJEmo9vIScQEDY52hsbaPoQd1xwmkKZPHRT/j/vEKOxsyVh+74B3x8GOyoIqZFpg7qAShui+OPFrJWQWAGYLHnyHLjV98eRHciLbiPn5oKabVFoIzoRbmKtrl2CURWl4m5weAsIuiZ/nSZRMTrqWmNAE3bUFUSnMzMnxSuwkzsoj/SGhzsfV7x9hsLbgYGUY808jJaSE2XoWx5PAKqezyhKaoMOa4wTyvQE1q8q91FOraJMnw+HGL1Ile73Aytb0IBL5RSODuhJuqW5CAWaKFiZctBhYI3vMIR9pJGqLnWB3v7hDXJRBm91We1S4HDIHYO7i69/bVJ/X+aoRMQ1Ju0EiMxPYzvHZHG7H20VG6THt3lu1jmkV8HWfzr5KWI1UvB04HesJ29I4tR8umMr+chmt0OsiR0QeNhD4T0aRT75Ctyd7wku52kCTnrHbwnhasnbMvW;4:cCvqswcPR0kzyRQoVPcy1HSmMyLCsgdg3ZMNUD4KfhmV0A1/KIERsW0KRJ9CYM2Pqr7qVEu/1i7xpiBY+kiZF5pC8Z9b4Uz4UXGsIi0nIHDeq2FSxBNSot5zbNBDMDvrcCP0b4VCipw0R9zMI6DuRolC7nFTTwfF/QmQPivvMSSLHFXcvoP4WHzqBKtNxIC7jPK064DsHZn0Xx2cwcubTVw9vs47Qv74T8vBNKZxHrpBsVvnMOAHYcAo5Jc3jglW5V7GtkXeJx8q1mKHOU1d2DD8orL4pCt5QaTeIauzen8w9KNQkDT9yu0Ggmcvl2WoprIngqZjRx7WD1mTghsJwTgnKhsy+4SRkjD/40uPWXo=
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2427F702FC3B34E03CBE4D3AE6440@HE1PR0401MB2427.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0401MB2427;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2427;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(366004)(189003)(199004)(44832011)(446003)(25786009)(51416003)(486006)(81156014)(81166006)(2906002)(39060400002)(6506007)(386003)(50226002)(7416002)(316002)(476003)(4326008)(2616005)(50466002)(11346002)(47776003)(8676002)(66066001)(68736007)(956004)(48376002)(5009440100003)(6486002)(7736002)(76176011)(16586007)(53936002)(26005)(478600001)(55236004)(106356001)(105586002)(5660300001)(186003)(52116002)(305945005)(97736004)(8936002)(16526019)(36756003)(14444005)(575784001)(3846002)(6666003)(6512007)(86362001)(6116002)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2427;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2427;23:j/aqOP0mGz5v/XFZwZFkMe4R643zt6Okp7TAJvP?=
 =?us-ascii?Q?n+eUsBaDk94YUsCi+5SWyFeoBAGaUkyFJK4J4x6dcFj52t+u8zNfnxjx/ocQ?=
 =?us-ascii?Q?btbOmi6YRnbx0fqotzm5dXMfu6hGcLtAkffzyWyI7ejDSe/qXt6tzJHdtlpo?=
 =?us-ascii?Q?gx9eT74w/HP2zhcLRCMs2r8aATWs9HlP1w5R3XTCA7ga17txHqH3QcGaLrnE?=
 =?us-ascii?Q?NpUPpBzoultwfxxk2kWrPvIltMIfMUhOQ7sfW3gBj2XdiQ5HqIVKfByqyJC/?=
 =?us-ascii?Q?uURRp7wakivDMgSi8xIGk2IXtt2+0RauXZWv6RyiD3+hHtZyvllzig8d9qEe?=
 =?us-ascii?Q?5RHTv9CGBCOkj5WSsO+LCL2as95AHV+/LCcdnwzHOKvVHoiJNOszi2mY8p4M?=
 =?us-ascii?Q?4aso22GqzBFqTXlErUxd5KdILOY9/BKAS0ylCJZgYSAn9yHAQ1+IaPQN+xDT?=
 =?us-ascii?Q?T6lJ34lSIHMOy4BH/oia4v1EN7wMHvba4XKvgNc3KotlOQyWmhKEysoXTcdo?=
 =?us-ascii?Q?5QHQkJLp1wIpR69uVW6iVky2iwNpveBeA7o7mH/HeztJ3jdyKpbVLcLgmTvZ?=
 =?us-ascii?Q?qzk5amZfQwHi1RdYjof4qcxJYG+uBeksIC3t8hb5oADfO8lZyjW24zQJbFwB?=
 =?us-ascii?Q?OhfDxLFZXyQC6rNyi+RI0m8eIGDLex2ket9hpTIANKSO7vKMCGBnpSqTBHP+?=
 =?us-ascii?Q?HwT9BlRuDu6qWxWGkUCi5sGfcWP2P1aHWOJEeDJoGdIxfQ1Oblz5+W0G31vp?=
 =?us-ascii?Q?OeQ0Ibp7BLwzce5vTWfoaUgdrXNyifudPMiAfK4L6UwNFhm/RQZ0+88sAORk?=
 =?us-ascii?Q?M8aJhEf6SiEXt4hBw7RoUqi1NQgYoEdqS2NnPWbGjaCRMvmkQRz+GaQBECnc?=
 =?us-ascii?Q?uTvELc45F1iY3vYWsxIHSxLg6lyE8XZIlrTU78kUyxVqr7RmPSd6lHumcelj?=
 =?us-ascii?Q?uG6PvaC+9cfTsAv7q4aYEj7oFXcUl+xTPP2oSVTm5wQN1HpGBkJ+X0KzrT6+?=
 =?us-ascii?Q?SFeAu/kLX3C21pR7LhFJw5134rc0/SLJcoDy8gloSu3ARiHeWwxKsUnyTnKN?=
 =?us-ascii?Q?LcVO5D04qienAjrqiI3LH9j27UkvxaSukh1iVLgpSi96nkDD8p0WnO1Aiz3V?=
 =?us-ascii?Q?/xtcNtjlz27MEZISezMQ8n3B1d7HGZfUGZrxLosYF7dUnEvEHyanFQn3d4ka?=
 =?us-ascii?Q?B4jnmr0SLkidPUADWlV/79O2UbDxsNqB+uyJD1B2ZPMlvLKp575ES+21c/xT?=
 =?us-ascii?Q?uuXdg2ghext0AQJ7z/gxMbwe7xrJ5LUR9Z1SHSh3j2ClU2KPEfIUcDR50++W?=
 =?us-ascii?Q?4qUIB3Z3Eq2WCAByViB9ispDwLoZ0zJBOMktcMWaelIi+sFM2gMhsQIdKw/T?=
 =?us-ascii?Q?kF/W8lEvA2DBnLOb4LhoProyfK0g=3D?=
X-Microsoft-Antispam-Message-Info: 2/NAIT13mD9NZrosLsNto1i9cE7OpdrLOtsMAvSUumNQcJiG1lFHK3iei9kKoj18Z/shkblaS9Ghm5P066jrXyqkySuPXGtRe/BqIrEVbVVfWcClXPs5VA3H2tOLeWpsfuPt6crY5d6I2OTc2iJGa2/It+VJUk9yqDkklw7xiXtUMsfnxXsPHk0vT1Sx0SbqqB3Bvkw8LJoLhqhw0YB/myPASw4Ln1yUZTT2fbUu8aVZ8UVnhTU8BPpVwoQ6e7dOq/lLcl8la/lAbyGs/9sMNFkhS/pJjku3pJzYv+hkas6Fqx9EbUfz0oF2GswgWck+mVJ8WkGf4ZnMc9JVsk4uNur09U58CN1Hcsb7i81ayjk=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;6:oxODgz6YsxOGxNjVeXSGpqqzzcRgoGTcnxFRoPnWX2domazMfcSQauJOTRt9JrAO9ErHtII7wHPsGBIPrLhB4OTmanPfeyjAUsPVXtzIXkx5pGMI1d0LebMLEmry/CTat+lQw+sRR2crCmZpRyv+FYb94KsJDOJHF7N3p3DWrozrRwz+STH7wwX/5rfTejm33b75syx5qjhaA9UGFe4p72I7Qtb1S6dJzRkG8m/Eg13mH+301CSusDmXFnLfkgXRENg/0+POpz49XegQdIbjANe29EDdt+OqfLnnR6252Aw3+Vl+wUu++vvgDo4LbtB0lUILBWs40KT5ZpwUVIJOZ5fDgkWa09XPx/OV/LJvxUqHx6K3iZ4tcbKj3NYj8i3QDEfJ5bgisrqrjRLfJ/VF0fJ1LkwOmVtFhQ+lO4+3skeeZZkSIjCKwUamqiKAMY2kvUC3wWc/ybyta8hHXi5d+w==;5:OiQciVgpG8kR+YyotrsfZQcllkcjjavB3LiyOPGpe0DTFLAk/xKT9r9LrGgJuafC59IF6kyvoGGy7060s8DYYoctPVL46WbaA2cqkinelw71yV7fbsr/zpGQ+WkaOtIsDcja7lrpBi8oUgHs9jwgu+YqLtfVAaRG8HCLB/aU7gQ=;24:AvAqSmIS73V7N7mMG9XNGPocCITR8a+ok0fwLGVRMKeCVwEL3qifTDDuK4xyZd1AxBPptO3Avb7RHjm2FtvflJRvyQIDyn6FCVt58visTo8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2427;7:MipNM2ec8Aj0XOXcCz/xXVnQtMhJdm0I0+w9iY/ZYfGh54dwYRm+c0Chwes+U3kUenuXMu0UuUzcallFj9DD4LufG6R68FbiqzoDJ3GIcbNpTg5OWBACtcob8eMYt5I44kHTagU8lspCWmKmWwhKi/k7cLSCbQ2OyKf7ZCH4tQYBw+dAixuWtgNcuD9puQFB7FYQu8U7/+NWhS5tTQ+JuMgnhJ83w96wrAqrf86YMs875aT+9QztGqUb55vukuCX
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 11:19:35.9100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e77f9660-6a60-4fe4-2a13-08d5e58ddcdd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2427
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsl-mc bus support the new iommu-map property. Comply to this binding
for fsl_mc bus.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 137ef4d..3d5e049 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -184,6 +184,7 @@
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
+			iommu-map = <0 &smmu 0 0>;	/* This is fixed-up by u-boot */
+			dma-coherent;
 			#address-cells = <3>;
 			#size-cells = <1>;
 
@@ -460,6 +463,9 @@
 			compatible = "arm,mmu-500";
 			reg = <0 0x5000000 0 0x800000>;
 			#global-interrupts = <12>;
+			#iommu-cells = <1>;
+			stream-match-mask = <0x7C00>;
+			dma-coherent;
 			interrupts = <0 13 4>, /* global secure fault */
 				     <0 14 4>, /* combined secure interrupt */
 				     <0 15 4>, /* global non-secure fault */
@@ -502,7 +508,6 @@
 				     <0 204 4>, <0 205 4>,
 				     <0 206 4>, <0 207 4>,
 				     <0 208 4>, <0 209 4>;
-			mmu-masters = <&fsl_mc 0x300 0>;
 		};
 
 		dspi: dspi@2100000 {
-- 
1.9.1

