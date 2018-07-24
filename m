Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7279CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F18520874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQn+O1Qi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F18520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbeGXI6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:58:30 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43430 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388426AbeGXI6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:58:30 -0400
Received: by mail-qt0-f193.google.com with SMTP id f18-v6so3232848qtp.10;
        Tue, 24 Jul 2018 00:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ms3UXUN+tRkedHgzdSQ3MFDZaZlc9lO13BJVu0VmTHc=;
        b=iQn+O1QimCEyXQOELvyH1KePxKQa68ANJm70nB8GRw1RvHkblByCVka/sAKAQQJtC7
         OLH4bRYexoRbd/y1h4Y1NXxaXP+w/EhcRf0hMRKReg01hFl4hs67sw0WEGpSOXMIBI2E
         kNyzMzrWddK4D9kR24X2IIEIqSU6sV+rljKhFz4LeZ0GJzgMQxTVQip0ixRomZ8mQPGz
         ZsxG7mLHrHnebKjbh12vLQ3i2g7YYtZAb09+afY0mn8G+IgQkiG3h8wLTo2s9iqOhEw/
         3yLnl0LhPftRcn1WkN292XdO6UqfATL040F+XbhyQ6oIK5Kcoz4P3kVWSV4XT3d709yO
         IegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ms3UXUN+tRkedHgzdSQ3MFDZaZlc9lO13BJVu0VmTHc=;
        b=q3KkEtTVFryuxmWUVuPvWhY7ODz8KvpRQrMy69XvNiRCFI5JR46+hLUv6hN9VOJBwL
         KvxS/NxzRi8pHc1zHhJ3Gjk8ESpVJWQ8kcaF7SJv0yVOsTml/DH+0DRMitDgss6vnoYQ
         i+CjkFhNbrQ10uKcEqYmQgfBFvVe2eUmv7ifbBBL707rdkwIjpWqf1PDQIcHuPF+bjL1
         EeaEWPICEY6e54HvQSxxtdhGTCNvuRF+260iBWxAdB7H7kqPkz2ICSPCbrJNmjoNQg2Q
         qIVYg82IUzZM/1q2EIEy0cJlNRUbsGvdTYDEar+UNC1Cgt5ZXenWjX7eRpTe210sZqmr
         ncXQ==
X-Gm-Message-State: AOUpUlGrTtUEV+QUd1uFX3Q9UXKg8ZQOHyK71m/rEfSobxekso4WjuGM
        UrhwRldFLykhkOvAJIBTFI/TJQZZkAAf8f5Qr+c=
X-Google-Smtp-Source: AAOMgpfXlojlkj0KxKYxQXSUCOW67Ab00aMfJCDyXNwknorbjwcS6Z3aZStMdWzAfUUE+d3VqVP20LyiZy6e/0HtjJA=
X-Received: by 2002:aed:3848:: with SMTP id j66-v6mr15452152qte.218.1532418798200;
 Tue, 24 Jul 2018 00:53:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2824:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 00:53:17
 -0700 (PDT)
From:   Liang C <liangchen.linux@gmail.com>
Date:   Tue, 24 Jul 2018 15:53:17 +0800
Message-ID: <CAKhg4tJjp3yymCTDFpCQJiekos3265AcuBMuCw5TkZUvjCvg1g@mail.gmail.com>
Subject: VM boot failure on nodes not having DMA32 zone
To:     pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have a situation where our qemu processes need to be launched under
cgroup cpuset.mems control. This introduces an similar issue that was
discussed a few years ago. The difference here is that for our case,
not being able to allocate from DMA32 zone is a result a cgroup
restriction not mempolicy enforcement. Here is the steps to reproduce
the failure,

mkdir /sys/fs/cgroup/cpuset/nodeX (where X is a node not having DMA32 zone)
echo X > /sys/fs/cgroup/cpuset/nodeX/cpuset.mems
echo X > /sys/fs/cgroup/cpuset/nodeX/cpuset.cpus
echo 1 > /sys/fs/cgroup/cpuset/node0/cpuset.mem_hardwall
echo $$ > /sys/fs/cgroup/cpuset/nodeX/tasks

#launch a virtual machine
kvm_init_vcpu failed: Cannot allocate memory

There are workarounds, like always putting qemu processes onto the
node with DMA32 zone or not restricting qemu processes memory
allocation until that DMA32 alloc finishes (difficult to be precise).
But we would like to find a way to address the root cause.

Considering the fact that the pae_root shadow should not be needed
when ept is in use, which is indeed our case - ept is always available
for us (guessing this is the same case for most of other users), we
made a patch roughly like this,

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d594690..1d1b61e 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5052,7 +5052,7 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
        vcpu->arch.mmu.translate_gpa = translate_gpa;
        vcpu->arch.nested_mmu.translate_gpa = translate_nested_gpa;

-       return alloc_mmu_pages(vcpu);
+       return tdp_enabled ? 0 : alloc_mmu_pages(vcpu);
 }

 void kvm_mmu_setup(struct kvm_vcpu *vcpu)


It works through our test cases. But we would really like to have your
insight on this patch before applying it in production environment and
contributing it back to the community. Thanks in advance for any help
you may provide!

Thanks,
Liang Chen
