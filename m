Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520119338-3-12761652359557433712
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520119338; b=UfCowco3AGEiKzDJoru9aElR4375kFoygF7LKmoK+CdbvAm
    vECLvfDJAt9SyHoPXyzOeQZLicHXLc25YmCwOZbDUMEOfKV7AS/JP3Iavg65WKYe
    M7nb3f14vW/DaGpvNXjQorCFgjBL6NGemUQ/pc6ZTPVl+VdpLfnKuDy23tTIr+DT
    rk/qs+J0kI/LxCVKHRSxvL0okYPK7L2FyuEAlXbDQ2kZmuHKcqqqgasGPPJAEx0b
    Lv7zLn4/+ZeDkPg4j4s7MHG5taJN0UaPOAIQ81B00FxBFWHlN/uEGou8keiw5+w8
    kDrvpIZEneKBZv70iKUwsOFS2gG3WW9i8+gjjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1520119338; bh=NAhB/NqYbOpzevgXmiQEIHKY/3
    SyCjcFaCRj7dTMztE=; b=SkBFPKJ8jLUJQnKG2eNqAJ+fqBKN9IxODZZ2VxuK0q
    m5t3RqCA/Ujqk2LjjaQjY716JOn5XJUjNvuH9nFpJ/exETRfhPp/bdqMuDVYs1KT
    Atfm2SBCdwZXvwbkmZQKFIa8d1h6imL/JOacjrVlpRgEKwaJYKOuJvwJzEvzDTVC
    taEWaXqa5hny2Wh+12YIircs1yvXlVfWDIJtYboI6acCHWuXOGNHlYh/Y5os6E+6
    //Fy72eHP6zAd6QgBw9J33+NX3mMuAXzuj8lViBPsJDxl2gaF85ZMpEidcb+3JCO
    QAv929LKrVqMIN/wpwb5r5HZRDv5fdDlcoXmddwV9zdA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Cn4CoId6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Cn4CoId6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeCCXWC (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:22:02 -0500
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:45128
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934684AbeCCWhz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 001/115] Input: tsc2007 - check for presence
 and power down tsc2007 during probe
Thread-Topic: [PATCH AUTOSEL for 4.4 001/115] Input: tsc2007 - check for
 presence and power down tsc2007 during probe
Thread-Index: AQHTsz9GMP6bSjhR/0q/yavqjp9ymw==
Date: Sat, 3 Mar 2018 22:30:47 +0000
Message-ID: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1100;6:P78veYsAmIomg/ycLwjrGCOIOpPEtHoktUcDMaMfdb4SLNsepFkhKyICbjsg9Giy10hBpNFzfAkVMf16zycY6pBmaKQd0a64G7UzezdF5fICaj7Q64lCf3SAWhXpg2bfqaOu5EOLdttfb4lfC9cu4bEZ2352bVN3K6mvJmv6BGQkruzw+OiWvD1yNVrFQNb9vXuOI6Z2Y0y//HVzgUOMUeU+wQPajKjMudnKHzCbNpqmbvmaO3+86naoAbEAZrhxsb+7hCMNMZ8NZ1HGgoABmoHXLa+vI5oYBaQTx7fLDIu23V5NdEWQ6S+qdQkE+hRxGHLkP6PboBZS4VRUMmjkLnJDMxyK/JtxAjtiGxLigevFR95YKmmSGeUH+MKDNtz8;5:I/hvRcGFa+RvcfbKbYyHCDr2n3a0ac0NprL8N/NYqgtF/mD5TJCTvx58GZ8qn758saA63M67/AFxZFp/W20eWi73FJxGY90IgvqIjEGDDlnDWtbwEIaIbAW/dY05J1vtleeLY2FygCXYv9giBfdK2SgkLDAAff37iEHxxuM8JH8=;24:u3rs0GDcugRtSLTC/uC6IzErRwR2YfUHwtQ8WLIEblwaGIDPyMfxe9PLGx7iucWi/PnAhWZpZCvlEJBVYlc1aoZmI887otSpGqtLuFkyN8Y=;7:ZtJt0sFMoLnMwNfFnHiUgilvSthBOi8oYRH/fZbAsZKBl18I6BjZqjGTFUoF5mwHwQWk6X4QP+stvWO3oWg55XNrgouIS1nnSMVnWtmpzG+WTAaSYLRT5lNZZdRPND3CCScIE1DeHbM1xJCqfC6Ucnc5lETTqVBmJpdNPLaGezUPhuksoOSRA8TUR8Z8v4SnYJfvRJwo9Yhr0+1c7z+iYX7SYcRlJx2+Cd7BUqe+qf8p510SJrGN0xxMqvNJuBGL
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: edf57e90-9f26-4200-f7ef-08d581576624
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1100;
x-ms-traffictypediagnostic: MW2PR2101MB1100:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1100ADDFDD74969B15AFD0B6FBC40@MW2PR2101MB1100.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1100;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1100;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(396003)(366004)(346002)(199004)(189003)(22452003)(97736004)(7736002)(5250100002)(105586002)(2906002)(6506007)(72206003)(66066001)(4326008)(305945005)(10290500003)(186003)(3280700002)(39060400002)(102836004)(6666003)(2501003)(478600001)(26005)(2900100001)(10090500001)(53936002)(8676002)(25786009)(81166006)(81156014)(575784001)(54906003)(86362001)(6436002)(106356001)(110136005)(68736007)(36756003)(316002)(6512007)(5660300001)(107886003)(8936002)(1076002)(6486002)(3660700001)(99286004)(3846002)(86612001)(14454004)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1100;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: qX0FLBJnzjL86jUzw1RN+5qeDuAobtlkAuHNzPYKryPIHL8eBBvsVj+X3k9TUHB2gs48Lxoy5TOUCtnoRFrX8D8q8rpXD3OH6ddKBx/UiMVjZg4+DSgz0O1eTvZi1wPgYJrjag1h74r4ejmT6DgwvT4CqTuI467K2DFWxBCyOo4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf57e90-9f26-4200-f7ef-08d581576624
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:47.6352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1100
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "H. Nikolaus Schaller" <hns@goldelico.com>

[ Upstream commit 934df23171e7c5b71d937104d4957891c39748ff ]

1. check if chip is really present and don't succeed if it isn't.
2. if it succeeds, power down the chip until accessed

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/touchscreen/tsc2007.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscree=
n/tsc2007.c
index 5d0cd51c6f41..a4b7b4c3d27b 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -455,6 +455,14 @@ static int tsc2007_probe(struct i2c_client *client,
=20
 	tsc2007_stop(ts);
=20
+	/* power down the chip (TSC2007_SETUP does not ACK on I2C) */
+	err =3D tsc2007_xfer(ts, PWRDOWN);
+	if (err < 0) {
+		dev_err(&client->dev,
+			"Failed to setup chip: %d\n", err);
+		return err;	/* usually, chip does not respond */
+	}
+
 	err =3D input_register_device(input_dev);
 	if (err) {
 		dev_err(&client->dev,
--=20
2.14.1
