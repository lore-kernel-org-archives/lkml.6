Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523243824-2-10938463483240503242
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
    1523243823; b=eOqb9nOHhdX3gjwJGJW4Tk3n/zO9Zqo+kYVTOJzv4kHaTRzHCC
    mndGy5GzTWeARVztZvzfxYvPytD0K1CZFpuRLMopqQs4dofMnPdEVsOTTDJbk92A
    L7o9Kpnwr0nEHrC1WPDsw1ZCD1fgJsJVYD2GfQuMl/ZanLDb/AbFUX138wg1ZVpj
    IHPHf+DtCitZSboBsC16nB00fc4Qhuxca3q2+eyiYzHBMC9scT0J/RAD9y1x41g8
    8as06/6nGo+fi7cIHaKUKB7FQhccBSmJ+TqnGLO6VuAQtI1nAougj1ttc/VJqwyz
    qTiSlI3g3NWLzIK2+qipWPcyVjHAIucJ/Leg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243823; bh=SrWs4p6g8U
    nv2pRMU9cVQqldkyFFpCiDDdU9ooTe/qY=; b=kjnZu7TOG/4VEWOPSb3pDgH6bR
    9UAk3FscTjaRumSZ8D45kO7oNzUwyhflsg3ETDTgYGB6la35IbvE/7ubchJPzgcx
    lhDaatUAOxsYSqLdjKjq5yAY+X34Oo7fmtHieb1eTe5u2p72vGCB2kps/THJ+BS5
    nnubNQdyWJav1RALHHMRgqtRXFmZQyvaqH3VqOzFRsHziEonKxDvAqGi6Qwe/E+b
    seo3KTTjnT0Jdg95V7UkvXI0Uz3Rmr6dw0ZZn6vutOeUiqiJrXszkr7YRr7iwu0q
    aa6NwlgConvHNBlLmVoq0t3+f1FQbHpy/LO+CBVMhVLyVV/gdcK8oolBBV7w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nSu3hih3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nSu3hih3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJu8TkndDjdePqkEcYQuqHKfg3aksl48TQooUh62ClWT9Qvl2TpuT5yLr5pIqSyxBrb0dOD1/5KFiP/efZTcf4tF/0eU2OkmNJjxccKaEE7U4qxO+NHt
    RarljJrKsjYZl8dglqvwpRk9H3VDLm4jTDzV2jOVilpKOmNHTfPXT+cltYxEhZcrItZEtQfHFkGlHcvCg7uHlHnHSRKAYQU9kP5F2gLXfHWzEWLmpuMaQgXF
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=hD80L64hAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8
    a=N7OR0B-K6y4zIct5v3IA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751851AbeDIDQq (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:16:46 -0400
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:29467
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754886AbeDIAXh (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:37 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Andi Shyti <andi.shyti@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 061/161] Input: stmfts - set IRQ_NOAUTOEN to
 the irq flag
Thread-Topic: [PATCH AUTOSEL for 4.14 061/161] Input: stmfts - set
 IRQ_NOAUTOEN to the irq flag
Thread-Index: AQHTz5iUxOBDJ2k1fUWQ3LsVZuWx3A==
Date: Mon, 9 Apr 2018 00:20:35 +0000
Message-ID: <20180409001936.162706-61-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:ANG2GHbU4JIPyY3XAtNUu+TpZVD2c7vrN4iMixeuohvrTyVZGZ5U79xPA1Pc4oCsVg27FIOlVTCaA9R3yAWigWH5vIlpagKPAEcweDDhW1TvDW9ycRvOYyFEZUTWM3yy4BDdVS0+MGMwl7OLZejNngFRzKzJa52zrcDDIklrhp23Cb+31Xgf+8cZEbDehFgzFp6CrSikUU/wk+kjAVii75cyoZERxN0qSqZDb4dKv9yM6IkWpXAsKmlcbcZNyct+;20:AQ0O2o6rBkrpQROzAFplD/x+Hh9bCyctxNLnjwYxoW5MOmNGncBscvI5OoYVhJtfU4eg6sF42c0silSIw8NEFv0wJrTfjkz4NCQMpJ7bhAt29twTHAKdQjGr1I/aETdHc/AzJ3zPK1e8q72i+FmzFyXLE/Aw2r/mjRyggsBF1CE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6afad3b9-151d-47e1-7194-08d59db022b2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB108042562050403FCE4D83A1FBBF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(2501003)(5250100002)(8936002)(10090500001)(5660300001)(3660700001)(446003)(107886003)(14454004)(36756003)(6436002)(39060400002)(476003)(3280700002)(2616005)(11346002)(4326008)(53936002)(6512007)(22452003)(305945005)(10290500003)(316002)(102836004)(2906002)(6116002)(66066001)(6506007)(3846002)(7736002)(486006)(54906003)(110136005)(186003)(72206003)(26005)(1076002)(105586002)(2900100001)(6486002)(97736004)(478600001)(81156014)(81166006)(86612001)(8676002)(106356001)(99286004)(86362001)(76176011)(59450400001)(68736007)(25786009)(22906009)(40753002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 2eXaDeA+kP+fhqve4n7LGTR+SZZn4mbUqbe5cZz9Td4NUwgMmmuKTvs5ptpwWGrgoNED1TkmqYXKPwZL/UQVn2qsYJ4+kD04PLsKNxjlgpux0yV0olqXNZ8Uu+kCS3kLHFErHWnsO9DlSJ2/M9QDeFjkgoOnnXMQ9KkrtrGCyfK1rCcrXeEdbUuOiS6U8GOoDbt6olXgGQdL8KmJqyWy2b6fSR6r4684/LNmH8Duj8BlZrH/Sxhg8X6/bC+OjRYg+764C+fDyPfSCyvZgj6H4riSv+pl8R16Tc0Xw0RBHPFya5rjq6sk2SNcpcFLcw07Vy2qoebs8oioVWNpZwNKkyrJocC0jh21WDDKtcQIbM/bnJJb3YxToel2a3D9WoOdkAOtDqfwa1ooZ1TrGDBIw6YeogStq+zMwckjSJMCpsY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afad3b9-151d-47e1-7194-08d59db022b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:35.7692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
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
index 8c6c6178ec12..025bae3853cc 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -687,6 +687,14 @@ static int stmfts_probe(struct i2c_client *client,
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
@@ -694,9 +702,6 @@ static int stmfts_probe(struct i2c_client *client,
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
