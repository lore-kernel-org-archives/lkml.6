Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236690-2-4497134637360095845
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
    1523236689; b=T+NLuDFbp7YupeccN+iGVl3JTA/95/Up1O0HGk5Hkrx1TOSsAW
    +fWquViMcqHfwvIloySbrMySZgXS0VYHHJpWMu99mWgpb3QVWGVdsJDA0vcPovNV
    EggWnuVCQuSO/zB+LbhD2ypbjGH7iZI4o9LO+y99qDzdK2x4nhK/Ux7zjO+DUufW
    VKFapgVB5ogiXFuo01GBezDQ1XE6FO1yWzTrfn4EFfSShE09f90r37MxpxTv3nCF
    bS3DMAhPHr1N45lc6iZ2BDWs2ENcPH3UaTSzud4huBoXgKw4jkArIxT2nOUgB1HP
    /JPvOAXjKhp9Mst5PMgksN/ApHRFtwSMAUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236689; bh=pTTMAMSl2o
    wG853ZhpPBT6lVxrcyzBBsiEWRcfJwQTQ=; b=XI/6uMXyZ/L25VV8Yv+CepqO1K
    Ny6jb7onRLQiiK2vDTqKy8mmAVZ1GzXioR3i1+dUnXrxP4zx7f9GJ6QHKQM/pssH
    azEJnwJKrVvlOTqs/xNxZwZsxiagovLTRJmNBTm/oiSNqJo9SdclKHGZW+o3Wc1l
    vYfTf7YG/LNr511e5S9Drw8qLEb9dWgTV3tMNt+Rw3m/uXPvI2Cj+GCvzsMWt8u6
    R/FyOLNmKx/xjin8unW2MJf+X0uZ4aSnA55b4Cd1N/asJbEoGdcPKx9IVqMg2vFy
    3Gan74dz4Eavw5JH/3kTjayFVeCHvdhup7hAKdo3wbdYxHXSxTwhIcEDGO1g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GE8rJ5BU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GE8rJ5BU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCgPYUlCxATFPsq7WykUT+Q/b9HoheDJ+QUFHtWkQIYGHDzytwbLVBXmARsfNWn21Pcv0vyVUL5cSPuS4XaLQfSFhBtVMup1J2Dhc1aZ1tdWVAQDYq1r
    n7WfyxmT5Zm7QLM2Cy0jsDPFX4EKYmNnRbfA0iTTrEbuA8zwp6Df8F6eAdMi0PXg7HMYZx9s4XvHLS2bPj/xO7agoaVjsWnmUC0WqgsHfH0Z3qaYQ+g2mku8
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=xjQjg--fAAAA:8 a=HH5vDtPzAAAA:8 a=U7UbAiMzAAAA:8
    a=hD80L64hAAAA:8 a=yMhMjlubAAAA:8 a=mX7iJj9eJ85zrJ8fbVoA:9 a=wPNLvfGTeEIA:10
    a=L4vkcYpMSA5nFlNZ2tk3:22 a=QM_-zKB-Ew0MsOlNKMB5:22 a=cNtvukwP7kaFzDVqf0Q5:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756501AbeDIBRv (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:17:51 -0400
Received: from mail-bl2nam02on0103.outbound.protection.outlook.com ([104.47.38.103]:27456
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932846AbeDIAhu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:37:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Alan Hourihane <alanh@fairlite.demon.co.uk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 104/162] vmlfb: Fix error handling in
 cr_pll_init()
Thread-Topic: [PATCH AUTOSEL for 4.4 104/162] vmlfb: Fix error handling in
 cr_pll_init()
Thread-Index: AQHTz5nDM8uPJCEcSUWSHf3KSrrZWg==
Date: Mon, 9 Apr 2018 00:29:03 +0000
Message-ID: <20180409002738.163941-104-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:dHXZyCO1rkJEzrjSky5pyncMG912KcyRVGFObPikCePPBe0AkFLh5UlAL7BwBo/n7OI7C4LLlXRDb5VCHxUekTJns53JKT62ioOrK/BZXejqbxf7ZSZEx3vmG7Y/uMCNk6oYLIfuDG117XM1F0jVG89OLhPnDP3EnV4/Xhus9mV91XdSnLmwHQUTpA9oDujtGywtFwnXYAzXr732u3Kx2KIJZBzP8zyaQ1h1k4PK357frMTI5e7bAAo4hUFdlAW4;20:htkzK2vPAXT5llQye6v4x2W8u1cH2zDAnkN4SOgOmOfhuwfqtc4NLAkMduCnuys3I345eCg0ZF77/glzX3K79d0rcCw26Of+M0ZLCCcJzaral9L4J9bh4hYCxuTyjRtDgFozYE3zgcQYFVPGMnRKMEacY18URQ4RSX/3fm1gy0g=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8fd08ce7-e39d-418e-b23e-08d59db21d5a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1110C566E2A095F2E82D90F6FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(199004)(189003)(53936002)(186003)(5250100002)(105586002)(11346002)(99286004)(476003)(66066001)(6512007)(86362001)(575784001)(3660700001)(4477795004)(1076002)(54906003)(68736007)(110136005)(3280700002)(316002)(305945005)(4326008)(107886003)(22452003)(14454004)(7736002)(446003)(6666003)(2501003)(10290500003)(3846002)(6116002)(72206003)(106356001)(25786009)(6486002)(6436002)(8936002)(478600001)(5660300001)(86612001)(8676002)(81156014)(59450400001)(2906002)(102836004)(81166006)(6506007)(2900100001)(76176011)(2616005)(486006)(26005)(36756003)(10090500001)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: rhFokO3LlUYiaaIDDUuXnlgM8pzv2E0FrGNmKaHBfa8YD9HYo0iOoB8hVuNKEvNb0KcbEpQnj0Y0eYhbYPahDBGAFQfoWdozmKPsla+c2H93Px820ocIIFxwbwbW3WSMcXSErNQeu8GV5YwciDwq7YJotv4jRaq1ZzAeA7LfOmi103RPVwgvNau1YjFA36bHDQr0qIAPyMX/a7Upc9+l2+TgF5wUixhi4873+svyKRpvTmo3Sg8yzLAXUvdPZOczMWRpRNHp7cuSv0xIWSP38l1wtEaJDpjaV9ZFaxEnZod1SrNu1rC66g3q9qKnGsuGcjbt25rtZ2gp/VDYtlwUve19FRSF8a2zOK8JSttSGVyPuo6u3OezD18rijgi4J35++kJHrKN5rzSUcFBiX86NUt6Rr1ESGePoSP6s4pIVAE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd08ce7-e39d-418e-b23e-08d59db21d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:03.6148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

[ Upstream commit 6af574e826740bf17663b48ba3f8fadb81d2113f ]

There is an error path, where iomemory is left mapped.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Alan Hourihane <alanh@fairlite.demon.co.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/vermilion/cr_pll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/vermilion/cr_pll.c b/drivers/video/fbdev/v=
ermilion/cr_pll.c
index ebc6e6e0dd0f..ba105c876bed 100644
--- a/drivers/video/fbdev/vermilion/cr_pll.c
+++ b/drivers/video/fbdev/vermilion/cr_pll.c
@@ -185,6 +185,7 @@ static int __init cr_pll_init(void)
 	if (err) {
 		printk(KERN_ERR
 		       "Carillo Ranch failed to initialize vml_sys.\n");
+		iounmap(mch_regs_base);
 		pci_dev_put(mch_dev);
 		return err;
 	}
--=20
2.15.1
