Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682887-2-844503075679277959
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682886; b=SdRHd5GUsgWye0dDMozj3OFrL7dXGo2f8pU6PCx8MFYvSEy
    G35EKY+rqEMgzEwSiHfkvmChjTTyRuP+lsSPv56cFiLobtyCRiQLqrCgk0tParEj
    XKv+lrMTdjZ9JzdJbwWB0oQKBj3PpRqYTT+XKEfd+/679ZrnR/OAW+uFnyec2daf
    UATy2JBbMglOKK+ycG/vslNH0lwsm0NwBUTW00HKu5XPLjXKt50sHdS7Y2sOyvIJ
    jxWCBlCYefwOIt8RL4klsaozMCYO+KxD/kNfwUF9GB88L8XiV7K2grToJ8VSmFzG
    SUY2P0GECtV0frC2e53tgWWJnO9FxoPYS/9k4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682886; bh=Qo9vJv
    dueowfxST7nnE/GGtfBoj6b5DtE9Kd8+/LLUE=; b=A6fLbgy34XlS51bg4JrDTI
    6wviHB3xExMdYYzzJ52wSVKjXzghNgjhJbrsmT/L8zMkxCjMIBVfFR+oQv9NO5QF
    ZPg6wtMSPs0Z5+r83fy4S0+FhX5wm4UvBRxBO1EW30ZOOln9j7Yig9rg25x8QsAz
    S+p+p85LSFCOA6pMPve+D/+52+hlc2bGtlflgWUuYEZEy0RE29imwyVolPlom23j
    Il4+FwDs03NjOG9oGrhC8FZMn6+drrCm44DsiGn7IGyzPaairH+/CJyN0gS5b4cd
    9yCKI1Pfw92nWamJ4+h8lG5uCOedatEn+qQLKnim4GmfIh2dsV4WXEmlmPNlvj3w
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MHZnQGFd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MHZnQGFd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754630AbeBCSen (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:34:43 -0500
Received: from mail-by2nam03on0111.outbound.protection.outlook.com ([104.47.42.111]:44500
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753050AbeBCSEP (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Andrii Chepurnyi <andrii_chepurnyi@epam.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 072/110] Input: xen-kbdfront - do not
 advertise multi-touch pressure support
Thread-Topic: [PATCH AUTOSEL for 4.14 072/110] Input: xen-kbdfront - do not
 advertise multi-touch pressure support
Thread-Index: AQHTnRj8rsSdAGvMs0OeRrAK5PeOcA==
Date: Sat, 3 Feb 2018 18:01:16 +0000
Message-ID: <20180203180015.29073-72-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1105;7:z30o5teS4z2wKwkUuOxRI2g+uvknWN2EfBciEARz8Mpi6+CFGc/0+OAf7e8sbeyOk9By8cz0vhy8MjMXpizc7uHGGgieuGMBOKPlXu3p6l49Bj1k/KBAjIhqdNDUXJRHRrDW8KT6V+8abe5+bknnNaq/bqG2lvc5fcyvL7y4Zf4+nNgf/qhrNQ3arKVRuJqFRBusUBhPdNNtXYl5UbEQqTGOcSn28twqcbTv2ZSBTgAtGXo0F1Jndbl6Jk7Kk/KQ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 379175fb-2d02-4213-3b60-08d56b303d79
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1105;
x-ms-traffictypediagnostic: BL0PR2101MB1105:
x-microsoft-antispam-prvs: <BL0PR2101MB1105A77278CC71F436C76BABFBF80@BL0PR2101MB1105.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(278428928389397)(89211679590171)(85827821059158)(4114951738403);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(6346003)(97736004)(6512007)(7736002)(26005)(305945005)(102836004)(105586002)(68736007)(5250100002)(8936002)(6486002)(6436002)(106356001)(6506007)(81166006)(81156014)(2501003)(2906002)(10090500001)(99286004)(66066001)(54906003)(6116002)(3846002)(36756003)(1076002)(8676002)(110136005)(575784001)(39060400002)(107886003)(72206003)(2950100002)(478600001)(10290500003)(22452003)(6666003)(5660300001)(2900100001)(4326008)(25786009)(14454004)(316002)(86362001)(53936002)(3280700002)(186003)(3660700001)(76176011)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: YAlvGYEwbF/C9Y4QCJRyh7K6qGIOAC0c1UPFRrGIbSmnv/MHgScrSrreEId8In1UVc/vu0dMcJQO23Hl3j8t8Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379175fb-2d02-4213-3b60-08d56b303d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:16.2690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

[ Upstream commit 02a0d9216d4daf6a58d88642bd2da2c78c327552 ]

Some user-space applications expect multi-touch pressure
on contact to be reported if it is advertised in device
properties. Otherwise, such applications may treat reports
not as actual touches, but hovering. Currently this is
only advertised, but not reported.
Fix this by not advertising that ABS_MT_PRESSURE is supported.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Signed-off-by: Andrii Chepurnyi <andrii_chepurnyi@epam.com>
Patchwork-Id: 10140017
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/misc/xen-kbdfront.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbd=
front.c
index 6bf56bb5f8d9..d91f3b1c5375 100644
--- a/drivers/input/misc/xen-kbdfront.c
+++ b/drivers/input/misc/xen-kbdfront.c
@@ -326,8 +326,6 @@ static int xenkbd_probe(struct xenbus_device *dev,
 				     0, width, 0, 0);
 		input_set_abs_params(mtouch, ABS_MT_POSITION_Y,
 				     0, height, 0, 0);
-		input_set_abs_params(mtouch, ABS_MT_PRESSURE,
-				     0, 255, 0, 0);
=20
 		ret =3D input_mt_init_slots(mtouch, num_cont, INPUT_MT_DIRECT);
 		if (ret) {
--=20
2.11.0
