Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523246342-2-14909963957883719871
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246341; b=bJmeHHOnS/8aeWker0T5BKq1bPZANM6UpQmS8rZwXXKw8z/9Tz
    Lq4+7AkCLHaRecDdY2fGQoDJRGKfOLg4jEKV8F1S+n641H1zZb2Ic5m9lxEvzlS3
    PLMmqUZOKDEno3H9p6tYIr9aPXWBldigtQJGoPFVHgtxBY+q5uYvTtS7drvl1ZHt
    TL8QZnc+xtHNGzuh+QTrmWD5IrJqlHw69wydNhTgCkMp69wBrW0llkfXFZkzDYZr
    Zvoc+/c/QDW4XW4HBkypsimfZEBkMfeKH/r3S67jF8FuepdmZCHJ3fg06V4MeKOn
    qXNGWNWsfC08/XzK3vtOG9LGQqhR1x9fZy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246341; bh=Q9eETulSaB
    bfndVrXiKUDg8bvkXydGYYPHyu+DkjrNg=; b=Gs6R/Ij2y5Z5memuz31oHCV9qJ
    VFBSRzYKGs4/yAmYze6CFpK8KlQWWBMj5nuYcfXPyhPLruH+9EBZGRQDiWXccfno
    m/sFzqoetTO9rrYH+W0Y6VAbyPFR/4L0Dxhn7anZ777Z/ktDFHf5Fx/6MPv3o3zb
    t5WcolkMH/ae4dquILdaO4Pz+Ccw+n+B/ExDZIVJwrVZPdgp2AkivnTZ8FQQBUhi
    x33zLa1hahQ6zsnKYYNLw2Tcj8ktNhrKsve9/hjrcxbs6jKVjPmA+xyyZ273XYFC
    may4D5ewWLe5XJYH8JcFKShyBIa6qlfkmgtPORX1SsQ6sTbxI/o4VfT7C2Rg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U0QelXf+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=U0QelXf+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFPZIi4bdNxJOlT6x49zCBYq5IhOTA2ceNxo6f3bl60JzUdOHn9ENI0Xa4dHsd2Q4nTfNBDNjIhiePYfrzc5VmHqlILgh5mHYHTGiyDRHLZA/44SCJqx
    oVD/CB5a/5gW0X8L16OMHxyyL8Ht5R0nCKVqvYnynmna1sv/bT3VVWffSphrBm9Eztnnxt00Wo2qhNJM1r8MN4aiPDbI8oPy9SLGXzG8d2t2axTWrO57J9SA
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=hD80L64hAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8
    a=N7OR0B-K6y4zIct5v3IA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753982AbeDID6p (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:58:45 -0400
Received: from mail-bn3nam01on0092.outbound.protection.outlook.com ([104.47.33.92]:62923
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753676AbeDIASh (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Andi Shyti <andi.shyti@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 072/189] Input: stmfts - set IRQ_NOAUTOEN to
 the irq flag
Thread-Topic: [PATCH AUTOSEL for 4.15 072/189] Input: stmfts - set
 IRQ_NOAUTOEN to the irq flag
Thread-Index: AQHTz5gs0UlQqGXDx0OxIzwAXqYNlA==
Date: Mon, 9 Apr 2018 00:17:41 +0000
Message-ID: <20180409001637.162453-72-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1128;7:n5he95ivgcgU5JKRn+mwrThld6WSprDohyg8fx6gzylG3Yy/TBeNVn0tEQCeGDsR7+WeTrlgvozVPyLaUzHTUDF8sV9e3/gI0lq+0tXlKD5owaTVXUDSStNM3JbW2PwembSN9ZSz/9EkpdrFUy63aUCGkkvJnmQjlkk13J8zac3WirVJDHHlxAfYJk1x6aZb+oaOgmGvryTDAh6BV+6AYy1RCgbsh20ymyywnDx/pOXNRNRFF/T/nRsV8VAT3GTj;20:gJ6ixaOg0n16dj5vpMYYuC/Hdq2dL4rFJOjJNpe5uEEXx6i9BG2IIY3oKIUiFv/F8GIpFzLpLZbOqWFitaMcKbtO3pw15NXiaoHnyU95U1jCQtprTs35u8HNR+3DGqWLFqh+T6Y7Pgx2bqipwY7lFIPly4TykP54WbVYWKtmltU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c005b4ce-ff84-4882-c4ae-08d59daf6e96
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11289585A00596FDD6B1F224FBBF0@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1128;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1128;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(2900100001)(25786009)(36756003)(6506007)(76176011)(2906002)(6486002)(86612001)(99286004)(102836004)(1076002)(7736002)(97736004)(2616005)(446003)(486006)(11346002)(476003)(26005)(305945005)(39060400002)(6666003)(6512007)(4326008)(107886003)(478600001)(6436002)(5660300001)(10290500003)(5250100002)(22452003)(316002)(105586002)(186003)(8676002)(110136005)(54906003)(72206003)(53936002)(2501003)(68736007)(14454004)(6116002)(8936002)(3846002)(81156014)(10090500001)(106356001)(81166006)(22906009)(40753002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1128;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Jfu80g1d/DWyh+MEMXOPHauxOG8zgQxjfg51Gcovwbs55MH1TWQdkKwIepV0lzhT57BCFNwazG09MFNWp5d8is+FTdw4Fltd9p50SzJs2PFP53xfN10nY/acKY9Pv7yFErQZL6HHCXGuwCkM36ZmJLIyuDqE7z3pj4565btt72Sha6GWgW4IKzkSaIF2fGXGLlFc8tV1HTjH0nYDWlpCsK8VvcZMNvhn212zaTSTLd+8oqt7CD5AwQjmDPkydreKvfyKxxXWz07PWwwFnD+V+3Bip6KKyb2FUUrCpTYDr1xwwnIppjA0v0tVJ5MFDf0VJ+9XTD67zXkSgpBxkbpigqA7NuqzD7O24Cj4YH0w65Sp2KrZBtNjedMl74dZpB0x8SpFlUlpth26qu7yAPIoIQ8C1/Z6tpTu2GgWgv2icqs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c005b4ce-ff84-4882-c4ae-08d59daf6e96
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:41.6490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andi Shyti <andi.shyti@samsung.com>

[ Upstream commit cba04cdf437d745fac85220d1d692a9ae23d7004 ]

The interrupt is requested before the device is powered on and
it's value in some cases cannot be reliable. It happens on some
devices that an interrupt is generated as soon as requested
before having the chance to disable the irq.

Set the irq flag as IRQ_NOAUTOEN before requesting it.

This patch mutes the error:

  stmfts 2-0049: failed to read events: -11

received sometimes during boot time.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/input/touchscreen/stmfts.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen=
/stmfts.c
index 2a123e20a42e..efdb1a75a163 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -682,6 +682,14 @@ static int stmfts_probe(struct i2c_client *client,
=20
 	input_set_drvdata(sdata->input, sdata);
=20
+	/*
+	 * stmfts_power_on expects interrupt to be disabled, but
+	 * at this point the device is still off and I do not trust
+	 * the status of the irq line that can generate some spurious
+	 * interrupts. To be on the safe side it's better to not enable
+	 * the interrupts during their request.
+	 */
+	irq_set_status_flags(client->irq, IRQ_NOAUTOEN);
 	err =3D devm_request_threaded_irq(&client->dev, client->irq,
 					NULL, stmfts_irq_handler,
 					IRQF_ONESHOT,
@@ -689,9 +697,6 @@ static int stmfts_probe(struct i2c_client *client,
 	if (err)
 		return err;
=20
-	/* stmfts_power_on expects interrupt to be disabled */
-	disable_irq(client->irq);
-
 	dev_dbg(&client->dev, "initializing ST-Microelectronics FTS...\n");
=20
 	err =3D stmfts_power_on(sdata);
--=20
2.15.1
