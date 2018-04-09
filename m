Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233315-2-14414965652933288173
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
    1523233314; b=mAOdJ1pWhC0JoscfknBzoRCqzpoTc/bt8xqu8ZHv+RCjVpuzeM
    6eCL5HSPCDMjWxOtS0M4VdSxDe2fdoErqFkdVHnL40U1+6dOxHRaf0SYvEEZYFZr
    NqPFSWapVZTZP/npXAyQeqqZcIrGhIoIIS/538SKpoHn/E6FD8SDLt/zvLSEeXNW
    +NqI8Fy3+lDNDY7yIR+1X/WT0F00CUiixMrE+e2X+u06pNc7uT+1Og9/g9/DMtY7
    VOjiMonE1XWqtUrT/KLsS9TrzPUjGeqPCtSYZSKogOAX1PfLyYj8rYewKjByRo3q
    e0Zwe6Ha1Btac32mFpqVWcwM8FwX4/qw+dew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233314; bh=NMhPXnHkxH
    eNgPrpRwIdBJZ+Wfcx8oFwFDHlQKPX624=; b=ll3tybqR0lgMwhJSVhYpzF58SB
    DDzjXkyCe617Nl/Vb6W7DQU4hgWBEtnbnlBG9H5IjrCoCutNIvOJK8i0TRFoitIt
    jqYXR5SR3Ljd59TzPOXS5ebRV8paPrs7MKSzZ+SZWow0AJC5Wc+D3i+LhqxrGvgN
    R+cxJbg2htS81O9uUPPdqkhlqQeNN90Q17akYAj70hLaAJHUN2Ic6k2OvJD1guGN
    P/4IhEaQN0zS8JKIyq0sNJq5GQfrRwx3EjbnFN4N74WaFDUE8AVLCD9BNkjO71J8
    LhcQvTLK9jkI2J79cJxaBEZLyIcc4coKZalQsVbyp10qHAE6QAE9okWkKRfg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aeGcp63m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aeGcp63m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMaiuhaliMHBKW37QvfW8sYJsrPvm/YXbldC8LjHm/NWYtFnaN3FhMgYNBcAcoc6D052pBVyR5S1SNQMBioPSKOPymusUasfNAIY5lrNVoTMoOPRHB0a
    75J5quYlE6mqsynJ0i0/ZcjXq4tkZNN/cJHAnPFcXgCTFUphH70WV4CXG5VmfCZFLCXfa/70xW4Fm+emLaCjWxlz3mD5RJlhWpFcxS57o2Yrphe0vP+DAMip
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=SRrdq9N9AAAA:8 a=VwQbUJbxAAAA:8 a=drOt6m5kAAAA:8
    a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8
    a=YM1bZ78Ye1qdObJGYFMA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=RMMjzBEyIzXRtoq5n5K6:22 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754520AbeDIAVw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:21:52 -0400
Received: from mail-bl2nam02on0127.outbound.protection.outlook.com ([104.47.38.127]:48448
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754502AbeDIAVt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:49 -0400
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
Subject: [PATCH AUTOSEL for 4.15 181/189] vfs/proc/kcore, x86/mm/kcore: Fix
 SMAP fault when dumping vsyscall user page
Thread-Topic: [PATCH AUTOSEL for 4.15 181/189] vfs/proc/kcore, x86/mm/kcore:
 Fix SMAP fault when dumping vsyscall user page
Thread-Index: AQHTz5hi+R/wYZl4zUWBb3YMJrEiDQ==
Date: Mon, 9 Apr 2018 00:19:11 +0000
Message-ID: <20180409001637.162453-181-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:o9Jn3By8lTO136TZgPeHsaxDnl17KbmqPUIczDgXrLUZp3ZIGLzo848bSa4690QIgQBpxMwfUA1MvUrli3SP4KMCqIblB6rPn8KXNGms3jPJjHR21NfrN84xRZpEiQZawvsMXSGkV/668fQhN6Ql/HOgBT6bhCnxQNMLZM6DXLlbTvWX2nyKxj9ATdSXWaNMOf7bh21CPnzZ08QtlQaDPuu7elBOjg7tTe9f/LD1yh91ngPmoWsKwtzB8QJLxGXH;20:/sOmWttYG8AKNxRRsZMuonLb9kAxxjZfDqOnSIdTt8rkVDrFtGMA0CgTmaKxCUL4dN1SknZSmFFnnZ3KS9wn5ZJJmkJej21TrvyDV8zkfSZy7cSDoRT6IpVLH5G+uR+WO5FBeAdS78+aSQ/4gU4t1H5FM2ByKMFSn9XrgQAzsUs=
X-MS-Office365-Filtering-Correlation-Id: bc7809ac-5e3e-49d3-d64d-08d59dafe153
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1125C025C50678B74BD561DEFBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089)(42068640409301)(168385556255192);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(105586002)(7736002)(8676002)(97736004)(81166006)(106356001)(966005)(81156014)(305945005)(14454004)(66066001)(1076002)(102836004)(5250100002)(478600001)(2501003)(2900100001)(22452003)(72206003)(68736007)(26005)(86362001)(575784001)(8936002)(76176011)(6506007)(6116002)(6486002)(186003)(5660300001)(6306002)(3660700001)(316002)(54906003)(110136005)(25786009)(2906002)(10090500001)(6512007)(3280700002)(6666003)(10290500003)(53936002)(99286004)(86612001)(3846002)(6436002)(486006)(4326008)(2616005)(11346002)(107886003)(36756003)(476003)(446003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: woNbnyWM6WIMDVjGKDNg6w6TuR0/Zos1h+nEljUNl4x91oLlQD+F/JJFrCA+AAKW0rv33YayA8godQEtswVwVDB1SYonm3FtlELI0LtpBwlNmMSTF5tx8NWaB/rGKlr1/jMUGKWF+RLdORJb0KH+hLa4WBhulLR2LtI0nkxCujoSjOrBlGwkrihcyfjraop0zxleRgSSTmS8hDejZDdgHOyrpcvMofMo9A80tr3qkMEj8b7HBJu8Arime1deYbmUsMQuvm7b0mt8JBG/C9lp+zkw+jjdXFd57j+yAZZ6TqzlfPQvUlc+pBMomkyaLgNfXrwRn+V1l2zJD7/evxa4c44f2OSUzSd1GL+j2CtjRDfq3ovrbq3qR8pOi92xahpY6wsh8dNpsn6p/VuFyd96LRlwF5qdTkikp8zcwbclkiM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7809ac-5e3e-49d3-d64d-08d59dafe153
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:11.7675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
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
index 60ae1fe3609f..780097ed24ea 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1186,8 +1186,7 @@ void __init mem_init(void)
 	register_page_bootmem_info();
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
