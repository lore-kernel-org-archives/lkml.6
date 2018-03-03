Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520117855-2-11006846597684129988
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
    t=1520117855; b=EjyelEfUXiPp4RU/lc3Pi5Jg0sDNSr5vKcgWQIeEk9pCj6K
    sozpRbR4X4wl1DXgxw75hrqhfDYU0HRIdJ5NQMUDGV0PBlBMW7PWenw2AXbbruuz
    RZ8U0bYattKa65HIjK+0eFLbPNqOW6OHOg4xOHGPOFBWzRmzXsgPIY7UNhKR4P49
    ph3rI6Q/kPK+CGb+P0lKNU2KYOU6nlbduLG7AwxKa5TdcYHfUJwi9N2BRViE19XA
    saCtIF+mtcyK+oVKyq0S4aFesZQRq0RHt5p+IGd/Q7jfofTIxvcaWciIurylNKUF
    VaxpQmV3qzfpiJxInUYU3/KO2+3MMZwrfoLbZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1520117855; bh=4yf+C5QHI3Pt8f1Hqc1kWX2mt6
    yoREK3wcK9m2IbeIE=; b=uNYoXhUEXBGKBcNnVmH5ufa3CzLyXwc4Mz62hw6K4o
    3Mq/8MM0PqcBc+Ps6KQYEWeymWuvekGXh8kf1DBsxJuzHSd9BYFw7AVle5TXq4C0
    Hznh14x2XtXywt9MtTIxXT9hT2DyX+nkXCjMUW1MWKlQkfrBJIqg5uBytPFAsszj
    DwK1dN6MLFxh0Q8nkRxnLk4uJRf/xtVRacZmZu7/Uwke89CGfs/fpwJGEp7S0KPf
    5yJDrvIqnVpz7C++YJc7lA2Id8YNuiQAyzyYTA0BG1dP9DCzDXcXXKWDAtis3BQ8
    OQ2h8gLdUosCLr3eNa2jWebEFgIpOLvpyLsltpKVRd1g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CiSGHQ5z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CiSGHQ5z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934082AbeCCW5c (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:57:32 -0500
Received: from mail-cys01nam02on0110.outbound.protection.outlook.com ([104.47.37.110]:31968
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935119AbeCCWk5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 01/63] Input: tsc2007 - check for presence
 and power down tsc2007 during probe
Thread-Topic: [PATCH AUTOSEL for 3.18 01/63] Input: tsc2007 - check for
 presence and power down tsc2007 during probe
Thread-Index: AQHTsz+ahCaeH5StO0C+6pVsw8ivwg==
Date: Sat, 3 Mar 2018 22:33:07 +0000
Message-ID: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB344;6:Sdud9zM/aHDd/KBA/NyLA9I/KvH+KrEZu/h64AQS/2rd7ycds0W+dBqwMZb1Q5O4dYsAqknuRLFnZhkCPOF+E2eLldLkB/oPMxmo49WHP6EubfWmc6i3vnvNGXby+OvTM/0A1XoH3uBYENZRQuSRk+g5fMQ/ckP6odrZ8ssdssJQv/IvhZdnARU2Eu41knfSvsSJu3eGBO7JL355/qJMlRexwxFXJa3CvIudYuJm6+RPcagkGhOHJF1fugumKD7Mu9++iL2P/oTN+AT5ks8rBdGao3GheSbV08lD7qKy2sWgnplAE+XbPbFxrLdqAsZicsSktDbDAM1tLgSEIID9oJVDKjegc0zBEHO8A1qre+AqD0FdzUi5AILgfB3hhRtr;5:By8+42C3cspW5nRCOVsqpMrq/vtulXhRAeZqdq+zWfRvmGyWOX/gSNoU1IMelwvD52V9ZaX6lMnrTdjwU/ExfFtYprz9ne6lr3uyBze+lxtvoC/RdE3sN47jyoMNj5oeUI9U8Fj45IIkhLpyLV6YVg3X8SPJ96IgqG4KcN4aHfM=;24:mm7M8UIBhD7Xyu3NJWEFmUkz9CerrPGMM4Wz+kCCADvI+Q2kYS+7el91qqniWiFBE1YhFOaX5VM0p6UnmCGWLFyMgcRLBmJYWI1KUMxWgrM=;7:al0lUOUoWy1zB2AdTB8pKYKzwe5CYcckQ6/Fme1DNDSNSvY8OiAcFRTO4PXMT6fAvyx3+FQqRrG2xdbGwfFiTFgQCMSP27VdbrPYnHQ2amADkMTtJoEFkoukS0o92QUYfxfILoMwO6mU5uMjTcT0qxNDphTTlXWELPdkCavxLNws8YVy82Y339cC/vDgYN5mjU9cUP4OYHBxet1Hnrvls1AsElgGC5bd211dfpUOP2jZU2pXrQiWzrRfeB7KPSK+
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63595ee5-b4d0-45bc-9326-08d58157d2ec
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB344;
x-ms-traffictypediagnostic: MWHSPR01MB344:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB344388EA095EBCF72BAEEDBFBC40@MWHSPR01MB344.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHSPR01MB344;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB344;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(8676002)(5660300001)(5250100002)(2501003)(6506007)(7736002)(36756003)(25786009)(3846002)(6116002)(97736004)(305945005)(2900100001)(6436002)(10090500001)(26005)(8936002)(186003)(81166006)(102836004)(81156014)(106356001)(86362001)(10290500003)(3660700001)(2906002)(99286004)(14454004)(86612001)(105586002)(478600001)(4326008)(39060400002)(6486002)(53936002)(107886003)(68736007)(316002)(54906003)(110136005)(6512007)(72206003)(3280700002)(22452003)(1076002)(6666003)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB344;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Q7Vc0blr/aL9v7Mh86F72ZM86nV8fYeImCtUbq8NAf1jDHElzAckvhAy7s9zLaREtOfhrFLtXERu/HktUx3/fkR3LxCs2V9PsQMWGyCuH08Q1Z0W4/DW5BoZRYwJgCvpoBEj2KhnvX/wSHEVZuJ33HlJznHuZU1X2QNFKhtTRns=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63595ee5-b4d0-45bc-9326-08d58157d2ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:07.8879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB344
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
index 1bf9906b5a3f..75810fa97db5 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -456,6 +456,14 @@ static int tsc2007_probe(struct i2c_client *client,
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
