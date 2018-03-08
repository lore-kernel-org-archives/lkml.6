Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520491973-2-12290629679671108551
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
    t=1520491973; b=KWXJ+I1qAB7wR0Z4uQAD35xVrRZ+9R2OL1riWGuzHPiCcxZ
    BtpP1NXpkCFwOG4FnwolB8g5zg9dP1HtEAnIIdenzUG/jlxADjaxRIxCGmKGpRc9
    X/9yc4FnfFL1AmdsqiNMU4JrK8cKPn1ep0a7jXFsRbfD+BZXvsEVHWIEIXlPUZV6
    7a4jJGcVEYRgbQP2HaTdR6dp17AZX+6n5gZmjTVZRW27XgL8dR1QPtZiwFRDba7i
    jJjzXBLt2DVp/zGz32nd5TmyORe8cOAqJ680GFlLJoNviIhfNe8vMnMW0gbn6FHL
    8R4/Dvk7fvGFVk2VjBzIggXxkWd1uWbxEiziI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=arctest; t=1520491973; bh=ibxZ/A1vRk5ZdYwWOH0g3r7FtK
    rkwanG/yCsiuWOqbU=; b=aHx7t3ioO42bAoxlL1+hW58OJKm6gG5Kt2JlWzLIaS
    NbNl32Ag4freV6tGwLTMAfUg54RnTluxBD/C5ltHfKgJlOCaXxVOHnBwHPFqz6YQ
    qjouMeemWjkRy4kTxDXdIUWsYR/eQRaKgpE6ufwYX324VOZxwKlFI8lhggxUAJZV
    0pWxmFmPCFuTS4cBynM82bSl3qjsYCKBUXHzfqNBxPhnc+PLNP5Y+mx3g/Ho1+oc
    lqWwn9A3JFh1PVG4OGuABFuZNOlyva6Nlp+fCYNZvmfzwMgTOG+ss505A7pt9Ed0
    HDZdzuF9vZWsQH2Df+IYtaXokxWmnYyKoN9ihDJM4keA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jVDvxt/a x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jVDvxt/a x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965232AbeCHGvV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:51:21 -0500
Received: from mail-sn1nam02on0119.outbound.protection.outlook.com ([104.47.36.119]:48736
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935223AbeCHE6J (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Loic Poulain <loic.poulain@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 01/67] Bluetooth: hci_qca: Avoid setup
 failure on missing rampatch
Thread-Topic: [PATCH AUTOSEL for 4.14 01/67] Bluetooth: hci_qca: Avoid setup
 failure on missing rampatch
Thread-Index: AQHTtpn32kyTTqIXREy0QBJ0JmxEJA==
Date: Thu, 8 Mar 2018 04:57:31 +0000
Message-ID: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:tT6Zvb9166DUefR+mVRXQTSh7JbNMY4RDLZfLOEOhEsQAs1m4cY6zHrcVt8b9ruvjoZwf91WxbLVOK4Aovi5EAxg607H61jZ9GIbx1DtGy57b2IPzXU54K46v1/fntwbNonGnYW4EnPUN0JNUZWpbaB/kpfLGcs2478dIY94j2ZQLzoVJb8zHMRDJgoEtjH4UdLXSOTLol3tkTYsrQFU3dFReZe23xNoQjCrwWHtV3JG4O0ykTRBKZgwqr+B/h+Q;20:0RpyGHNnNpzc8di4Uae4Xds9NeDvfZqYMsMurBvc6ctVRxhQvXmuqVmYarccueB9qlQk8OIhWMC8LerC8Dq6jPwju09WkYmern1QQSoMcW/mXlvGD17H/QUFrKnF8ia7gctIGTWpaKx/mSS1WetUo9Z9ICvhFvwzF6bOUS8zF3Y=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d125231f-5e04-4f9d-c4e4-08d584b12bd9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09362E96270C9D218C5A689CFBDF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(396003)(39860400002)(39380400002)(346002)(376002)(199004)(189003)(478600001)(99286004)(575784001)(6506007)(3660700001)(36756003)(86362001)(54906003)(6116002)(110136005)(102836004)(1076002)(3846002)(6486002)(3280700002)(10090500001)(10290500003)(305945005)(72206003)(6436002)(6666003)(26005)(5250100002)(2906002)(186003)(2501003)(105586002)(66066001)(7736002)(68736007)(25786009)(6512007)(106356001)(86612001)(8936002)(107886003)(81166006)(2900100001)(5660300001)(4326008)(81156014)(53936002)(14454004)(97736004)(316002)(22452003)(8676002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: xg/Ev9FhAvBwOnmf4CMjU8DjtiAmwKAJk2Fl63Rp4GWH/iU7zggSgJetiDaLhGgCttlkSOSwNu0jDsIQoZ3gCqFisIiQKDqj2M9Slas9/r5JDOwWFXwTkuc1EH20xoae30tGKHVfu9kbk+u6TOAGewc9kg6j+hnZYQHe3WWZacNUF6JMvus8qXS7++YSTFVMasjBVAHT4xyNrZQcq5M3zrc3lt/RbTpoecjo5uigfCRF8pjOFuU7lvqSPb/HkEgJlyKVwKfaET9VClLrBhb785lCqz2X+wHCRpScH5gUS7axeLrbuIsU+qpTEPrtTL1GRBj+i8yFp4fny1IAPKdCOA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d125231f-5e04-4f9d-c4e4-08d584b12bd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:31.8420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Loic Poulain <loic.poulain@linaro.org>

[ Upstream commit ba8f3597900291a93604643017fff66a14546015 ]

Assuming that the original code idea was to enable in-band sleeping
only if the setup_rome method returns succes and run in 'standard'
mode otherwise, we should not return setup_rome return value which
makes qca_setup fail if no rampatch/nvm file found.

This fixes BT issue on the dragonboard-820C p4 which includes the
following QCA controller:
hci0: Product:0x00000008
hci0: Patch  :0x00000111
hci0: ROM    :0x00000302
hci0: SOC    :0x00000044

Since there is no rampatch for this controller revision, just make
it work as is.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/bluetooth/hci_qca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 392f412b4575..c9f0ac083a3e 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -933,6 +933,9 @@ static int qca_setup(struct hci_uart *hu)
 	if (!ret) {
 		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
+	} else if (ret =3D=3D -ENOENT) {
+		/* No patch/nvm-config found, run with original fw/config */
+		ret =3D 0;
 	}
=20
 	/* Setup bdaddr */
--=20
2.14.1
