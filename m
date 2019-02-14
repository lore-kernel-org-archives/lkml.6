Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EA8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A8F21916
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="CPDsXGRu";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="rsYJLnHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394413AbfBNTqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:46:24 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:60462 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728650AbfBNTqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:46:23 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EJdVkQ018899;
        Thu, 14 Feb 2019 11:46:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=u8lbnYO9Aql7UzXzuCasT/40fYmcPzrmcDmmTjbfv5o=;
 b=CPDsXGRuavq+ngQwzoAXabTUjDBkYg+T0iuA/LtnRaYcbrn7KBooalVuiFPkIJ51nI2S
 k0b9XOuv9Sa6temCzSnzn6pPG0yuCFfpakscZqMXE331XgDm+aQpJwediHqrNTRFUIw2
 7UBXgOor+XeMM73rBZ2xrlJeELPQlCLGPOEZXr5vnGwNg4PcKot12KIIPpAQ1mRSLnl+
 +B9alOJjkAz/8kZwrbEfPZp3LHYI+kuJU/0ztAeS9EA7rwM4L64rVQDdRx+6DoJ/mXvr
 YWY6uSSfcrisBUhLrNGjX3496d2ecXv/QuCdMeBhhMWirKafRtsgID94yMpeFCao0ULN iQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2059.outbound.protection.outlook.com [104.47.37.59])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2qn8dqhrsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Feb 2019 11:46:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8lbnYO9Aql7UzXzuCasT/40fYmcPzrmcDmmTjbfv5o=;
 b=rsYJLnHy186/RuWFUhYqQbD3G+hs/DhOcfGcwiYfu+2fu08Z/+w/EXj15kVM1SiP1bvW7JjMW4S1X5kJnGWQq+p2PGUYIu/JGyBK7Vg4i85GeQba6W3n3ZThe832ju8901EQp16ckwVXV7onBfyvZGdoKUJCOEEYTCN3GHotUT8=
Received: from DM5PR07CA0047.namprd07.prod.outlook.com (2603:10b6:3:16::33) by
 SN1PR07MB2255.namprd07.prod.outlook.com (2a01:111:e400:c456::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16; Thu, 14 Feb
 2019 19:46:06 +0000
Received: from CO1NAM05FT049.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::200) by DM5PR07CA0047.outlook.office365.com
 (2603:10b6:3:16::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 14 Feb 2019 19:46:06 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT049.mail.protection.outlook.com (10.152.96.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Thu, 14 Feb 2019 19:46:05 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x1EJk2cR012765
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 14 Feb 2019 11:46:04 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 14 Feb 2019 20:46:00 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 14 Feb 2019 20:46:00 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x1EJk17u031402;
        Thu, 14 Feb 2019 19:46:01 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x1EJk1VW031387;
        Thu, 14 Feb 2019 19:46:01 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <mark.rutland@arm.com>, <linux-usb@vger.kernel.org>,
        <hdegoede@redhat.com>, <heikki.krogerus@linux.intel.com>,
        <andy.shevchenko@gmail.com>, <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v4 1/6] dt-bindings: add binding for USBSS-DRD controller.
Date:   Thu, 14 Feb 2019 19:45:09 +0000
Message-ID: <1550173514-23573-2-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1550173514-23573-1-git-send-email-pawell@cadence.com>
References: <1550173514-23573-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(376002)(39860400002)(2980300002)(189003)(199004)(36092001)(246002)(105596002)(106466001)(8676002)(336012)(11346002)(305945005)(54906003)(2906002)(86362001)(446003)(7636002)(47776003)(2351001)(42186006)(316002)(486006)(16586007)(356004)(4326008)(6916009)(8936002)(26826003)(426003)(107886003)(87636003)(186003)(4720700003)(50466002)(48376002)(50226002)(126002)(2616005)(476003)(36756003)(26005)(76176011)(51416003)(7416002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2255;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT049;1:HFF545EAhG+iStod+HiPhqypjoe7d6uUcNgP/a/yl8OT3INy478VOTIUp15f9fPPCeJczeqtdj886wkteLVhvACJfxBM0GSrFcGF83E4IYoKnuRDgGLktcH9/yq3Dz7CWFfO9cVXcOUM7obtJQv+MX2HD05vLzVDlfq9vuCSNFk=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3434c38-dd6e-4cc0-3c09-08d692b50efa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN1PR07MB2255;
X-MS-TrafficTypeDiagnostic: SN1PR07MB2255:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2255;20:31u2MsDZoX+btMQDqe9aXqqObMno6nicA/57BGlE57GXyZvPETUQ5p1pQAzEn3K2PndZUDJXfGwJodR7EobcvpkRIp9KRS5HL6yU+NKzPxD9PlBjiauiihgVJW+tQ5gvrmF9j+KE6ZF8yivJB6FULPQRYryCyvCnoVdp2ZtOBrHmkEs9Jxnm4/C+uQPACMVkWjnT6beIWBGaTxLq1+lzsKa4Azyvk7Yw9GDKBy5JYqja5QKqtWV1pwiVbdFzNzXEdGldy7M6T7LsaaDyh/CQ1MAfWDm9xjKPN87l1sGJJ1i51u/I/T+OqRbtKsOkwjKXq8z8qx4hkgl28rlJd7Q82E0OY3nlDPZmAdDnjY+N93Ckj6N9qVYDyHqi0wi+ojE6Q6184YcWoLnhBtMEzyPgda8ASIFWxKLeBNzeTj7RywCZT0D3Lkti0Xo4u57mzxSmUoH02jvalRj5MJhDCTbRBbXGBMMhTBHZLyJonJJQKQp4tYy9+wP4Qyvmpe//Lkhh
X-Microsoft-Antispam-PRVS: <SN1PR07MB2255AE49448413173B7950C7DD670@SN1PR07MB2255.namprd07.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB2255;23:KYv4mT83TN6j4Iokv0dq7328xbjAHlHZASBO6TebB?=
 =?us-ascii?Q?F3hL4CEBfy4hjBrR72c0qvW0zjyEXZTMD3iEJVtIUTrAsrUDr/oNgPHItd3g?=
 =?us-ascii?Q?wIJTIbIZxPwRa0KKxtokOmj9kWGT3rl7Eu24Ihjoxu96OlIP97LcH+fgnken?=
 =?us-ascii?Q?syiOhfg+MpT+Ag6mWTctMvb/Aen2sAZ5IUdya7wYY3G157fxC/vpDA2JnaSM?=
 =?us-ascii?Q?ijbSAxbtbLSD69WoaE0knF0ADMIdkYGPQyaMTRiOwf1nryLKwJN45DnRHEwS?=
 =?us-ascii?Q?uc0XHvp35aXF3K9cZ1FgDcXC95IuPQDjJ1FtUDXwSBdiVmuFbvEWWEgV87px?=
 =?us-ascii?Q?/zAZKzqUR1Jit9/jfiXY8CT4e5mAd1QHvFmHXctiWN0J0HDVLXxNk8yntTQE?=
 =?us-ascii?Q?xCK7yBr6c7ZRZQdMIW5WdKDyK6gt02Mg9WgcqekZY8uI5cwSMcjCnTpgzo4l?=
 =?us-ascii?Q?qGfQtXr6xlxi/MjUqYETJg8T81LgkOumTOcKvxFxlGrtWz6Lj3tUCEpg8FEm?=
 =?us-ascii?Q?Le5DgrD7PvJ2Ow8A6QMGqGeOUETrNX2rXBmJXv08Wow8w7JujdrxYfSSNPTK?=
 =?us-ascii?Q?GR/BSIVuhSbU29Mz5T1i+uh2qVfq48S+9rTiaA27XYO29JMv9e0j+5IO0lOi?=
 =?us-ascii?Q?wlLZRV8CPCyPJG2aTtUXXmxQG80fl+zJnUCmbPnJaH0chXLq7uiamI1Xnxvo?=
 =?us-ascii?Q?z2j4TbacOem+0tK8IHogz0hVvnw3FCxDrVXiU055lXkyj5P3j744sGeN+Uvz?=
 =?us-ascii?Q?hU7JTAJc5ldGPNz5N0EnJxPMq0DGa0E4PMFMot32NKD0k0PQJA0xNNjMz/Ar?=
 =?us-ascii?Q?j/si9IjPDSHKRoPwsHydJjD2HA5dwclAIcdxPrOHbNV3Xwet9qeOidKa4E2I?=
 =?us-ascii?Q?ggkT0hC717ZL8PvOtvUR7edGC94epbP5xN8mxIgMsQeJdjkLLuwZ3jRUNSs+?=
 =?us-ascii?Q?CpN5B4mWqSGqeKSqCpNifbrP5LP7Mk0D0Omse/U3EcHPBH473wxo8Cz+HN8B?=
 =?us-ascii?Q?JIgwOD75ngiM6dGO7/9e2d5gdjshj6id/jVvoSDS8eNXdd09kVJ8GuhElZMb?=
 =?us-ascii?Q?7B93L0F7hnflZNkHjhhIgm63I/zg1APCUIlI1cRRJZ5TAcofw=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: H2oLGKw63Wb4/YlMg7TVglhtgMvj8zDOZBGtUnCO1LO6ObYqhVW88VXKiv3E3VhcytB/FfA/WAlgfihbnpSFYHqHj+J8rGVxAIi6mNtdBpOcy1iR8tPLNCH39oGWXXGadG+j9jJhDzAZ/4L+2ZaETDOJAWnvfLuUj8KcwazNHGzbrIQGgVtKy5mQFrlXoQiMCKUo1mhNJ6j7Fvaiyn50ZE8f5AsAEUiX/z9QB54Ye338cYj1qgC1UzJmWOSyTp5bxozbEqCI8Boc9qoDEOIoH6rV4pDewX2Ik9190eOiFV9Js3dTKN0j8TdU5FlFTeAfw92OPXGS/3YFWzZaT7oBN1ohdZWpiT/JXdMHpA7/Bw64zMdsXCGUeVOHTsSrwKnW8TSfSESOy1OkiJI06AH+uooSaBbshbweT/+5ThJCmcQ=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2255;20:/iXlrB6Yynj/bbtBbMaSEc3A+mcrRdFIoYS29sx2rEQ9XCcwuzZ73KpRQzzzoFjwkpKN551jivJKkpufdlsfb314aMQxIRC8pyRzQj8ZGuQ0ZDgigSqdCu5Bn88d7uPIsw8m/hCwotGjffs4JZE2sxsM6MbCchsopT5fnXgNzl8MPbIpE7B9LpxB9hBP+oc3e1UxSNQ6FnhhP4G1lS3b0MaaQNcPW/8mcUwc/KkqUP/Gy1E8SXSxDfmi1wfW0Ke9
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 19:46:05.2466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3434c38-dd6e-4cc0-3c09-08d692b50efa
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2255
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=761 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aim at documenting USB related dt-bindings for the
Cadence USBSS-DRD controller.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 .../devicetree/bindings/usb/cdns-usb3.txt     | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt

diff --git a/Documentation/devicetree/bindings/usb/cdns-usb3.txt b/Documentation/devicetree/bindings/usb/cdns-usb3.txt
new file mode 100644
index 000000000000..1d2b449e3cb4
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/cdns-usb3.txt
@@ -0,0 +1,30 @@
+Binding for the Cadence USBSS-DRD controller
+
+Required properties:
+  - reg: Physical base address and size of the controller's register areas.
+	 Controller has 3 different regions:
+	 region 1 - HOST registers area
+	 region 2 - DEVICE registers area
+	 region 3 - OTG/DRD registers area
+  - reg-names - register memory area names:
+	"xhci" - for HOST registers space
+	"dev" - for DEVICE registers space
+	"otg" - for OTG/DRD registers space
+  - compatible: Should contain: "cdns,usb3-1.0.0" or "cdns,usb3-1.0.1"
+  - interrupts: Interrupts used by cdns3 controller.
+
+Optional properties:
+ - maximum-speed : valid arguments are "super-speed", "high-speed" and
+                   "full-speed"; refer to usb/generic.txt
+ - dr_mode: Should be one of "host", "peripheral" or "otg".
+ - phys: reference to the USB PHY
+
+Example:
+	usb@f3000000 {
+		compatible = "cdns,usb3-1.0.1";
+		interrupts = <USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0xf3000000 0x10000	/* memory area for HOST registers */
+			0xf3010000 0x10000	/* memory area for DEVICE registers */
+			0xf3020000 0x10000>;	/* memory area for OTG/DRD registers */
+		reg-names = "xhci", "dev", "otg";
+	};
-- 
2.17.1

