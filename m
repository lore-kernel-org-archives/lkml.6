Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161811-2-11599417426484885613
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161810; b=ccZLR75CwGWpf0XdQJA3JotFCQwc5Co0zPugXPr+TEzPLr2JL4
    LHTmymC/zx2EJ11Q9Jgrt4MfUsQZluegOUt6B2AvIaV6x2I8ZfXCWHDcNvlV9z8F
    tYXs0ug4vxA3az2xtUe4tpZ9jbURLWf8+NDpUV3/Lt/wYmdmiFdTChpiCZ7ADoYk
    FD7Pniu0DJj4ZD79wM35jBFk3w5/ngrv5/eIh+EIsx1YcTHbiUgWRLB2hSdGDKDv
    Roe3XacMVliIrGEn7yHcLIUK8SMMzBf6Q7GJJp5nwcuG20Bp4doIFZcHPGmhWM5h
    mIfzAWyo/xzPSPAz6xBKsMMHr4cheGYNoFiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161810; bh=fikzMe1XC84N2aGwB5fqnFfHB9njw2
    es3gUgeiJe/xY=; b=BP8b1C8YGKmcZSpOjkAI7RV5mspZ/TczQKJkV1QNAVy2dQ
    1XEzBnwhoAWmrfn2tqRCB9KAB4owDwoa9kX8LuSRHOZXtqc18mrXdrnYwNG9zjnB
    +v8vEQ+TBgpfFbay2h/ndy2pHj0rzgZO85+oZ/5hSBOHm9PPcKhSNE5RH+xRD3UB
    rzoFBbntp6Uq+ME087wXPWyGEtRmZjLl7nwaPrTPxNTcKa9OxAnHiqlfu6n0wNW2
    Jvg4E0ZiR0buCJuMJXUwZEl3px/n+gFMLvu8JcQZSpAOFhCgy2vTvS2BuWEdEnUA
    bp/H2lsmJIHUxJ7lq6/y8hK1nXGg9jeC+FNS6bUg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=K6HMsPZx x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=K6HMsPZx x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfEtSy2TLZMOObey6jRmJzFjCCBtaw0K9hVWfU3ykkorGiGx+03N5QUVFd4e+peXUgNzbRrTO8nJXMOnsP2Vll8HPyI4Arx5DLnIi3VW585hafFCYZcuW
    prSLKXGiazWD3hY+MreW1I2tYRdgkzxDv65C723M0UxVi6i9YKh2WxK9Yk5Iq87uYFw7VI4KfCemBvYvLbfv6QNspHtiGnxOl+vs3bdEy3LbysRorDUhRydZ
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
        id S967500AbeEXLgf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966961AbeEXJtp (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:49:45 -0400
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
Subject: [PATCH 4.9 23/96] x86/kexec: Avoid double free_page() upon do_kexec_load() failure
Date: Thu, 24 May 2018 11:38:06 +0200
Message-Id: <20180524093606.923671272@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit a466ef76b815b86748d9870ef2a430af7b39c710 upstream.

>From ff82bedd3e12f0d3353282054ae48c3bd8c72012 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 9 May 2018 12:12:39 +0900
Subject: [PATCH 4.9 23/96] x86/kexec: Avoid double free_page() upon do_kexec_load() failure

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
@@ -71,12 +71,17 @@ static void load_segments(void)
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
@@ -93,7 +98,6 @@ static int machine_kexec_alloc_page_tabl
 	    !image->arch.pmd0 || !image->arch.pmd1 ||
 #endif
 	    !image->arch.pte0 || !image->arch.pte1) {
-		machine_kexec_free_page_tables(image);
 		return -ENOMEM;
 	}
 	return 0;
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -37,8 +37,11 @@ static struct kexec_file_ops *kexec_file
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
@@ -79,7 +82,6 @@ static int init_transition_pgtable(struc
 	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, PAGE_KERNEL_EXEC));
 	return 0;
 err:
-	free_transition_pgtable(image);
 	return result;
 }
 
