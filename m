Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239128-2-12228972918699428259
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
    1523239127; b=Ubw5cvJ1wbPe22nyPBilTSWbhjiHP7l0NbOn3UG6Mk+BlPoAOu
    8sxLRQKahU164ROz9ky+nMs+Wtk6k6cz7ZETjJTo6Bx6omY52l3ehlnZ/f6WnXgl
    0YloqJBP4P55nKRbKXYPyHUoeM3MbJ79cGLN9QjeK+lLDmgumqxRGfjwhO/qh23d
    gpZUlg2u3flwpv9ulXGEA3b/EbVomR+ynLqyeOfWoYAtfhRs+oeCt1muVOydMHw/
    q1mMFNDJ3ZGoBLUdrWxh3IZ7nuFc9duBY9URxK8PYNmeiy5uTRkSemWT21Up5KGB
    JFcCzO2DN2cFQII1t6GqEacOvKs9gJ0s5BpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239127; bh=c8+/r+pD+9
    a5kiQbSCvrJ+H/zMVyve8q4gS9Jy4WSvE=; b=NFD2Rv8/GFQeif2M3Jdco+pjGg
    FDHY3h5PLF3b3xwJuXzzgMu1yadBebolEifEWpk+izmldVhD6CpkVJNkSW9xUfhE
    A+L9XUSjldqrynQ5UItA37I/nLg5bdfOYQ8mCqlRtHxLF4cWjf1oP+4g8cVOAIv+
    xN+fp6C8RzKE0zqx83tGC6Peew1YFOSpq5ODncMLErz/G6PeFv3RhXV3LET++nuU
    8bPg1xb3CwVHMQS8UooffIDOnkuzE5naoXNSmSc9b/PCeD3PxvBTDFBRRRfXFeWH
    PxpkuJvy3E5xTC/qeIBtHwD4zzejOft8yig86tZDyPh3anYdrzM/Vh7hG4Mw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WGW4kGLY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=WGW4kGLY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLvF/kaP9vtw+aF32f/M9WnClSebTk7H2Tj7cjIoNSyUXXHUOXrv3H6QLriVa66UbU4sV8UjWf1b/GLUwGNLe0jaWTZa5as3mMslIOaZXx2AQlQeUPM2
    /K8CCkrS48nf8QPZvjY4BnB3XQ1e3NopuDZUITaRAT4QgsUcP0iISUuispHuKm37h4c5Q6mkY5z8h6grrlWYhhpkMwc3ZAiAIsI0nTYi/hz6P7QVgKenJDLi
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=TCZwIYwWp4WjhJQ2Fw4A:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757388AbeDIB6n (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:58:43 -0400
Received: from mail-by2nam01on0107.outbound.protection.outlook.com ([104.47.34.107]:56905
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756493AbeDIAcs (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 214/293] ASoC: au1x: Fix timeout tests in
 au1xac97c_ac97_read()
Thread-Topic: [PATCH AUTOSEL for 4.9 214/293] ASoC: au1x: Fix timeout tests in
 au1xac97c_ac97_read()
Thread-Index: AQHTz5lK8DPN/1kHCEahPKfiCXOVoA==
Date: Mon, 9 Apr 2018 00:25:41 +0000
Message-ID: <20180409002239.163177-214-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:Xh9HWE+ljP+k0pnx6LS87TuhpcZa0RFYWmUhQOLQgytMalPhhRLTuWEw7LW66SdycVc6ar0R6Cbq0FzTmhVm+HmzArfgdJjVEMFepkFVjJpkEVKuheEQJYrdc6Hk9HTy9nSU74scxQ12l8k3k6377RDSWBT95pHfGfcY1zbk2tyhL/S4KteHojNYVqpQuwk1vDU7diae85nhqiDRWg1sTU9EEZ+n8jgoiJLBXVV439hwiNn7rOUtcU1eHWAyHoUP;20:ijdSBI1yIWP6jDMvKC8TiCilqZCgYl5G1Khg3GeXK/2+lwplAokxGlPBXC40UrBpH1KpAUPrOE2+vtaEPXG4zeLhR2X2N25w9UvkvTT3j0sh3s3/iQOkiPN4uPQOizFpIYzMPkNU9PXWlfjr1AF6rV6Erd6Iyz1B29OHrnC5Wh8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: bfbaef20-db72-4b79-62ac-08d59db16ad0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080675723D52AB2759EE50E7FBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(15760500003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(86362001)(14454004)(72206003)(8936002)(106356001)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Pdg/mOQ2Azzd5QAXRuPdRsvQlSDfvrE+st6OMRP7XDLLeLuYyNC+hMsEDJmEKtDXvB7hWawtUEAaCYagP+BVGRRHr0jyoDJJ0FE4EiShYHqv6rJj/SbHIxe8zyNUVAsrlIvdG0DErA5rLWoNqANyeXlvPbVSaAXjbjqf0UFdlNqkA4SISf0+4VUMe6aY9NAuQUvOv7C6YjOJmD6y/WNMbSsneV8LtfSjQhs8NhgvkMGVT4sOZwDyn3qmTMUhmEqJeSSPaNr2yFSh2MAFMqT0c99JavYSQAOTGRB/YKrjTMPC+hPsSIaKmE54G4Aw3X7D6mXgqAQQCdv5KWFvlFm0bT7eh0PRNMweAdv5sRiO4FRfUnuk9Ahcrmcs6hJupZa2Mp/okvLT8e++JR31GO6IQTO7w/6X/bHRi4403zeaviI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbaef20-db72-4b79-62ac-08d59db16ad0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:41.3316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
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
