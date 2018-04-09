Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236128-2-13552908586355173084
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
    1523236127; b=DE6C6bML7bWUhVpWpBnjKkOnikTYef/M+R5haecVQuueu9Q/gx
    ZZmcKP3833V4yXoscfcWBOO3K7CQIxrL/uXovgxnALGARF1xt6w+jB4g4FOcdsHR
    s7IervyJsuPcSpiFO8+TdQSrOPJkZyXG3IFZIsRKrbcFaRuleA3UYeRcjFWkmo7N
    80vs/qcp4zWgZdbDlRMNP4ZHKjMPbgxQO/8hXaHH9Ij/J+WlilYbPEfqMuTXqc7q
    Wm7k5SUtp4jD9pe7f4nnxaGy1jQaYb7bJ2ii7wQWFuJlMZKOQjHoy6OR2EyX8Q2X
    F42UijUhtVZfY5Kt5MOjuwgozmFfFwxA/saA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236127; bh=FAcshN7gB7
    9ZZOdrq/kzj5HwLR2n6NMd/nodWJDZQ8Q=; b=uST0t47iNTDaj0AiNuGdrp7ZBz
    D+qPIr+DPgx8oQtTkLVQxaQsWoRhdCFkUS+N+nj9CDwAIdajqrTC3Txk1dAvSrkh
    zSaftPp3W4cYwsGOam+u6YGRiGt+GL5ZJSGH8savCdlmRui+VYxbfYe0antZhr8r
    RZBbsBgMn+4DfjI5ijz699nzlloXyjK65lR8mp3By7ndHPLts0gZHQiVospLcBeh
    BNFBSA2wO/Hd/RZZbK/cLG649xOGdOyeaMI4MmDIeYUwutwzulYEjXcTBtATs1ln
    DXENbzVY/XDVzOlEgwWrAxZi/VaHnoaS3irMHcFbupysoxMibYHV9YcwYOuQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EVKFfkSF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EVKFfkSF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNojGqkjjlPAPd4IPkMv+SLqgFoqRFGiPspmBlkkIEfHZUmb95kq8VtRAote9u/aV0mbImwGzsmtXtvaqO7H8mdN5IYnjb9nonRf/D23H2ao3H1/0zG+
    /RT2PuKdrruvkdvbHR8T5p88liT9C8NM2uJQF4xtZBjWG4iJsuLYR6JGAvATvz53EjzxnB+WCjNPKwLx+HbmbfubZjophEzMZ3O3YQWMUmSJOiAcGC6qrvHz
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
        id S1755925AbeDIBIb (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:08:31 -0400
Received: from mail-co1nam03on0103.outbound.protection.outlook.com ([104.47.40.103]:64416
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932996AbeDIAiu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:50 -0400
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
Subject: [PATCH AUTOSEL for 4.4 144/162] x86/power: Fix swsusp_arch_resume
 prototype
Thread-Topic: [PATCH AUTOSEL for 4.4 144/162] x86/power: Fix
 swsusp_arch_resume prototype
Thread-Index: AQHTz5nZi6wwjhwO/EaancXIq4cVOA==
Date: Mon, 9 Apr 2018 00:29:41 +0000
Message-ID: <20180409002738.163941-144-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:hpeQMxtWudmzC+rvbeVdutwJljiXm9sE1yQc8xh7PzTzGk/Di68yI/OnP8sEeZqo7dmYzf6MRaoHaceD3QoCNsDsobFzZJXlPnjkhpIyJHZXfvMAdISR9u9Zh/U9foD+Jf9IdxKu/Gi8xtX5GKN2C62240n25oJA1IfVg8UO3YLfRDH/UEToQfZk7TXF7k2cwopGa6BI401wbfeEGU/gexEKiBYHjlrOarrUON7XbdiVyHg+EA7Ms7XOricSMuep;20:iruIWNGnp6uu4hIN8m3PWnfKMu1OU8eFNjLHqSxhaeRvuqCgYzy1+UC7gV80fj0x5VyKiS3KkCVF9mjf1x0SLE6UGnsZadyCyjMBGKsWz2PJhl+NqJp2u0FjZdBnD9zUilmvCbzj4+ItOCcvRw4/G5P+DAGPfV0+sHH0Wlj/YeI=
X-MS-Office365-Filtering-Correlation-Id: 3ef2cf39-8b1a-4cc2-bd05-08d59db23ff8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11259B8DD3EAAA3DCB3489F2FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(366004)(376002)(396003)(189003)(199004)(2906002)(25786009)(6512007)(10090500001)(3280700002)(10290500003)(6666003)(6306002)(3660700001)(316002)(110136005)(54906003)(11346002)(107886003)(2616005)(476003)(446003)(36756003)(7416002)(99286004)(86612001)(53936002)(4326008)(486006)(6436002)(3846002)(81156014)(305945005)(966005)(5250100002)(1076002)(102836004)(14454004)(66066001)(7736002)(105586002)(81166006)(59450400001)(106356001)(8676002)(97736004)(6116002)(6506007)(6486002)(5660300001)(186003)(76176011)(22452003)(72206003)(478600001)(2501003)(2900100001)(26005)(86362001)(575784001)(8936002)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: T48sArjaZfMda5HSOpZVPiYMCeTJpvN2gbwhoyHIHNk7DnCnT2wthK2UlCtisPOeqPLMk4/0LVWm446/CDFt+77uOhn83qZrp9BbRGfExxXfRPGT02GIS97Ui4PfviEQg/dcr1lvDCYNZcDV1FnKYiEcqkhPFa/1h3MAw9AfzZaGiyAhzE9qbiwMTKIW7opIEzZPbcjv6MxWOPMUjhV5GR1v9RFPFs53w5ryK+houOFRBsW3XYDQLpVvDoVyABHQfPJX13lJDCKyu232jRJj+iPX4FTmTQsLRIJPYj79duFsxW69FiidZHwDNVoqWHCbpIjJyaV2ZkikIYqKFM15XMnQjeRbJKTdrg13X5nZFZYZK4EOhnwveyOE4FaMscBVDV7mm6srFMhrbAK9mxF+E5xI1XiETa0JjCrNSgQnn1I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef2cf39-8b1a-4cc2-bd05-08d59db23ff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:41.6308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
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
index 291226b952a9..77ac4e4deb16 100644
--- a/arch/x86/power/hibernate_32.c
+++ b/arch/x86/power/hibernate_32.c
@@ -142,7 +142,7 @@ static inline void resume_init_first_level_page_table(p=
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
index 009947d419a6..0e0c773edffc 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -78,7 +78,7 @@ static int set_up_temporary_mappings(void)
 	return 0;
 }
=20
-int swsusp_arch_resume(void)
+asmlinkage int swsusp_arch_resume(void)
 {
 	int error;
=20
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 8b6ec7ef0854..4a69bca7c6ab 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -377,6 +377,8 @@ extern int swsusp_page_is_forbidden(struct page *);
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
index caadb566e82b..25367fc0b152 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -85,9 +85,6 @@ extern int in_suspend;
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
