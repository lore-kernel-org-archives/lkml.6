Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-748302-1525471207-2-13462267688254754854
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525471207; b=aujauEmOwqGf3jfJxRFxCOx6U7IjSFc4OndFI3+00x4OB/1cVO
    IACpmnYp4024Se5TEJRf+fR+yAX+BxEZ6s0Fx2DEaFYQIyGNXHJpij734hhgFLYY
    N05WVNSwk5Nc6c2X9x+VNSR8OnSl5sfKAtys4MmZIb/+UubgU6ZkVRI6o5iNZrnx
    n6drWrA6fhfhXUx7wPmcwQEehSagP+2Snx1NZMcj9iScoOI+7KdMbed47IWSJQh2
    hOm0z90Ip3lC9BO2ne4XRZM7XMi/9XMo+1XCGmkgd7B3I1d5FtXTDqkoPu/d+HLM
    +8XwMF1Z0skY8DUtoPkMYguhfR4ZsbT3lJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525471207; bh=9iglb2/kMOFnfKTo1Ydy0zwk8HC/08
    AHjTMCVe03db0=; b=P+PkDyP9rymPArnySXNtTLdV4gbGF6bBPK6AKsERCaoIQR
    0QBMMPTOAFJ7YwdmA1syvA2P7nvTF576NB08iPrOsNdkBAUyG6qrV6TPfoVN/S3W
    ywfBjoFq3IAveNuvh/rPtj5Nbnj6F7I6RU5qjm/gYwcw/Uq4OtuBjJTs/TNJhNkD
    RmY+JqomdTd+J7SJQAu2PLu1kL64JWKURxFWDIcdgxf+4nBCEeHEhMwxboqsl8M3
    Z6f1Y+LUfylK7c+/rfM7J600u71yyLFWceoHN+mJJ9qlSnp4hC63CCdnQxhOxufE
    kLJbFkB1Z+nl1xAIC/P5QQZE52E5nUouMpvATIrQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=q+Kz8XDH x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=us.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=dt9y766o;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=us.ibm.com header.result=pass header_org.domain=ibm.com
    header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=q+Kz8XDH x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=us.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=dt9y766o;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=us.ibm.com header.result=pass header_org.domain=ibm.com
      header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF6Gic9ehlzhjK86DSQWgCpWz2iDjocP3mubrMAWu5evz6wZFS+mpasFPAuEPldyuJgMFjI9VOfF8cSzIqYAmc+Pt+mnggSXdwJTMfa1GzfUV3G+5fRD
    1/+/Cizt0Jf+nXUous2mrMJV4ptFmP8hO6lBqQ0jaXuVsYWQDYCmPxnAJQRzbqf4SzCrJ4AvQtUcvvUWPR7w+uPZ0XO8atBWwKTzwdpMyrjIw2rdeLgnv1Mi
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=V-DIwOb5Ze3ySYPkDWEA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbeEDWAF (ORCPT <rfc822;linux@kroah.com>);
        Fri, 4 May 2018 18:00:05 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34451 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbeEDWAE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 May 2018 18:00:04 -0400
X-Google-Smtp-Source: AB8JxZrCxCe264EfldhoVBie6g3ncGWryXLn0iP4dJXtxr8a4c+uP8D8sBZqNsPB/a8STj8+hDxAFg==
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
        linuxram@us.ibm.com, corbet@lwn.net, arnd@arndb.de
Subject: [PATCH v13 0/3] mm, x86, powerpc: Enhancements to Memory Protection Keys.
Date: Fri,  4 May 2018 14:59:40 -0700
Message-Id: <1525471183-21277-1-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch series provides arch-neutral enhancements to
enable memory-keys on new architecutes, and the corresponding
changes in x86 and powerpc specific code to support that.

a) Provides ability to support upto 32 keys.  PowerPC
        can handle 32 keys and hence needs this.

b) Arch-neutral code; and not the arch-specific code,
   determines the format of the string, that displays the key
   for each vma in smaps.

History:
-------
version 14:
	(1) made VM_PKEY_BIT4 unusable on x86, #defined it to 0
		-- comment by Dave Hansen
	(2) due to some reason this patch series continue to
	      break some or the other build. The last series
	      passed everything but created a merge
	      conflict followed by build failure for
	      Michael Ellermen. :(

version v13:
	(1) fixed a git bisect error. :(

version v12:
	(1) fixed compilation errors seen with various x86
	    configs.
version v11:
	(1) code that displays key in smaps is not any more
	    defined under CONFIG_ARCH_HAS_PKEYS.
		- Comment by Eric W. Biederman and Michal Hocko
	(2) merged two patches that implemented (1).
		- comment by Michal Hocko

version prior to v11:
	(1) used one additional bit from VM_HIGH_ARCH_*
		to support 32 keys.
		- Suggestion by Dave Hansen.
	(2) powerpc specific changes to support memory keys.


Ram Pai (3):
  mm, powerpc, x86: define VM_PKEY_BITx bits if CONFIG_ARCH_HAS_PKEYS
    is enabled
  mm, powerpc, x86: introduce an additional vma bit for powerpc pkey
  mm, x86, powerpc: display pkey in smaps only if arch supports pkeys

 arch/powerpc/include/asm/mmu_context.h |    5 -----
 arch/powerpc/include/asm/pkeys.h       |    2 ++
 arch/x86/include/asm/mmu_context.h     |    5 -----
 arch/x86/include/asm/pkeys.h           |    1 +
 arch/x86/kernel/fpu/xstate.c           |    5 +++++
 arch/x86/kernel/setup.c                |    8 --------
 fs/proc/task_mmu.c                     |   16 +++++++++-------
 include/linux/mm.h                     |   15 +++++++++++----
 include/linux/pkeys.h                  |    7 ++++++-
 9 files changed, 34 insertions(+), 30 deletions(-)
