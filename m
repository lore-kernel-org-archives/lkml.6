Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523240192-2-180150087642693534
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
    1523240191; b=tZ1ybL6KtaAzLiOVjeO7FxqbaJ15DxyioA0Eeutf2oJbUzqmCh
    Gr63rx2g4Dv2EQAQSmjpIt0WTujM2VxmZT0X9SWy36PotdXhf/JFclt3Y2+h4apW
    pru7eiGgAY6vEIvzjOxAmttfr7XyfuwaI0GCkdLS2Lyf5zedR6Imvu8ZJ30SFAqG
    f9J/5EqoPNeZmOGqivP5I+eJEOe/9GjcLfHt7cLy3kgq1OyEhbqNrdgX2jR78euU
    eG+2j3lmUyl8tyhI8yJv/BsxsG8tLUqoQ+dZDk6kaA6x38oT4mtFMXOGy6keNouC
    I2r0MSe8yYFaBAOrHo8p3as/i7fxU9+m/94A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240191; bh=/0e1WDLrcr
    9A71fPuyWvzMNVGEQRAswhpq4qCzlKKAo=; b=qTssbYDdATkXYHzSCV//j9urzR
    EydLZHQECVodnhgEobQy7Fg+y1F7VuHTC7AdpgfjWYDSU5mZXuo2OyQ3VCy9tuV6
    G7sVIOKpqv7JOaXnT3Ypq6AB4Clk+Mw0GpVcSIzks8Cr+sNyry7Pm9LfiCsmZril
    accbDGXCrMxa4CFrlHpbB1VBcDlfnzZI0xWi9wkeqj+tilgEMXelV2SAInTsv8gG
    mneGk96+6PSSmVstxqxHjW9SCm7g8Mx9SHUEvm4D+fC3EjllsirFaZ+Hm+z9HdX1
    5Ho91nWk96VMP+b21W9pPrPL61EbyQn4vrA9GV4qbTiss2pYxEKzs1dzaBZw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y6udrNWl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Y6udrNWl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHRV5mr1AvMzSds4waf2OPDT6MTbalsx8e6/TLCFWWQKs1VJv+sv9C0f9VnlaIyNkBNFPYCB1pDLBNihE72Ao2jpkSSH7fFB1igvq8HDq0BxXtKkb33e
    NxahtoA/IhIKpYVhaNN6d/dCu3o34MiOkTt7/3RUaAvdkG1zAW3+/WEEKVFVWuGKsbYhTAu02m3dZixlsCb/ffPnwopmN9seJZpyrwRiTQsMg2R/Cd9ynk61
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VVlED5B4AAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8
    a=53VAsZ4GQbqPQTDdyKYA:9 a=wPNLvfGTeEIA:10 a=NGXS0kB0m_rannUenejW:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756219AbeDICQA (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:16:00 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:60032
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756097AbeDIAae (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Daniel Scheller <d.scheller@gmx.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 141/293] media: dvb-frontends/cxd2841er:
 require STATE_ACTIVE_* for agc readout
Thread-Topic: [PATCH AUTOSEL for 4.9 141/293] media: dvb-frontends/cxd2841er:
 require STATE_ACTIVE_* for agc readout
Thread-Index: AQHTz5knD/t7gb0GBEG7i9l1syJYYA==
Date: Mon, 9 Apr 2018 00:24:43 +0000
Message-ID: <20180409002239.163177-141-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:qaNVtEYe3rms8/iT4eBsMWYgMXE4gP8xSJx8zesgyQAtfyV4OVBajDhrkHC4D1FCVB5oa53wMCDrloEjsfss5N26CVGb3rdh7w5D3+Kkcc3DsVNuNt1jYy/YFUYDcncz2zEmw9txwyU0djmSXzpABj0XAMmOx14eFT6LE57cM28Hw33Sluos/TlUtYmnbWFj34xHPtz+RoavTTqYZs2QAn3MN4fKbXShzg75GSVnt/GxFGEjP6xc5Cr/eFKj2CWM;20:ouJ0AsnTEc2yN69uEqO2bBBlW+uHhXWfGa8mOEA4kqD17Rvc0ZdlkFN5aNDrI5n7sJ7F9teRlG5m+/S6WSkhxPZhtmv2F2HR52N41zAW6rZUK3qhMM7R5Y64DE+X5YN9adDM+saIGdpa/JtjakxmKPtwkkGtAVfVyqIUQ4Gdq+M=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1d4ccee7-824e-484c-aa3a-08d59db118ab
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807DE417D060892D15925E8FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(248736688235697);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(575784001)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: rw3gHc+mKH6hhwjk+nm4UNqVMZWnl7OFjIancFGDw77DKYHqCdfZcDngKzqMayeci48KxIqGA/jBL/8eVNcl0g6rbrZg9yp3+i+/HChpANTdWYVW9IXSKL17M2J6y+BdXJBpwy4unqqUd6gAe+u+WtDjZAXYoA1sAQbcp8mOQHBNg2IMnj6cSn2I4Jkhwa422A2975BLd58HH+FWZm2Unrdg6QNL7lkuLPR+1z5lquO8xLbS10lZUhFWADvLqV3vTlQSNSYsRijqxPakj7jeXCqfHswmUTGQrNtWHVDInZyiCGYRZ9ouku0ojePjGRafvK/AWsNTyN/TwERitdYpn1KUJuMHjnqYhlgnYii33L7AMSqsLMXMfAU9Bms26f6i7T15yRD4XXfO0KZEEwbZqpwV1cfQJYa2tkCvFbujhDw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4ccee7-824e-484c-aa3a-08d59db118ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:43.2688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Daniel Scheller <d.scheller@gmx.net>

[ Upstream commit 8982735f8dd02096b75255e3c0a0df28aeaa9955 ]

When the demod driver puts the demod into sleep or shutdown state and it's
status is then polled e.g. via "dvb-fe-tool -m", i2c errors are printed
to the kernel log. If the last delsys was DVB-T/T2:

  cxd2841er: i2c wr failed=3D-5 addr=3D6c reg=3D00 len=3D1
  cxd2841er: i2c rd failed=3D-5 addr=3D6c reg=3D26

and if it was DVB-C:

  cxd2841er: i2c wr failed=3D-5 addr=3D6c reg=3D00 len=3D1
  cxd2841er: i2c rd failed=3D-5 addr=3D6c reg=3D49

This happens when read_status unconditionally calls into the
read_signal_strength() function which triggers the read_agc_gain_*()
functions, where these registered are polled.

This isn't a critical thing since when the demod is active again, no more
such errors are logged, however this might make users suspecting defects.

Fix this by requiring STATE_ACTIVE_* in priv->state. If it isn't in any
active state, additionally set the strength scale to NOT_AVAILABLE.

Signed-off-by: Daniel Scheller <d.scheller@gmx.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/dvb-frontends/cxd2841er.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/cxd2841er.c b/drivers/media/dvb-fr=
ontends/cxd2841er.c
index b97647cd7dc6..8c175d959038 100644
--- a/drivers/media/dvb-frontends/cxd2841er.c
+++ b/drivers/media/dvb-frontends/cxd2841er.c
@@ -3210,7 +3210,10 @@ static int cxd2841er_get_frontend(struct dvb_fronten=
d *fe,
 	else if (priv->state =3D=3D STATE_ACTIVE_TC)
 		cxd2841er_read_status_tc(fe, &status);
=20
-	cxd2841er_read_signal_strength(fe);
+	if (priv->state =3D=3D STATE_ACTIVE_TC || priv->state =3D=3D STATE_ACTIVE=
_S)
+		cxd2841er_read_signal_strength(fe);
+	else
+		p->strength.stat[0].scale =3D FE_SCALE_NOT_AVAILABLE;
=20
 	if (status & FE_HAS_LOCK) {
 		cxd2841er_read_snr(fe);
--=20
2.15.1
