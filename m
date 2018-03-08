Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1171329-1520492134-2-13265046701474248675
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
    t=1520492133; b=GXKioAj//vqn2bUNM1W82V3n4PCS6v0F0KINw463WeEejLe
    FTSGahbCfpnxsfp5t4AUyTf4zkzQomdv53cgLy/me23DMPQytndH1s92ucYcfk/y
    4Hv/yRQV5BYLugeIWqNS6vLkFlnGvTNYGkr0HpuB0+OBYLtTqPUqJGoEg5UPw5Zy
    SvpbBzDrs8VUlGHPt2d3DYaH83vXW4JEyQGYBuGKY+mSNd8DPh4gwnmxJNHvqyPh
    5nQgLPPtP5+Nu0SwScL32oFVSMS+iCFPscxUQTOMsR1fSC/UurJVAXP/R4upbs47
    sbbYM44ancy5uPA3TrYyEqqZLTC/R8nNg1JhflA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492133; bh=dTjFRf
    t2oV9fDKUl6YHdkyp7bFqng/z54R9GvFLOK0U=; b=n6/JhzH+nU/F3swftP3xEe
    hH0MDnRtoQIv0NmK0oR0OPR5jc/vxuvdvhh3pbIe6pXIdxMWHh5hDjix1FpyW6tz
    XxllbLM1/Mzn07mBEcYLTAt/Ik9EhgZooXq+768l1H4n3r1TTpqnlsYmAKiAklmO
    mepu4CuCrxnd2c8boerHGncHOc32MEBoI2Kd/e3ONme1AAcSzfS+zNpXmJ3o6C9y
    dxEG11879wbP9YtABxl/60fGZAylixRMzDDuTuduVQz4ZTzCoau+Lntp4+29uVhq
    LqczTmEXU/tkSfHOvKzpv3QLZbVycDMpCgp2guGgHwKRgwDCMvEJFkqbL4Kl6gcA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IqOnvTun x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IqOnvTun x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935202AbeCHE6C (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:58:02 -0500
Received: from mail-sn1nam02on0119.outbound.protection.outlook.com ([104.47.36.119]:48736
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935168AbeCHE6A (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Romain Izard <romain.izard.pro@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 72/78] clk: at91: pmc: Wait for clocks when
 resuming
Thread-Topic: [PATCH AUTOSEL for 4.15 72/78] clk: at91: pmc: Wait for clocks
 when resuming
Thread-Index: AQHTtpnUDEBhzrbYnkeok28Intz2xg==
Date: Thu, 8 Mar 2018 04:56:33 +0000
Message-ID: <20180308045525.7662-72-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0936;20:pVmohS2497qs8hh4tJvEVXQ3RCscVIpcy25Nfgm90pfmCyTFUfNzjB/sWMUoCNPasCLPqive3MTA3eBBOsYA23SOWH/Sz6ZE/bI5e093Mgo9QSWFufPpcX3KmHEy2eSnc2M9+V8FrCjR4rxLvcOPtLRq6oZ8ms+fBtc6mcFhtH8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6a3f8597-f9e3-4519-9329-08d584b129c2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0936;
x-ms-traffictypediagnostic: DM5PR2101MB0936:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB093682E9EE7F0F5A529C47AAFBDF0@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0936;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0936;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(346002)(376002)(199004)(189003)(478600001)(99286004)(6506007)(59450400001)(3660700001)(36756003)(86362001)(54906003)(6116002)(110136005)(2950100002)(102836004)(1076002)(3846002)(6486002)(3280700002)(39060400002)(10090500001)(10290500003)(305945005)(72206003)(6436002)(6666003)(26005)(5250100002)(2906002)(186003)(2501003)(105586002)(76176011)(66066001)(7736002)(68736007)(25786009)(6512007)(106356001)(86612001)(8936002)(107886003)(81166006)(2900100001)(5660300001)(4326008)(81156014)(53936002)(14454004)(97736004)(316002)(22452003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0936;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: gkl1hP+Qh1nD8RAz1Cr1TdJdi+nh2+iB//IckV/MGxsuuPcdCmibNY1vyyVR68MEI2yEJytNBUtGMiajv3uFb1g3/lP3181Q9FvoYAVXIvrBqEB15wRK2vxQjMe+TcxhaYJ4GaRkHsBQDTBeBtY4B5A53w/YnbDOkEnmdfAI/4y/ON+xdC4zpeu6RGXWgs19ZRQ1/QLotU/25WexgTMT2hnWXEItn6uhDMqG79QeT1M1cD4o/bSDJuFwh4vpFqi5KJBWvc0Cb1Q/cCZsUU8XtNTwZtYigmPWU9K+mdEkG5REY1icGLnWHqBb4V0ZzTPk9svlft9Aaha1lDZxepsSUw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3f8597-f9e3-4519-9329-08d584b129c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:33.3872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
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
