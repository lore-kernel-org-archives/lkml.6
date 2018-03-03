Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121378-3-16069259385607869928
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121378; b=FdXaahY56M94Gu9mdOdpxcQ0lwNpiKMXgc8L3sV6+NrD9BF
    OSyScqe+nPtApgQqt3F9s2nR/3XB/PbGzY63iHzMVKzgTvBfDYnjkfPwystu02s+
    Du8K7EFQS3co7qFIb+rWkviAhQDcMmHL0j7lr5v2XJGPEBiOxPSjORckjcKZVuI5
    IJd/JLDhphkhpNkNG22OtBPQQeRLLRBUisBMn9M2in7cPJWThhVbpzHh8C/y8xDE
    ryftjynrUPymNXyhKJjc4zKrvvxrmbaB0lvaKpB349oRobT1BI/76wkpnm1SgAhs
    v1U5ZpSn0tt5Bvk1wuzFxPo/JjjQ/mOrRcdNQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121378; bh=xI+4JB
    jZCtYQnidH9bL2jSaWa6M+rM4Glt68qFdp5/8=; b=o/11CZhkRfu00RIJZ+ThUR
    +uW/b0F50nAIexXp8w/Y7lX3t9qxNaT0xHrszdQNZr/YNePgj/g12fL5wwXZugfr
    OUQrhjMiXDtBp48NvUelt6C7IA7Dj7EFecNMVrpotHTFo7kv6jfdYI8EYDQXTAS7
    sODwogZ2k5zUASbfCAuq46vC4LQt8thFxFa3nzwAI76WAhFOdk4sNv2S6Qr6F590
    QDJ2PqQHy6alaP9SljWla5B/dUHcfSUzdNW19vfZiCKkaO1dzL9J0plSrCjvZqaF
    2wNadACKfEslnDuNXL13UPViYcRToNzNQHST1S+B06DTYs4aTGD4sPEBdKcUjFWw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OyQwYllw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OyQwYllw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932657AbeCCXz7 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:55:59 -0500
Received: from mail-by2nam01on0107.outbound.protection.outlook.com ([104.47.34.107]:32944
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933259AbeCCWcz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Baruch Siach <baruch@tkos.co.il>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 069/219] ARM: dts: bcm2835: add index to the
 ethernet alias
Thread-Topic: [PATCH AUTOSEL for 4.9 069/219] ARM: dts: bcm2835: add index to
 the ethernet alias
Thread-Index: AQHTsz74vmXGJPolzE+3igo6G/gDGA==
Date: Sat, 3 Mar 2018 22:28:36 +0000
Message-ID: <20180303222716.26640-69-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;7:x87Gs0Cr27fFsUp0FKRhAL7XQFwD+/hLJ2Cm1Gh+gmpkUykbMG3n7hncgHtCkG/tqerjMpBWNSeMrPOvgKS4kJVEIqSye8ByCBVaRDEG9iNmXlolhG60hTTM+WOUk/Qzn6eqD47QNADFlDP5rLSEJb/VF8qjg3pnIb10AQtlI+nvX9QVUVLi2wwnXQnROQw3+zSxDt1K5EFt9h8kXvLDcBrVZ1HsFPsFtEXaW2b6SKhasmDRXlZlPBnFd97wPE2h
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 780c508e-fd58-4218-1385-08d58156b43d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB109790363A6A16339C66B6ECFBC40@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(105586002)(36756003)(3660700001)(86362001)(575784001)(6666003)(66066001)(2900100001)(5660300001)(8676002)(10090500001)(81166006)(81156014)(8936002)(22452003)(10290500003)(2950100002)(4326008)(25786009)(5250100002)(2501003)(68736007)(7736002)(72206003)(14454004)(478600001)(186003)(110136005)(26005)(316002)(2906002)(97736004)(6512007)(99286004)(107886003)(54906003)(1076002)(6506007)(106356001)(53936002)(6116002)(3846002)(102836004)(6486002)(86612001)(3280700002)(6436002)(76176011)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ZoTBnjht6QkJrMxHsNcgKn6zv7HYN6Bug15RAI8EmdreiFllqp9ARvR1bkM0tIPvFfGjNasotTPKmeFBVjNBXctYQSuzN0IrZzKa3SMEK+ILt4uysjlkQDBpJqmZxpkU6cUi+k0CaItnEosnD5vAl1Q8igDh2p/jTFIz/wv2dQ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 780c508e-fd58-4218-1385-08d58156b43d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:36.0725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Baruch Siach <baruch@tkos.co.il>

[ Upstream commit 10b6c0c2e2bb8cd1be682f8d36ef597e3419cb88 ]

An alias name should have an index number even when it is the only of its t=
ype.
This allows U-Boot to add the local-mac-address property. Otherwise U-Boot
skips the alias.

Fixes: 6a93792774 ("ARM: bcm2835: dt: Add the ethernet to the device trees"=
)
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Acked-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi | 2 +-
 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi b/arch/arm/boot/dt=
s/bcm283x-rpi-smsc9512.dtsi
index 12c981e51134..9a0599f711ff 100644
--- a/arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi
+++ b/arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi
@@ -1,6 +1,6 @@
 / {
 	aliases {
-		ethernet =3D &ethernet;
+		ethernet0 =3D &ethernet;
 	};
 };
=20
diff --git a/arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi b/arch/arm/boot/dt=
s/bcm283x-rpi-smsc9514.dtsi
index 3f0a56ebcf1f..dc7ae776db5f 100644
--- a/arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi
+++ b/arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi
@@ -1,6 +1,6 @@
 / {
 	aliases {
-		ethernet =3D &ethernet;
+		ethernet0 =3D &ethernet;
 	};
 };
=20
--=20
2.14.1
