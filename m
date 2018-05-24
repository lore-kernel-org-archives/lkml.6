Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1900785-1527164075-2-2550861391114649616
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527164074; b=GPtqiU8alGFVgONU76P47NUQz5EauNtOX6FGM22fswp2lUw/Zh
    2/a2fsL9xWUbnWQAo49DXSuQFe7vB/s5KTuVGW7wh78gr+3uQ5OphqzqAHnE4y2o
    eS1mxfcluVM/a2sFWvj6kpNQ5yL66B7P9EcoqG1asBcBfWb/oqgy3Lpj7JBBeROC
    /sOib/5EoYZi+eM3mX/qFoHplQJAEUMQUMadTMM7QI8JtAcJJXRUGBH29irX/ZFa
    FAPjsKcsaKQubdyHun1crKu8x+AWp1BfZ7qjgMhTEHyTIcFkMjPEUiK0l/ZtMoFY
    6AGn4NXXOQDqXrNxRBnFt8FuHjMt0EoSVKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164074; bh=DRJbhNZqJBK42h4FVEA3yZhB9QenBv
    3Z/B+mVGiozLI=; b=agPer+mtCW/q5iTOau6bZc2kgT5oTdGACrVmI7zm2/sDbY
    xVoKFDhkyQYeChvYRAhcXKs0a72o4Dbbrq6D7ZTmkcOjKqEeTuYdsa4svy5GaqmE
    jzL0iGVDPTlPxXJ2DL/jvkcERVhmMc7W2LZyJsgx2vb4ahCVSVlG+WadzansePYP
    EMeAb32cbCTrEEmbF/1DeIogK/JfiObNoSM1LiMtrqd3hKGdaFYz4DZNSJBXp7YY
    yigbmuYuqILvhK77ePf74wGivwNkyW7j6Ep6jUMh5BFSL8sRPFk7oPtCP9aGQiu6
    LjJKqU8/xFYhUOjr0K9f7+pa4igGvIKiIFCcvdCw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=uecEDenv x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=uecEDenv x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN93Pidw5d1iWJKWTItWQoEqqo/iii3lA3cU/n9+pxGzGM5EI7gsTLI+mrLwakTFI3fGXJvQUJY2pzSLZbj/YfrrUDRZ46rViH0h3uxz1zLtMjx2aeBK
    RLwf7nFO2cuX13hGlagADD4tjlBFvfsTIJQoqYbdexCXH4nw+9k+RobLMF8lgMZ+j4cd9ij0yFSMPLWwt3D8wF6Sb7JqwJ+PDuA5ZIA2OBJJ2SKFxJkOvT3w
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=20KFwNOVAAAA:8 a=zd2uoN0lAAAA:8
    a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=4RBUngkUAAAA:8 a=KKAkSRfTAAAA:8
    a=oGMlB6cnAAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=4nylR2gx3NDDJxsWytsA:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
    a=cQPPKAXgyycSBL8etih5:22 a=_sbA2Q-Kp09kWB8D3iXc:22 a=cvBusfyB2V15izCimMoJ:22
    a=NdAtdrkLVvyUPsUoGJp4:22 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966410AbeEXMOU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:14:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965900AbeEXJm2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:42:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot <syzbot+d96f60296ef613fe1d69@syzkaller.appspotmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Baoquan He <bhe@redhat.com>, thomas.lendacky@amd.com,
        prudo@linux.vnet.ibm.com, Huang Ying <ying.huang@intel.com>,
        syzkaller-bugs@googlegroups.com, takahiro.akashi@linaro.org,
        "H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org,
        dyoung@redhat.com, kirill.shutemov@linux.intel.com
Subject: [PATCH 3.18 45/45] x86/kexec: Avoid double free_page() upon do_kexec_load() failure
Date: Thu, 24 May 2018 11:38:53 +0200
Message-Id: <20180524093126.768103561@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit a466ef76b815b86748d9870ef2a430af7b39c710 upstream.

>From ff82bedd3e12f0d3353282054ae48c3bd8c72012 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 9 May 2018 12:12:39 +0900
Subject: [PATCH 3.18 45/45] x86/kexec: Avoid double free_page() upon do_kexec_load() failure

syzbot is reporting crashes after memory allocation failure inside
do_kexec_load() [1]. This is because free_transition_pgtable() is called
by both init_transition_pgtable() and machine_kexec_cleanup() when memory
allocation failed inside init_transition_pgtable().

Regarding 32bit code, machine_kexec_free_page_tables() is called by both
machine_kexec_alloc_page_tables() and machine_kexec_cleanup() when memory
allocation failed inside machine_kexec_alloc_page_tables().

Fix this by leaving the error handling to machine_kexec_cleanup()
(and optionally setting NULL after free_page()).

[1] https://syzkaller.appspot.com/bug?id=91e52396168cf2bdd572fe1e1bc0bc645c1c6b40

Fixes: f5deb79679af6eb4 ("x86: kexec: Use one page table in x86_64 machine_kexec")
Fixes: 92be3d6bdf2cb349 ("kexec/i386: allocate page table pages dynamically")
Reported-by: syzbot <syzbot+d96f60296ef613fe1d69@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Baoquan He <bhe@redhat.com>
Cc: thomas.lendacky@amd.com
Cc: prudo@linux.vnet.ibm.com
Cc: Huang Ying <ying.huang@intel.com>
Cc: syzkaller-bugs@googlegroups.com
Cc: takahiro.akashi@linaro.org
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: akpm@linux-foundation.org
Cc: dyoung@redhat.com
Cc: kirill.shutemov@linux.intel.com
Link: https://lkml.kernel.org/r/201805091942.DGG12448.tMFVFSJFQOOLHO@I-love.SAKURA.ne.jp
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/machine_kexec_32.c |    6 +++++-
 arch/x86/kernel/machine_kexec_64.c |    4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -70,12 +70,17 @@ static void load_segments(void)
 static void machine_kexec_free_page_tables(struct kimage *image)
 {
 	free_page((unsigned long)image->arch.pgd);
+	image->arch.pgd = NULL;
 #ifdef CONFIG_X86_PAE
 	free_page((unsigned long)image->arch.pmd0);
+	image->arch.pmd0 = NULL;
 	free_page((unsigned long)image->arch.pmd1);
+	image->arch.pmd1 = NULL;
 #endif
 	free_page((unsigned long)image->arch.pte0);
+	image->arch.pte0 = NULL;
 	free_page((unsigned long)image->arch.pte1);
+	image->arch.pte1 = NULL;
 }
 
 static int machine_kexec_alloc_page_tables(struct kimage *image)
@@ -92,7 +97,6 @@ static int machine_kexec_alloc_page_tabl
 	    !image->arch.pmd0 || !image->arch.pmd1 ||
 #endif
 	    !image->arch.pte0 || !image->arch.pte1) {
-		machine_kexec_free_page_tables(image);
 		return -ENOMEM;
 	}
 	return 0;
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -34,8 +34,11 @@ static struct kexec_file_ops *kexec_file
 static void free_transition_pgtable(struct kimage *image)
 {
 	free_page((unsigned long)image->arch.pud);
+	image->arch.pud = NULL;
 	free_page((unsigned long)image->arch.pmd);
+	image->arch.pmd = NULL;
 	free_page((unsigned long)image->arch.pte);
+	image->arch.pte = NULL;
 }
 
 static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
@@ -76,7 +79,6 @@ static int init_transition_pgtable(struc
 	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, PAGE_KERNEL_EXEC));
 	return 0;
 err:
-	free_transition_pgtable(image);
 	return result;
 }
 
