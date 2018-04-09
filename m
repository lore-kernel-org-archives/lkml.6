Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523242289-2-18073980855689521113
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
    1523242288; b=jvG5YZ2a1fbkYmZ1s708107g1l8gBR11sq1K2TSSDoO2Ay4/6V
    FShDLFkx9C34V+ek2isGU3KnVPbtmIc8N8J5/EP4+N+6iE/Es6Y7PFzDKASkKd9Z
    x6ylGQdnIqoeyxfcs1YMursfmLpz+y24i481IggAMY1DhM1gU4LT2qzsmmqDeCs2
    VFqmAx7UJjN4wmXmcTN93tlfNOETmLg0+dCembTTIa4Q0EbStPmqdftblxsej2PB
    NIrPUnIKsAPapPVGnsc+t3TWvgHWOz7Zp+mun3wRNPdif0HTG1NAHxO7Ww/ZkeY3
    6ZZuJYVZHoGnzIrA2OItGwZTu23yxF4/wmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523242288; bh=EX+6U/2Kur
    z3He+Y7Lo37MR+RlBwaqJbp1fSu6ScrOI=; b=TF1hvb6F+1wgOtjuCsiWvM+prF
    qWN3sKespAC3Ow2Avt8SPv4TopGiQlaYmegUyvkbqOXwNg1qIZeCoZeNR/YahkEX
    0ITorOYDF0OLm2lWwi5a8EiW78huaAwFE3e3IbSsXFOoNgjnJPmaHykZVe+vCBE1
    YBbFsyiygEYg3kSjLSZXAMdocGx52fF/ihU5T50PINbW6Npm6AionvE4b7Rwh5HE
    p8vcs7P+Afry5dWYA0Jd1qNw52O8D53FpG/Y3jzy/IwXvCGtpeQl6trJjltrKUo+
    Ky3CEd5nTMJA8ZB10tM045w5XHymQg9gXhuPV+odwC9zXFhQqRDVizZY2Mdw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G0LNojp8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G0LNojp8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHtcQKk/Z53KwBSrAQiawXlcHRjwOwCNnUpHGy8VYoaYl5bbgK0ZA5MIUtFZd3CNQxun9GBpgYwV1bIVzM8zDOxpJPxbIKU16RJyDGf7gZ0JsWvRA+KZ
    lYdCJ8wVvZiUQ5aDk3ianrlCr4uO59nd6m7bHtRtkQSHXqJEUOnXv5lCggYgb3yAhERXBu7sLlGkVMZcmChe4BTNuzxisbyBAI4TK+3Jg2DBiFiEMthKKnTX
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=SRrdq9N9AAAA:8 a=VwQbUJbxAAAA:8 a=drOt6m5kAAAA:8
    a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=YM1bZ78Ye1qdObJGYFMA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=RMMjzBEyIzXRtoq5n5K6:22 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755357AbeDICu4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:50:56 -0400
Received: from mail-by2nam03on0131.outbound.protection.outlook.com ([104.47.42.131]:4960
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755311AbeDIA0e (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:34 -0400
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
Subject: [PATCH AUTOSEL for 4.14 153/161] vfs/proc/kcore, x86/mm/kcore: Fix
 SMAP fault when dumping vsyscall user page
Thread-Topic: [PATCH AUTOSEL for 4.14 153/161] vfs/proc/kcore, x86/mm/kcore:
 Fix SMAP fault when dumping vsyscall user page
Thread-Index: AQHTz5jFiloHpnDSuE6bCLUXniuigg==
Date: Mon, 9 Apr 2018 00:21:58 +0000
Message-ID: <20180409001936.162706-153-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:Mbl/B000tmii6C83HVQJaC8RzQdbtwTaXC0llEl87hzqy+WJwleL8+R2kSVhX836MeqpGO/wmfq6B6XS+WafSZNqliHWDjt/uTt23FFcE3ILJqAW8noL1mBKeMKjjzkMB4Se3lcuC+DkyJUfiV5Az4Yy4JI1Y7OK5oA8eDmt0m/MAWTPUJxfsNzh3Q52zDGLCMFtev7tHw6ItAhrx+bc3lALxH7C7Az87692QSyV5NCJV7147cdS1+xU9acV/Hq0;20:5VpqM5p7LkfOO5LollkI/P5rp0ZnK5gLZZ8O8uuo3diIN0CAhF52mjxmt2PAOiS6W5lu8IM99nLGYaSatmZZZMEDkRpGNS3RPgj1iqsNUvgdEA0wMsfUOxfyrZ1E9mlofOMwJ2CWKZpB+fO5lc/Gxla1+eTcz+v+xA46WIIbIBM=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 21ff6ae6-000d-44fd-ab05-08d59db08667
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072573DF17EC2F48125D0762FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089)(42068640409301)(168385556255192);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(6486002)(81166006)(26005)(6512007)(6306002)(4326008)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(966005)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(575784001)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 6bNtABwiTtKAHEyPWAAUMAo8bqFkf08XLL629SceXWhAWUT73hcxMreXVAl/fWjpElxah144PM8ecy1P7m06qoXjcrMbUW2WOcXuuYgkvmofqJRye8yvqEnIquho2uYKtooruWmZmRF9OySEzrnp7QBda/AKcq7LlU5w+goKaVV6qV5km+HIqsCe8jPeBZU0OOmr7WGHP9D1/RwHWNBIwCpnihhMH283yD0kwJ4r7KfN9X7iOS3J3FqWlRu07nO+FEz3JkJ59lqpBddkDZXHuFSSpohQW3H5yAIPL41qH505dEv9q+4CNMMX3xVZU/NMHi77JdwfufzAglbBIWjg4bpgsaWYw2SjmZSdRoxDi1l1Dq6z0ev5c42R6tUgL+8/koOZpjRhMHYtfgthiMtM/DnfuS12YPGEmH6rWAIYSUs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ff6ae6-000d-44fd-ab05-08d59db08667
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:58.6279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
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
index fe85d1204db8..642357aff216 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1180,8 +1180,7 @@ void __init mem_init(void)
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
index e8a93bc8285d..d1e82761de81 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -510,6 +510,10 @@ read_kcore(struct file *file, char __user *buffer, siz=
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
index 7ff25a808fef..80db19d3a505 100644
--- a/include/linux/kcore.h
+++ b/include/linux/kcore.h
@@ -10,6 +10,7 @@ enum kcore_type {
 	KCORE_VMALLOC,
 	KCORE_RAM,
 	KCORE_VMEMMAP,
+	KCORE_USER,
 	KCORE_OTHER,
 };
=20
--=20
2.15.1
