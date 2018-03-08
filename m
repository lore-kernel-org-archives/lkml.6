Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486846-2-368076843432331156
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
    t=1520486846; b=Nzvbw2qh0s0O23q6SePWMi35xIDaiqgkOUvpjle74RyZ52l
    eWWHdUqaIuq/X+L+jIpBNgAhzhsOhRtOKTcgN4Nzamt0w0liRr+O5G8x9iLBzcz9
    +PBzpS+M71edEWxG7bkqbeX8TSAD7dM3TB/Ye16XXvLv2T4lTXq8lTKXGOk60ZIw
    bXr0afp+8K84gU+k4gFoKX2piq8u2P1WAWZxEbrQu4ra8TGVmaU4J5VMbZjDrbu+
    WmV5I463ybv5WWwjErFCE7bc0m2cJVBMQobX7AYQXPbgJ4SPMy7OHoHou5AilesB
    XRpYu4xIhupk9dmUUM4qq0Wf/Dj1ZIt/DPrVw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486846; bh=XaJAl2
    WpAnkYa6BzjK2mjagiaIrgZLknN50IbuXSv4A=; b=BBcQALUcfmIuELxOryrk5e
    Z7y8v6MIgrbQHBzoE0/VRoYonoJHRowMINfQSVZhyOMO6TNw6EtvOte+oL1SUbZE
    03iz5jmMntvuXRRkfSgPfWe+m3DmECVj3QZ4TH98cP4s614GcBjDPSetghgNhJ+l
    +lusbUk3QwcRrKi9+CWXdKjhPAtoHMADX8dcPmDZ6ZnB09tm8iriFd2LHMhmE83J
    LyrX71IOHrWiIk1EPNVSLdaPI6rEGUAecvYSXfDKTnq820PWwWcpAilgbyY9EP0s
    zBY36TIBrEmSoFI4BxkofupcVaADs7RgpFvT41nRwB7MLj/zGHzYbEjHu64/YAHw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mR/gzrPR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mR/gzrPR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964940AbeCHF1I (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:27:08 -0500
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:41401
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966541AbeCHFHI (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Loic Poulain <loic.poulain@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 078/101] Bluetooth: hci_qca: Avoid setup
 failure on missing rampatch
Thread-Topic: [PATCH AUTOSEL for 4.4 078/101] Bluetooth: hci_qca: Avoid setup
 failure on missing rampatch
Thread-Index: AQHTtpqbVcj6f9wG9UG9fhKP8c2fFw==
Date: Thu, 8 Mar 2018 05:02:07 +0000
Message-ID: <20180308050023.8548-78-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:tj2nA7JBLQ5/J/OMPLadJ0n46D6N5mNPT4NzIeuwVa/9ugxOKgOS4z3CD9KJ5KrbB8tqvq73YUfxwJyXqCcHm67rxnXOVAf/P7lIDz2PFnELm3PUGs2+4G48ozPBEC5+iJhhU2XlwJ9OZRDw4PkP+y3Ko/GakLVg2j5weu7LalqWchiLrua/k3mP+za/NS4IV5Wr2u0F9NzQFwfm8XW7EfJltsfmroFMynj+jFOgbg7fnVzmUMchSpiT/vH3XnXt;20:B+YySTD8ANx3dDuPqPgb6mi+d8QATtFOLEOnUXu80QUst0vqCxAwsa1DfV01igcXp2+kKZ5S5SDhsQaNqrQyr+QrM2+JkbLuwM6F07zvcAWe7DJsSEESL8QdsSh7bcaCONBjuzZpO/KsdYyXDkwLyggsJfZ1IMbz2ZeaJrC3EhY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bda393c8-b351-416f-dfb9-08d584b27051
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10775319DAFBC500935CF1BEFBDF0@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39380400002)(396003)(39860400002)(199004)(189003)(86362001)(102836004)(575784001)(6506007)(22452003)(2950100002)(186003)(68736007)(26005)(106356001)(105586002)(66066001)(86612001)(3846002)(3280700002)(2900100001)(25786009)(53936002)(5660300001)(2906002)(3660700001)(10090500001)(6512007)(1076002)(4326008)(6116002)(305945005)(110136005)(107886003)(54906003)(2501003)(5250100002)(8676002)(8936002)(81156014)(81166006)(14454004)(76176011)(7736002)(72206003)(10290500003)(478600001)(6486002)(6436002)(99286004)(36756003)(97736004)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: fsDx4BXDOF+QV/3itoGP+dlcWWhD1qdtS0X8yAKjoU2ZU7T4k4WyPr0u/Mk2KvvXdYeVEVtb4c++s9WDTYcbMEfi/sh6tzN488a/wucNWVr7HDVvL2Hhyx0gHQwBb7FSrI1m+B0oRhCMpIArxTae4aD+05Z7beCHiOZ0Rb7FwfBOcz5EszqJzzwrQBLI05PRQoCQWQPZkK8yPKndhHa9m4VN9+SlCLcm7qk4puPZNJEpQ6y5U4N7yTScIwotd9HRSsGdKtG7CLxpZ0BOUhVA26OH/Umxy0OIYxYPiysKGmeXAflWLxCyCJ8GM36DtZKDSiE8JgHiZMtLfKE7Ta5ybA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda393c8-b351-416f-dfb9-08d584b27051
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:07.2664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
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
index 71325e443e46..8a3bf0a8c31d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -936,6 +936,9 @@ static int qca_setup(struct hci_uart *hu)
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
