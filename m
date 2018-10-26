Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFBCC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D048A2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zqews/Nf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D048A2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeJZXwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:52:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35923 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeJZXwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:52:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id a8-v6so1791855wmf.1;
        Fri, 26 Oct 2018 08:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=/gJpxsRyY5gIbCsJ2vAio9xx9GqlAyJh0govziFB65g=;
        b=Zqews/Nf3If0V6hE73++8a6YoSseiDQisNXtt3bnhKblrcjMvDW8BMa6HT+x1YBxB7
         skRVPSCivhxX49/EpXa9C4vqmDjrfAvZGMeKAKOLW/K1oG9jjyj2c3Kyfi/g9YfnBr+c
         bntIdMhPj7KQnh8JJ8mRuUHt/2YAjAbhrTAxXHs8kB7bntRR34H10HayAgV2cIN8KzJO
         SwUF7B1uvp5KoT+waejAFZS/RE+gIIJMsugSXm1dUdiCoKCfuClDrFdRG1n0dPWuB2Ng
         VYEGpav1GodKN14CD9Ui/QXCD2f8cpIDNHieJB9smG4l2gYTow+SC72SqgHrHdtM/wXG
         OSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=/gJpxsRyY5gIbCsJ2vAio9xx9GqlAyJh0govziFB65g=;
        b=gXg/1RDpQp0pBTbTMI3CgVGYGVZ85GcmeY8/4cU9AcbibB0GhKJXIadQPigRoa0Vgd
         fyphjiI2pS1dkm1keL58q7kYj3Wfqo1E9rztsCwkC+SnjiPscm9m4Qab15OLciqsCY1P
         SdQGjA2JDD5Y80ARuYatpOl+TsnmhWJ86VfRBy/WSH4dVWypPP9UpSaI1wj1pVjBPJV2
         KSAK2z8FdabkWzV92sK5pw3DwFd+S6Q038X8b5M+IXAx4pCx7MrEHU/IRgNzxiDqE4yk
         viyhlhmohL4e4Pyozxj2mFrAipyBh1nlRMbMF2r20YMdJ0J1xHSp2NJUlTQPTG3tT41H
         5PAQ==
X-Gm-Message-State: AGRZ1gLOi2IASf+zINzgV3uSSeYR/YyjexU2yt50Las+ipfoRaOMLT4C
        iBX+N6YKcfb7RfIUL8h+OLI=
X-Google-Smtp-Source: AJdET5dDodT0TeVnimL+oXSHEfXDGvubSG8lcl45KIGlQXOeCy9iDTytuKUZqiZ29EkVzgl6S1LHBg==
X-Received: by 2002:a1c:4385:: with SMTP id q127-v6mr5799568wma.111.1540566915908;
        Fri, 26 Oct 2018 08:15:15 -0700 (PDT)
Received: from localhost.localdomain ([156.213.138.111])
        by smtp.gmail.com with ESMTPSA id p7-v6sm10127257wrt.10.2018.10.26.08.14.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 08:15:15 -0700 (PDT)
From:   Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Hossam Hassan <7ossam9063@gmail.com>,
        Ahmed Lotfy <A7med.lotfey@gmail.com>
Subject: [PATCH V5 0/5] KVM: X86: Introducing ROE Protection Kernel Hardening
Date:   Fri, 26 Oct 2018 17:12:18 +0200
Message-Id: <20181026151223.16810-1-ahmedsoliman0x666@gmail.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 5th version which is 4th version with minor fixes. ROE is a 
hypercall that enables host operating system to restrict guest's access to its
own memory. This will provide a hardening mechanism that can be used to stop
rootkits from manipulating kernel static data structures and code. Once a memory
region is protected the guest kernel can't even request undoing the protection.

Memory protected by ROE should be non-swapable because even if the ROE protected
page got swapped out, It won't be possible to write anything in its place.

ROE hypercall should be capable of either protecting a whole memory frame or
parts of it. With these two, it should be possible for guest kernel to protect
its memory and all the page table entries for that memory inside the page table.
I am still not sure whether this should be part of ROE job or the guest's job.


The reason why it would be better to implement this from inside kvm: instead of
(host) user space is the need to access SPTEs to modify the permissions, while
mprotect() from user space can work in theory. It will become a big performance
hit to vmexit and switch to user space mode on each fault, on the other hand,
having the permission handled by EPT should make some remarkable performance
gain.

Our model assumes that an attacker got full root access to a running guest and
his goal is to manipulate kernel code/data (hook syscalls, overwrite IDT ..etc).

There is future work in progress to also put some sort of protection on the page
table register CR3 and other critical registers that can be intercepted by KVM.
This way it won't be possible for an attacker to manipulate any part of the
guests page table.

V4->V5 change log:
- Fixed summary (it was reverted summary)
- Fixed an inaccurate documentation in patch [4/5]

Summary:

 Documentation/virtual/kvm/hypercalls.txt |  40 +++++
 arch/x86/include/asm/kvm_host.h          |  11 +-
 arch/x86/kvm/Kconfig                     |   7 +
 arch/x86/kvm/mmu.c                       | 129 ++++++++++----
 arch/x86/kvm/vmx.c                       |   2 +-
 arch/x86/kvm/x86.c                       | 281 ++++++++++++++++++++++++++++++-
 include/linux/kvm_host.h                 |  29 ++++
 include/uapi/linux/kvm_para.h            |   5 +
 virt/kvm/kvm_main.c                      | 119 +++++++++++--
 9 files changed, 572 insertions(+), 51 deletions(-)

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
