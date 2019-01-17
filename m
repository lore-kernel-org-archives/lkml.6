Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A65C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF6420856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="vYWEXhcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfAQHCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:02:46 -0500
Received: from mail-eopbgr790082.outbound.protection.outlook.com ([40.107.79.82]:27584
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729577AbfAQHCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJ1lNp9yN3MpyMNsNgJb2HTckE82kdkkFVqkfcZPb+w=;
 b=vYWEXhcNv7S6TA3Ke4rwLgfNR6z0795TsaWHhNJ3sNgQrK7REoJ3BPlr1/3X2ZwjqcZjOiaKae+YZkxgufcNSZbL1fzLaZDszixGdp5J8fFWzZXBPWt1cTFBgyqgU+Si+dgrlNNj77kKW2j2d7PYLsGGwZUYXgNzt2F0fdF3xmU=
Received: from SN4PR0201CA0031.namprd02.prod.outlook.com
 (2603:10b6:803:2e::17) by BYAPR02MB4456.namprd02.prod.outlook.com
 (2603:10b6:a03:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.24; Thu, 17 Jan
 2019 07:02:42 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by SN4PR0201CA0031.outlook.office365.com
 (2603:10b6:803:2e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.25 via Frontend
 Transport; Thu, 17 Jan 2019 07:02:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Thu, 17 Jan 2019 07:02:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1gk1hJ-0005kF-0X; Wed, 16 Jan 2019 23:02:41 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1gk1hD-0007Rm-TY; Wed, 16 Jan 2019 23:02:35 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0H72PME022376;
        Wed, 16 Jan 2019 23:02:25 -0800
Received: from [172.23.155.90] (helo=xhdengvm155090.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <kalyania@xilinx.com>)
        id 1gk1h3-0007MN-5C; Wed, 16 Jan 2019 23:02:25 -0800
Received: by xhdengvm155090.xilinx.com (Postfix, from userid 23151)
        id 61D6D800D5; Thu, 17 Jan 2019 12:32:24 +0530 (IST)
From:   Kalyani Akula <kalyani.akula@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kalyani Akula <kalyania@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Kalyani Akula <kalyani.akula@xilinx.com>
Subject: [RFC PATCH 2/5] ARM64: zynqmp: Add Xilinix AES node.
Date:   Thu, 17 Jan 2019 12:32:18 +0530
Message-ID: <1547708541-23730-3-git-send-email-kalyani.akula@xilinx.com>
X-Mailer: git-send-email 1.9.5
In-Reply-To: <1547708541-23730-1-git-send-email-kalyani.akula@xilinx.com>
References: <1547708541-23730-1-git-send-email-kalyani.akula@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(199004)(189003)(4326008)(107886003)(106002)(8676002)(486006)(44832011)(16586007)(90966002)(42186006)(6266002)(110136005)(63266004)(186003)(54906003)(2906002)(26005)(47776003)(426003)(217873002)(305945005)(50226002)(336012)(11346002)(103686004)(51416003)(446003)(76176011)(81166006)(476003)(126002)(81156014)(2616005)(106466001)(8936002)(316002)(48376002)(356004)(6666004)(2201001)(478600001)(52956003)(50466002)(4744005)(5660300001)(36386004)(36756003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4456;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT036;1:zaZ41sp1g/NzQgheoEIWxs/n/lOwG8gBUoSusQEh79gSLPyKOlPX4HX8NQbq3t2eW/+IHGTcZHOK2HDz8YZXi9Ma2TjC4ZN3JcWeYfKn97OMQSUlakf6VaIcyLW/E2NR
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09518b58-3759-48d2-d687-08d67c49c61c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BYAPR02MB4456;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4456;3:1r8LZjx5qJvf0jJMInjHXNOc2vCbdP3k47uhYkhXsDwLQ7dZ+cLfDwKORRAKUR5+b4uaqp0s5D5ex2KeF3W4C6Sy5YcEgKV/UE7ckvcJp6Wu83aIrJFW+JXu9vYVJ0uYVAYsNdmdN0NXbovl0uI7I64tENcdWXZAnU6YRvcIGMFds4Ne5du/s5WwyiZws2MWB6ZlgeOjLSkGCKP3/QOAD8c76KEEwptsUpzgF4SIQydt9sDboaiEwtIHWnbAmOHbpelYRMbSOvFKTFoJXMa8pXHJpXgiOLfedxr1vPFaHPYMrZkkPbTd/IoNZ82J11p7RNQoDBNX9G8cZERCMdabM0Lsl729Z38hCdStsXG7nfWiiB3vK5N2eVgzd3QOWOoN;25:rrBr/+cPQG+Dfos0nQby1s30Wqaje2diyeuLMnpGgRVotrg0QgT9nZpdcnyYIxmEBBg6YmUnEIRlbo3dbK9sh9+42AQMTM6SH7SMX1lbHljhmryZUEUOAmhdIvrwpSoedINONagRLUnhOo+zzPsotlObpbLY0QqKsmUgR4S81rOFlAkOJYBUv865svhazhBt4sP0h9OOExos/dI8IMFCa4XvcJoG2bnaMs48I3WnZmpoYkPk40jhjuccKHZDoFibkTPV4KpEuVQhLIo5XFqMkAaILN+/8oHpH3YSL4TYLFAYoBU4Cg5IcJOd5ug3afRMEkF5eFHjNq6wOGD3YDpydQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4456:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4456;31:6bUlqMfQTjFja/FTahEa+95zMMLhy5KvqdAo3VUUcAd+CcZAWWbbGSx//B5rachK7Smo/kxZc2Y1ap0lW9jpwd1w8FDlIMwn+MBL1blFbXavvYck6btqsmH/Pw6jF5HxJWmCjWoU4QYvMGoBnwg8KY5qwye1/StN5OIlDDtBJ2+T9SMBQlr7Sjz/EAKJ6NBkP1PSZEFljp04svd6mLhbd8BfcrQ+66wq4WI+RHxbhxc=;20:aUsjP5OoatU6YtOaq1Tl+ZM9XdkJ3s6QlQYCMdnng10Ldpl5B747pTHM/dGPFJDWtHNtodYgSCnXxB7YFYWArpGk/0VL78sE/JOya7ypJaxJ7howYoG25V/RUO/cVwWPoi3IRY6uhxESmbncNhW5+XCPs6Hv6RvM44t032FCHWyE2W7jJ/7ocO0G2qdQjdj9ZFyMGIA6YEmfdA5XNLWQ6w69gn1DwqlUm0e2w0cNTA0wasq/fDw2xqHi3dTsQ8Q/8F+oDsL6pNpfdbRW0Hw7p7YL7cpVNejCuIsCaWfZs6kBRQkDZThyIie9GqAQnNRgzREasoN95l/t06jcZrchCgnfAR5Fhti31TpeCWz5mVMU9O0friZxTWVS8x5AqaS1E5wp41GyOZhHAcSehgafIVaySAqx9IQWf1RMJ4Ncd2+ApW6MynkmfOlH/osW17KomGZo4J8yYZIkAa2qMFjx4AY8bc5lUwdY2JDARO8ESWb4KY0NAeKlkZPviJbASj1W
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB445656BA0F3AEDFA19FF311DAF830@BYAPR02MB4456.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4456;4:d21CHhKppJjeB3yvoRxTH575ihKkZV6mhg4TqQTnYZcsVdL6m8ZyHe3Bs7Ul9K48SJNLPtxSG2Fpnwq6QRvigNJJWXwL3n5pXerMxc+p6kaFohgSB73d5t14AcWQDCDWzqgBBEnN7D8f1rNcFe65oyOIpkzqfZDTbEMf9nlPGWv3VO6nPhNaj09y+gaqPEQtumhbfrTIJSgP+eN6rYXtyWuMNtKScCnPWEi4JqxJ5MqVzvfjuvo/1q6Mvjb4tXLPQrwI16Zb6WUrVfeSBD10R7aiWttZM2fEPJ5ogXqfL13Gwx08ucPBAxlQEVtybN5A
X-Forefront-PRVS: 0920602B08
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4456;23:UV+rrznKQDBFzJ7tOdqyV++71GPWmsOEdSEcLwoN1?=
 =?us-ascii?Q?R6YnyQxLURY9wlW5FpzEtGZZFwsQ3ViHgMAw+jwPp8F31J2GiPNiFWC0z3LC?=
 =?us-ascii?Q?aWI+Fja5/qfDYO3jo98LhLA9tTWm2f29M2uzHungeP/cR2W2mItRSvgTGBpl?=
 =?us-ascii?Q?EZvQWSF4C+zNdmbinOIFoqUGQcakRUV4jrYyM1vMZ5s+2obT5HwUOsN0zOJS?=
 =?us-ascii?Q?u3iX61NnG3kIk96HNdo0PgQNgntGBeEdVg2WeL87JNlHYW9nT4aThCKl3INv?=
 =?us-ascii?Q?nmk1cb43g9pLeZPSPVSrgJOIT5VVTvjAniSzWLQVO0bfLlsft5cGevj5eejq?=
 =?us-ascii?Q?ffg7AP54uX8Z8E6dDoxZYKdFIAHHcB7XTIx/mG13IRO2+dduONIIQB17ArzI?=
 =?us-ascii?Q?Afm/1f5EOUfzdzXhhqt4Ag8qIshs+aNim7P+u0J6VNtAaR+80N5WbopK2Kvp?=
 =?us-ascii?Q?0V0/QM8YkOSC9slTk1AJ+6zjBBWeS0vW+G2bLUl1kZqRFtJME1i0WN2NWfa0?=
 =?us-ascii?Q?B0Sns6OLKkyxM3oMcAoE9Q9xgDF52QRyKbNBskw59H4NKPsqX7QQY+wQ1Em0?=
 =?us-ascii?Q?QGbFSSSqvcOqtpwnlCROGC55a8VGpFD5TNjRcQJtsfkzISETPtPglXVzsMlg?=
 =?us-ascii?Q?iZwv4A1Ejy010j2zMdig6REK3OIH06+FlrDZvS19Oc/q6Z8R/2lew4B73uB8?=
 =?us-ascii?Q?I7rHJHbJriafuYhWBOdVtMT2TXxVKX8FLHePGTs2qGAdg696aX+Mw3M3COk5?=
 =?us-ascii?Q?OEiotaSnngO5nOZu/ABMcBFPoQNktKfTahnL1VvcWRPpkon7vPSZF4Ore6Bc?=
 =?us-ascii?Q?BOftcHZeRYXu7pGbvMfjZRDGVSw+SOAk4JsY5FTeFkUtG8XkS8EhZM4EeTOg?=
 =?us-ascii?Q?SILrJ5FVDSZRnCft+0jaKF622hDyMDqKYDVAlA63Kpq6ykEXpVf0+Vrcb74m?=
 =?us-ascii?Q?vzdqhTjPkUf3NoXcFQQdXD/TDBWR+m5PSs4eI8x715IQ3tUqfOI+NvLRmTpH?=
 =?us-ascii?Q?P6nZVsrjv7vz44/K9SustuWYH4FfYgo3mIJiwr9jLH3ssVPpnBDIdwiSimRn?=
 =?us-ascii?Q?ABFzuO+CmStutGik8T6cJL07uhrKV1OmpWN7ykP+YWXV5KRGfSTB8IGe6iAw?=
 =?us-ascii?Q?oHkYpeCWHtPIsU5vLVS7XGbwLxna6T2bMf6hk3pwbOgqpBWrKSQ5u4ffAoSQ?=
 =?us-ascii?Q?1kgpw53FQmbnURiIG405GLTxVfHB1WE5pfI?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 5clRLH/76Z9StLA/VFqUoZrhfVFlK/2QD4z8zUoLqtvbS7r8fCC+Wi9hchIbjcvA6GbDgXyzSCk4SnSGkg0Pw8vgtb6HgAovWd/E8qPmDXQdpoBJis1sleqi2FBi4uGBGojCjUYJfwkfk2w4KfnouSIFjeDgSMSoJbThKLlx+xKXbL2gkNJKtkitqzs4alSlN4uM9g7Yj6rTgp4Ar8F8Lso4KMhso07e/YFGT6CbfPxwUgOeWgZe6EqptQyvQL4u36wCsaSWlYstMefl6lIrsXfctCwUUiEvUiR3HHdggRAfo6efYiJV3aKnPoCFTmxuIEbw0GS8jlLHgRjt0HYNEBElqy1nj8T5MU7Ry3kS/VdWHSRmtnf50yX1kj0Xd30PhjpQI+TmxePoT7XCv1gSVZICJnDBVjCNuxg4qo6/4nQ=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4456;6:uDU/bkg7FkmXekX9BaghUL6l0I2BYryB4CBPWFDRpeXEr+eOrAxsgMvTjw2bM4f5J+YPDB40jQwn93XYTymaCd3ZTWx6KR/VsNCJdSo3QVyhWK6zYE6HH8XHwFu9pDKZbpw6kIsvn9Bs0yrFvdWK3ZkamYlXlpeLEW0olOvASaGspQM9Izu9l5wPhTNWbSdcRlUr9WUdGgJaMk2WCumiyn5OWtFI53EwMmkbPZlnhILDyhyX4zADI5dY7UZt6svyT08onKrQI+WoCOuRINsxkBxDGkKQk7hOwrLyWhsBXdSALJf0s/HatLhFk9bEhjEUVq060N/kwkKet/FeTU6pcB6BInnClSniIapHv+2XnByWeR/8gDn0yX8f3JYz8C6k91fRA7ONnBMPcUUHWSwNH659pHOf/ge1jL84dS2G5xZP2mpYn+lZfLns1Nwulb/9P4io/w5dE5G5+KZF/S1WFw==;5:nD2Eg4PapL9VjkDfGrA9kMFuwmzLJQs4VV6zg/FrfOKd2gUf/H1E93psYexZ2tq75P6KqPzZHa4BnZPA/DaEvpXsEDppfrs9cuoS9fUIus+OX3tvKDmaM7wQCIuTWlto55MnNK+xidIr/4hRqfoUqoTn/HKfs8SnLVdoi683K3XuYr/NF7PEQtpgpyz2ZaoxKx55ZBZ5UkzJ8fuK9YVV1Q==;7:RjwwlMxRxs3Cw5l0Oki7QLdSy+MQa4ZrDyNdIzPl3Tqt2NeJ+aKejZZ3k3Av1vWptoPYWgJmJ77+brTZON3e58MfFIKzV7g2BVVFv2s1Nx47vxUYqOY3Kg9JF8PYFrpvisDV2JWdjIuxuqSSSy+jYQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2019 07:02:41.5987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09518b58-3759-48d2-d687-08d67c49c61c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4456
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a AES DT node for Xilinx ZynqMP SoC.

Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index fa4fd77..a3e8332 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -124,6 +124,10 @@
 			     <1 10 0xf08>;
 	};
 
+	xlnx_aes: zynqmp_aes {
+		compatible = "xlnx,zynqmp-aes";
+	};
+
 	amba_apu: amba-apu@0 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
1.9.5

