Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F7FC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F8127C44
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AP3LWUlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F8127C44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934439AbeF2JvX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:51:23 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34998 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932288AbeF2JvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:51:22 -0400
Received: by mail-pl0-f67.google.com with SMTP id k1-v6so4213024plt.2;
        Fri, 29 Jun 2018 02:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzqBCyemS5Hh2v//fHumPlk1EpHJH6n9shOPGT7uypg=;
        b=AP3LWUlWgOlpyiizaorqvkyPV1yV+Eq6bvz0rtb/k9fTA75bxuyf/y02KmgIRhFFh1
         BjOIcufUKD93t/Jy7oqXEqYat5Qx4MCTDOPuu/E575PQ4hCEkGQuzciNl++s9xRDeS2J
         8G3663XMIkOOZ0AiVynsfeoVKeyUvl+CIhxGrcQnht5FRUPRMQ+IhErtop/KnJ4/i0w4
         lYPZiSC19+UFNM34jNVL5Bd5HPCb1nhKqNbyyp1kIlCr5nQuL06xwR9iGsY93Y9bUBjT
         S57miAjDca0R6N7+sshd+OMEgzPw2DXJRQX3tLOddHKwShxJC8tHQBYxhW8yBNfIgSj0
         Y49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzqBCyemS5Hh2v//fHumPlk1EpHJH6n9shOPGT7uypg=;
        b=VQX1+5YKYy4+jtiPSjHlRxnGxLWLuWqTnwr9XZqD41xg46nK+o7SoNJKM7P8LcImmd
         G3QWuwmehIAUJOtmegJeoI9KWE9tK+M5PqYGlMDRBHPhDLyRZB/BHc5/xg04qd2NtY13
         i/sXDbchMbKNsPAXPnmkT2h5WVayNbO456gZoIrDwu+S72MH3IErruWusjW9GAI4Bwgv
         ydn3wSO9jcElmPfVqQSgUtA5z80hbgWopTreMWjQAMlAiLmxgCO6uZCv/jvdvNItQrsn
         rl3FfvH1OfljBHo/5m1KfvEb17x6hqsEiCDMMGCOVa+PH8qOeT3MVVrIP91WY1/09+iO
         IxMg==
X-Gm-Message-State: APt69E0Q0nA2bc93xFop+sQ+VSoy8Khmhc1wK8VlaFmGCDjHGvs2PZ18
        unypiAxFth6D2bB6XBRctwcoEA==
X-Google-Smtp-Source: ADUXVKKg/ZeMdxu/fLm39ZpYYTjlEtO3ocEFtEPeD38q+cLpMR2YaYNCO9VhnX6NiDDEwGdv/7WLUA==
X-Received: by 2002:a17:902:43a4:: with SMTP id j33-v6mr14173965pld.118.1530265881304;
        Fri, 29 Jun 2018 02:51:21 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id z19-v6sm16802066pfm.187.2018.06.29.02.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 02:51:20 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH 0/2] KVM: x86: Add PV IPIs support
Date:   Fri, 29 Jun 2018 17:51:14 +0800
Message-Id: <1530265876-18136-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using hypercall to send IPIs by one vmexit instead of one by one for
xAPIC/x2APIC physical mode and one vmexit per-cluster for x2APIC cluster 
mode. 

Even if enable qemu interrupt remapping and PV TLB Shootdown, I can still 
observe ~14% performance boost by ebizzy benchmark for 64 vCPUs VM, the 
total msr-induced vmexits reduce ~70%.

The patchset implements the PV IPIs for vCPUs <= 64 VM, this is really 
common in cloud environment, after this patchset is applied, I can continue 
to add > 64 vCPUs VM support and that implementation has to introduce more 
complex logic.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>

Wanpeng Li (2):
  KVM: X86: Implement PV IPI in linux guest
  KVM: X86: Implement PV send IPI support

 Documentation/virtual/kvm/cpuid.txt  |  4 +++
 arch/x86/include/uapi/asm/kvm_para.h |  1 +
 arch/x86/kernel/kvm.c                | 63 ++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/cpuid.c                 |  3 +-
 arch/x86/kvm/x86.c                   | 25 ++++++++++++++
 include/uapi/linux/kvm_para.h        |  1 +
 6 files changed, 96 insertions(+), 1 deletion(-)

-- 
2.7.4

