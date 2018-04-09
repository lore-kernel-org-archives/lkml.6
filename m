Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523235078-2-5829015409802143178
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
    1523235077; b=G3VOEWl6vh/gxIfwNg74568dxeIhAPX4KzXvQ5lLRwBBVaxmWS
    MzLWTch/aLJCNOHLMibkjP6RB+QsPboLLMfbl/D3ucZiervnyuwY8DB0HFb0WFqb
    J9FnSpLukC6OYoxohlYNpqncRk/La3vIC2qZ/W+ZhbJE/dHcxOON6V1rcVOlDViS
    Wrqbbtg1EigS7w5u0TTUlO2lN6i1yYMSLEShsZffLCd8/nmTF/e9r4MTz8gJ9KOW
    TDn3nN/uwzayZz7MneDRjYx3zAFtL3DmZ6ftJEHnWwzR8smBuXciww59ypCmu8Ae
    oUZDh9belebHvEiOUnXSD7zvel9HuO9VzvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235077; bh=pTTMAMSl2o
    wG853ZhpPBT6lVxrcyzBBsiEWRcfJwQTQ=; b=iiI+KdPZWn3PnmTjZgkPOI6nTT
    tUuq4Dt84FOgwtr7u+DE/SfxJk0EnNYqplpzMfRVbcqodq+7138e3z75gfvsFku5
    zEQrumigYOed3Yun6l/VqvxeJlRezUctiSvhOTV0bCeBOFFL0u96hOLKuNa3a03L
    9fuMl3BmFUOLzS2bnpZbkV7cwVRc4CZcPRfh8Mm+89lFlgnE/Dlt9nN6tkn/Jn/b
    WqZPIqs0tS1Ay48HmKsyn3HWyROmBWsQIp6t5znFSx/IijOMCz9EfwjI2530BPFa
    aLR8dBIIoejjnWA1FZa/4utRuWAH2oCUaZMwsG3EG5G8H5VTA/tSZ2W26Uww==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ATmRhKvZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ATmRhKvZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIBgub2NEvpUX9bh8+Bsy9iW11j72GbAPE8eZAYrZLshq2jW4wNdUJzGHoot8kMNbGofbW4BhS4C2vz3XW6sKs+/F1Gz8wam9HHuUluyjziwTr0+5Ali
    cgMte06hjhYE6J/0t1rzjQy1bgB2fH2wuYQQOjCeKtI+CrYeGSJ/BNYBYcTJw/b9ZZR9RITMovu+kfDiL7MD1nRw3emEs8kDCQKMo0vcqR3ZdUgm9kXgYELu
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=xjQjg--fAAAA:8 a=HH5vDtPzAAAA:8 a=U7UbAiMzAAAA:8
    a=hD80L64hAAAA:8 a=yMhMjlubAAAA:8 a=mX7iJj9eJ85zrJ8fbVoA:9 a=wPNLvfGTeEIA:10
    a=L4vkcYpMSA5nFlNZ2tk3:22 a=QM_-zKB-Ew0MsOlNKMB5:22 a=cNtvukwP7kaFzDVqf0Q5:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933341AbeDIAvO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:51:14 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:24363
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933414AbeDIAla (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:41:30 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Alan Hourihane <alanh@fairlite.demon.co.uk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 063/101] vmlfb: Fix error handling in
 cr_pll_init()
Thread-Topic: [PATCH AUTOSEL for 3.18 063/101] vmlfb: Fix error handling in
 cr_pll_init()
Thread-Index: AQHTz5t9Ovwi9O7LtUqQhVymVXwjWA==
Date: Mon, 9 Apr 2018 00:41:26 +0000
Message-ID: <20180409004042.164920-13-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0901;7:xex73XSpJycng+WSEIbF7DLVjPcP+I8j707R3Yq0Ke67ox29j+fnVSDyvQoHez7m0upKfZGvulPCkxaoFSFymOgfKCCsVynNnILSlZMS2nHVJAvV9KhoKRUj30GuXGm7UPRdHsBwfeqccxFhLHVa7fXJcmu5O3rxB5fuu4ehqG1JbQmoUtMG6pQxA7Zi6IkbwDakeIV97yM0UhupSwY6y91jB8tkjM8QTFdjSoBKUrb3Lj0G1mTJVnEXy3+gAyjy;20:aBUDdm1jbga/F9aU+22W+mlmPRHMT1q6ghYWOuFM/QCjGG6tmYyOI4ObPczcI5vvbUa1/ckiKf/abEbtXWLuVM8ZPVVLG3hhXfP4fB8jLmuvyGdG+JNZgdMiGvGXcBgwS8gbQO9QmNVUZ3jDIVMCudB++SXGlKoKwjFsnIuOotI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: fca9a1be-89fa-4951-f991-08d59db2a055
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0901;
x-ms-traffictypediagnostic: DM5PR2101MB0901:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090129769049A4A67D234261FBBF0@DM5PR2101MB0901.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0901;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0901;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(59450400001)(99286004)(68736007)(10290500003)(25786009)(86612001)(6116002)(66066001)(97736004)(3846002)(76176011)(4477795004)(6512007)(54906003)(6436002)(4326008)(53936002)(105586002)(110136005)(6486002)(3280700002)(1076002)(107886003)(8676002)(10090500001)(2501003)(81156014)(81166006)(5660300001)(14454004)(186003)(3660700001)(102836004)(7736002)(2906002)(26005)(5250100002)(36756003)(478600001)(446003)(316002)(6506007)(2616005)(106356001)(8936002)(11346002)(575784001)(22452003)(2900100001)(86362001)(486006)(476003)(305945005)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0901;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: S//AehoB4ybCHaWof0XaZdyEu4LJYCz0BXsXFGZIh0ffRryhPi71vlM4hZBxBQX2OO9mOVUwF9wdOmLQtzjy5nsTs0KY2ybeAXdn2tlnAK/P3W58qyCf5H9Zmpy3dbJFvncA2BwoNdqhyU8QQH4zx+BaYEk4yoG8oeubSjXze+NoRzZjPCu6+0bN8Kd0lJsb/5itW77iJF5vD5+s6EjX+EHuBUZOVmMCdurTb7enucSvAt4bB2lJ+ODY06Im7FrTsiAr3niw3gZBFMad+eFtdudgKIczCLtwS52qU4YQtISeaPYRS9Zjbd3j6Vv6dfWHT385uj/uoB1LBzoGizapwoy50RzldcVofYNc+NH+nxF30BJv7+OjUJDrNmNuosB22jFgY4tMoH93tC8Bgv0c2gkjNcH4c6NuC2Dafoq+SGI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca9a1be-89fa-4951-f991-08d59db2a055
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:26.0334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0901
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
