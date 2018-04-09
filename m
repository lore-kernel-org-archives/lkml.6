Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237356-2-10588892444052890829
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237355; b=P9EMsiaqy4xHZ94wE4xrfYq5a91Z2zVHJ/qoLEiX+0BhPFijjc
    kcQQNuN3w89UGI2G9upE3rLDlCM1h/jqdZsLMeG5ilA83flFf/GFbWD16XOfMtfZ
    k/wUskNBcWzd4J0uXFdcK+d+fIHqlaSx+rcvFHSpISrWUK9dm5L8RdG14yuALMUn
    /FnQDLeFcAWqKIfBbd4eTuI2Gc9D9UcwTn1AZ7Rt4vFI0QhAF0L2IZSNKpM38Bl6
    QfNcjLUAVe05fgCIorkVB/AsMHxmuOhNphpgNUjOjWm8immkfzqzQKmDcaMJZSYY
    /9rkv5yUcL92g7ZhNAMs9BVCDV4IqQmAHrKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237355; bh=IaelpxEt6J
    WFP/M00mTAlbvgGUjlxQeh/Dt5eqIffUo=; b=E+TUwCMh/leMBi6BkF8O7yyWgP
    51AuCri36KXFT7BKv3HM3gwo+2VSFHD+QBtmrBYm26Ygs32eJAmEI1apTczwSmxr
    /HjvvP6FYNjXVsP1Qp5AIeWcTAmJKR1hvDa+MfoNWqjvMoWnSCHc1SKhaUuG8Mz5
    OruW8/EtP5SK2IJcA816H22oYJGu98t2QqZdPUPs1ZgNe3EX3T+jGO+x+2kGs5hi
    bw/vVq8vPL01WrsHGMkJNMIHH8zKCWnaRVEuLFTUMMy9DcxCDdkA308uRUg69oFx
    8HFHWIf4ZbCtOm8mIVt9kGOG8xVtFgUbeaHPap1a0+gU0RSfK4OuG55XqzbQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OmUgZeIW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OmUgZeIW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCyf7sAKI0Tt2J+GisRtX3dMujCW7FFpWUijUIAp6brxDoE2HQAjiCuzvJrUP10DoeepAJ3VaitFa6WzBUC5WQSDlBBQLvI63hOZrg8AF+gYYZJs/uE6
    yj+oJfuG1w0qFYK3bI2aieeTwOovSUBQuXh0G6Rz/SGhbCF87GVxiOZp8VCiTv9+9wd9rwj0fVUHduINSfknmwpwrKnAp+J+YT7WxHQM3rvP0zXmC9VmM6V4
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=QyXUC8HyAAAA:8
    a=yMhMjlubAAAA:8 a=B7bxuzicBWLByr4HpmMA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756582AbeDIAgB (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:36:01 -0400
Received: from mail-sn1nam02on0133.outbound.protection.outlook.com ([104.47.36.133]:9440
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756623AbeDIAf7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Johan Hovold <johan@kernel.org>,
        Vincent Cuissard <cuissard@marvell.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 045/162] NFC: nfcmrvl_uart: fix device-node
 leak during probe
Thread-Topic: [PATCH AUTOSEL for 4.4 045/162] NFC: nfcmrvl_uart: fix
 device-node leak during probe
Thread-Index: AQHTz5mm+ZQzXtBETUyFIlqpHzN8zw==
Date: Mon, 9 Apr 2018 00:28:15 +0000
Message-ID: <20180409002738.163941-45-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:EQtJeiu/8bSIMh46N3QHQk7y+MIrRHh0kBdJQyax+Xb9kSOFHogjUcxowxc7MOxclTDH2ch8gDuqirrBggEgNnoSoMhawXR+UVR6kfu/i/NlddqcIzt9nP6eIY35ZfnZFhn+qLyVb4N6uKyshBlbardq8bgbqmeQwullePLWlJBWr9BHFhHeIG7NHybedoFap2iielFQv01qd6Qqr8o31VekLX7lqMcX/dctq6kRncfGByu9qsUybrcEfZ5rxUN7;20:m5kdMQ1Pgr0ZHmKb8cCYNgwspevB66QQnZil/a34bUsAL0/FuPlDHzOBeWXeq+sRKdafc0AYZQHdCt+46ADQ278p+FXoJOOJZ1QwX+9d9iO4YVnVHcO3H+wIFGxmrgrkn77KFiN5Aq5bZ8S5fKPPUVpbn1O+M1hSoxwnmAfZnKE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 870da82a-c833-4ca9-5760-08d59db1dbb9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725AAA1E3E9CD987AA98B36FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(86612001)(575784001)(102836004)(5660300001)(14454004)(476003)(68736007)(11346002)(66066001)(446003)(99286004)(76176011)(486006)(10090500001)(3660700001)(110136005)(305945005)(106356001)(316002)(105586002)(3280700002)(3846002)(10290500003)(6116002)(22452003)(6506007)(2616005)(1076002)(7736002)(54906003)(478600001)(2900100001)(2501003)(5250100002)(8936002)(25786009)(81156014)(8676002)(6666003)(6436002)(4326008)(26005)(6512007)(6486002)(81166006)(107886003)(53936002)(2906002)(86362001)(186003)(97736004)(36756003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: PVK6tzrRuFb2lVXGlj4OPSp2fXz8ddsTZoyQHhWu84wDL9niz+xyYIErt/HNpRNdIXghnKbF/qwADWkX+BwvVfERm0CgaigutENym7EuVVUrdb+93OgD83qsZoJ1SJfuKR/sw6YJNw87/yeUcEnijkDy2cmlO0yok4/Avib5zUg2OZ5K2mxWSjH7xAjuTbR4KWkH81eIweqzLmX4zi09EJDFp5mPyoeGs+JyHhSmptiOXSQY0Rp21Lsmx8E5BBd/PUf+5AHNGWqj5hSQdshW0uFo6Om9TTRCyu/G3Pvin32fohL9XO42s1dEE2otce75vQQIOlT92HzbxF8dF5HyOrZ7egtpRZzu/vvQ/G/YXZtYOooy5ud3Q+HvkH64IIxwNyyT37PnNjEmddJY+hdX8/NtzP8/8FCH1Jr/rNgWkzI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870da82a-c833-4ca9-5760-08d59db1dbb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:15.3018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johan Hovold <johan@kernel.org>

[ Upstream commit d0607aa4aee88cb097b694caa619e68f1e0a39c6 ]

Make sure to release the device-node reference when done parsing the
node.

Fixes: e097dc624f78 ("NFC: nfcmrvl: add UART driver")
Cc: Vincent Cuissard <cuissard@marvell.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nfc/nfcmrvl/uart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nfc/nfcmrvl/uart.c b/drivers/nfc/nfcmrvl/uart.c
index 6c0c301611c4..91162f8e0366 100644
--- a/drivers/nfc/nfcmrvl/uart.c
+++ b/drivers/nfc/nfcmrvl/uart.c
@@ -84,6 +84,7 @@ static int nfcmrvl_uart_parse_dt(struct device_node *node=
,
 	ret =3D nfcmrvl_parse_dt(matched_node, pdata);
 	if (ret < 0) {
 		pr_err("Failed to get generic entries\n");
+		of_node_put(matched_node);
 		return ret;
 	}
=20
@@ -97,6 +98,8 @@ static int nfcmrvl_uart_parse_dt(struct device_node *node=
,
 	else
 		pdata->break_control =3D 0;
=20
+	of_node_put(matched_node);
+
 	return 0;
 }
=20
--=20
2.15.1
