Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211E2ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4AF21712
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVWEgUqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4AF21712
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeJUGfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 02:35:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32862 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbeJUGfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 02:35:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id y140-v6so6436913wmd.0;
        Sat, 20 Oct 2018 15:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=j5IhCilCPKuhu+os03I0QSlpoooNfwaBxP7xJYXDA3A=;
        b=JVWEgUqGtAQ6zgb6QZzC9k4C0VH11zHiWkv8mGuKfPNXbLyZwGVXYBgPaVQrnTkOjC
         m9tObW0y1uBswgncTGKh7EGeyeIPEQPuXTQ8n/azlC7Q0bxOUTagTCtsFSXCIfB4QA5Q
         eGK6SHS2HLhdN+h4GAtN1cwp1YXDxcWYWiS9IAgoyub6+8PJWEYct5C0586vNLlw7oDP
         S3TXhnRruR2Hec0ku1IooTghhytXQwWJlIYvxU7DZRruZA9l0Jo5EzKh6XBzJJyqzWv1
         l5ROtuTKAuSQnL5MbPF8ViLH8RP5FZWXx5Qt5Q7HGBbp04FaTSFJ5ffqbPN/emvkYhJ5
         oS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=j5IhCilCPKuhu+os03I0QSlpoooNfwaBxP7xJYXDA3A=;
        b=dI1lP+EljcJAW1ixATu4dBzkFCTmJ/3bEgCeKx0cQ6fAKfpQyC+hPB6wjz1PO1OHCW
         gNhvE5eKcbK66p4gTJLrLr6+vP0bEqMgTv25H0o8A4CWiaV75uiKKU6RVej7WIiSYonX
         nlBBTHNTHQL3QqF2XR4vsC6EIJHbMziTiqR7IqF/0CY3rINXMRNzSrVnB/blq7JUUkOS
         YM1L0iSTT24jZi13s/+MwvwWBsiwCJNZHSsTR5t/RbAKe8Hd/pNvZ1JED6/9lTjJkP8i
         yIpb/3CSW6E/8DGsQO4zjILAp1n/Yw0G2l5BRxuVUdVabHI1GDHL+cGam4wfQxDCWsSt
         HQkg==
X-Gm-Message-State: ABuFfogRHaWbBeFXZlTcmUuLWR4MwmMPD43inrvkWh7s6F7dDH+zV2Ro
        +6ajynpUHvhzrh+3pCDXYEs=
X-Google-Smtp-Source: ACcGV60fSQm33dfHypigFaFcAQIUyqBW+UkDaPEPFpAve1fKeP6vZffSll8DwkCxEOchv1en6VNrBA==
X-Received: by 2002:a1c:e08a:: with SMTP id x132-v6mr10504776wmg.60.1540074181027;
        Sat, 20 Oct 2018 15:23:01 -0700 (PDT)
Received: from localhost.localdomain ([156.213.155.51])
        by smtp.gmail.com with ESMTPSA id o81-v6sm5013746wmo.38.2018.10.20.15.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 15:23:00 -0700 (PDT)
From:   Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, Ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Hossam Hassan <7ossam9063@gmail.com>,
        Ahmed Lotfy <A7med.lotfey@gmail.com>
Subject: Read Only Enforcement patches V4 [VMM based kernel hardening]
Date:   Sun, 21 Oct 2018 00:21:22 +0200
Message-Id: <20181020222127.6368-1-ahmedsoliman0x666@gmail.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 4th version and the most complete one. ROE is a hypercall
that enables host operating system to restrict guest's access to its own memory.
This will provide a hardening mechanism that can be used to stop rootkits from
manipulating kernel static data structures and code. Once a memory region is
protected the guest kernel can't even request undoing the protection.

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

Summary:

Documentation/virtual/kvm/hypercalls.txt | 40 -----
arch/x86/include/asm/kvm_host.h | 11 +-
arch/x86/kvm/Kconfig | 7 -
arch/x86/kvm/mmu.c | 129 ++++----------
arch/x86/kvm/x86.c | 281 +------------------------------
include/linux/kvm_host.h | 29 ----
include/uapi/linux/kvm_para.h | 5 -
virt/kvm/kvm_main.c | 119 ++-----------
8 files changed, 50 insertions(+), 571 deletions(-)


