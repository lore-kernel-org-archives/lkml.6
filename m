Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520491013-2-6925888218158735837
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
    t=1520491012; b=RGExaKUYfsZSis8G2jnO9pfY3nvykHIE+uaixOD5xGtJ33T
    mW/hB2sQo1ZwRTGM2tqywriDlj6BgzzcLG7fGmnDIW6vFxD2h2rd/5ILTDJTvjhX
    tMe0JB2CUwQSLOrf90Nqhj4C6o0IEf+/0s8Xal06xC4syoWSdLi1KcpbhYZDJIRw
    I7eMpxqqnubPB4JxuTmmEqv9W2/YcmFbO7P+MAJoVrmf2NgFFWzymHHqVDD20j2r
    m2typAHnpJq6T9X3nivXmydBKOmSTMLejvDUFUEbwDp3o/GNxXLKT5Ahb0ER/GE3
    M9No69je6keDwXf79chDLeH/Tb6K9InM69U/z7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491012; bh=dTjFRf
    t2oV9fDKUl6YHdkyp7bFqng/z54R9GvFLOK0U=; b=MHeWmI4vLmRMaCOR9Z7QfR
    Y4syvBwbhigAvRbAu7BBPVhwUB/wYR1eAGiBthPzJ2FK3gifBsdRSaVEXOjzUmZV
    YI/qWxXrrpkh1NdgZZikTtJfURm4oyZZZ/5LNOMHbceGa2g8ft8ytxhVdepn3DxT
    RaJSiopQ8xN3gnvzJrjzF0u4h/2fhojos8wwUtlvkaixy+AlgB0eMyXaNXi+syI5
    lAsOlKuyNALY/0FG/RZuu5e2p4ZL6PnBuIRxwPkzFhXDq50qtDTnRJWOIU7bHEbf
    gyyy6CFjbEKJU8O5qX+dhzVEAkyPT2hfj9td2MiwxB6RM48PA8a5p8Vl4FvMk8Kw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HcXBJ02J x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HcXBJ02J x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965218AbeCHE7r (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:59:47 -0500
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:38384
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964919AbeCHE7q (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:46 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Romain Izard <romain.izard.pro@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 62/67] clk: at91: pmc: Wait for clocks when
 resuming
Thread-Topic: [PATCH AUTOSEL for 4.14 62/67] clk: at91: pmc: Wait for clocks
 when resuming
Thread-Index: AQHTtpoHB+uxbwyEJkG7qLqt1viqcQ==
Date: Thu, 8 Mar 2018 04:57:59 +0000
Message-ID: <20180308045641.7814-62-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;20:BNRIsRYRGRxOozDgFa+1nOFSeUWGIR2rJoy79fkQ4O6dt6863wHVt5OJRRHZFvwngKNd6wnaqUKpJP2v8h0OfULT7BKPXBdOcT/DU5/Gmk6HGqFr/L6WBPw8Ub5pZN0CcGqG8xMAMaI1hbYF4g0j59em42arRWzHlltGkABUru8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7fa12fc8-e502-41cf-5f03-08d584b16883
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920ED8229D87ACD7B9ADC3CFBDF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(189003)(199004)(81156014)(81166006)(5250100002)(8936002)(54906003)(2501003)(305945005)(8676002)(107886003)(110136005)(97736004)(99286004)(6436002)(36756003)(316002)(72206003)(76176011)(14454004)(6486002)(7736002)(478600001)(10290500003)(186003)(22452003)(59450400001)(68736007)(105586002)(2950100002)(106356001)(102836004)(26005)(6506007)(86362001)(3660700001)(5660300001)(2906002)(10090500001)(1076002)(25786009)(2900100001)(53936002)(39060400002)(4326008)(66066001)(6512007)(6666003)(6116002)(3280700002)(3846002)(86612001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Vc04Yn0IrVUISTSd6ryiUV6xupo3ltyjhnHRDm4phWwZ45aZ9mk+q1F7LtZySq7S221akQOi7I+Hcx2bYqA1X0UUbs5p7Zkagi3cS7XhYhINBttx04HeeXcwYAwhSYoqnfR1FLO/3aiZxTFPRqUqVbVdGpgSV1u9zGnQQXvMF2YO7VB0EPhIsueA/fvUmhLBSaV598CpE34jcv4JOZ/4rSRTfBRBYUC0zRpg412h0HRqqZMlk+//SLFW6isfVZ2xmeMrcXSnFFAQJa7zUrrHd2tMqrHmrMPEtmxZAvAu06K8G2z4q44y2PblkwdjlQLyJ6z+sxU33JkuHnV2sbQtMg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa12fc8-e502-41cf-5f03-08d584b16883
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:59.6725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Romain Izard <romain.izard.pro@gmail.com>

[ Upstream commit 960e1c4d93be86d3b118fe22d4edc69e401b28b5 ]

Wait for the syncronization of all clocks when resuming, not only the
UPLL clock. Do not use regmap_read_poll_timeout, as it will call BUG()
when interrupts are masked, which is the case in here.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/at91/pmc.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 775af473fe11..5c2b26de303e 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -107,10 +107,20 @@ static int pmc_suspend(void)
 	return 0;
 }
=20
+static bool pmc_ready(unsigned int mask)
+{
+	unsigned int status;
+
+	regmap_read(pmcreg, AT91_PMC_SR, &status);
+
+	return ((status & mask) =3D=3D mask) ? 1 : 0;
+}
+
 static void pmc_resume(void)
 {
-	int i, ret =3D 0;
+	int i;
 	u32 tmp;
+	u32 mask =3D AT91_PMC_MCKRDY | AT91_PMC_LOCKA;
=20
 	regmap_read(pmcreg, AT91_PMC_MCKR, &tmp);
 	if (pmc_cache.mckr !=3D tmp)
@@ -134,13 +144,11 @@ static void pmc_resume(void)
 			     AT91_PMC_PCR_CMD);
 	}
=20
-	if (pmc_cache.uckr & AT91_PMC_UPLLEN) {
-		ret =3D regmap_read_poll_timeout(pmcreg, AT91_PMC_SR, tmp,
-					       !(tmp & AT91_PMC_LOCKU),
-					       10, 5000);
-		if (ret)
-			pr_crit("USB PLL didn't lock when resuming\n");
-	}
+	if (pmc_cache.uckr & AT91_PMC_UPLLEN)
+		mask |=3D AT91_PMC_LOCKU;
+
+	while (!pmc_ready(mask))
+		cpu_relax();
 }
=20
 static struct syscore_ops pmc_syscore_ops =3D {
--=20
2.14.1
