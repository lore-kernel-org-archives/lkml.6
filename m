Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233022-2-4861369244662726091
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233021; b=SptgE2c4TKFdWub+f1JAzgxZ3/Yiw0cTgsIbPlNKqM4uY5MsG+
    2dKklo0wsKYIhB8av6tU7hg4jMXK4ygga36XnW0Y9MY86kslLfgpukQzwrt/ovBi
    3Xvru0jb12JfYsDx6dFfZmSu1mD+RpqcZBkYHO8PTNJdPNTLZfSUceVz3kYxgm/1
    q/sZHPVgkYmmwwMH1IokHPEuICY/j6dHcCDfSATaz3qx/XvFPcmSEFrY2xJTjPGP
    yilHlhsIYSMyD2g7DulOH8kG2MwOq3nDmvrxcLuS85gz2gpiFXGiXXskRIQl/naC
    hLPPzoeLDhmvm2eYqKGsES5puTpP+fT0QkBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233021; bh=c8+/r+pD+9
    a5kiQbSCvrJ+H/zMVyve8q4gS9Jy4WSvE=; b=JboBlfAaNdt7cvyAykx8TYkPBD
    S47/35bIxcIPFsE8nyvHjFqnRZ7LFm6MW+qI00KCKVzrPGZAsyTz2valFLY4u38v
    fm4KDZ/2O9vsMUPeP4ZODGOzBwlhn6bqTOCGlUgnsCxvvAqHYYu87Ob9y3I2hJHt
    2EQezPjLxc/jPBph6SiKuPGup+GCWJwFk36ZbMOGp3JTizvrbwqgdsG6yRmqIlTL
    rIMJJq/Al2U8l02F55PSdJirR2syslMUPNAwn0x+XsBd4eL0NBJYPLrr8W5Z0z0q
    dtImNdq3soUEWq7TuYLmIwOW3AGMIjpb6L2qV6cW9h7pgV2vvV8AY7PWgIng==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wd8twYXv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wd8twYXv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDC6VdY1Opyf3EOjbhoFzhBv5CSQ4Wcz9jrYTQa+pUgGxfROWygDD61c7fmV54+ThQRzC3IFPTFClClSmqXOBQBOVPOrVRqNVlALWvDNmTTe3vOhNNer
    Jacv5A8qGYuxU7z6t1ZRVHEnYMXF3y9NQIpywb+GiELmVX82diVrZmqsOCtIPQHyqAVjUopJiMsBaKejVjMt8NQr6R8m924lCvplOT0iEJVxbuUgV5dOUAPx
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=TCZwIYwWp4WjhJQ2Fw4A:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeDIAQ6 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:16:58 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com ([104.47.37.97]:28800
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752892AbeDIAQy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:16:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 009/189] ASoC: au1x: Fix timeout tests in
 au1xac97c_ac97_read()
Thread-Topic: [PATCH AUTOSEL for 4.15 009/189] ASoC: au1x: Fix timeout tests
 in au1xac97c_ac97_read()
Thread-Index: AQHTz5gO6i1Cb24CYEGrczrMbRT3qw==
Date: Mon, 9 Apr 2018 00:16:50 +0000
Message-ID: <20180409001637.162453-9-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0968;7:k7Bt9o67KnwgGkAoRanz7ZSJZz5TUuYss4/o06b8SsZ8wF+SX8eNzOBjO4G9KpjNIGWn6we6R91pOstbaBfoKMy1dV9urkjKW7ITsqMPhKKTd1NtwS6PtwC77d+xyQdeXLVz1p1YYayDsWPqXHLFrjXJUIm7Mue06g7nq3263KNcOgQJbetLzRx80OB6AxjkmUWJevi+1U0ggsQntQHoQIy4eRSFKTOnwftuFFNKSy+AtgCmipBA4WWjFU/HmEFE;20:C8KxrdLSJIxScedxj/O6Ht3PKhiWc1gY4wLobrFFwlmcsRdByk0PAXBrBlWSnYN+nLKkoKas7ulW2xrCKYRE4rnkwORdkewhTUqivNDQa7dl6fsPXT2jbJDy8+s9kyRWglDjZFX4fY9ZJcwUrAxk+xHeFTv30YDlwLAfD1zc/Vc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: d45a56b6-f674-409b-ba11-08d59daf30fc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0968;
x-ms-traffictypediagnostic: DM5PR2101MB0968:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0968D488720AB4A10F0D3703FBBF0@DM5PR2101MB0968.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0968;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0968;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(39380400002)(396003)(189003)(199004)(6486002)(53936002)(107886003)(81156014)(36756003)(10290500003)(6436002)(81166006)(5660300001)(478600001)(8936002)(8676002)(6512007)(106356001)(105586002)(5250100002)(2900100001)(7736002)(305945005)(2501003)(10090500001)(66066001)(25786009)(15760500003)(476003)(3846002)(6116002)(186003)(2616005)(59450400001)(68736007)(6506007)(486006)(14454004)(86362001)(99286004)(26005)(102836004)(22452003)(76176011)(11346002)(2906002)(316002)(3660700001)(110136005)(97736004)(86612001)(3280700002)(1076002)(4326008)(446003)(54906003)(72206003)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0968;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: TH+rCNbE3lRE+n6IwRK9TfDtO1g1pPqeLMKbSQ+agSFE/0UEtS5AXFci82sv/xxDowzwkDjCgtCYsFUUYr4qmZTtynf/vxbP0Ek0W9EhASjQr7MEfQbSyXUJKMDXRhySvoSE1quI9Xqg/IXZV98aqYXoWwtIMpXY0imFphNuCLVXy/P8Wm5nNPbJ3imZvtDB4axTLCc7w3saFSsA3doqR9rQNGW2PUvkR7rCNFvvpubjNuunM/LW7chKDmOIEygby2T/RlwaVez3wjvlEISJBCynEBQP83UlW4khTQgdK1womUHhzK4JcnyKW05wW4A/4xm89qkCkjo9mDzb5owGp+YVgh9z6LEAbqHFDOIP3SIkyLD6Jiqa/PLkCawMwe1y+/JKOfiBUovj+Fd2b7OT59XMkTWd9S3tcWwz7oGSv4A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d45a56b6-f674-409b-ba11-08d59daf30fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:16:50.7781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0968
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
