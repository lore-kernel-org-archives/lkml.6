Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77472C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220C420869
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UteIwLR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220C420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389580AbeKPU6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:58:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41820 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbeKPU6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:58:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id v18-v6so24370216wrt.8;
        Fri, 16 Nov 2018 02:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i+L3xCtiXB8nII9Oiueu+4abIrusChErc/QA97p75xo=;
        b=UteIwLR4JOGKMusslZlTPHGfcRb8SMx72rmaUU9yLjnIsST5G6cAVlLI/NOqcTHVSh
         H4t/DAzxhWCjvNg9GH9EF5XN36nHPNjYNl/vvaSKGyQGyQY2q++slP8lZD6WJvzdo6ZZ
         0/0IaQBPEEqWrYEuFmAsoJQPAIb1APnQ93tRBzPf822qGhNPjVkQ1kC9oL+hmrYut9jT
         pe/eYqc2OfPqSzbHLVMyWztwbRC12jz/mlZbPtZGJmAXsqanwT+KqxbH6hUOw3m9s+ZR
         G1a4BjQ5+WLPhf5X6kjpTJLPjmVuBVRz5CKEFrQCDo4pFO61kQkoVx4+BWIUxqHJXH35
         vRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=i+L3xCtiXB8nII9Oiueu+4abIrusChErc/QA97p75xo=;
        b=c7twpaXzswnSp2+RcpOwHb5clMcAyMmuEkXim6aTyezGVBr4uyryZjb69YNm/kR3ff
         0hLgXMdgoRY8Tii7E+XFchU3Uk+YS277nlm1XlMIEwdfkJXYl7oH/1jIHCIWUNKvXLNj
         baKJ4Qd3jXiZVtEgtz9MkxP2m4nZBl5219a7VlTkDb6FfU2CDTRZnx6qqSXqPkfFTb4N
         FKKhGC6lHb0Xl3JlR+lja8k//TLJ++D9HPmqh2iCGfmM/V4YeqlXMCg+di9rirSAc4Rh
         c7WXrMFhHHQ1D4kJXM46Hn8Ipfq7kJkHaoeEa7WyKaYKgZ8bI/IpauHd0kOC2zNVz9Ei
         aVEQ==
X-Gm-Message-State: AGRZ1gJhReQi+p+Lro82UKQL5TcVa2zyzBPH8pZCrnSIkR3tSXwW/5Qa
        /4b9hTtEMOH00l12aVzhKHI=
X-Google-Smtp-Source: AJdET5elbkFV9ya8T/GfS760zXw1ZRsI8UO05UpJ9sKn87OJvp2nfipnbiFfItUWCwLiPz438P/BXg==
X-Received: by 2002:a05:6000:1251:: with SMTP id j17mr7687683wrx.315.1542365191401;
        Fri, 16 Nov 2018 02:46:31 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.googlemail.com with ESMTPSA id 78-v6sm10155096wma.30.2018.11.16.02.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 02:46:29 -0800 (PST)
Subject: Re: [PATCH v7 0/7] KVM: x86: Allow Qemu/KVM to use PVH entry point
To:     Maran Wilson <maran.wilson@oracle.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, jgross@suse.com
Cc:     boris.ostrovsky@oracle.com, bp@suse.de,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, hpa@zytor.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, linus.walleij@linaro.org,
        luto@kernel.org, mchehab@kernel.org, mingo@redhat.com,
        rdunlap@infradead.org, tglx@linutronix.de, thomas.lendacky@amd.com,
        hch@infradead.org, roger.pau@citrix.com, rkrcmar@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <1523920175-27287-1-git-send-email-maran.wilson@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <9aeeaf85-6ecf-c1e2-640a-657f5bb0f8ef@redhat.com>
Date:   Fri, 16 Nov 2018 11:46:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1523920175-27287-1-git-send-email-maran.wilson@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/18 01:09, Maran Wilson wrote:
> For certain applications it is desirable to rapidly boot a KVM virtual
> machine. In cases where legacy hardware and software support within the
> guest is not needed, Qemu should be able to boot directly into the
> uncompressed Linux kernel binary without the need to run firmware.
> 
> There already exists an ABI to allow this for Xen PVH guests and the ABI
> is supported by Linux and FreeBSD:
> 
>    https://xenbits.xen.org/docs/unstable/misc/pvh.html
> 
> This patch series would enable Qemu to use that same entry point for
> booting KVM guests.

Hi Maran, what happened to this series (and to the QEMU work)?

Paolo

> Changes from v6:
> 
>  * Addressed issues caught by the kbuild test robot:
>     - Restored an #include line that had been dropped by mistake (patch 4)
>     - Removed a pair of #include lines that were no longer needed in a
>       common code file and causing problems for certain 32-bit configs
>       (patchs 4 and 7)
> 
> Changes from v5:
> 
>  * The interface changes to the x86/HVM start info layout have
>    now been accepted into the Xen tree.
>  * Rebase and merge upstream PVH file changes.
>  * (Patch 6) Synced up to the final version of the header file that was
>              acked and pulled into the Xen tree.
>  * (Patch 1) Fixed typo and removed redundant "def_bool n" line.
> 
> Changes from v4:
> 
> Note: I've withheld Juergen's earlier "Reviewed-by" tags from patches
> 1 and 7 since there were minor changes (mostly just addition of
> CONFIG_KVM_GUEST_PVH as requested) that came afterwards.
> 
>  * Changed subject prefix from RFC to PATCH
>  * Added CONFIG_KVM_GUEST_PVH as suggested
>  * Relocated the PVH common files to
>    arch/x86/platform/pvh/{enlighten.c,head.S}
>  * Realized I also needed to move the objtool override for those files
>  * Updated a few code comments per reviewer feedback
>  * Sent out a patch of the hvm_start_info struct changes against the Xen
>    tree since that is the canonical copy of the header. Discussions on
>    that thread have resulted in some (non-functional) updates to
>    start_info.h (patch 6/7) and those changes are reflected here as well
>    in order to keep the files in sync. The header file has since been
>    ack'ed for the Xen tree by Jan Beulich.
> 
> Changes from v3:
> 
>  * Implemented Juergen's suggestion for refactoring and moving the PVH
>    code so that CONFIG_XEN is no longer required for booting KVM guests
>    via the PVH entry point.
>    Functionally, nothing has changed from V3 really, but the patches
>    look completely different now because of all the code movement and
>    refactoring. Some of these patches can be combined, but I've left
>    them very small in some cases to make the refactoring and code
>    movement easier to review.
>    My approach for refactoring has been to create a PVH entry layer that
>    still has understanding and knowledge about Xen vs non-Xen guest types
>    so that it can make run time decisions to handle either case, as
>    opposed to going all the way and re-writing it to be a completely
>    hypervisor agnostic and architecturally pure layer that is separate
>    from guest type details. The latter seemed a bit overkill in this
>    situation. And I've handled the complexity of having to support
>    Qemu/KVM boot of kernels compiled with or without CONFIG_XEN via a
>    pair of xen specific __weak routines that can be overridden in kernels
>    that support Xen guests. Importantly, the __weak routines are for
>    xen specific code only (not generic "guest type" specific code) so
>    there is no clashing between xen version of the strong routine and,
>    say, a KVM version of the same routine. But I'm sure there are many
>    ways to skin this cat, so I'm open to alternate suggestions if there
>    is a compelling reason for not using __weak in this situation.
> 
> Changes from v2:
> 
>  * All structures (including memory map table entries) are padded and
>    aligned to an 8 byte boundary.
> 
>  * Removed the "packed" attributes and made changes to comments as
>    suggested by Jan.
> 
> Changes from v1:
> 
>  * Adopted Paolo's suggestion for defining a v2 PVH ABI that includes the
>    e820 map instead of using the second module entry to pass the table.
> 
>  * Cleaned things up a bit to reduce the number of xen vs non-xen special
>    cases.
> 
> 
> Maran Wilson (7):
>   xen/pvh: Split CONFIG_XEN_PVH into CONFIG_PVH and CONFIG_XEN_PVH
>   xen/pvh: Move PVH entry code out of Xen specific tree
>   xen/pvh: Create a new file for Xen specific PVH code
>   xen/pvh: Move Xen specific PVH VM initialization out of common file
>   xen/pvh: Move Xen code for getting mem map via hcall out of common
>     file
>   xen/pvh: Add memory map pointer to hvm_start_info struct
>   KVM: x86: Allow Qemu/KVM to use PVH entry point
> 
>  MAINTAINERS                                     |   1 +
>  arch/x86/Kbuild                                 |   2 +
>  arch/x86/Kconfig                                |  14 +++
>  arch/x86/kernel/head_64.S                       |   2 +-
>  arch/x86/platform/pvh/Makefile                  |   5 +
>  arch/x86/platform/pvh/enlighten.c               | 136 ++++++++++++++++++++++++
>  arch/x86/{xen/xen-pvh.S => platform/pvh/head.S} |   0
>  arch/x86/xen/Kconfig                            |   3 +-
>  arch/x86/xen/Makefile                           |   2 -
>  arch/x86/xen/enlighten_pvh.c                    |  93 +++-------------
>  include/xen/interface/hvm/start_info.h          |  63 ++++++++++-
>  11 files changed, 240 insertions(+), 81 deletions(-)
>  create mode 100644 arch/x86/platform/pvh/Makefile
>  create mode 100644 arch/x86/platform/pvh/enlighten.c
>  rename arch/x86/{xen/xen-pvh.S => platform/pvh/head.S} (100%)
> 

