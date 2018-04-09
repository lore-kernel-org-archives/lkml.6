Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245448-2-8861588883651956152
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
    1523245447; b=sduNzR7C01vUPsbla1mDfylOkOawKTLGvQNVrhubPpgfZ2iLYv
    JRk8wNH4BzbmQgzX4ExQTbmqOv868bYzeK4tQLVvROS2BQX+VM7ZuXj9Zv98vxK2
    qa5emjjcz4UamiibNXwZrV0o3LaUH3yFOih1aZ8rxdu1W5Z3RKkPAqPrT0iKSdOC
    YIXGPHBgGAOg2ClhSf7xwTYBTtsy2xvwsqwijp4iKOPTc3quraCdhQI24E2HbGIF
    yfgArMyObb5bm8/cdf4F9rYDmFLg49IsbUIkE3vSrzNuGR9xq7mSUcfxZk8UyMRR
    kLQ7HSq1aM+Zv8PvcQZtu42qk29vMlvc5KDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245447; bh=92LPbcuP1+
    Nu6hJ7JSAFmsZgtoYGVkr1KtL7T+wJ5YU=; b=bS5ZUX/sGoBSWfEMvWKGxW2nQY
    8VZJIJJtEmhD4+JeG1wgQOV9LMHeUoJmmaHBQIAgPUHxYPzYa3QJROUIpw6FDmcq
    FEvys0VG5BA952qsc9hvmEMUJ6Gpq9oE0oTwJdUQslHruGCUC5NUlu5/YJk9WXbf
    pYDf9y8aMb0rnpSu7t7IR85apLgwwsoOiKVrs22K7wX+N3ZuO02KKZNihKmi3wOv
    TfWXDIpZ97s0mnsmNntWOMAgaPZklLrd1ide2c+tBl4j9GOqEoarVD2RFpZ9ymO2
    7udRdBNJOU2lNLUxtMPBa3xeq8Av1G6OBU2vpSX39Klivu/vEn9EYUOtvG6w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IJCJfXZ3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IJCJfXZ3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMOQqIZiiQSOvfav/C7SrurVIGIXKKHOnI5aDmPrzNJsNYZRE83zjfzG2B0nQrjK2ZN5cY83K8wXAZLJfx66aySZbLhBFpu6Hvvo/OXxoCq+FW1i9lBM
    rhBxDsFZIYqNJo5maNp8UcEMM9FUY7rXzSuE6HLkn6LLTL8taCcBsIGu/KT9FRWcQWDoVnujmGLUBRTtPFXGKo0XleZrtCRE3Yke1eHpfavLCIfIIBUx6YoP
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
    a=p-nOP-kxAAAA:8 a=JF9118EUAAAA:8 a=yMhMjlubAAAA:8 a=m1UO6bD35eZV1AGazdsA:9
    a=wPNLvfGTeEIA:10 a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
    a=XN2wCei03jY4uMu7D0Wg:22 a=xVlTc564ipvMDusKsbsT:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754734AbeDIDno (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:43:44 -0400
Received: from mail-cys01nam02on0118.outbound.protection.outlook.com ([104.47.37.118]:44776
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754235AbeDIAUb (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:31 -0400
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
Subject: [PATCH AUTOSEL for 4.15 140/189] x86/power: Fix swsusp_arch_resume
 prototype
Thread-Topic: [PATCH AUTOSEL for 4.15 140/189] x86/power: Fix
 swsusp_arch_resume prototype
Thread-Index: AQHTz5hPI3hswFjA/UizBoQlW/Tn3Q==
Date: Mon, 9 Apr 2018 00:18:40 +0000
Message-ID: <20180409001637.162453-140-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:Xc71B+BMtMc7QBuc2F/KwJYX7vgBog4Wy1nipqUZY2exu2Nyg8Xwh9LVgAMGbICrBMoYDqlxzTx+UL8BSxQFou7CrnMCEm0OvTFn+dxupnt14l9AUOjveWSV9wHKsjNgjqpRQQXymOh/ilOb7gQ+vnUHyVnJRlKTYfKNrlb83GLRwwogyzTVRglsMdEyftKD94cb/30rif29Hv2UN/Xn7rknFCYiJWna4mSPBYWxQykecPTcBoo0I0TSTsZeFeUg;20:kHFpjO/AxI7IuZNNJ/+gGvVlpeUnA+XD6o7pGl3/Tog5gVCNt8ze304VfI1uSTqWusewuTPeDjHzoToXB4od5eTY9w6jmR40OeCGrjLhgU1wuF4UiKxGAP5Babhmain4HG5DW66wIEiWbcZju0KWlXgGl45GkfoR9O53LZqTX/k=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0a3e17fd-a309-4392-c8aa-08d59dafacca
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11104251739DABA4BD36E809FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39380400002)(39860400002)(199004)(189003)(5660300001)(7416002)(478600001)(86612001)(3846002)(6116002)(106356001)(6486002)(72206003)(25786009)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(486006)(26005)(36756003)(10090500001)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(575784001)(86362001)(6306002)(53936002)(966005)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(54906003)(68736007)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: uvaZff6Vft6rNCqIL/JyAlTBIT3IeGuyhgFZfzcIvPQGbCv1DynfMg+WUvidXf6ZTkj8y1X9BcL9/BXjYeozvsdqSUON3Oc7PgzFNvaq/HwTHQO54noksnNoO1e96Z8PB8swnXkBswLPIZ4jBl+Gv++SG4qbBRT2EdNg3M3+mtbrmnD9dZE4JjQM0OesMRimj8wcc0jO+36RsW+XfVhc/kkiCBNZj82IJLfr7ZdFXaa8Xrxymp9OOaXjrH2KPJq0/XfZE8ErgsIzbWElwNDDbMEFi3KQax5+OH5RJExf/PTumwvR3ddeDTbH4/A9bXftcnqCDG5U3gL6fPu38T28zqXnSUI5nXXABvsi+TxswOvfYz5E0tA94UvzMidyTx+DLxL1mienga2JFTKwBT3pD8JBPz9IS/rnfh5P1x1y1aI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3e17fd-a309-4392-c8aa-08d59dafacca
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:40.3470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
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
