Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523235048-2-1533556383192881709
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
    1523235047; b=cGOm+x2ikKv73H6y5M98I0xFXvbH6J2+jZ7x7mmCOW2RHX/odn
    GoF3TZPm4Yu0pegWTIajbB4+fXIjL5gXbQK8XLIwxu5wphcpRxR19CYjseVkenp+
    jG74zuO7OcP7OyGIkMUf71rKYjiPuzU2GfZiTRQ1Ne5gfuVfmROgjLqHJ/TRd6RX
    Ho3nUoMxbPfHab263yTTB4KmDyNdWb/zy+jYSl02oc75UKFqmJXkAUSNW2eSJnqh
    HMqaAkT38x6YhbkAnS8j1Cm3N8V/lYU0fut84wH3UGcc3GXsX5LD4vrO3YUNRgLU
    kSg2MnrMPNFPAkzetQt6WmSLLJhgDiGUUpHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235047; bh=el43ZlnAZB
    EOcsgSjgToq7x1nuap0QM2Zt/fT9IsL4c=; b=YJ+HScrLkigXMYqH4ZEKbqWR7k
    YDGRSQQ0NBT7fa8f1NI067wF5fETyb+L22R9nIv4ru+2pZZrgTq/Ymo6Etm7QGGZ
    rxU/Tey7xe1R+8OcHbMqp/Gt6su82MNaYcv6WDifOkM8ABIiv9Dt0lkO7HQOncqC
    MZNQiX1d7k7/5LY2vP+d2RqIKl6t1pktorBw+E8HRUSk2FZ7vcLCWWQCVijONr4C
    31zCLrvQJ9TXVgDP+k9DsXOSitN0iXReHDBdgpY7HIYzlBCme0eXn7d9LL8If4+J
    bpB0CIWaO4N7lMvgCVrqAXftS+jySIBN8TL1SnpiXP9cNJug26YQjXGKmJkA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OJilx/rs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OJilx/rs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM1T2Es3Z1H3hWBkpyqgD+EMlhMgex4Vn7u/XpPXdVRJ/DkIDAIMM1ZF0ACQUXrBVtQkfd7amWFM6Gcluk6UejdyU3sTbZk4jkiUMp9miIF+kYabguap
    Nf4fmwAjZp5ILIECmCVTSxwtKeYmCvpODiaPrYkeD8/DOplymPtOFALB4mxHEs4vgxZq8MmtPBFo2D4EdE4gqAEnNf0yJz3Iqw0r9qD5Q6H/6NeTJi7id5MS
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=TCZwIYwWp4WjhJQ2Fw4A:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754676AbeDIAuc (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:50:32 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:24363
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933464AbeDIAlc (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:32 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 065/101] ASoC: au1x: Fix timeout tests in
 au1xac97c_ac97_read()
Thread-Topic: [PATCH AUTOSEL for 3.18 065/101] ASoC: au1x: Fix timeout tests
 in au1xac97c_ac97_read()
Thread-Index: AQHTz5t+mpqRjRUVjk+WmvFEj4Rrtg==
Date: Mon, 9 Apr 2018 00:41:27 +0000
Message-ID: <20180409004042.164920-15-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:Tb/fDDJgCg9uJNMs6wFy1HnZZTFA7bf3hnj3M4U+4aRmc2BW0IfA6qcYDvn1wfozENvqaru9Me10lx51tIpPJbb/R3KYjmpNfOmy2MXkvFYDFQjut0iG2bDSPXIGVv3w242XDVl8sN60UHm6mOg3HFc0ummZAZtsWyeGVd2jZKH4VWpD+4aNfdk0ptMIMX9z0IkHvbguLjL9dzfnLjVwOyT1XfTHBoLa9VRIkmb14gmyY5JtwIdxTTG5JhFEoWM1;20:5wBzzCpX8M0idZHHp58AJ+wIv5rR/KZ/TyvMpGOwqgWTCuzBNL3hsi597+koo5l8cVMSvIu+A8d4EpiKJi1HuB2BkkX+JUHj1xwxtBdHOBbGhMg4Ux1Vc45c26hRjYRRbpGWVl8UBxvXYlN5V8mPsqucbQhUNAYor1DFojnQbpY=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a40caaa8-a1d5-4ae0-efac-08d59db2a12e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0901006315C2EE6491122AADFBBF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(59450400001)(99286004)(68736007)(10290500003)(25786009)(86612001)(6116002)(66066001)(97736004)(3846002)(76176011)(6512007)(54906003)(6436002)(4326008)(53936002)(105586002)(110136005)(15760500003)(6486002)(3280700002)(1076002)(107886003)(8676002)(10090500001)(2501003)(81156014)(81166006)(5660300001)(14454004)(186003)(3660700001)(102836004)(7736002)(2906002)(26005)(5250100002)(36756003)(478600001)(446003)(316002)(6506007)(2616005)(106356001)(8936002)(11346002)(22452003)(2900100001)(86362001)(486006)(476003)(305945005)(72206003)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: dnVLWfUtkAunuzUShFRFce41vaV22ascKd/SlVzNMsQdwnHNmn8aQrE2WybadxlpyVkSmKiTCVoUCzdX0A6HaH+O2kYWprCwU+gjbLIqkl5t9cuBcJz50U8+mrFbE5YwHOH/Em5RQYE+yQsKTgGs+UAkep33bsN/D2LyywJfFEhsmTCMlucv7nvoNtWmT/V/19/CqUBqCCfYVclrAa/kvZ6g4mzdXTvzLvisjyz56pzx98MbS69anqCvUzDanIQosZ58/h72xxZWbUt2BJX6EoJI/E8KGbSNeyVcBbpscSjpYBdoX1+zLuvaEdYxJ6fdCOZ0OGMkv0Uz3ILbiJroDXBySSF6SzoU91L2O1KAxtvT4Iv0er5oyno9jTRuFmYyfI6T8XJE6ZGb3MgNXLjPFaUXvkQumwLF7Z/JMa1QXkI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40caaa8-a1d5-4ae0-efac-08d59db2a12e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:27.5334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
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
index c8a2de103c5f..7591e48662bf 100644
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
