Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488117-2-7868379289362107692
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
    t=1520488117; b=Ne8GcR3T0XSRdmt/ugus1fmVNWAXw7KerFHDAZb4R/0E3jM
    l91OR9WohvjDYPAFmZTqCeXmzYHXBHl3ixGVNEseQlRk2wzZZY0Paewv6YHzFhbR
    D09VTrHCuiK1NUc+YgJYn5Jp9+2V4ahmpMI2xXdB95hCHfOU5Y30Amfa2LQmrpCp
    zzEd8LESjpwHXJAzpyXhLDtrixDpKI2w6TVlSPnAMzAjtzpl6NW3kr4qHq5uQOkA
    XIQNGcLotkTfbZSGtJjizVVPtqaNfD9ysYedptMuqohtRakj9NdN+LDpOe4qgKi9
    b/pt3IjVMkJku07+6zMZSyjzqRMzmqNxtBHz+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488117; bh=qPU3X4
    xl0m9xwv8s7C4s2kcYSIDUVwWAlPLVGcSXYD4=; b=u7X4dYmoeXcfHnp/TSAGhh
    bRf/JucQXsoFiqqD/31FhXCkK0UqTNqPhJFMuf2bWFWh4PaKVGPwUk/7/XFAN+vJ
    2DUkS3IaDoaOc0rxQ045+/jB0bBAl9Vsme0aACaCdbbLHWf3pITAX+zYVLOXlBOA
    31MNwmTqX1BVmouNukgUt9lgzO6QxAKRLY3Hei8RmRsfKSa3iq4tZFiAxE5FBeIV
    /BJ6RR4WzlNt3MIyRk/xmDoBSDxFHxAT2ZQiM3ITDFjYyiYkWzlhAVDxWFRCQ5dW
    SGfQNawVbz4nmP5qhDA0/aSi9cH2X/5xGnOUqn+9CEtYunK+iXQbmItAdPBiyZAg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fwJO6fUL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fwJO6fUL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966170AbeCHFsV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:48:21 -0500
Received: from mail-by2nam03on0127.outbound.protection.outlook.com ([104.47.42.127]:45712
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935573AbeCHFFD (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Joel Stanley <joel@jms.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 185/190] ARM: dts: aspeed-evb: Add unit name
 to memory node
Thread-Topic: [PATCH AUTOSEL for 4.9 185/190] ARM: dts: aspeed-evb: Add unit
 name to memory node
Thread-Index: AQHTtppY3NI+smV+mkOn4XE58uprvg==
Date: Thu, 8 Mar 2018 05:00:14 +0000
Message-ID: <20180308045810.8041-185-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:ra6Kd4cZNuBwamlZM93GcclYIiskeXZs3kZAhSmbo+FGaUOGCQ6iDLPvwUYkfEnIe+JAkDnDwfme7jCwlez/YhHCi42xX88b2djsKfljgyZZk1X4ouFrDKuMXfkv7zSIZUKVMsCb/4k7tI46eZ7rOrO8kn7rS7atVcnAp0i9ILzNZvjOd283kHopPDtiVi3DtIz68rLtx6bGpdc+ONWmuLDBlLQPDi1Qn/aAV7KZDDkhVhe+e1B+m9tzR1PoTCFU;20:PiuaOUM+JjdXRpBk0TbCeUQ0fIWNAYPma63yZ0IW16NjkYuNvvvELDFb+al2AVQu/L7ZxBNVo/+MoMXPnJMM49Q7ee+qvbYlRv0qVkS+U7RPb8Irz15NyYNZoYQYvk34eGCy1bDMR3cx1Tdb949mCb5F/Sno1+1zMbhw+nlg5P0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48bd3877-763c-4720-d2af-08d584b224d3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB098135C49F95995769413203FBDF0@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(305945005)(86612001)(2906002)(7736002)(6486002)(36756003)(54906003)(110136005)(6436002)(6666003)(2950100002)(10290500003)(316002)(186003)(22452003)(10090500001)(478600001)(105586002)(6512007)(53936002)(66066001)(68736007)(76176011)(102836004)(3280700002)(107886003)(25786009)(8936002)(59450400001)(106356001)(6506007)(5660300001)(3846002)(97736004)(14454004)(2501003)(26005)(5250100002)(4326008)(3660700001)(86362001)(575784001)(6116002)(81166006)(99286004)(72206003)(2900100001)(1076002)(8676002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 7a/Wv2srPi63JgWuEhsOjNLl/ntcdk9yUwBjs7i+Lp3IVupvN+iMlg1hzwKfAvv84gysruVCQiBv6Pr9tUFw46DGCbn0Bvx6RvbJqnb21uEwg5bZI6pXe8GSUJn81h6XJT1/N/NzCi+YfPpNhfs6BS/g3BdbIWEXoES/Kq/l6i2+f7vXVM2YUcUqvV7bxVpAw3E5f6SiSaTuC4PWfZkl1GOLcSSlZfqFRLsQ99EimXEZHGRtlB/UAquUlee90uIVcTjC1YxKhcVo4XHvvh/CQLYonO8JAI+kx+NJr9UoZdk02tmsdygZ3uVaSv3Q25RO2gHiij1JCowVdKCbuxeeFQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bd3877-763c-4720-d2af-08d584b224d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:14.3645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
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
index 1b7a5ff0e533..d7774d35e466 100644
--- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
@@ -15,7 +15,7 @@
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
