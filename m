Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523242891-2-4238978352970347542
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523242891; b=YnRA+mOx65mnN75XjeIIZa2g8M0CHOffQlN0p8hSYZ5vyjlDiC
    GDB91BMKB/oN0Ltc/qYVlK6k1BBHPArd9u6jtXnSOIVR4jlb20SJ9W/CGLQhsFSD
    KBXiABKZicR3u/M9rZKHSIK7m5sfbjvDQnV07mng3pdCNOpLZFs3v8F2LgFQ0Uq0
    ZInWZIt16JqQErt+iDNzyF85J/hnizBt1bNsS3bT7tuGIUiaW1BB7lrNCd1uSJlX
    4VpVt7Nm7TQtENEmggp5BbMDIwtZst6wG6iNV11k05WmGIlVVcPVIAnhYUjcmaNw
    csEB4ZAGagy9FKgHtY7GZhuwR4qiHqEqkVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242891; bh=92LPbcuP1+
    Nu6hJ7JSAFmsZgtoYGVkr1KtL7T+wJ5YU=; b=D5YL9R1m3ZOLbr8QAwzQU4b4o1
    maGiIengYyRAXPFxEhNwQlHr5CIEUgdNJ2zTr5/R4D+0VPJGCYii2wq5hNYid7m6
    j6mXs3hV/SzfQ8v+GBdzttc1doyL82ESdYJuCruE265sCgwVcGvYpx3xdyBdYMjT
    e7QLfVpAkxf9APKOr/Bnkg3vgM+0/JozxVuKxc9yYu+qQqCycNFgK3Pmge/ksLu4
    oZi5McYzmykfFUpwq1Lo/BMOXWqd4/YlV2B3MF9ieSJBudyafTlNyOsSuHo9nS3D
    /JMx1RR7c7Ox4DHG3YidZXb7aUqCEowMT3Aup+yglH17CfRtlRsqQnECcPOA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R0ryEgil x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R0ryEgil x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJh5hIGGarazCgUOe0UdVZjjM/7aIZ96eMO4TDYoeheAp+IXVTVXJQJJo4im/lgiOjEBg7xnr+nL00Jtli14/68gWNwYYzuwsgAcpdCRHTjx8pYRUZsY
    eyTBu4mwxi8fE2XBimJfth9caHBVLt8Mx1Se3QneUc+7OwDRq8KvQLv7gagU4D0sNahf9K4ngBP25Ic2Diu0JmPvyVDdqXQoclhxmcnsBu8E2Mb0tEST+RSN
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
    a=p-nOP-kxAAAA:8 a=JF9118EUAAAA:8 a=yMhMjlubAAAA:8 a=m1UO6bD35eZV1AGazdsA:9
    a=wPNLvfGTeEIA:10 a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
    a=XN2wCei03jY4uMu7D0Wg:22 a=xVlTc564ipvMDusKsbsT:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755159AbeDIAZ3 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:25:29 -0400
Received: from mail-bn3nam01on0112.outbound.protection.outlook.com ([104.47.33.112]:5721
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755155AbeDIAZZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Nicolas Pitre <nico@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 116/161] x86/power: Fix swsusp_arch_resume
 prototype
Thread-Topic: [PATCH AUTOSEL for 4.14 116/161] x86/power: Fix
 swsusp_arch_resume prototype
Thread-Index: AQHTz5iziPGN6a6CTUiL7GOEJKblVw==
Date: Mon, 9 Apr 2018 00:21:27 +0000
Message-ID: <20180409001936.162706-116-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:NU7eYY1L9x1UIh9S87QUYtlve/KPmMKQ4OtRZdw/cR7enA1azVmntzqJNcQ+DhV7f3eNfoes3KcPtTtKKHIPI6UrbcXgn6ru0ZnI7YcJo4ojg4rVM+RviS2yKRAPI6puEIOcv2w5yATtTiSCakh6MrQOA5TrVKIfzKClmPyi0RVb1hBFezZh6sbOx54xEaeR1Bt5o/Xs/Ldhcil2rcQ/VCsSZBUioYIthwhP4YiK50LwdZrpuNpbeXSoPLhpsksA;20:vwF6DIu2+DuS5SUymbkK1wxqwobYHCq/gfMbtGtGaJ0dMUO/RfkxYrlRAYk8uIuQ7Pty7aXS/bgEdqFMM/W3t98241LXko4v5iU5gQgbyNlLskVCqZXItDCGBgmkCkndpliCFtdBZ9d3AY8nfYlBrs8gpoopuIwVtKE8BHPyjvY=
X-MS-Office365-Filtering-Correlation-Id: 9d6f50c8-239a-45d0-cd98-08d59db061e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013D7D842C7FECE79B27255FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(3280700002)(2616005)(8936002)(7736002)(476003)(446003)(11346002)(53936002)(3660700001)(86362001)(575784001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6306002)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6116002)(966005)(14454004)(4326008)(305945005)(6436002)(2501003)(5250100002)(10290500003)(478600001)(2900100001)(59450400001)(22452003)(110136005)(316002)(7416002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: UxgE0R5GFWVN+GZDXH638zg3HbikgXA9t6+gV7Ce5mUM5crWutT6uGF3zCLvwLHUF/tOuOhVw+/uBgRRSYmLdJOQQPC3lkBpJbtdU9fD6oOZC8IGNxkwDR+rbDIyJuRwY0ZvDIRN7thqfUSnRYTNWzzIZUa/mGk3er9HA9mjRyVExmSkymehYlXUFHxfttVnCyNJWov9N3+h9WoCygR1ab8/jxRI4g1FVyWbLwGJrebdj+qVLDOhFG4Q88FFjnUUugGoRabO1QTYRrBiCmReX6QVXm/ZaExxFEb+0sV6qZ0IBVYEjhwVE7jutAXtrdm4e2f7blL0+VIBOpuiDSq2u73I2J9DggaR6GLlW4pYSR0gBGkD45ka731rCUMMhDFsnq1jO4AlY3GoEXK+vmZiVF3nEHdng/tYyFE5XayHUyk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6f50c8-239a-45d0-cd98-08d59db061e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:27.9874
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

[ Upstream commit 328008a72d38b5bde6491e463405c34a81a65d3e ]

The declaration for swsusp_arch_resume marks it as 'asmlinkage', but the
definition in x86-32 does not, and it fails to include the header with the
declaration. This leads to a warning when building with
link-time-optimizations:

kernel/power/power.h:108:23: error: type of 'swsusp_arch_resume' does not m=
atch original declaration [-Werror=3Dlto-type-mismatch]
 extern asmlinkage int swsusp_arch_resume(void);
                       ^
arch/x86/power/hibernate_32.c:148:0: note: 'swsusp_arch_resume' was previou=
sly declared here
 int swsusp_arch_resume(void)

This moves the declaration into a globally visible header file and fixes up
both x86 definitions to match it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Len Brown <len.brown@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Link: https://lkml.kernel.org/r/20180202145634.200291-2-arnd@arndb.de
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/power/hibernate_32.c | 2 +-
 arch/x86/power/hibernate_64.c | 2 +-
 include/linux/suspend.h       | 2 ++
 kernel/power/power.h          | 3 ---
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/power/hibernate_32.c b/arch/x86/power/hibernate_32.c
index c35fdb585c68..afc4ed7b1578 100644
--- a/arch/x86/power/hibernate_32.c
+++ b/arch/x86/power/hibernate_32.c
@@ -145,7 +145,7 @@ static inline void resume_init_first_level_page_table(p=
gd_t *pg_dir)
 #endif
 }
=20
-int swsusp_arch_resume(void)
+asmlinkage int swsusp_arch_resume(void)
 {
 	int error;
=20
diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index f910c514438f..0ef5e5204968 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -174,7 +174,7 @@ out:
 	return 0;
 }
=20
-int swsusp_arch_resume(void)
+asmlinkage int swsusp_arch_resume(void)
 {
 	int error;
=20
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index d60b0f5c38d5..8544357d92d0 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -384,6 +384,8 @@ extern int swsusp_page_is_forbidden(struct page *);
 extern void swsusp_set_page_free(struct page *);
 extern void swsusp_unset_page_free(struct page *);
 extern unsigned long get_safe_page(gfp_t gfp_mask);
+extern asmlinkage int swsusp_arch_suspend(void);
+extern asmlinkage int swsusp_arch_resume(void);
=20
 extern void hibernation_set_ops(const struct platform_hibernation_ops *ops=
);
 extern int hibernate(void);
diff --git a/kernel/power/power.h b/kernel/power/power.h
index f29cd178df90..9e58bdc8a562 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -104,9 +104,6 @@ extern int in_suspend;
 extern dev_t swsusp_resume_device;
 extern sector_t swsusp_resume_block;
=20
-extern asmlinkage int swsusp_arch_suspend(void);
-extern asmlinkage int swsusp_arch_resume(void);
-
 extern int create_basic_memory_bitmaps(void);
 extern void free_basic_memory_bitmaps(void);
 extern int hibernate_preallocate_memory(void);
--=20
2.15.1
