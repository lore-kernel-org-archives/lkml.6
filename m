Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491823-2-5231906905750206726
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520491822; b=dJa6VnyCHWJnFf0As/VxdwVJUBgzLSUU2H+UzMcLz9KnsG2
    sg+W0Om0H8XKzh4kQOJRtTsOmlilLR2QXYYS/StueLR/YiwAA7dy14HTQ3gsRsYg
    /D13dxKUBaIAfHIwVKr9QgjDCZ4ZxJ7t35SCBfKRMOe1StstGcVCZHZXZ+B5J+62
    kz2Wq4oBalQrCFrRg2GpnWRmkzEpmAXO42rV7b7vn76ASZCc3kp7PRqEU9OGtuCp
    q274jea1MpGxPO1rTy0eYX8IX5gVdIxljf1IYYZEB1WTIeX1yYhmK/hk1EsSXW1H
    Y0Cc1xe65l6yC+Kz0x6UbjrCRw1CJMGFUOMYN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491822; bh=DHzTkm
    Wov34e75OzwivOXqgUUPVMau5NjkKS3lIL7QI=; b=SFt4pNL43Jw80ERRSCFfcm
    +xTjgFPWzDHJW3iNqqMLPHBref2qmaS6LOhecU72NpexhMHD01ChjyyXGiKKw4AH
    J6T2cIe++NvAZ2IGIDPA9NPLdHUNwZypGKCVKATfUkGmCVWuv2eDscKlrcnqPsOy
    pUwUcdBYZA02EF+K3dxMqqXhvFpB3/VwaT21fqTKMsktGEFYIjqa1fJA8SI5Jqzj
    oJr8f7p5uZ+Fq7+evwOHcUdfqPOoN2nqyWeZAJVAxBeegGLidv/dGefXVrcASlJT
    zy+ddcbk3cm42Sz+Ku+iliXV5VThAnPAsgElLWTMW7Ccn4SFffM4IymV+Az7gIhA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ijpM6n71 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ijpM6n71 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965058AbeCHGuT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:50:19 -0500
Received: from mail-by2nam03on0101.outbound.protection.outlook.com ([104.47.42.101]:17968
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965057AbeCHE6O (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Ron Economos <w6rz@comcast.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 18/67] media: [RESEND] media: dvb-frontends:
 Add delay to Si2168 restart
Thread-Topic: [PATCH AUTOSEL for 4.14 18/67] media: [RESEND] media:
 dvb-frontends: Add delay to Si2168 restart
Thread-Index: AQHTtpn7b7I8zGGJXU2Obh9xwEToTA==
Date: Thu, 8 Mar 2018 04:57:39 +0000
Message-ID: <20180308045641.7814-18-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0808;20:R06XrvPg6nGMTAU2+2nFP7nvBbKqaJ+kSCUb2J+MSvttXDAya/H1XThV4zzBJF4cJ7H/YPqWFLEmNuXmFzogyKQpcHPNAYtV8e6ENzcBQPtYNFO2QKFHeP77UEP4d4js0nKd9t53xo3wAoijfmp+gc3AIzmrbqRogL/btH84hFg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61f00f57-9dad-45dc-5b9e-08d584b13214
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0808;
x-ms-traffictypediagnostic: DM5PR2101MB0808:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0808ED521D3E71E99E8B93EBFBDF0@DM5PR2101MB0808.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(68173958961439)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0808;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0808;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(22452003)(99286004)(76176011)(2906002)(105586002)(3846002)(86612001)(478600001)(72206003)(14454004)(8666007)(2900100001)(8676002)(102836004)(68736007)(5660300001)(316002)(6116002)(54906003)(26005)(6506007)(575784001)(1076002)(86362001)(36756003)(186003)(10090500001)(110136005)(106356001)(6306002)(4326008)(6512007)(6486002)(7736002)(5250100002)(3280700002)(3660700001)(2501003)(6666003)(81166006)(2950100002)(305945005)(53936002)(107886003)(8936002)(6436002)(81156014)(66066001)(25786009)(10290500003)(97736004)(966005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0808;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: ErxagfGm30puv/F2OLiEK9hwryy+jxF6GpFv7rbbutaVMPpgK6hgysGk8fuQK6nuAcqju5yKPyI4D303QGm3WTlMYw3f2x3ADn6nRKp6vWlIh6Mpk76fLmpPIZMy4M+luXfHlrqzbHEWXlSD7d3tJg18Aw5aj60KLSdYmMGIkUITLIPkmeEnKph1QdPyzz7Js4RBl0K89NqYDcEpUCjZYX3MTxsk2YNx8gTJDxkHGUGl8TDdve4v0S/Gil/0vVXnabzJrP2sslkiRLC//JgiuIjxc3YmyQ5zcRIbu4p7YdZsUmpUs8ZEGV0oiTtOerCLJ0WF1ub9CZfpVAnBbg5t5A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f00f57-9dad-45dc-5b9e-08d584b13214
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:39.3983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0808
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ron Economos <w6rz@comcast.net>

[ Upstream commit 380a6c86457573aa42d27ae11e025eb25941a0b7 ]

On faster CPUs a delay is required after the resume command and the restart=
 command. Without the delay, the restart command often returns -EREMOTEIO a=
nd the Si2168 does not restart.

Note that this patch fixes the same issue as https://patchwork.linuxtv.org/=
patch/44304/, but I believe my udelay() fix addresses the actual problem.

Signed-off-by: Ron Economos <w6rz@comcast.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/dvb-frontends/si2168.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/dvb-frontends/si2168.c b/drivers/media/dvb-front=
ends/si2168.c
index 172fc367ccaa..24840a2e5a75 100644
--- a/drivers/media/dvb-frontends/si2168.c
+++ b/drivers/media/dvb-frontends/si2168.c
@@ -14,6 +14,8 @@
  *    GNU General Public License for more details.
  */
=20
+#include <linux/delay.h>
+
 #include "si2168_priv.h"
=20
 static const struct dvb_frontend_ops si2168_ops;
@@ -435,6 +437,7 @@ static int si2168_init(struct dvb_frontend *fe)
 		if (ret)
 			goto err;
=20
+		udelay(100);
 		memcpy(cmd.args, "\x85", 1);
 		cmd.wlen =3D 1;
 		cmd.rlen =3D 1;
--=20
2.14.1
