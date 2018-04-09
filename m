Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3643807-1523234099-2-5609124454083179397
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
    1523234099; b=NA1GaOlEsNJx/+7WzAcjzBty/MsgzbeOopL03RCg4ZRFWHlM/0
    pmbzhPUn0tieoerjQ2Tp6uYK0OoJP3kTSLxINPOAXJBvMWhDZmnlGNQN8x+DajkW
    J8liq9wgXzjVveqMi4Bel6mZ8sqI+U8tCfClSHQ5pvvdPygmkCL1WnF5ZDpGvPmx
    qLTc+Q4SaWvcedRinvGGZdKELX6scAzo6pZ9blDsqoekk43XvOPkSpV01FHV5Z9T
    DmcBwcRtwpQRZs91rOH2ywO2OGpS0j6As3Vuh3CEUSS7r2RLEMqUFbA5VcKdaXmn
    8Q9M8jyxrTmYx6+6tepP0iGh5Q7BRJqF5Xlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234099; bh=bUgEYplZQB
    TdXDXdW133r3jkl0ynNJVC9mWCYmZzgTA=; b=sL3EURQu2e4UKrRIcjUlOhl5Jn
    oMPUQqM3J+zBzUuammTqR4D0YIumx8ozKslwdhZMwNXIuMrKjQp+ZddSOY/xHbYX
    40nTgl4Lsc6MRcYJOiH7uhW1Q7Fiv5yupc0tCc3vEU40yp+puPb8JS33YBCvujYq
    PzF0Hfo8FXfptZ8QFWsKULOf1nwAk7bPNDOXFeqsvgEtxVsQXUXbv4gjfCKoy4jD
    QhZWWK4ji5GqSchrg2S84M9BSJGNEVYMjjbixZBIlCPQQ8eLHLWhDSGX1Fo/cKgi
    NTgJX8kOQHfzgyZtAz43j+oamcnu2Ud53cB0lRz6qkDUbzEsSKxNouon1wPg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V2NbFgvK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V2NbFgvK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBc4gop4orYU7IWm9uSS9i+0JcCff+cAYQxN09FyJ9Uh/aeLqKjSMnpclrXRFGE+P1Gn2mSYp8V6DO99GyOsjLIGvSNoo/D3Tdw8mxXZ/VQRx04wUMaK
    1qmgfr4u3ROCD5ElWkmp0e2cob/Pf+ogUPtfzmd0+1MmoTK08KjnucYCCqS644vsM3eey5j5xTZsedZDvyN/9byoM9ELiZY5j781DJhIT5Gs1mBVuLqznW7w
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=SRrdq9N9AAAA:8 a=VwQbUJbxAAAA:8 a=drOt6m5kAAAA:8
    a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=YM1bZ78Ye1qdObJGYFMA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=RMMjzBEyIzXRtoq5n5K6:22 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755830AbeDIAe4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:34:56 -0400
Received: from mail-by2nam01on0123.outbound.protection.outlook.com ([104.47.34.123]:51296
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755715AbeDIAex (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jia Zhang <zhang.jia@linux.alibaba.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 289/293] vfs/proc/kcore, x86/mm/kcore: Fix
 SMAP fault when dumping vsyscall user page
Thread-Topic: [PATCH AUTOSEL for 4.9 289/293] vfs/proc/kcore, x86/mm/kcore:
 Fix SMAP fault when dumping vsyscall user page
Thread-Index: AQHTz5lvhyvmIvO5jUedhnGF1iComg==
Date: Mon, 9 Apr 2018 00:26:42 +0000
Message-ID: <20180409002239.163177-289-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:/KA8Sc/BIpNAXwlYUp5W+9IV55nFrj5AQpONvKOzkwLSYf7zZqINF3R07yWExsnTOi1t/KSaYUQqf2jcUrmMAnJnOZ72X7+a6zA7k1A6LRs76bWaD0KcS1ajnIXH+JzckSFG3C6FCdVvKAwIR7/0LoTUiIKB4oyNjTb4V0hvGfBOkxXLisYvGIDQhM7OlMXH/5VvjQD10a6dEU2pV8KJMPAZHByqJAcBxZrh/q/7/ggfgBU5gParufNLTm3FVJly;20:wf7NM3is2eCECoXXFbzNlCPApGWWBk6oUMeC2eVTcp3+Z1MvTk+DwXMlfl4Xq5C4qZXnS7CY7YIeaOQ4O1twJhBRGd8bYp49keWPTlSlJTRSUoKFpo/mdeXhvsN3JIyjdDQ1wSBkuAawSbVnSKyJR2if0fPRFOtyGg+nBXMK2GE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3598ffb7-6e50-4741-017a-08d59db1b1e6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806E1D73B90F332D7C36D1AFBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089)(42068640409301)(168385556255192);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(6306002)(575784001)(86362001)(966005)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: gKnT3VGpY7DQ9rIHpF5/RtSqS+Lv2ZFpCn+NkhNSxz1ASnI4qLBiznh6xdUbRmmcB6uhu833Yl19/Y+IftAfH9ioxT98hTxVcPIHwWYk2VyCZJWe91pvShOlRGWrlGw+d3LnyOXoB2zLxkLQNrMhKorxJkWzK66BnJHsxbvhjMgVOnRP7Q1ahOUYuLIiJvru/qe25IcHTHEk0yqlDiyDAMEG5mhnCzgubpuPLraHkrJYQkuo0cBMRwqKaHujCR7MY8fYgy67njSS5yBhD5BtAK3P1e0KVMnVUBuQglPbkBq3hvcdnpQGrG/YrHcZQsWLcslWys17jtsAnhJD0Wp06lz5fC2T4rGxgGFhCjF4dLgFLgX44qag297mN6NFndCj9oEpA4tMm16l3rsGTjzw/xE8rCA2inLQgQEbfY7DRDg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3598ffb7-6e50-4741-017a-08d59db1b1e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:42.4884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jia Zhang <zhang.jia@linux.alibaba.com>

[ Upstream commit 595dd46ebfc10be041a365d0a3fa99df50b6ba73 ]

Commit:

  df04abfd181a ("fs/proc/kcore.c: Add bounce buffer for ktext data")

... introduced a bounce buffer to work around CONFIG_HARDENED_USERCOPY=3Dy.
However, accessing the vsyscall user page will cause an SMAP fault.

Replace memcpy() with copy_from_user() to fix this bug works, but adding
a common way to handle this sort of user page may be useful for future.

Currently, only vsyscall page requires KCORE_USER.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: jolsa@redhat.com
Link: http://lkml.kernel.org/r/1518446694-21124-2-git-send-email-zhang.jia@=
linux.alibaba.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/mm/init_64.c | 3 +--
 fs/proc/kcore.c       | 4 ++++
 include/linux/kcore.h | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 7df8e3a79dc0..d35d0e4bbf99 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1014,8 +1014,7 @@ void __init mem_init(void)
 	after_bootmem =3D 1;
=20
 	/* Register memory areas for /proc/kcore */
-	kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR,
-			 PAGE_SIZE, KCORE_OTHER);
+	kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR, PAGE_SIZE, KCORE_USER)=
;
=20
 	mem_init_print_info(NULL);
 }
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index df7e07986ead..7ed961c0124f 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -505,6 +505,10 @@ read_kcore(struct file *file, char __user *buffer, siz=
e_t buflen, loff_t *fpos)
 			/* we have to zero-fill user buffer even if no read */
 			if (copy_to_user(buffer, buf, tsz))
 				return -EFAULT;
+		} else if (m->type =3D=3D KCORE_USER) {
+			/* User page is handled prior to normal kernel page: */
+			if (copy_to_user(buffer, (char *)start, tsz))
+				return -EFAULT;
 		} else {
 			if (kern_addr_valid(start)) {
 				/*
diff --git a/include/linux/kcore.h b/include/linux/kcore.h
index d92762286645..3ffade4f2798 100644
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -9,6 +9,7 @@ enum kcore_type {
 	KCORE_VMALLOC,
 	KCORE_RAM,
 	KCORE_VMEMMAP,
+	KCORE_USER,
 	KCORE_OTHER,
 };
=20
--=20
2.15.1
