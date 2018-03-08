Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520491049-5-10945804711667543511
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
    t=1520491049; b=tSzIML7xNE5DwH9aVlSPgNluiu8d61Hwmlmu6bhR5n1j+A4
    9BhPEma5P2lv4TUZKSwWuwlw8b7eDkBRbYBx7+63LB9iybBSQBdd9SETv5C8z1mf
    zhzSfl/qyNIW5cNM8dw+BeDFlkDfAoZOWlHYPyQLMjXYDEjrOQIAckIqJbj+zJmL
    4tMl2ZChyX5MQ428Sp/LFdmOZ5k69dmCkc9PLw/Z41mkWKf4cvCjUXEqhNNbIeEj
    39QqP5mC8xA7eAFgoI+xsafZxgNYNqioPcKgfyS7rwKz+NhSuw8+zU2LimSx2YO2
    +Z+8vt8LaeRsioHdzn9DJsEu11CoKl0h+byl65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491049; bh=lxHH5K
    EboN7OSE1SCiclVsrt9zM0LJ/t0+Y9r58nrvI=; b=ibvSlyGc3HIK/cGeZVWgYt
    VfH8ZXLFH7DdeGDsige/lOlQxjy0mtfizkU6lLbmRQl3bOROUxDx5DWyAqL4rzc4
    Y+T0JgF0n8RUk7vDZznV4fzTTXH8w1+rAJ001U81NnemRBOX4JqEuQN9V84mMH0J
    7mtQ7y2WkbLUcoyTBF5LBWhBycgvawMt2ql1S8hM3phW4RlHkEmo4efGET+/vX3E
    psZbeu7rBxVKuKP99LUSM6DmUzecen53VXgFLAlvVKx2HxaNdLSU3Ay9YXxyehwj
    VJ37SlYg0POycjI5FGRkGEIziGa8IBr9o0iyo8auCLDs0L/LNrBVl/J90lEZNltw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V0DTVDVi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V0DTVDVi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755344AbeCHGhI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:37:08 -0500
Received: from mail-co1nam03on0126.outbound.protection.outlook.com ([104.47.40.126]:14720
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965365AbeCHE7S (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:18 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Joel Stanley <joel@jms.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 60/67] ARM: dts: aspeed-evb: Add unit name to
 memory node
Thread-Topic: [PATCH AUTOSEL for 4.14 60/67] ARM: dts: aspeed-evb: Add unit
 name to memory node
Thread-Index: AQHTtpoHDIWDmkjook2W2Xwau3m8MQ==
Date: Thu, 8 Mar 2018 04:57:58 +0000
Message-ID: <20180308045641.7814-60-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0999;7:mg9EecrcC2vAukIIJTz/7z6SYxyB8IUw+cdIGvYejxjlSznnkpC2E99OoCiEFeXOzVfekEgh7BeB5DpjKdKeIFYHc+y2Ta/Zkm0ePmHqwJhZ4fTioiCtpEY45XE3KR9uQtqSFjyuxxVx4qWcglXglY+Ov6qPJzMMPRZ6vvW6E1P+W6jBgc13fDQG/AgtZoM9+HHot80dYOz4wTuNjaXbvsOabOYrJKNbn1FgGrtC1untnEvj+wiPgT7+VruqqbwH;20:6p7D3rvJTJ7E5ppiTVtnULQ//hhuE+Bbit51EG/Xv2VxNPQaOb/QOdSp9SU4IdbRpUPiJc3vnZClHe/GqWVFt3EJjZ2tGnCOYfwip3Zh7wxdFFTfyitHcCqaEyamHOOSRdkQbsb9J68eIToqbaD1/VyClVaj7M+AZjbyeJCgJCE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e871f0bc-ad9a-4c82-ea14-08d584b15614
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0999;
x-ms-traffictypediagnostic: DM5PR2101MB0999:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0999D9145BD3F9214406D5FCFBDF0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0999;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0999;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(72206003)(3846002)(106356001)(8676002)(6116002)(1076002)(6512007)(14454004)(81156014)(66066001)(2906002)(3660700001)(478600001)(10290500003)(8936002)(6486002)(305945005)(7736002)(36756003)(2900100001)(81166006)(4326008)(25786009)(6436002)(5250100002)(105586002)(54906003)(22452003)(76176011)(5660300001)(10090500001)(110136005)(316002)(6506007)(86362001)(186003)(2950100002)(97736004)(3280700002)(102836004)(99286004)(107886003)(59450400001)(68736007)(86612001)(53936002)(26005)(6666003)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0999;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: kJ2LYxKECRo0oAWASzSvG+6/UnFA1Sr6/IVMaibAWjVir2/joWoW/T25hk8SjdtgirMz/8Ylhgbk2orCX7FE9gf68rOikeo6lmhAEF2DW1WlJPIHNcyHguyXNAJ9xd3y3iGrA9QFQtcesLTFtbm4Wi5cJ/BxtE5xOvabnwdmQXNbRKmG2gcAKHT7FO+EYpXCDYduh5uT+M0nsZJVb6fq9oaY5ni+iQ7bCmto3wgAwbMG5gtM8wVSUZAtXCUyyYTRfwcot95L/rkxXfWxE1qNs9PbDJKANUfirnsKXL17Gd6uI1mPOGktBxZAbW3151eo58ntlB2eKxvygQSbM9orBw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e871f0bc-ad9a-4c82-ea14-08d584b15614
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:58.6077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joel Stanley <joel@jms.id.au>

[ Upstream commit e40ed274489a5f516da120186578eb379b452ac6 ]

Fixes a warning when building with W=3D1.

All of the ASPEED device trees build without warnings now.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/aspeed-ast2500-evb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/a=
speed-ast2500-evb.dts
index f53e89d63477..c971cc93f42d 100644
--- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
@@ -16,7 +16,7 @@
 		bootargs =3D "console=3DttyS4,115200 earlyprintk";
 	};
=20
-	memory {
+	memory@80000000 {
 		reg =3D <0x80000000 0x20000000>;
 	};
 };
--=20
2.14.1
