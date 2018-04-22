Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405386-2-10630118547806331811
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524405385; b=v9ug49fDdoJ7K5ApYSFlpIZnemIRicNUGGYuwwGif7C/Ap49Zp
    TbKZ1WHK1OVZ4AXbTlule543LlSu6zCLuIQD+7CsvpuGMD4Wg8uwVzLurlqceHYG
    ZqmWo7dzyJdgRtJn5hR9f2oKPbpetw8REnQjSnqmBFzIEBEp/vdy7U9Vbv5oyfVQ
    94E8MFxjqEqJH7aqOLk4X1q5M9ktTSXca3Ec8A6/DrhN6rsk9aliCUmZNlJE8Xkw
    RtSi6IxRPcemzGNiQL9GRwz7lzDk2zvimaEBIYfNCApXVgrs5+ftdu3lR0jS3CEv
    zVs5MiHHExjajnbp+e36CwMJ7vR8nroxPeVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405385; bh=mgekYa0YBcFQvbKjVWtl/Vk4S7jl/6
    Fc7btQgHROUxA=; b=emEH9QX23yrV1zKrPrB/zqDXC+QbZqIzRebz5RN+vfrMxb
    DicDh7atAb28ggAtEyGNDBjSnWNtjwtFgj96cIkEeouVEvm75j+Afp27YIJVeR8x
    NFmXgoeMR5rSIBNSi+5I4UU4B2vKNnvP7kopm8q2iRVcQOCdaWE+Y48IUs50KHAq
    JXntHydyUVldpysVapHhKxf9K8ODotyNw5JIdsXngS6uHUxJyPop5edf8T6Ouc1S
    CooqhC6LbkhjQjZav5u1oxn5jARmj8+9nU6G7MmE8PDpHRkbZ8QHftbZcTBx4zdG
    wJ9Tk/uWmBnU3RQqpJ9Oga+/FHMwvrlT8Mbvag0A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOhk60u92ouR3VPTQiaj6/62D2cBtJ4RrwnMX6qJXGRx106sEx2F0r9f8QnEZNEG9VvuxDCGfipBaPLngYFWeez0GUkJOJs2gub0KRVW0pH1hBKPTPB+
    KuwISKfG1S0WtmnM+cOgmGONvnQ0UUqJ0VXSOGjDGKIqq6ZuVxapMdsd5SdSGVFdJ5THmz32TGUud/o4MrRdDIFc+cYWNLRDCPUqSRRGOYIDoUEucEKRE0+p
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=nrACCIEEAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=Z4Rwk6OoAAAA:8
    a=yPCof4ZbAAAA:8 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8
    a=WWzI1fqJHeLtmhwy0voA:9 a=QEXdDO2ut3YA:10 a=LP-oT3CeHzb3Kpa8nOvR:22
    a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753725AbeDVN4Y (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 09:56:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45092 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752545AbeDVN4V (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 09:56:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 011/196] mm: hwpoison: disable memory error handling on 1GB hugepage
Date: Sun, 22 Apr 2018 15:50:31 +0200
Message-Id: <20180422135104.760569006@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

commit 31286a8484a85e8b4e91ddb0f5415aee8a416827 upstream.

Recently the following BUG was reported:

    Injecting memory failure for pfn 0x3c0000 at process virtual address 0x7fe300000000
    Memory failure: 0x3c0000: recovery action for huge page: Recovered
    BUG: unable to handle kernel paging request at ffff8dfcc0003000
    IP: gup_pgd_range+0x1f0/0xc20
    PGD 17ae72067 P4D 17ae72067 PUD 0
    Oops: 0000 [#1] SMP PTI
    ...
    CPU: 3 PID: 5467 Comm: hugetlb_1gb Not tainted 4.15.0-rc8-mm1-abc+ #3
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-1.fc25 04/01/2014

You can easily reproduce this by calling madvise(MADV_HWPOISON) twice on
a 1GB hugepage.  This happens because get_user_pages_fast() is not aware
of a migration entry on pud that was created in the 1st madvise() event.

I think that conversion to pud-aligned migration entry is working, but
other MM code walking over page table isn't prepared for it.  We need
some time and effort to make all this work properly, so this patch
avoids the reported bug by just disabling error handling for 1GB
hugepage.

[n-horiguchi@ah.jp.nec.com: v2]
  Link: http://lkml.kernel.org/r/1517284444-18149-1-git-send-email-n-horiguchi@ah.jp.nec.com
Link: http://lkml.kernel.org/r/1517207283-15769-1-git-send-email-n-horiguchi@ah.jp.nec.com
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Acked-by: Punit Agrawal <punit.agrawal@arm.com>
Tested-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/mm.h  |    1 +
 mm/memory-failure.c |   16 ++++++++++++++++
 2 files changed, 17 insertions(+)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2604,6 +2604,7 @@ enum mf_action_page_type {
 	MF_MSG_POISONED_HUGE,
 	MF_MSG_HUGE,
 	MF_MSG_FREE_HUGE,
+	MF_MSG_NON_PMD_HUGE,
 	MF_MSG_UNMAP_FAILED,
 	MF_MSG_DIRTY_SWAPCACHE,
 	MF_MSG_CLEAN_SWAPCACHE,
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -502,6 +502,7 @@ static const char * const action_page_ty
 	[MF_MSG_POISONED_HUGE]		= "huge page already hardware poisoned",
 	[MF_MSG_HUGE]			= "huge page",
 	[MF_MSG_FREE_HUGE]		= "free huge page",
+	[MF_MSG_NON_PMD_HUGE]		= "non-pmd-sized huge page",
 	[MF_MSG_UNMAP_FAILED]		= "unmapping failed page",
 	[MF_MSG_DIRTY_SWAPCACHE]	= "dirty swapcache page",
 	[MF_MSG_CLEAN_SWAPCACHE]	= "clean swapcache page",
@@ -1084,6 +1085,21 @@ static int memory_failure_hugetlb(unsign
 		return 0;
 	}
 
+	/*
+	 * TODO: hwpoison for pud-sized hugetlb doesn't work right now, so
+	 * simply disable it. In order to make it work properly, we need
+	 * make sure that:
+	 *  - conversion of a pud that maps an error hugetlb into hwpoison
+	 *    entry properly works, and
+	 *  - other mm code walking over page table is aware of pud-aligned
+	 *    hwpoison entries.
+	 */
+	if (huge_page_size(page_hstate(head)) > PMD_SIZE) {
+		action_result(pfn, MF_MSG_NON_PMD_HUGE, MF_IGNORED);
+		res = -EBUSY;
+		goto out;
+	}
+
 	if (!hwpoison_user_mappings(p, pfn, flags, &head)) {
 		action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
 		res = -EBUSY;
