Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520121163-2-5342708162833182889
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
    t=1520121162; b=hX9F3CCG4Y3myi2FQI6LyTWIoDhRcReuVhju10+jfj25835
    9U8UxYdh6NFMcLJPdV0uZBmcYjcA1GlHZswWMWSxeRpH0/IP0efo6Qlcu6pm2Jlk
    tZwbnBC27OZbT8Q4zxfRvLrftAWypEXWrQFF0Lo83Jj09t6WferpAR1rkHiDXb1n
    rzGKZZ6Lmjpc/i/u9cs3a8daBCJieD6tHVLvTzB/HT0DK/tPY5xxidsYCcwSIQw2
    7pwtxcQdQZ1OQPNlLyydsdm6pwUAMSMMbR2BKfVPPyfk8pPwTSzqdDTe/IGkrQRv
    CMbZTVjBMw+IxfDRm9AzHpkIYd3f63r9LrL/i/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121162; bh=TewPN/
    GWPY2eo51CXLkdgC3Db7lwsbYIEevWGLwiMhU=; b=LVTNwQsGk4HQ7UaGOI0bRv
    3wxz+jD6lcfB99mMESlqu9dV7OOW6WJ8k2VcG1CP1GX5+XRoi7fTuKJaArAcg4kR
    x4w22j4luSw2Gclal00cdx0QiUAHOlgTlxYW+gChhSVJF5YLC2r+77A+gMpKDd8P
    ATTJ2SyYfiV+v9Aq/IMJ52tRkNJxYsINMTuDWtz/AsU4tGpm7M6O0eDpoDh2MqAS
    TggTenNzb9ylstRupePf00bDRn0wKZ5bAsaK4HRf0g3H31NwONPieH3Ojc2GKHaT
    gXmxp8WxY+fiFgevPxBoHC2dfDca9Gq1iGqjUX1Ecv8pGCnSewWOubAYb51rfOMQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hh1Cf+d+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hh1Cf+d+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933915AbeCCWdF (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:33:05 -0500
Received: from mail-by2nam01on0107.outbound.protection.outlook.com ([104.47.34.107]:45280
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933742AbeCCWdB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Shikhar Dogra <shidogra@cisco.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 075/219] driver: (adm1275) set the m,b and R
 coefficients correctly for power
Thread-Topic: [PATCH AUTOSEL for 4.9 075/219] driver: (adm1275) set the m,b
 and R coefficients correctly for power
Thread-Index: AQHTsz76tSK5lV4GKUevZQqDjMba/Q==
Date: Sat, 3 Mar 2018 22:28:39 +0000
Message-ID: <20180303222716.26640-75-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1097;7:YezFdwGse4syFEsHAkD4fwiv/17nKJvtPq8yDfT8AOYgBahp7OWYnLeRrjijux7Ul+4j/s7rR0SeRqim/GQHrLvX33fYXp3/DgCbgldpUSzvitFPN0ZhG5+M8igoYPAzhMUSkgF1ZXKkVLj/iYvf4WeOBbNwQCay7dh/6y/7Xhu5SdwrtG1eS0WV7hmCXGfpJXo3Dzx50jFqA4awkrC+3p9U6tRRVrfmQL/GDkGBpyJQvcYfhTu8vMGqBmP8Iaqc
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca6ba791-c977-4e6e-e2a7-08d58156b802
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1097;
x-ms-traffictypediagnostic: MW2PR2101MB1097:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB109715A72489752E1DC06C38FBC40@MW2PR2101MB1097.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(270121546159015)(28532068793085)(89211679590171)(232431446821674)(95692535739014);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1097;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1097;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(39860400002)(346002)(189003)(199004)(305945005)(105586002)(36756003)(3660700001)(86362001)(575784001)(6666003)(66066001)(2900100001)(5660300001)(8676002)(10090500001)(81166006)(81156014)(8936002)(22452003)(10290500003)(2950100002)(4326008)(25786009)(5250100002)(2501003)(68736007)(7736002)(72206003)(14454004)(966005)(478600001)(186003)(110136005)(26005)(316002)(2906002)(6306002)(97736004)(6512007)(99286004)(107886003)(54906003)(1076002)(6506007)(106356001)(53936002)(59450400001)(6116002)(3846002)(102836004)(6486002)(86612001)(3280700002)(6436002)(76176011)(22906009)(142933001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1097;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: AkA69Kzoqlpqvahwv9T2tDlQBU/4HwwZK5GSp25EH6F1oOJDmfhW4UTJkexNt7gpPNkhDdYh/mR+S/2tzUH4vs84QMoOAHBd0mF5pwhO2iRWRMGO9cgIC22Fqed0qLBnWIIPO1MxS60qYSOUsTOsQvBV77lwkk8n4xiqF7BZ+fY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6ba791-c977-4e6e-e2a7-08d58156b802
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:39.4944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1097
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
index 3baa4f4a8c5e..d659a02647d4 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -101,8 +101,8 @@ static const struct coefficients adm1075_coefficients[]=
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
