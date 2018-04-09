Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238406-2-17817260650170959640
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
    1523238404; b=ILvKv7C6kfw9iUULpD1nGDxc4obU4eCtixL6ALmiFG4HuxTwWA
    g6+Q7RyOarRoc9mm1s6T617v6Uh1TDWYToWRZr92ihRsEbPZkLPSEqrAOGYKHWbt
    7hbOJQViZZC21r2xv/hsRFvk3WXKL6HbfZneLGOf2GQvWb5p4EsURvObzLWCO0vu
    M6Lobpf/TD+Oigt0o5Nj8aEx7my7MW1OzEUIDMy0aG3MtoadG3w5jXtGZcskci9Y
    dBOYp3zKuIzNWO6tBT/nVGz+KyWYQX1dhjufRUNS8B2jbrKNpD6K1q/5k0JYsaJp
    r3DbH6RFVeGVw1WMA/XYUoO5xJhllj1A9tXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238404; bh=QxC1ci7ByV
    z4cHTk8jiSSEBb7ew0d3RlgefFsjr6Ymo=; b=QC+VW/Seov3OL8jmge1Oi8Xeco
    NqvzP5Djf4QfwWRzFuE50pdjaIAz1v9dzktVBGAnukfA57ZyxRzCIaaj2aMKp5sD
    6YjOuJxi9T2pnTGWTOUk2/FdeeC9J2RaXzK6ryI2F7PZjD9xVPC4D6n9Q0D8gYNj
    0SqiOWmiVPMcAnOUwqXh3rc8bQjkdUDSOhevJr/+e94GRXkSXmu6NV2md6cOWg5C
    J6ovRS6fv4BJ+o0B++503UIM96HKX7kOZU2HrBfno5OgIEEH8v489z5jx6TOaI/b
    qkZ/pomaGcUmBcS1IlGbdJ2ezkmtKgrSkYrDH4KqJTfqOu/NcPniBzP9x76A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jWk7WNaW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jWk7WNaW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMDXSRpasvgZ0CO2GUXmIDyIzaAXz/eZAXHN+8TZI89nfOpkND9fNpY7E6JRZOHkWD0UWmsvvF5O1pr6+zZg/M/1KWAeLcZK/REH4kqZeJ9TLXltulqE
    qxAYD4RyIC/8qYEzwyP+3OWG1U8nINSnx/f7hfG4fLtDESiUWr6zckSldy2P9OlUGpqBDX51245rGqDwvE8Z/ynlNvJDazWuyOXdT8z7BCa36yY/abac60Is
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
    a=p-nOP-kxAAAA:8 a=JF9118EUAAAA:8 a=yMhMjlubAAAA:8 a=m1UO6bD35eZV1AGazdsA:9
    a=wPNLvfGTeEIA:10 a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
    a=XN2wCei03jY4uMu7D0Wg:22 a=xVlTc564ipvMDusKsbsT:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754840AbeDIBqj (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:46:39 -0400
Received: from mail-bl2nam02on0114.outbound.protection.outlook.com ([104.47.38.114]:2685
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932444AbeDIAeH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:07 -0400
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
Subject: [PATCH AUTOSEL for 4.9 268/293] x86/power: Fix swsusp_arch_resume
 prototype
Thread-Topic: [PATCH AUTOSEL for 4.9 268/293] x86/power: Fix
 swsusp_arch_resume prototype
Thread-Index: AQHTz5lkevEXBdGU60yGk/7NLrKv2w==
Date: Mon, 9 Apr 2018 00:26:24 +0000
Message-ID: <20180409002239.163177-268-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:sEvjXVb/wBsEbx/uX7k2YySI3uHIDh8tDnyuF78USkHS1bXFrLlTFPKFRvr647Z8TqEMjUVBZytOsaFEnHjLdDdL8yytyYWEKE5v5+39ZkzDyc1xLc6tHt7IByLyDC2OistIwaMF3hcTq2KZyObkGPqYoR50odYiRgvh1XQ/gbQZr94SGbFtJ2tEP9h6p6l+bWzCGzzvICOsCCboNE0FLlZh/S3C7RhoKHxOj11TdvRdlZnYR4M8oLOcWaN7VHx6;20:3m4tRQBsn3GwMBOwNXbsZ6Y7geezu1R0ql+tLgAjV9t0Yu4YmzfYk6JYbPZbvGVf9I/Sam1JWRBhDUEI0JAp4jyQtL4wrwy8+WJ3+5qm/JmeR7GWQRYlzK326iW5XzDARBC/e2HIhNvfxqa1/DHykm4i9p7zmDOZZ1NpGXRwCrE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 34194d9c-ace0-4c98-924e-08d59db19820
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984FC8589FECBE22BAA62A9FBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(346002)(376002)(199004)(189003)(26005)(99286004)(2906002)(14454004)(97736004)(59450400001)(8676002)(81156014)(81166006)(8936002)(6512007)(106356001)(76176011)(186003)(3280700002)(10090500001)(36756003)(6506007)(66066001)(3660700001)(72206003)(478600001)(6666003)(53936002)(2900100001)(105586002)(102836004)(966005)(2501003)(110136005)(54906003)(5250100002)(486006)(1076002)(25786009)(6116002)(6436002)(11346002)(6486002)(22452003)(4326008)(446003)(7736002)(575784001)(86362001)(305945005)(2616005)(476003)(6306002)(68736007)(3846002)(86612001)(5660300001)(7416002)(10290500003)(107886003)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: KElItWfIc2DQwXGqa3QhADBZFu2ONBP7D+I9bOSwI//WOeVJ0441l6wVsYW6lzzihRUow33Yiu9zo91CUoV8bvYDAw+OIQx6R2NpfVYcEujVwlUUlXuxYIjv3q6BBLPc+E7ekDUFIJKhYkD7qvNux7Tgc6CQyOlf+Sl6tZamfMUa9r4GCYPyfpm9yYqejveBurjm4z015X8+E1dIvms5pUfgtq40nIC5FGtN+3ZFGWNGljz33/B0FeeJm2WdlRX00u2q9svHmk4eyGs+wIAs7fcdUiaZFTADiFuzB8LGY2XPQOHGkMNfwQTQrQ85fFRVRGZID8xtointbKin9oiDVkavD5+6QEOL6feBhot1xuZsuoCN/A86ve8zubJ4GkChQ3Moa6tmdA2oHHaXBnZIhVGhXvKRPZw17QM8yAH4sik=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34194d9c-ace0-4c98-924e-08d59db19820
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:24.8164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
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
index 9f14bd34581d..74b516cb39df 100644
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
index 9634557a5444..0cb1dd461529 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -149,7 +149,7 @@ static int relocate_restore_code(void)
 	return 0;
 }
=20
-int swsusp_arch_resume(void)
+asmlinkage int swsusp_arch_resume(void)
 {
 	int error;
=20
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index d9718378a8be..249dafce2788 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -378,6 +378,8 @@ extern int swsusp_page_is_forbidden(struct page *);
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
index 56d1d0dedf76..ccba4d820078 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -103,9 +103,6 @@ extern int in_suspend;
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
