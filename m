Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485347-2-12300209946749198044
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520485346; b=nJdYW3WURTL3pHOWqbdBPXivUkJPZ8wZYHMDupL3O7dxOQu
    5nB0NtbfBdx8AKnmPZzlQQQS8oWpV155ssDdz2cwjqxnRGnJ8ygBr5TzspVlyNNF
    rOTNwbNK38SSuzI3uFDO9uXIDbCwnBc+KGMK1Ss+HugTuJMlG9t4tBeKRjFnCz6Q
    EArZQ7o8FPg7P20Pz/jJxLV6AnIru+QkNoq42PHOTuFOHgl+pSRwHrLEOy+cfmcx
    O2NF8RRGIxu2hY1POqdsU2Sj5s8nd8rx3dc32bBspu9iO3kCyILYr1Lo0dYEgqt4
    Y2Ay37B36zSZoXbPHn3JaGM1siP9f4ilzMaaWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485346; bh=ogaTKA
    3aE63lDMczu/L4ZeRCso88SXx3U6f/JtELxuo=; b=pr3yoeZd4/dO9973TRxRO4
    rLI1TKZBZJ6tVgslemOkxbiEG+BF6+L19RC89VHzZJ5BNdLSRKTHNrLv6nARrJkv
    a3Ynt/cCNTy2XIPbD/wP1EKn4d4ffCSaTR/wsLc7wfTdtJXs+vhtG41I7qr9maME
    88Kg/OjI/vwIGLaQEDZepc6KYutPaW04d7pYeAdNfqXPrRp6IK4osXXK3YkVpyCY
    7kwzIKW0fz7fWmltei9vd3nxCgzHOHg6jRLanNiESvb5/BiYX3L8SRILZvNNexnE
    h+fJUihhUKOwOx/JChlEyO3++rpldGqiGuiwXdJYZ9YS4nB6vGKSfH+bGIER8IOA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L1LczTls x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=L1LczTls x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965854AbeCHFCW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:02:22 -0500
Received: from mail-bl2nam02on0104.outbound.protection.outlook.com ([104.47.38.104]:33440
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965830AbeCHFCS (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:18 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Dave Jiang <dave.jiang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yinghai Lu <yinghai@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 103/190] x86/KASLR: Fix kexec kernel boot
 crash when KASLR randomization fails
Thread-Topic: [PATCH AUTOSEL for 4.9 103/190] x86/KASLR: Fix kexec kernel boot
 crash when KASLR randomization fails
Thread-Index: AQHTtppBRYQ9xxIh4kmOl+leNbU3SA==
Date: Thu, 8 Mar 2018 04:59:36 +0000
Message-ID: <20180308045810.8041-103-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;7:TYGhVZMPg/6I7UKMSFgo4eDPkN28hkgIs1XkLnvN0Y3scYmz7WdcxqcK02u8K7KVfbdaqr8tdzSvx94zpGg5CDJda9JHm//FAkthlagVZKsRQhYXwP2nPgzrWuzkgG1e+KU/eeD3InsIaJnyqyO3LJr4GA1/+Km1S+EvaAeOSh6gnPVwZqZO/GI3HhahelmV1fgXCJ956u7b1RzMkKDByk2Zl8K+4VoZ2PjkxgVb+1Y0xj84jKC0GAgyLnTwVJ99;20:daWbAFs8PSn1KM0hSvDtEY5/NCONBVplDChFOOTfGq9pQKeJ65ceKPB+bpwQSbuH6QPpyWHkRwkLpJPy/FSAgiWO5rhaVe05FPueOk1WrddCqOhxJlirGGslFrVIeomD2ryAG8AjzeRexExG7G4uD5pVWghGhgvEP6mXuQbmJIg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a9d3b7b-606f-45a2-2b20-08d584b1c0bc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0997438813FFEC552D297964FBDF0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(42068640409301)(153496737603132)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(966005)(97736004)(54906003)(76176011)(2900100001)(106356001)(99286004)(110136005)(316002)(3280700002)(22452003)(10290500003)(105586002)(36756003)(25786009)(72206003)(66066001)(3846002)(6116002)(3660700001)(4326008)(14454004)(1076002)(478600001)(2906002)(10090500001)(5250100002)(7416002)(6486002)(86362001)(5660300001)(186003)(305945005)(8936002)(81166006)(2501003)(26005)(2950100002)(107886003)(6306002)(81156014)(6512007)(86612001)(6666003)(8676002)(102836004)(6506007)(53936002)(68736007)(7736002)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: fMZdMbGQBEKPSmeWC9ZgPcwAD3e0Jk5XchjhLIzn/hjheTrDUJburalwD28exAqtDAu7qp62P0G+S39+k7it5RobNq/NtKQudTIA35jcQE6jSVi4WDrPWjdCkI7+X2zVzwA+gYfA58xPlxvKgEfZjQNu/6BGYvPdKWRT5PZ+Jv0pjUjke2t0WbYC3Zv7v9/2HlSyiCk0F9mkOvVmxtBu5ATH18ngXjBwGcdkhB82RZoeha4Ak7GzXysdV8p7JV5aoELtcGSmTkqiQVaKvYEN5VbAM9pCKEyQ+PUD4gZCaQTwTVtWmNGDjWobJmqlS3BuVe1n7QgHnNF7x/AKp92mwg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9d3b7b-606f-45a2-2b20-08d584b1c0bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:36.9300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Baoquan He <bhe@redhat.com>

[ Upstream commit da63b6b20077469bd6bd96e07991ce145fc4fbc4 ]

Dave found that a kdump kernel with KASLR enabled will reset to the BIOS
immediately if physical randomization failed to find a new position for
the kernel. A kernel with the 'nokaslr' option works in this case.

The reason is that KASLR will install a new page table for the identity
mapping, while it missed building it for the original kernel location
if KASLR physical randomization fails.

This only happens in the kexec/kdump kernel, because the identity mapping
has been built for kexec/kdump in the 1st kernel for the whole memory by
calling init_pgtable(). Here if physical randomizaiton fails, it won't buil=
d
the identity mapping for the original area of the kernel but change to a
new page table '_pgtable'. Then the kernel will triple fault immediately
caused by no identity mappings.

The normal kernel won't see this bug, because it comes here via startup_32(=
)
and CR3 will be set to _pgtable already. In startup_32() the identity
mapping is built for the 0~4G area. In KASLR we just append to the existing
area instead of entirely overwriting it for on-demand identity mapping
building. So the identity mapping for the original area of kernel is still
there.

To fix it we just switch to the new identity mapping page table when physic=
al
KASLR succeeds. Otherwise we keep the old page table unchanged just like
"nokaslr" does.

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Dave Young <dyoung@redhat.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yinghai Lu <yinghai@kernel.org>
Link: http://lkml.kernel.org/r/1493278940-5885-1-git-send-email-bhe@redhat.=
com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/boot/compressed/kaslr.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/ka=
slr.c
index 6de58f1bd7ec..eb5ff66b4d7a 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -460,10 +460,17 @@ void choose_random_location(unsigned long input,
 			add_identity_map(random_addr, output_size);
 			*output =3D random_addr;
 		}
+
+		/*
+		 * This loads the identity mapping page table.
+		 * This should only be done if a new physical address
+		 * is found for the kernel, otherwise we should keep
+		 * the old page table to make it be like the "nokaslr"
+		 * case.
+		 */
+		finalize_identity_maps();
 	}
=20
-	/* This actually loads the identity pagetable on x86_64. */
-	finalize_identity_maps();
=20
 	/* Pick random virtual address starting from LOAD_PHYSICAL_ADDR. */
 	if (IS_ENABLED(CONFIG_X86_64))
--=20
2.14.1
