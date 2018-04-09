Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243871-2-18169300817557269140
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
    1523243870; b=PTFDSRgEXbUar+mNZKC2+Fv4iqn2OnJnaO4lhV8Bo8gj6xybVy
    a7cQeFoiVY2MYJIeWyRjSyryimuChOAHe+HhSxKb9YhqIMrR/b8qF77y+q4HXqhJ
    +NJANd8qgvPPsJC6XVocV8l5AsD7rXwoWJ7JPvKWtgHERl0+XET5EJOSQ9j0pC4B
    175kDrsbXFwiKetKGkK830fmRhaZp0n9eZy2aPX2wVPBllM36ueTcSHPsNRGDaL7
    fWJqouT+zw47TW0p0AwmZlPQvGQk+nYknPntHdxKc1wYpk3MvTxqJd5DUEiK9dcR
    tnfwI68cPNrdJljiWplyI9woGfngBrUNa1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243870; bh=hzMZY3DaNp
    1nbYji6bW4VPw/geV/k1dXAuXCwXMydOM=; b=mKWthvEFfP/++V+bg5P3b6k4VG
    77ml0XBpbq4TYxbfkwcYxDpt7miB2B01ViARK8qmZ8AAetu4c3I1g/+ando5g7cc
    D8SJ9sOrNZKDluF4ZbMTyGZWq1Any9qhbSxDPp9ApP46HKMLAfxGokVzG++x+d9C
    RCZe/TKpv6K3AJJjiUiYlEczu3oIGmNmWSj61/fjlFErYbpEIVZEHIe+IQpTgVIo
    9pQsU5dK7KU/T0x320gRMwpEmLREYt/Smd1aCpV40ynrxEsUqaNYhwoChlC2nmxT
    7bC6KUqQsUHozalgmV3rVkt5IumCUDdgbBUjdkR3qCGgYtTjtCk6+46OdVUw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=a4e5PNCF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=a4e5PNCF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMgfWd0UMSOGPW4JB0sJoUPdedBYpDMa5WBv0NqwmJcKsGXX8fUuw01uKxj73fwRAaLwDAi/z6j/pdeZf/6ovWhdXyS4MX/wLpEvX+vL1JmfSDKSqncJ
    W3hbk/mmcMGXw07xyw+y+Bb6P48zJ4xnBKk2y5445wEJ5elvaljd4jPBIPjApM8MV8xunT/f3GdZgoKZ9gbmiRPVbaL/ca4ob3apPWw4ylIf3JxCDUsthPJW
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=Utfb4SCxKVlw79s-hMwA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751738AbeDIDRE (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:17:04 -0400
Received: from mail-by2nam03on0112.outbound.protection.outlook.com ([104.47.42.112]:27929
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754794AbeDIAXf (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 060/161] scsi: fas216: fix sense buffer
 initialization
Thread-Topic: [PATCH AUTOSEL for 4.14 060/161] scsi: fas216: fix sense buffer
 initialization
Thread-Index: AQHTz5iUF8KwTdG7TEmiGGk62yKb2A==
Date: Mon, 9 Apr 2018 00:20:35 +0000
Message-ID: <20180409001936.162706-60-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:kRAhF0FD4cnUHx/oIQVL9AqAdlQbnymK261+hHBlSy1xRlAADNGCbqnGxd/GiS6xVhpcHrO/4nIk64Zvq1PjiyEGT47fZ41Vhhn22iiC47T0/xNOJDQdfXLeElzKObdAjS4H4w1dLfnTnJ4gi+9DgO6z2ytPaeQfgjUMD/0AmcEs6lKujB1JThdKRhmlJc7dbUNGv4FGgi+SgiYcIbwMMG4M1JlTjfOcczZaF0IIqB5FBL7HczVRX/aFoMMMAW8I;20:zSogrR+ir0fq+N8SY8/nHB0npVIbB7MpHi2YrWkhZcnIycwNMxI3yMCqAZd/k9YJH4AjLZeDp1zXCGrKiXYvTbh8HAMDKka1GVajgFaq3Oz2svfMsKy2IrWERmeZZ24leay3SzgWL71LhJmGKziyBvqc9pVoSCnyB67bK6MDnYk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5fa4a2dc-8397-43ec-f79f-08d59db02153
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10807516152E7DCC3B363940FBBF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(2501003)(5250100002)(8936002)(10090500001)(5660300001)(3660700001)(446003)(107886003)(14454004)(36756003)(6436002)(476003)(3280700002)(2616005)(11346002)(4326008)(53936002)(6512007)(22452003)(305945005)(10290500003)(316002)(102836004)(2906002)(6116002)(66066001)(6506007)(3846002)(7736002)(486006)(54906003)(110136005)(186003)(72206003)(26005)(1076002)(105586002)(2900100001)(6486002)(97736004)(478600001)(81156014)(81166006)(86612001)(8676002)(106356001)(99286004)(86362001)(76176011)(59450400001)(68736007)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ajrogu9gqFHWE31Y6EqB3Gn9fZ6sDgdW/xL+e4FdtqkFaDcrivwF7eDOp43aqruotMU7iEAEdqrr3E2/KVL7fJVAXCdlRNbB1OVd5iEbH1kOO6n8UKmn9ABIm7C0lvWVQNVv+F56ygXLQ9YD8EuaY/YXNOVd0mCl8Fd++S8bZV4f6kgV4CDeirTgJUEOCMOyMyLR1vdJK1kZSE6Ql4qfuheltjLI1g7O7z6Bq+w0sei8d7H4ukcwuNO5j6ZoCN/AkxiXdwPq7W/m0Lg5bJsm9KO+DueKPoIbSNrDPCmMZdYdH2I6eawk4gu90zDr3TuNlBdfbQMwBo2sorIi1OYjGIVZm0Xx3PqXKRZc2YdXeYKfzKjJDsr6XS7i9FLD7yJE1P5G1KkfvgOU1fFbBfLbAHofiN0GP0ePKYeI1ex5knY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa4a2dc-8397-43ec-f79f-08d59db02153
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:35.0348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 96d5eaa9bb74d299508d811d865c2c41b38b0301 ]

While testing with the ARM specific memset() macro removed, I ran into a
compiler warning that shows an old bug:

drivers/scsi/arm/fas216.c: In function 'fas216_rq_sns_done':
drivers/scsi/arm/fas216.c:2014:40: error: argument to 'sizeof' in 'memset' =
call is the same expression as the destination; did you mean to provide an =
explicit length? [-Werror=3Dsizeof-pointer-memaccess]

It turns out that the definition of the scsi_cmd structure changed back
in linux-2.6.25, so now we clear only four bytes (sizeof(pointer))
instead of 96 (SCSI_SENSE_BUFFERSIZE). I did not check whether we
actually need to initialize the buffer here, but it's clear that if we
do it, we should use the correct size.

Fixes: de25deb18016 ("[SCSI] use dynamically allocated sense buffer")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/arm/fas216.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/arm/fas216.c b/drivers/scsi/arm/fas216.c
index 24388795ee9a..936e8c735656 100644
--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -2011,7 +2011,7 @@ static void fas216_rq_sns_done(FAS216_Info *info, str=
uct scsi_cmnd *SCpnt,
 		 * have valid data in the sense buffer that could
 		 * confuse the higher levels.
 		 */
-		memset(SCpnt->sense_buffer, 0, sizeof(SCpnt->sense_buffer));
+		memset(SCpnt->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
 //printk("scsi%d.%c: sense buffer: ", info->host->host_no, '0' + SCpnt->de=
vice->id);
 //{ int i; for (i =3D 0; i < 32; i++) printk("%02x ", SCpnt->sense_buffer[=
i]); printk("\n"); }
 	/*
--=20
2.15.1
