Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85263ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327E42147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="J5N+pO+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327E42147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbeIQI0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:26:41 -0400
Received: from mail-eopbgr710118.outbound.protection.outlook.com ([40.107.71.118]:45407
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728995AbeIQI0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=406Ib3+U9TrPFXpk8MZNarZGL08R6lUi3Zo6EU7d83A=;
 b=J5N+pO+QRleJd+QNKMxFhLH9mTtSw1yrSLYvZx6TqbOWTyziLmvWXu4+XooH98hZ/iSi/xFC/c82kKzAK5GBHaZ5y+xU7GCjz2F4rktcyxdSx6F3/Uq/Tk4ZRjoijYC42BOAwyo8qoahvC4mBaTNxAcx0Hr6h9H3VHBI8UVv4jg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:01:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 052/136] usb: wusbcore: security: cast sizeof to
 int for comparison
Thread-Topic: [PATCH AUTOSEL 4.18 052/136] usb: wusbcore: security: cast
 sizeof to int for comparison
Thread-Index: AQHUTjKgQgcrbSLn1USmc1uBoY4bGw==
Date:   Mon, 17 Sep 2018 03:00:44 +0000
Message-ID: <20180917030006.245495-52-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:Irr0w/yGZpB6aMikVAna8fyNMCvhqPyxVPJRy4PNT0Fk19fGzsUssuTiQflhsuIpTxB8oPVgyixdT+4LlixRTw6ifw3F4UGSvWmODgYy2ix/lncjUoCDkLxDWQbQF+Hj4uIYqX2qiVgLFj/a1GnFgm/KWGDpUn+nyvtNB42w6DhM4vRDqm3aBdAhw8BjoxDctdDaRlL2wkMVQQwRbRYOC/DVeMPSzUqHsjL8zZBq5054O3B1WLW2BfRzdqTepcblY6nlk/sdV9phd4cejK23cXiWmdTqU/7CdCDSnh688gaQWkBNXsqk/59K0OtWWew4yUk/NHKIONz70nNHrVGMmwaRn9K+y1qCNx69hmVShlJxQOlPVN+bRZyBQtXeTYWdJ2wYsHu7tWXj7GLYHosKmzRppSvgIhtbGekk3kovK3m5cqo+Wjj9SO1muOF8d7zRKDC13go9KLhW+3Ngil5IbQ==;5:s51CUVDcvtDJexzL2Jh2KFww+lfKOyGO4A6W6nv4lyD2Jii4lZDTvsonNIM8e73KI3sbWmIuK88ZwxLKcy1oFSpylWYsCh2tsnecu9dyk5Y5m2pNxOh2JDmbWP7Y0bPRAVsostHpz5JAav3fCMx2feSoO0KRRuJup+5jGJOtlUE=;7:kj7GcTnNOMC7WN6CC+XQciQ+ZvGXVQXurGaaj+8wycXZ8TueepVhnTZu90rX+kMowirek2SNp1mUYE8uqYBhBsJh3iFJiSz/xWNjeR71K85TZVoxyH4sUZcNOwURlZMnwQEm86AjzryaeiHK6CTd3K5/+IPqLmS6ECR6JqZ2yJgTSTWrUx+qenIuCRZyNDPGFDgmlFTWTW9bEGI+5aMqWV0b/8ZgykWvMoCOodnleBpkmhnVj8m/QI07wkh4UYkE
x-ms-office365-filtering-correlation-id: f7b80697-50c3-4e90-3a88-08d61c49d43e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB01675F61F6219B41C8C92293FB1E0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705)(163750095850)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(6116002)(1076002)(15650500001)(86612001)(4326008)(97736004)(53936002)(2900100001)(7736002)(107886003)(106356001)(10290500003)(81166006)(105586002)(68736007)(3846002)(99286004)(305945005)(36756003)(8936002)(2906002)(217873002)(54906003)(86362001)(110136005)(25786009)(316002)(2420400007)(5660300001)(6306002)(102836004)(66066001)(76176011)(478600001)(446003)(11346002)(2616005)(8676002)(486006)(476003)(7110500001)(6346003)(186003)(26005)(6666003)(6506007)(6512007)(5250100002)(6436002)(10090500001)(6486002)(72206003)(10710500007)(14454004)(256004)(2501003)(22452003)(81156014)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: S1O4MQkg+How7uTWyjrfdVTzpfJ1Cr4V8Vm2veFgAg4GRUTSCIOhDwyLhJrtwKoPVl9RAehLu4zzo7PeB11194NIQ4uEy5z/05jp1kPlxBT9ZyyWtEcbp9TRn904CRhq97UloRBTR1NyseWvzjX2Xd9/1873CPYN5LThV9RT0Hb8T4TmvU6Z7AUAE5zZHwfinNy/206eyxH1KLenLSepBQLshQ/cwjWIHClLNFnCqxg9QP4PmS2kQ+cvEPDn8fZ9TSooc73+jkitjxvR7agVfungbp48589JI1Ow4Ez8NojGOMm38AtiShYpOY2APSIBcbeK21lztjtgGUc0kmnUCqKtzE+A98eHNIv3w65BTxg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b80697-50c3-4e90-3a88-08d61c49d43e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:44.9326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
index 33d2f5d7f33b..14ac8c98ac9e 100644
--- a/drivers/usb/wusbcore/security.c
+++ b/drivers/usb/wusbcore/security.c
@@ -217,7 +217,7 @@ int wusb_dev_sec_add(struct wusbhc *wusbhc,
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
