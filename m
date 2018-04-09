Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523244623-2-7648970554236371321
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
    1523244622; b=aXw7qUPvbpb3yPFp1MjHfTNAVycffy0PwdzSR29arFVddGR8fL
    p6C7DDr7pBruzAqr9US5vD5jkYkH6fjCPkG6mNgFjFjMm9DZA4vwnJjxm3qPEOj7
    B0U0nFTf+nSHRzBlm9uMWs+pkihf1ZsbTaAO5BP4EOo1kknuTXELzy/+BtqWJMwd
    NMVRqCoidOQXO4483J22uDovYqGpl2vegNpuTasO4wa45JN5GZiWXpRQ0AaCmaqR
    6vGzDUqcRFNPtMd7GzfjmMmBIHtQ6/6Jd9FokXzc7JGJVPYlnsAdu+5+6YDx0SL/
    FQEAppQhIIyhxUruCFt9mD1KmB1AlU6PNwWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244622; bh=c8+/r+pD+9
    a5kiQbSCvrJ+H/zMVyve8q4gS9Jy4WSvE=; b=ktIPbNE4bvNdkHKMWHvk4nIYo7
    dw+qjODIFdPARVd3Eyt0qaHr+OkYUEOiwOWOxoTLoJSWRBmCsyCerwcSqCi3asxc
    El3mJbsOD03yCmc0REOvUEqYCsZ8HmYSSH0i3CskBAvz0RXQv1HgsNhO/GKl0ZZz
    TOErluPycWWZc058KiUs0ikMrykcSOxwYG0SQBLGz6O33NxN1ebfx2jVJlOmFlrn
    rG/AaXD5jgWTX7bkeRaClUK8BiFKLQowSQV/47EoQzEpUUCzkOM/ftfdfwd1d37+
    57UEFtk1pAmqkWiXkgkqfwYo64NuUkS7QOOytPiK4oqKu32vGUGApfOu2Zqw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mh3t6/iS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mh3t6/iS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHuqadvQTwYwZZCAQEuaG2p+yzvEM22+gSd3ditq60Y5iC763kRLJ2U7sEYdyGffYbSMYUTIhZ7HAY3/VEtzZ2orguZ+++UxLaEsBl36X4PNO2K4r35m
    NdvdSPe0C2PhywsWjLSHUXwolRHF3WFioXGBzfWtARsZs88r/m+sszWhv3B+jZ77DhnJi4Y5Iqgs1NGP4nBr/ZHt/UqrMnastS8oPZDkh5+NRpf6AjMImkHn
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=TCZwIYwWp4WjhJQ2Fw4A:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbeDIDaF (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:30:05 -0400
Received: from mail-sn1nam02on0111.outbound.protection.outlook.com ([104.47.36.111]:52845
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754579AbeDIAWC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 006/161] ASoC: au1x: Fix timeout tests in
 au1xac97c_ac97_read()
Thread-Topic: [PATCH AUTOSEL for 4.14 006/161] ASoC: au1x: Fix timeout tests
 in au1xac97c_ac97_read()
Thread-Index: AQHTz5h2orrgkd2P5UyDrM9wtSUTlw==
Date: Mon, 9 Apr 2018 00:19:45 +0000
Message-ID: <20180409001936.162706-6-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;7:7yTLLlFj+hSrlizKQa7V9ORVIN4HttxFyN1InGjYGUH0wlqNbZVkLenq3wsRDW56/yriz0rtnY60SEhilEn9+l8l5zSdDgX+tD0pdWiJFiYAWO28gKdZP8B12f9Oyl6oRFxJ92RKxH96fSQD0Mb3RWpKNiPg4fo6bzEYr6n0Y8TyhvtQhC+3LLdP2ojwlOu6Xb/qgQS3paE1ZDOaeAIyfUcmdBluIrDvKkMiKotvkhSuqty6AhwMbvmYPhBaNxxu;20:+ez7ts1z1M/fQkHms7amRWoyqFQIEiCkFv+YVSr/VCzNmkxdugvC1hP3otHBNzWHAl9KS5JB5Qr56TBJnQHm3oS9BUSf11+x4kUTEOgW3H2bfzLM92g0NZ94UkS4v85dKPxwyC4rxlkEoMC84FPdGLdQViBR4WNY8JfGmBT6FlI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 79d6d78c-2ecb-4ea6-296f-08d59dafe77e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0936590DAF4E981B6A961C9DFBBF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(396003)(376002)(366004)(199004)(189003)(3660700001)(36756003)(2501003)(76176011)(10290500003)(2616005)(5250100002)(3280700002)(478600001)(1076002)(72206003)(6436002)(53936002)(486006)(476003)(4326008)(6486002)(107886003)(5660300001)(54906003)(110136005)(102836004)(2906002)(6116002)(3846002)(86612001)(81156014)(81166006)(6666003)(8936002)(305945005)(8676002)(2900100001)(6506007)(68736007)(14454004)(106356001)(105586002)(25786009)(6512007)(86362001)(99286004)(446003)(59450400001)(10090500001)(11346002)(316002)(26005)(7736002)(66066001)(186003)(15760500003)(22452003)(97736004)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: YG8g8kEmxnkKjFukhpzKAJlI3IcEOMarSZ/ZBcvZprSvxxmQJ99otazFmrM/VVeB8XbU/tKdKQJ0dUbEfxFfWeLPW/8vpvcFYTgMXy6WkQ6nutLpkl5WsoVk0TJApJ2KS96cVkjp26+kVdc3FxM7Q/GJ+sqRYE006OftupR1EHiT0REeet23Mzar9SRp6LRRnasuBEu4P01a6Qh/V1rc3uqsf0AyQp/6qkpuhXWwFIhbuyTlXqpGsEXAxX7g2NHnyUh7Lxmuyp/nE0XAalMn7pWH+50kDAQM+BvwN/cGKEZisjMSBPLV9zARnirI7Jo6Vzj46aPIFhDSXQkSKelA0V29Vz08xs4EQV7SojqQfYAbwGNzmXgXzGWBAvN6bjlxZUhQ6L/JpbvOAToK13FFS1T/H2IYhbZ0HDicxrQ2cxU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d6d78c-2ecb-4ea6-296f-08d59dafe77e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:45.8952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 123af9043e93cb6f235207d260d50f832cdb5439 ]

The loop timeout doesn't work because it's a post op and ends with "tmo"
set to -1.  I changed it from a post-op to a pre-op and I changed the
initial the starting value from 5 to 6 so we still iterate 5 times.  I
left the other as it was because it's a large number.

Fixes: b3c70c9ea62a ("ASoC: Alchemy AC97C/I2SC audio support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/soc/au1x/ac97c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/au1x/ac97c.c b/sound/soc/au1x/ac97c.c
index 29a97d52e8ad..66d6c52e7761 100644
--- a/sound/soc/au1x/ac97c.c
+++ b/sound/soc/au1x/ac97c.c
@@ -91,8 +91,8 @@ static unsigned short au1xac97c_ac97_read(struct snd_ac97=
 *ac97,
 	do {
 		mutex_lock(&ctx->lock);
=20
-		tmo =3D 5;
-		while ((RD(ctx, AC97_STATUS) & STAT_CP) && tmo--)
+		tmo =3D 6;
+		while ((RD(ctx, AC97_STATUS) & STAT_CP) && --tmo)
 			udelay(21);	/* wait an ac97 frame time */
 		if (!tmo) {
 			pr_debug("ac97rd timeout #1\n");
@@ -105,7 +105,7 @@ static unsigned short au1xac97c_ac97_read(struct snd_ac=
97 *ac97,
 		 * poll, Forrest, poll...
 		 */
 		tmo =3D 0x10000;
-		while ((RD(ctx, AC97_STATUS) & STAT_CP) && tmo--)
+		while ((RD(ctx, AC97_STATUS) & STAT_CP) && --tmo)
 			asm volatile ("nop");
 		data =3D RD(ctx, AC97_CMDRESP);
=20
--=20
2.15.1
