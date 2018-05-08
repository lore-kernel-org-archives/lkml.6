Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2957852-1525790360-2-18102908214609789986
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525790360; b=RqdogkDxHQEDty96Bw+9ZkS35JFG+/JLtWZGbVFQ4kxErjXucK
    t/Nvp++woqOe0vXlw99oUZoh4oRiEMNW4b/0bF+7USxit+IOFAyBz+miMhoZFu7o
    qfg5eGxDeV/ygdWYIOH/nOlaACBAC8GXwFHzHgxGcQI8QJT6UTSpi1UKNEp+pw4/
    xu/ZCFap2l0G4ny/9uS7kY21xAM89DR0gBFbONeqZo8Z3lAqeUCkv1yzAAjrg/T/
    oZL9/ovLqZh2MRcIMvDu4v8nM5Xw9UpRfc8mEQPHD2nvujE/PRyCEzeDLMSNgL4I
    infBksjejA5uLfuol1x/3WkqqQRm5bgmW1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    fm2; t=1525790360; bh=N4UIeI22sOt58mJ6mcBPtpyNpTmQFksylezuRQKCDJ
    0=; b=aM7fw03PY9+nTJYotlMIZFVqLmPYCD9ilrvLly8d/Kl9ghn8GG25S44SUO
    jgUfwgvnhpocBlmGHVaxDsC4IaChJX/BfFHB//UzBrs7qajVh9QVC07NnEhnQ8Rm
    T1Rofu888wM5LRWWPH1zwVbhCOreR2zBOVetYVgN+XWsEvjiyFDSMEO97eQm3Sbt
    xjzGUAzXpR2zrlfiZfLxr3EBW0vaigWR8JXeTJACqCmPkv/NnW94dAvLoUiwzZY8
    8C49OSoJuVFXC2+df97HRHaK5JV+xfefrxJt9exA02WY4JeeeNxPFSQoWdSezOwy
    HfGBPZWcavkGBBJXvJLlE+Z9i8aQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ellerman.id.au header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ellerman.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ellerman.id.au header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPzK+k2FvhMo5rLHwvCrKSqjlDfO2akDFi80CAqFpnO4ls5P0wDtMTszwaNZErqMSzh0VdxLD0IUYMX6CGLvGNaFaNDeq/Cc0u67rAnNskmib0D3tS05
    SL0J+x7ZLMTBSiAY6+ssgp7EQc3s9o3+jwwzVOgQqaUKFQSdEcHQrHwSU8F7rKqnI/1PK79K4d0P/UxVVWXEkVajrU1tA1HJaFudwD9hGDXB3lF1yWw/GzGZ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VnNF1IyMAAAA:8
    a=VY0nZlanpfoqMpxWTqQA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932512AbeEHOjT (ORCPT <rfc822;linux@kroah.com>);
        Tue, 8 May 2018 10:39:19 -0400
Received: from ozlabs.org ([203.11.71.1]:32887 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932375AbeEHOjS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 May 2018 10:39:18 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, mingo@redhat.com,
        akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
        linuxram@us.ibm.com, corbet@lwn.net, arnd@arndb.de
Subject: Re: [PATCH v13 0/3] mm, x86, powerpc: Enhancements to Memory Protection Keys.
In-Reply-To: <1525471183-21277-1-git-send-email-linuxram@us.ibm.com>
References: <1525471183-21277-1-git-send-email-linuxram@us.ibm.com>
Date: Wed, 09 May 2018 00:39:14 +1000
Message-ID: <8736z21ab1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Ram Pai <linuxram@us.ibm.com> writes:

> This patch series provides arch-neutral enhancements to
> enable memory-keys on new architecutes, and the corresponding
> changes in x86 and powerpc specific code to support that.
>
> a) Provides ability to support upto 32 keys.  PowerPC
>         can handle 32 keys and hence needs this.
>
> b) Arch-neutral code; and not the arch-specific code,
>    determines the format of the string, that displays the key
>    for each vma in smaps.
>
> History:
> -------
> version 14:

This doesn't match the patch subjects, which is a little confusing :)

> 	(1) made VM_PKEY_BIT4 unusable on x86, #defined it to 0
> 		-- comment by Dave Hansen
> 	(2) due to some reason this patch series continue to
> 	      break some or the other build. The last series
> 	      passed everything but created a merge
> 	      conflict followed by build failure for
> 	      Michael Ellermen. :(

I have a fix, it involved some cleanup of headers prior to the smaps
change.

Will post it.

cheers
