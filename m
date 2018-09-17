Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55531ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046B32147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AX/8kqGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046B32147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbeIQI3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:37 -0400
Received: from mail-eopbgr710093.outbound.protection.outlook.com ([40.107.71.93]:31768
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729096AbeIQI3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ5+BkiQe4+jAewL57gYdhuW2vywHHJy3es5sWBRsiw=;
 b=AX/8kqGTZDATSdGy/HCwPAFjsiP53TjgQ6RPBTt/L6MMkuaERDlPtqeryGATS76d6trxYeReiJ4Xv8eMqVmhrCVVtYo39VMqAEybRqVeyrfofSuPAxelHCfAwqAt5XQgcIqllJj035Y1iFTJX7cmUApW/BS3a/Z56SzEAjrhmA8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 38/87] usb: wusbcore: security: cast sizeof to
 int for comparison
Thread-Topic: [PATCH AUTOSEL 4.14 38/87] usb: wusbcore: security: cast sizeof
 to int for comparison
Thread-Index: AQHUTjLp4UT7W+JqAEOFrmDDpLCkog==
Date:   Mon, 17 Sep 2018 03:02:47 +0000
Message-ID: <20180917030220.245686-38-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:mS9QcPg0Pjcb/tq16TU4mgoSxeqthlYhhODN3tjYeBYltwOqNFv/XQwR1vwURyK7XNKKNRZBlxipTl74qCgUBTLMZUUaYtw/tDHnbOiWuujZBZz8gOfsWdhjTyYagc4QcmaO6QijeqGw9c27hlnPSeqaiqDDS1o5ISeCDKTxvTGWNUR322ODw55b5D9AtaM1Bk665lTodYQ2UX1XrWs/3moKEeUPlH3MeTDQQntfDsSkwULZ4MdG66QW5ifWL3ryPbxT0IxTLF39kO92Zzf/we8biDBLmQqfeGK22kfyJFbtZZrF9LDuHB0buIyQYgQ1X3wR3Hd40WEUI3ucKka+2tKxLa+MJljCCFXKUdTU8FF3UadSAy+Vod177ManhtW0BHkcOBy2zdNlHPVBxFB5fJBzcBHBMtYIzqaU+Kz37Z+Xca7RbD6FXMvzUUi4MuU5lt3RsMPmRi+Rte9JYEC1eA==;5:jRF56XtaoWRk2V4F+fRUMhxwRlv4N8KpWFBDfrON4rB23M65WBewt4CZDpAV0g1wVLKRDe0vJeCL3swzvvhiyaeT1Cy4zoMtflPzPcyL1Aqlpq/p8Y9SOeQyvyEm/k7ds2cFCF0RIY0bHqSeFmulKcOC0eNhcBp6NxrQe1NMnzs=;7:G/anVTw8LFROSsnZ3NhWyPTartVvMkElEhdnZc2f3HxgMwMp+7d/J6NwUKFxrZMWe/P77VbmZfoQYZf91ywy+e0iHs4Uli4pSeb6FeDOLF8N0VVlrvLRNRHjednUBEoYqVtC57YShQ51bhhtjQqhN/mexBBRMg+4kM/9rAWRvnsz5f8RAupqic7g33tTrYKnVNrlePYTmnTj+oTqYxqbbixrHvlUtoF5uvVizyPboNFUDSZGEnyDfU2hTNDTvJYl
x-ms-office365-filtering-correlation-id: cb9403b8-e53e-4018-2c03-08d61c4a3fbc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB07767288C65223063621589FFB1E0@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705)(163750095850)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(5250100002)(53936002)(72206003)(14454004)(102836004)(478600001)(4326008)(6346003)(2501003)(25786009)(6666003)(10710500007)(10290500003)(110136005)(54906003)(6436002)(66066001)(8936002)(316002)(107886003)(76176011)(2906002)(7110500001)(217873002)(6116002)(3846002)(22452003)(14444005)(6506007)(486006)(5660300001)(7736002)(2616005)(11346002)(446003)(97736004)(476003)(6486002)(105586002)(6306002)(81166006)(99286004)(186003)(81156014)(2900100001)(8676002)(86612001)(68736007)(86362001)(26005)(2420400007)(36756003)(305945005)(15650500001)(256004)(106356001)(6512007)(1076002)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Jd4b4aFIO0w/ZP+NuR0/85kB6u9o56hR1eopqAS2j0KCinXl1+ezEwKYULVAJbj5kvSbyG0yF3wxyELH04SOon5I127EPqXtK2RnGyLKtLxJKQZQGs3hC/9fT9K14ijeiddcJa2U4OaRxXOBQapQobn70YVI5f+miTx3vDMiwtKHtEAKOUN/9bjYX38PHgpbGzv1wkZHgyuYwCxXOXsEq28UFWkCLZybRRiYWaRUGAzl/1AvrjSzXbxvNMIwWzEHNKyjo6xeBhjij3DstrIU5Jw0IH9bPQbVWYFAfYjXNfN+lpDBJwSnkgCdEpWx/WZjFqyvOQv7ttJs1QAlTD9x4avnDAq5BrgrcCnSlHb7EtE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9403b8-e53e-4018-2c03-08d61c4a3fbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:47.9155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

[ Upstream commit d3ac5598c5010a8999978ebbcca3b1c6188ca36b ]

Comparing an int to a size, which is unsigned, causes the int to become
unsigned, giving the wrong result.  usb_get_descriptor can return a
negative error code.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
int x;
expression e,e1;
identifier f;
@@

*x =3D f(...);
... when !=3D x =3D e1
    when !=3D if (x < 0 || ...) { ... return ...; }
*x < sizeof(e)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/wusbcore/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/wusbcore/security.c b/drivers/usb/wusbcore/securit=
y.c
index 170f2c38de9b..5274aa7339b8 100644
--- a/drivers/usb/wusbcore/security.c
+++ b/drivers/usb/wusbcore/security.c
@@ -230,7 +230,7 @@ int wusb_dev_sec_add(struct wusbhc *wusbhc,
=20
 	result =3D usb_get_descriptor(usb_dev, USB_DT_SECURITY,
 				    0, secd, sizeof(*secd));
-	if (result < sizeof(*secd)) {
+	if (result < (int)sizeof(*secd)) {
 		dev_err(dev, "Can't read security descriptor or "
 			"not enough data: %d\n", result);
 		goto out;
--=20
2.17.1
