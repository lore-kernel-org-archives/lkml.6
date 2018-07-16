Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0537AECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1C32086B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="Mxx1v1Z4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1C32086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bayhubtech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeGPGx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:53:58 -0400
Received: from mail-sn1nam01on0091.outbound.protection.outlook.com ([104.47.32.91]:56224
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726124AbeGPGx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com; s=selector1-bayhubtech-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t42d/JaSX3R1mdDkjNUCjmCP8UmTF0Cxrv+COT4TZww=;
 b=Mxx1v1Z4dhKGyFCzJkrxvHjkSQX/+aui+S6v3CFoauWK9ktWksxB3jGNnhnR3AFRA69+BQ2M6W4HIf1cSaMG80jDx5hEXo1I/CKvAUkGxD2ECv1H2G+Lt2gXHW/SWt2IpfJ+KV120YZ+p1OFg8wR1wh7AjY0bxb6c0pDjDgIRko=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ernest.zhang@bayhubtech.com; 
Received: from localhost.localdomain (171.82.0.134) by
 SN6PR04MB4766.namprd04.prod.outlook.com (2603:10b6:805:b2::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Mon, 16 Jul 2018 06:27:47 +0000
From:   "ernest.zhang" <ernest.zhang@bayhubtech.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, chuanjin.pang@bayhubtech.com,
        mike.li@bayhubtech.com, chevron.li@bayhubtech.com,
        shirley.her@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        bobby.wu@bayhubtech.com
Subject: [PATCH V7 2/5] mmc: sdhci: Change O2 Host HS200 mode clock frequency to 200MHz
Date:   Mon, 16 Jul 2018 14:26:52 +0800
Message-Id: <20180716062655.24703-2-ernest.zhang@bayhubtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
References: <20180716062655.24703-1-ernest.zhang@bayhubtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.82.0.134]
X-ClientProxiedBy: SG2PR06CA0180.apcprd06.prod.outlook.com
 (2603:1096:1:1e::34) To SN6PR04MB4766.namprd04.prod.outlook.com
 (2603:10b6:805:b2::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48697890-1068-43da-55db-08d5eae54ba9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4766;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4766;3:pIly6hg1qI7cDXXe+xo97W8sw20ycVF4fVnA1/WpUSgitNOPtxPfHA0QgOEmC4VSXFzhGeTggshWYcWzuyCGpQjCZecjwDznXvY+jLHMF3E38O5aK0nYqt/WG8ZNBLVCysI6mglLvNbIll/XLHA+HO5qAJaK5uc19QHrkMQtiwEYfZ3kAe6yD/kmkxu4H1PNliQWboz5sut8RClobzbdR/wPQpKY/plkbaBqxG7rBSn8mih2wNDuDHGGLZfQGTtm;25:g23dp1t/+TP8lbunEa71lmLS90oTbpH8rFK/AZsjpDCsRvjqy0lvHUcsDMH8JlrB+l/8DY30O3RNYPsN7Zr8gkg2aSGycqyVvyLhnkuvpSUqeHmTxHVpVxOvJLJfOScKcyb/ecCv50yuQk+p+16svOtQ9SCWH+LJvXS+z7OO7ja7M8vg51KKIhZjDxcSevpWe97mcDEHFiP5vSrOch7GkLdmaLUIaW1vfi3fdgvp6LUiuL04QDwKqVd18IJ9uYE7tb7bAwF8JJMXoQnhxPdE7OUpyVnJPufc3YK5Pj6neLW6iSrBFaJGCBQqsMOO3RFCZU1/5WeH2QQ6zxFm4e5oyg==;31:Ia9WY9bm+3YTYOpwvc4IwzFQwgMRkR30Eh2QkunfNvsgnpcptfkvtpQbwLCExaRwTW0PosOMQuDGkNUsCOKOIPg5AyV46lHrUiduMMDHoLJAEAqU0ZFVqp6R2pmZPW8EffB9IWyabGI2PPjYTYgjSzJwxQ8C3xlaM0/hg+t8odYNbUjY/sEQdPvymLEoEqjLkxiINTG9MzkzyakIJ9ajWymhMhqgCZd0oOR3PFtlY6A=
X-MS-TrafficTypeDiagnostic: SN6PR04MB4766:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4766;20:Jg2PN7b1f/t6xG+1j345OAqRRaLAjpqXg8e5y2iwUcvPdnX+J4hCdya2m9d96wgNs5p3kuKJs5c0i5xcKNiO4Ih81aSSKOhO29mh0j+9oU1d+j6VsNMEd6ZNUNWGwCYOFnfktU3aDWalpY7WERV32sTUXIDYGbBlgbPoin6vXhd1FLwW9Az1IB92ARXj/AxraIvrKkByU0OuTspFnNwHO+luCtZvLRWhgqSX1y+TKcE9Hd4R2qSuetBUcTypdHEbJIhEOoTgYprffxBpPdLT2np44m0YUWzXR4uhAcecQeYf0Q/Bun3psLwLjNlJMi3AUxcVc1trgDkEW19OfXW74bz7B6TsUXk6fGCkqYEH/dlCnxaJYo5B/BgdBen8S1Qj7deRNflLNF+1IygxtGI1QVMEzwUWb4la7boOeby2+Rc=;4:3d5W8At3JbP/Ym/9wdnj5ZpuAqh/DqSoz6eQciMAaDGFFdlL1BThIlx84WCrgiIoF7IVn38ukJK4k3cdEQ2aKZWFiAP2YjocVb63dFTBnvmqr9EzoSJwA+cY3T/rp8nj5Tf7F+p6SVGDk0K2Xqax5Eb+LldeMHte2Y6LHfBMqMBXx3D+kpkkHx3fjTmgrsIq2B+3C6AH9oXq085nV9WtI5txf8kjsw04DkiscUOhu005+vOdFk8ndmdniF0FYjGNxLK6yBkac82mfD4yqE8Evg==
X-Microsoft-Antispam-PRVS: <SN6PR04MB4766E2985A3A7BA2B99C9E4CE55D0@SN6PR04MB4766.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:SN6PR04MB4766;BCL:0;PCL:0;RULEID:;SRVR:SN6PR04MB4766;
X-Forefront-PRVS: 073515755F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(136003)(396003)(366004)(346002)(39830400003)(376002)(189003)(199004)(2906002)(97736004)(6116002)(305945005)(50226002)(47776003)(105586002)(478600001)(106356001)(66066001)(81166006)(3846002)(8676002)(6512007)(81156014)(68736007)(5660300001)(7736002)(53936002)(86362001)(956004)(2616005)(476003)(11346002)(446003)(486006)(76176011)(386003)(316002)(48376002)(25786009)(6506007)(186003)(26005)(16526019)(107886003)(50466002)(36756003)(52116002)(1076002)(6486002)(51416003)(6666003)(8936002)(4326008)(16586007)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4766;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR04MB4766;23:G2xkqQktIaxFNi/7/ghIpyFRVE9zQC7wctaClRZTu?=
 =?us-ascii?Q?AdlCVB5E5t6TqU6e79NColDltwsRFYjZU3S2dN/vcTE42w4Z87VzS2Bv1D1I?=
 =?us-ascii?Q?BQ1d37VI/tk2uT46rWFlglQl5k2SPQkSeYos8WnWWW6Gz1BmZSUQTFTaIoQG?=
 =?us-ascii?Q?aIYBhUoBc0jeY4xWWkBtM3ibfKJ+duEnctDxWWAnwyBpmleQ+hoIrDl5Hg+X?=
 =?us-ascii?Q?qP+H3RH7HS0bCSpTgrz3vVAEWIFwZxz0fY9jUDN4zNY0x0ac+kh+fn4YBijC?=
 =?us-ascii?Q?bcAWYPsxh+/SHoOOOap0P/I95xW/37M6mdaX9Fy2enspEzNGTx72GM+vHhnb?=
 =?us-ascii?Q?qg7yQFfRYDm+pBuM25MKg68hKe85DU854aQ6JyveH/b6xpgN7Y07nRcHWMfb?=
 =?us-ascii?Q?cBbnZBCJRXi5iZdkJ5B/Xc1gOf+pwLYxy/D8OpMDLwk4rOfnrE8E2ul76joF?=
 =?us-ascii?Q?1JT51yjRXFMRlfjxHCO+UcvQp4DTbtVtGho6T7Kg9NRji4zCU7Te6i6Q9kwe?=
 =?us-ascii?Q?kZydUFeCR2ANadrQDwf6Mvv1CZE8hmVJ8KhD5KVre6jArw2zmqnKsU4LhyAD?=
 =?us-ascii?Q?8plg8ujDmBj2YFU6adYVALcZUKoWn4GQSb1Yd2y9/+Ab8bYtKDENAbLXY/ZN?=
 =?us-ascii?Q?5uh3soDyxDs3/nvjvHYrZX9Q/lpZe4O1oA5c8NCwDvUhnZYpYHpMgOKVsWzS?=
 =?us-ascii?Q?9NvGl/TetlUucgAO4RVM/3CUHa8GaLWKnpk44Aia2z0BiBb+FuLyKsDHErBo?=
 =?us-ascii?Q?l9A+l/x7yk381Sin42KXHrQbpXxRazBQJnaHDAMyyiQdBq/pBklx8y7FrELS?=
 =?us-ascii?Q?rq6XH+XR92KCzBwPJNdJoiruufn7AtrA2dlKOudzMkRkr3kz2VNmuH7/YKme?=
 =?us-ascii?Q?5tuL1cki0xkgkQJzBeFl1PnDfzri34l4nfHiAyftbn3OiKvB/S2pX+tGveIi?=
 =?us-ascii?Q?HTxAiILgMwz7dnFXCMipCt0Pd/owsMunnR+7pygli39bBx2GbN9HO1kPDS0q?=
 =?us-ascii?Q?AUGVjAFm2Jqy5PQ0I4hIZ6OgCMbbN7GPn95SU5T7KtjWfjzJlPefHpmrOPxo?=
 =?us-ascii?Q?0GUFfwC7CUt57FlsUdjyij39TebNtMJ+8P59WkOdlCYwPs4D4kn4cH1CAqNG?=
 =?us-ascii?Q?PRjInQaMTS//1mnNrJuynA+X2za7dDwxOtwvnAPbCKrJ2bPUKGKQOSRadZcN?=
 =?us-ascii?Q?S1xx5dsP0c+Vc2xRV9VdDOJ7ALLTQcsznHbU5EOtLkKv1amA/ppOiduLg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: +49nd+k3PHhtngrVrKnHJC4UM7E0czs+de+vli30BBYAh2w69Dzr9OVmnFfWmd3kmUtBAjnW1BQbjdj4gK1a4f0FxdmzIwC7+UCWmBM9R3KCyHmNHhUdmpwt1iNkK30lOFEUgaGXO4WdPPkc+asEEyq3z7wZPX1RW/rGx2M5QmyzTc9Uveh4EzfOz8BH5efTfVYc6BHw6wFVJ99fp/+FHLUmcHsEk52/3x/W+7/xZJCvoULJbRkLgkfPYPMO9OFZcvXW4dfuw3d6opjLqpAeiav4+kOOE/QL14cQMBhlly3Tsq3cpLxDFet14HefMfRmzRuWDg2+SKggL4IbpHo8UbjsqSj7oVrI1dngTkck7zg=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4766;6:T9Mio38YnbbilqUuYrMsQuGE0uGa3Sdd8sTU992hggnOC+jExtWDIdTOOnNeO1569a3BYO9QcDNvIAbeN0VMOT0dJBnL2Ei72BIfKiTjMD7VkE+AAGX9dftiFErFP+QyoH7iYljRrA0jmeBguyX3l3p4zrpg9zPppb7oyLA4zvux3A4kwiTJLLgQT5kNWN3+bYCiuoGG4+qvRpG+bGvaGFIIorg3xgMO40biE1swAr8TDF17prmtPNY7QzFEgRlHNvS9psegt5DdPqRNpX/I6DeWsE0hJ4LKARnKTBEykLhgMjAVHwqJ4vyPyDJleAeMjL8BFLzrVLBW5PF8ZmaHodoaSM7NqjMrgsSBJpEGY2VPNE2XiYLMJyrbMI1noQArFfiUvoWHTF3yzAGLSc0u4eoRNBP02GlvbZRyqtJQW0GM6WhzmdZz8+r/IrlWMIOjmlsl+X1EQQ7oIusRS5k4HQ==;5:KXwyl1vXFlvv+OrSTQHQjbz/mqaBs703Tafg77efdh/12CeilEYh3AouTco9W0sGV0vTUaXum65lyqIGlAbqDGrWk9oiJEf3vSiFiVWhMrdZ+U0i4qaIz7kvMxsF+S6rF8fB3f2rQSiGF8xGi9ArCIUkbfDtRDzq4ksRwyakiRQ=;24:ZY+updkpImR+XcTzfriWl6vJTu952wmmH/Sd3KP7E4HRvIO5cfadNM/gMv9KJZ2Z8MeftNO9soHU6eijwuXnE0JVpkvTyzAb4ersR74PUxQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4766;7:m0Rg5XULSbLqZ8JHrTe7sQYBLNBKrd5nU3akMLuaEjRHV1GTyVsG2knkdd9PL6EqtrEMRdp/pvogIXdQLZ1FIbeOQUjcZtLo3id9cfbiUEvs4WeI53FTXeo3YHILkpJG3j328C0S998vgMmqfcIkV+pjLqiqaTD7tPJ/RyY8rwoNXFXxEFCLKcY6PbEwLbjZQJG38342XYPyyt8foGBGjl/PwRv8y9yYqdQLmLfcIX1iqpD7PN1i3f1Ws8So09uX
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2018 06:27:47.9461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48697890-1068-43da-55db-08d5eae54ba9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4766
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

O2 SD Host HS200 mode clock frequency current is 208MHz, should be changed
to 200MHz to meet specification.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
Change in V7:
	Change HS200 mode clock frequency from 208MHz to 200MHz to meet
	Specification.

Change in V1~V6:
	N/A
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index ba59db6a126c..94cf3cd75dd3 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -311,7 +311,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 
 			/* Check Whether subId is 0x11 or 0x12 */
 			if ((scratch_32 == 0x11) || (scratch_32 == 0x12)) {
-				scratch_32 = 0x2c280000;
+				scratch_32 = 0x25100000;
 
 				/* Set Base Clock to 208MZ */
 				o2_pci_set_baseclk(chip, scratch_32);
@@ -406,7 +406,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 					       O2_SD_PLL_SETTING, scratch_32);
 		} else {
 			scratch_32 &= 0x0000FFFF;
-			scratch_32 |= 0x2c280000;
+			scratch_32 |= 0x25100000;
 
 			pci_write_config_dword(chip->pdev,
 					       O2_SD_PLL_SETTING, scratch_32);
-- 
2.17.1

