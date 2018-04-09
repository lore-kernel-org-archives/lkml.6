Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523242917-2-12673641990076967902
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES encaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242916; b=JZZEyzAyZrE2k4LLxsjWkhq5xGS6Y15bIDjw7hhdQZ6IufDDH3
    bOZ14uqA4XIqgORtG8zGSHwVUeebdSy1Tn8JN7i833hCYX5hWk7pW1KuSTXBM0lV
    Kk9mlbQh9iUrO3ZbNAEq7Z2fmF+SI+kkagq6bW/KwghYoNYcjfVm8tg066x28b4f
    8AYiZn0gYLDFifwLFZORArpwE7CU/Caki5IEvyMGgI6SZCSH9f7JefjvPTl7gHBm
    Ef0PNOmz1r3SlXWDKH+XVGs+NPIuIvR+anIxNO6v3yBDHOAyBySX5EPYmoDr3AtD
    5cM67+GedIoC7g5UKcTxNt3bw3BqbJiOwKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242916; bh=kEbeKIWgUC
    GqWIDBLL4m+5ADVnQGu8x9ekPXTk31yvc=; b=PNjNU8BVbm39b3yVDqJQLyyQRW
    UZz1RZCFsEn3ilP0mLH+QhSnwDa0nxzjOuJEVXMcCPHy31r4awF1w+ldjhPJ3EyR
    cbeyD37/z1h6UaxXYcXj1EVLmjvp80LyveRkxbx1R8h+CgrNqXjaohEkBzrq8KNL
    CyjHCdDMc2jcLBKU9Qr2ycy69WFfdBzpHxabIqeP7uzPs7vjUYPs2jR0GfoUvSr+
    7PpHB4rVakCpuKo7Y85e59Z+n7MqaJFlCQIFHAi5qjHbLR5eURxOzxttUxBKOqSW
    KINDWxKmwWtpZCoxYyOqQqcfiIxMo2abhHZzmu3K+N8hmgGNT5iqLSOjMKow==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XT5IqOoT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XT5IqOoT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEkFGYDiUrGFfOALG3UQxZSrUJrzuUMA4uYptWlUJ9V5no2AUXwBgC8Jj647MQd421oXyIgjXQxWq0Swhdl3mkLIgUVGp1cc7pMJ6Inc0ZevlIThIdSM
    XBp5idkbRTUoikbZFYC7Q+PyB521e84Ohd26anrn/LG2ECNeZ0WUGksGqrFiGR8VXQRAlgv93x5H+rt1TPve0xuxGF3BUgjg5lQckBQP7a5uEGyfAe063KzW
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=JfrnYn6hAAAA:8
    a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=9IefVlp6ptrRNx8ANt4A:9
    a=wPNLvfGTeEIA:10 a=cvBusfyB2V15izCimMoJ:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeDIDBa (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:01:30 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:17920
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755157AbeDIAZ3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:29 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        Nicolas Pitre <nico@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bpetkov@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 117/161] x86/dumpstack: Avoid uninitlized
 variable
Thread-Topic: [PATCH AUTOSEL for 4.14 117/161] x86/dumpstack: Avoid
 uninitlized variable
Thread-Index: AQHTz5i0PincUFwi3Eis8GBTAiv9fg==
Date: Mon, 9 Apr 2018 00:21:29 +0000
Message-ID: <20180409001936.162706-117-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:cSyCAVsjyMkJPm+OTXwAlYPxpIEC6OKZv4B0BaX2qd4B4ElAnEoqBKBUGYSYn7bfzpikKKe/7hhat7S5StOC6czIinfZjxHvYobPy2390yzZy0IaBr84hkhs8Y2457xQYaqJ/23rgl6Sq8UaoWpICwrCd6HScXlO1xJMTpHNbFpKDX0WiYymz3twJaT6JrU7w042iycP/uG/KMcFLC0t1GlL3oMIB840HgxC7gNa+lp+fKVvZNN9JZ/GdkMkX++E;20:3gI0xPhgFc/o20ejoRdW1OwgcuvMyo1QWwOQqH0ulRmKgWs5MmCR6j7naiO4W8PCyux6JvKaJI9YaHR73frgyDCpioGDkLFLHqrZZdT71dtUsfLdL6jVrRMQhCdqVFsLQlm+KZXCqF8dPqEi+lcdNW0NlJ+gNiWij5maf3NNE3o=
X-MS-Office365-Filtering-Correlation-Id: eea326c2-7991-466c-2a60-08d59db0625f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013CD4FAB8BBA8F0469A283FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(3280700002)(2616005)(8936002)(7736002)(476003)(446003)(11346002)(53936002)(3660700001)(86362001)(575784001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6306002)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6116002)(966005)(14454004)(4326008)(305945005)(6436002)(2501003)(5250100002)(10290500003)(478600001)(2900100001)(59450400001)(22452003)(110136005)(316002)(7416002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: eENKkQZ07lkAiKnQLbJt4bUfHgLKJW8Xs3GpS875dCWBT94whU9p0peVbMZBtWzMpqCqPO/0X30lDAHRIxmKCaEkZSZkv+b9x5GyqSItk76wNjFIiWBUekJXJga1Y2T/Qzjcb35Ee/SfhblmpG8o5ltpn48H0N2hLjF26at+0ij1D5Fv6HIcUKOnzMhgAgRuowKo3+D5YUvhL9dj0W3+laBSmrtSPMzjqKL0JCfVjcdsr5+TeA28EjLgImJh372r9Qgrm7XKJe/lVnq9nQVds9TH9o4T2LjdYBPoSL9qVBHidx7Fpy0TPy92rjl4N9mRowmBtcjuWrnqJvCTGtgzcBHOoiUeqQyU3HhNZ7rSJmjHXkKwobMyYozsTjH7QdG5bKLJkYwvuxKoMvFkKZMEjSwdTTU8XNmM5M38vh5ox78=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea326c2-7991-466c-2a60-08d59db0625f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:29.3468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit ebfc15019cfa72496c674ffcb0b8ef10790dcddc ]

In some configurations, 'partial' does not get initialized, as shown by
this gcc-8 warning:

arch/x86/kernel/dumpstack.c: In function 'show_trace_log_lvl':
arch/x86/kernel/dumpstack.c:156:4: error: 'partial' may be used uninitializ=
ed in this function [-Werror=3Dmaybe-uninitialized]
    show_regs_if_on_stack(&stack_info, regs, partial);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This initializes it to false, to get the previous behavior in this case.

Fixes: a9cdbe72c4e8 ("x86/dumpstack: Fix partial register dumps")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Borislav Petkov <bpetkov@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Link: https://lkml.kernel.org/r/20180202145634.200291-1-arnd@arndb.de
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/dumpstack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index afbecff161d1..a2d8a3908670 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -109,7 +109,7 @@ void show_trace_log_lvl(struct task_struct *task, struc=
t pt_regs *regs,
 	struct stack_info stack_info =3D {0};
 	unsigned long visit_mask =3D 0;
 	int graph_idx =3D 0;
-	bool partial;
+	bool partial =3D false;
=20
 	printk("%sCall Trace:\n", log_lvl);
=20
--=20
2.15.1
