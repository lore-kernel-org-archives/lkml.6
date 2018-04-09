Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523234597-2-4636326693167649936
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234596; b=jmmrFds4RZevm9Jui/J8eLDzGjTay3bJSY05QDxz0y0M9wpvr9
    AAx1TFRXKNvi27NABMepR9lFSS0fWwlgjhJYrxuLDL9RkeY1nvniZ5s+ZtntSZtY
    ojJ32ToKP/0kgKedSP+ZVPWK5MIOu3WVyk4PNUZ8RftviQl0dfiHmivMs0kvfk6L
    Y7gW5tzik5qerhWwAU8EOXHaZ/KiK5GN/NycH//vOrDOB7n2TQQ+X0GL2o8vpZ2b
    +rFo26D6AOCFPlCBPWzvfmVvyIoApk4JOCRuPiWj0wChvYl+EbAtG7AySe4HlzFI
    Z3xZhTXWjPOL4UtDujPcm6DiXyP1uhQNIpgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234596; bh=xToftLCkOi
    p8XzocZXMj13wruOVli+B/vwieOr/rDIk=; b=YKDKd5zEpEp+62LZu2BTC+Fmke
    hzRsVwSI6mGe2ka7ge4PgrzBp6ZL4XSjb7xChBiDL2cgYa+l2sT6ktDiKpm8XNAr
    X0KecD2y+T59F5g3uKDxaxC3XTvjbdtskAaoyl30/KOoJgN+AMsvNm7wOI4L/fTZ
    gtrlo80BHX7JkDv5qBbzKJAMsOt1J/hcAgj035yf/qx4AAwgQHqFdgycRqGjmCJ7
    dGwHtXRt37C0U1z8DygLe0hcQU5hVvfTS68vx9njBS1XK89fOstP2o7x8IIP28I8
    wtmDhx6dLlvYDM8kra4BcZjpkS+IKZgPGJjuzVAsxN2i6CL5D3JAiHZys0PQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N84XG3iQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N84XG3iQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN/OlkjmJwHb+xhIIIOhZg5VmHqMnJevMqPVrnwS3dJnbTo+AeYzHGkKhK+u6smPj7JtsK8c4+RFUHEY3Xf4fPsuxelcbyId6lsC7LVGoRjvjMO/Ccna
    z17k7YtaM/x5JzKI+hYT1K25HCwGVecAvhGegEKL/j8y8ym9xl847VeUp+BIk270OaSet0+DiyNVoQ/7rQdKem0dWDjeguJvqRt2I3Zju0q7v7pbhkZFyeTw
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
    a=p-nOP-kxAAAA:8 a=JF9118EUAAAA:8 a=yMhMjlubAAAA:8 a=m1UO6bD35eZV1AGazdsA:9
    a=wPNLvfGTeEIA:10 a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
    a=XN2wCei03jY4uMu7D0Wg:22 a=xVlTc564ipvMDusKsbsT:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756809AbeDIAmg (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:42:36 -0400
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:44046
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756777AbeDIAma (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:30 -0400
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
Subject: [PATCH AUTOSEL for 3.18 089/101] x86/power: Fix swsusp_arch_resume
 prototype
Thread-Topic: [PATCH AUTOSEL for 3.18 089/101] x86/power: Fix
 swsusp_arch_resume prototype
Thread-Index: AQHTz5uKZ+V1oSlMfUuRo77hwH52BQ==
Date: Mon, 9 Apr 2018 00:41:47 +0000
Message-ID: <20180409004042.164920-39-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:rj8uWDkEwvpwpVLVNDXZ27sZ6Itc41gJLGYsNV+Es1BG7Ct0iZSgBO3SFTWUhecPC0ZqzF/7aizf88Vr507LJwd0BJsTZ4GRpWLHHt5tfNnupKw/SxIeZtbpv9zsXha1Vsijh+BrDGdh7W4Gy1SGwKsi2Am3NcflfNxMYiOc1Ba92r+jM3wa85u/s0HMq4ksQSh8Ed4Ee2bZgtLs8QZi7M3B1rKWeaK+AtyASewGMGnVHxmVGRv0HuVwM9Ut2lJy;20:6cz1ZMK4OknhDtxicvBdLUrHXoPGWGDfoFSFFRM7Bh91O/qP9MKUowiWCBuoYPFvoGs6fa8t8oa6HUsfHqujMv7Znho6kdRkoT3zO8/52KIC6zFfaJTlFwHAMQEhmGRedHKxmiCzNhJkmyNsSAbfAMuYUaUuc05XxStMGYdD3Hs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 389120b1-8f77-4552-8bde-08d59db2c176
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1062738B74A7044F4C121E33FBBF0@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(199004)(189003)(68736007)(6512007)(316002)(486006)(6486002)(6666003)(54906003)(5660300001)(110136005)(102836004)(6306002)(14454004)(99286004)(36756003)(86612001)(72206003)(105586002)(97736004)(106356001)(2906002)(22452003)(1076002)(2900100001)(10090500001)(6436002)(3660700001)(7416002)(6116002)(575784001)(3846002)(305945005)(59450400001)(86362001)(66066001)(10290500003)(3280700002)(5250100002)(25786009)(8676002)(81166006)(8936002)(7736002)(478600001)(476003)(81156014)(26005)(4326008)(186003)(2501003)(107886003)(966005)(6506007)(2616005)(76176011)(11346002)(446003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: QLHFQNwiXeAj7zGQop5K66ZEurBkKpVcVkkpTpex0dATFFg5S0i8x7eSw+DtGlJ8aZUaEHm6M3tbPaCMRiSus1IucrMJMLylkTXdzwxsPl3h9o59ZpJgwJy0ikiATAd9dX2R3uu/yPF1WQXMBJQHC8hmDOcufjarsAQKfu0WefesboFNh0hZD4v541Z4TkgY3rZ7y4aPyx2Tq6XgTdbKbZ2f7izmWqSkuLKM8+eQZZuckzTeL0N4eICrVRA0zl8xxXmYx9oNufwDVnt60jt82uroPGrwbM5JKvHojGsdewpUMzVNU5wTm4A95Mk8vnQx9VOVQ/7UhHcb4ccROif/u2nrIAB0aL4IKMgodcR9RCXTiXodEP0HDHe2F40fnNZQDNkiVlsxPmjdnTJKGgAO76v2DME+UdBYXzDQ0bwSrfE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389120b1-8f77-4552-8bde-08d59db2c176
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:47.4553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
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
index 3388c1b6f7d8..10a48138e063 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -325,6 +325,8 @@ extern int swsusp_page_is_forbidden(struct page *);
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
index 2df883a9d3cb..45244cb31c91 100644
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
