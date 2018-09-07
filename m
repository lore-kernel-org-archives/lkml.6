Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1D2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69482083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KeEqCwdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69482083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbeIGFPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:46 -0400
Received: from mail-bl2nam02on0116.outbound.protection.outlook.com ([104.47.38.116]:36192
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729396AbeIGFPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7I246I2qYWZAM9gWi6rKik+RVdUlch/EOfyhdroYgpU=;
 b=KeEqCwdbUcpusALfq8xEVxX4zXyg71RU5lveLb3fxOHdrzRySdN9nvUgRWC8Z4QpUclwQTcFmnsmxst5a0SZIZ7MVU0gAE4Uh3i7yB14I3obp6uXcSvqyr3dQED2+QHvAmecscbhg08TfEAjkHK+EIRmVuGl9IiJEQcyzSzKuS0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:37:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 78/88] i2c: aspeed: Fix initial values of master
 and slave state
Thread-Topic: [PATCH AUTOSEL 4.18 78/88] i2c: aspeed: Fix initial values of
 master and slave state
Thread-Index: AQHURkLbhDHnD3Vq30WEB9fWSi32OA==
Date:   Fri, 7 Sep 2018 00:36:47 +0000
Message-ID: <20180907003547.57567-78-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:5Olw2POt7f+bBWvfPcLC3ED0bLufTfW0lgsVrCdeX+Duk8gfcVlHJZu7RGJta1HsYt3JEFJHNYrLP1mqlzETyJ0TEMFc2og+guKCt1u6YYEIOrKaWIHJ4SvEIWEv7S0iz7+JExW0V+uFSkTxfklaCWk+GAynznN5LEPI7s30wIuSJE49Lo6h1d4iDxS1hAv7jKI541aWBIez+REMN6gNrSnMFZrnWts8TdZiCCFDfUzmNrn4tR4WjdWH7Sc6r1xqir1DRwpcE2wMCB0HkOpf0zgp8bCsOyy+9RS0U9Kd7VR2TOnVSUAdTT2jSQdORcRGRWTD2+C49grpzItyof4l2ppVsVAr9AM4cWfS1H8pOBRLOTLR9ttxKKnsRazwJhkqycgKY10xnlCzao7AGInp4SccVZ5uACoev8D2+BVz364A+Lnvme8KLzl7kR7tHA+6RzCFkVWmX8EM7E4mggoWug==;5:rjxR7yUqBuz7a90bZlns7zwrSRFFzfv/Im6B2ACodpLG6DcfQYgT0DGMIGwqxw3/DJcIAuyApsJ3mt9c6NQCvjXgL9OGmxLfniLTr38zr8G0PmpJ0fClpDLsDW7rUBdRNeg9Tt5GML24OEAR5oVaB6sEnUjfh+SuPClO9adY8Z0=;7:QihCtxs3ujRUwWwcgolPPFjdh58ypWVjHBEKU0bXu03l9Ga+kLTNDWhbKefoTaAlGXTwJpswWQKA2Xb0EEebYOL5cVleeJvgAi3Lh9Cu4je9VPQOlyhKpa46hQEr9DWV6mYDESYEF5MWZPCx7+7fB1+eoL04NghgYSKOGjEPgXMNJN3a9ByPMRh7YRRjyPciV0cmlYgjugRxRctBcQHVER6+lgEMwFQTcEo6/+AqahyeUG/PWsWDFIw7hMtJv58R
x-ms-office365-filtering-correlation-id: 82757c20-38f3-4105-3f7d-08d6145a1c36
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB083903B43CFD3904DD11DEBEFB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(14444005)(26005)(6436002)(107886003)(2906002)(86362001)(575784001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: dFAV0sfS47QQ/wrcEBJXYIGgp15aso8eNBz1GWIr6TepyIfTOUtesTUnEhQQUXCbgaGPX7AGup4qcSBel8VUIpeywcH2BduyvqVkgugvTaQcQz0KQmSrw63oQV7DF9oU5l51pAUGP0JOxO9XhvAcOKF3N2mebOIASGGIbog7/RTsUcozrrF5RGvy2gWRE7bOYNGINZbpJjkRYEoqGDLEUnzUyVBL3FRC76bLA2U0u2wWDnX5F/EWwwv9PoCXmhOHDNutyHXT3UgFV0pzjzz/NBYvUOaireJ4TtB4yp8unv4roAwlgAieuxhZb8jhxkFogBsXTKQfLJo5GIBT7ih96EOuCaLq2+wTZJtRsRet704=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82757c20-38f3-4105-3f7d-08d6145a1c36
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:47.0351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

[ Upstream commit 517fde0eb5a8f46c54ba6e2c36e32563b23cb14f ]

This patch changes the order of enum aspeed_i2c_master_state and
enum aspeed_i2c_slave_state defines to make their initial value to
ASPEED_I2C_MASTER_INACTIVE and ASPEED_I2C_SLAVE_STOP respectively.
In case of multi-master use, if a slave data comes ahead of the
first master xfer, master_state starts from an invalid state so
this change fixes the issue.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspee=
d.c
index 60e4d0e939a3..2714c7fbe7c9 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -111,22 +111,22 @@
 #define ASPEED_I2CD_DEV_ADDR_MASK			GENMASK(6, 0)
=20
 enum aspeed_i2c_master_state {
+	ASPEED_I2C_MASTER_INACTIVE,
 	ASPEED_I2C_MASTER_START,
 	ASPEED_I2C_MASTER_TX_FIRST,
 	ASPEED_I2C_MASTER_TX,
 	ASPEED_I2C_MASTER_RX_FIRST,
 	ASPEED_I2C_MASTER_RX,
 	ASPEED_I2C_MASTER_STOP,
-	ASPEED_I2C_MASTER_INACTIVE,
 };
=20
 enum aspeed_i2c_slave_state {
+	ASPEED_I2C_SLAVE_STOP,
 	ASPEED_I2C_SLAVE_START,
 	ASPEED_I2C_SLAVE_READ_REQUESTED,
 	ASPEED_I2C_SLAVE_READ_PROCESSED,
 	ASPEED_I2C_SLAVE_WRITE_REQUESTED,
 	ASPEED_I2C_SLAVE_WRITE_RECEIVED,
-	ASPEED_I2C_SLAVE_STOP,
 };
=20
 struct aspeed_i2c_bus {
--=20
2.17.1
