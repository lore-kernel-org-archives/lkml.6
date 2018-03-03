Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118937-2-15669646940087545965
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
    t=1520118936; b=sDdIxfor5elr0mqAsuVqDZRnTVcc5H8vatProG+j3TXug2+
    TD4lAImKN2Yy8HLiGtHRQpH6ojyeuTdghcaF3a0LY9NOWXFzPK4rs0GGfo8fRF8B
    iGEpKLqHpBrGH/C30sdMJNRydJA2nIsN1Ssv61pla9RXy80ZKfqVQ9V1KRxHD5mQ
    rgIzPhVjy4XiFIorfxCoJcRqkGxhXeJ7yvutt0SEG3IXAXBSuSu/aHIulqBSMh/D
    geR5vCnclGHAFHD+BlnTR6ljIo3CHG6WS3F8nqq9/Icob3tKzFjGseYIZLj3eKVF
    QvdjTuk6RT9qm5yYMJMGUWDanD65o97Mlb+Sfug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118936; bh=Ms7WjO
    g1MczygxUj+nraci2EWiSkc7CB/bkaIXfxSyg=; b=vtmeGu9SCVHgaslKidgXVT
    fKXoRGuje/9A28W4L+meBbEglVohONorqom227K+E9OhwQ5ijDWdhLt9w94K2yQ1
    rISt2myH37gUPm9uXmuM2q+dSrQgRUFaUBvOqTfhXTxQYwdpEpNqrOyfw+5Jpoh7
    AR2Wr7YvDksouc+OyHlDLEA0/4H9rEoL5Q5We047W1A2SdwG9WsCLy2MwHKB555R
    1CyAzqGF92hs+DNHXnsgj6JGqslVsDd0sbqqVEoLONcBPeCQRNZiNvGVbatmOGyz
    rXz09dbVK1fiGCgQEb0Jtk6u+gI5zKYuH25cwMZFfQJmMYMKUwOJmycOGrubAoUw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dG6uf02B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dG6uf02B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932069AbeCCXOh (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:14:37 -0500
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:65056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935001AbeCCWjG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shikhar Dogra <shidogra@cisco.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 036/115] driver: (adm1275) set the m,b and R
 coefficients correctly for power
Thread-Topic: [PATCH AUTOSEL for 4.4 036/115] driver: (adm1275) set the m,b
 and R coefficients correctly for power
Thread-Index: AQHTsz9TtSgJAAWslkS3MvRrnk7CQA==
Date: Sat, 3 Mar 2018 22:31:09 +0000
Message-ID: <20180303223010.27106-36-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0938;7:LIOcAMGudURUQljjcJCgaXmf0wuUTUBp7QfdSDIGCi6L8hOJ5DiRn03KWTrY9i8mPhFxRUYlyLHRZzYupICdKVKErF0r8K6qgWUAYTZkQNZZuZYED6Z5pgEB4qaqa/3AaCOhxcekoFNmoicESQpjMA7HyM/N1dVn6N4HQu0EpJPwBZ2L2+aAmXfG07SxAWZ4gwF6/JpdC1hCLoPOqyBFGkfFqno99cNYAW1HBgck67wwJ5ImtgVCqRaXVhx5uraC
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4699441b-8b5b-4c67-2831-08d581579101
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0938;
x-ms-traffictypediagnostic: MW2PR2101MB0938:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB093806B70350BD3E6A840E40FBC40@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(270121546159015)(28532068793085)(89211679590171)(232431446821674)(95692535739014);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0938;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0938;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(54906003)(4326008)(72206003)(22452003)(478600001)(25786009)(66066001)(966005)(6436002)(6512007)(14454004)(6306002)(53936002)(2906002)(6486002)(105586002)(99286004)(10290500003)(3846002)(106356001)(6116002)(305945005)(5660300001)(110136005)(1076002)(36756003)(316002)(2900100001)(2501003)(5250100002)(10090500001)(59450400001)(102836004)(68736007)(2950100002)(26005)(97736004)(186003)(6506007)(8676002)(107886003)(3660700001)(7736002)(575784001)(86362001)(81166006)(86612001)(81156014)(76176011)(8936002)(3280700002)(22906009)(142933001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0938;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: d5VmOtCh3eQAHsSreWqxVKEqCEEnwVxs21SilfqFho3JjRt/g9c7CyGOWkbHxzcDuvS5KjfUwSS6ICwPBxavwy1oWe5Rb33m2UKC+2UUrSOAnSb3bvoImlJ1aT9U3WMLlwVAiczLZSJ58eKWhH7ECeP2X0gJr0nCweGdec45ydA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4699441b-8b5b-4c67-2831-08d581579101
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:09.7759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Shikhar Dogra <shidogra@cisco.com>

[ Upstream commit 6faecba0b3da7b617bf72bef422bf0d3bb6dfe7d ]

Seems like coefficient values for m, b and R under power have been
put in the wrong order. Rearranging them properly to get correct
values of coefficients for power.

For specs, please refer to table 7 (page 35) on
http://www.analog.com/media/en/technical-documentation/data-sheets/ADM1075.=
pdf

Fixes: 904b296f308d ("hwmon: (adm1275) Introduce configuration data structu=
re for coeffcients")
Signed-off-by: Shikhar Dogra <shidogra@cisco.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwmon/pmbus/adm1275.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 188af4c89f40..18477dd1e243 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -95,8 +95,8 @@ static const struct coefficients adm1075_coefficients[] =
=3D {
 	[0] =3D { 27169, 0, -1 },		/* voltage */
 	[1] =3D { 806, 20475, -1 },	/* current, irange25 */
 	[2] =3D { 404, 20475, -1 },	/* current, irange50 */
-	[3] =3D { 0, -1, 8549 },		/* power, irange25 */
-	[4] =3D { 0, -1, 4279 },		/* power, irange50 */
+	[3] =3D { 8549, 0, -1 },		/* power, irange25 */
+	[4] =3D { 4279, 0, -1 },		/* power, irange50 */
 };
=20
 static const struct coefficients adm1275_coefficients[] =3D {
--=20
2.14.1
