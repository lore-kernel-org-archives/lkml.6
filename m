Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403D3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0833322419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="zF8cs8qf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0833322419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mena.vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733265AbeKOBec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:34:32 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44785 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733160AbeKOBec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:34:32 -0500
Received: by mail-vs1-f65.google.com with SMTP id g68so9722973vsd.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 07:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nJZ0hZLjIPCdZbwD/B96QEzrIL6ba4vJo4GwFwBJt7E=;
        b=zF8cs8qfH41ZCNwb7sQKZlHP0vQ4abMd99IbdFFpg/Ml2re15D8ET2WzwnbEz/5/5n
         uxlWTAXs5osBtc56vera2PGbSC+o5qwUHUGTjCKNMASGH+LS3H5rbWPA7aIvmUD1kRX2
         2U2cjiYe5Xyv96zJ2WNwJ49eiv6d2f892Bsncu/sfGDcngozC3BedSlFzKZPY13/gw4q
         xMSGKTcM+BYs/vwmYqQx5KztOH1arBandi2IzC5SELFitdkSBxNUaOx1+sIMZ7gnOMMw
         SyXyxvzyHzGhBpaI44TlOjORA2e+4MvLQkO8uaiQxXltIMmjvD4HKl3k1XH9tpl8MTn2
         bzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nJZ0hZLjIPCdZbwD/B96QEzrIL6ba4vJo4GwFwBJt7E=;
        b=MrMcpOmQxzNJi3ghLuZ7iVlUglaprlGXmQwOrpcYJ3DH6VUYiCeyprKIKG90IihV0u
         KpKaAZ7DXLfZmLVAivSyJGTz4zStLWps46ZAOPebnIYS20yhRpXYVvvaCFjW7dxgKiTa
         GnRg+LFhUO9LG5K6018NOSn4ifkLUQv18SKxNZqfO5UYwK1oa+5cE0S5HOtytrWghP2E
         5iafJ/Ysf3AbwrzWLE+ENsHY6roYdPucM+cKdxcG9dbHd5PNBrXuCUbx/E1pIsgiiO9X
         ZqHZEEVq36MKSzZ4ZPO8EPy5UOz3h2dSs46tez/+pF8RIv5rNsEMx0CXJI3UKqdr3+U4
         4JIg==
X-Gm-Message-State: AGRZ1gIjYY7u38QNipfG2kaeuWc2tiFnLZCgR/0Snivq4C4UQ1pSAsV2
        5cTfKbPCnm6T1ms7zl6wPUgjdcYuayke2bR/keCxCw==
X-Google-Smtp-Source: AJdET5eHiECnlnAdzjCPxI4PC9L/wiI03ADJDx1C36fFA+IZXTF8FBJIO2xNmWqX0D6VBOE2be9xoVd+cNkD70zY554=
X-Received: by 2002:a67:105:: with SMTP id 5mr1011199vsb.183.1542209449766;
 Wed, 14 Nov 2018 07:30:49 -0800 (PST)
MIME-Version: 1.0
From:   Ahmed Soliman <ahmedsoliman@mena.vt.edu>
Date:   Wed, 14 Nov 2018 17:30:28 +0200
Message-ID: <CANBxJ=EQOt1t=PkLsMvtfB2SbiLMPeGvFxB7SJXf7m3OkcionQ@mail.gmail.com>
Subject: KVM selftests are failing
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

KVM Self tests located at tools/testing/selftests/kvm seams to be failing.
I have tried:
 - dirty_log_test
 - x86_64/cr4_cpuid_sync_test
 - x86_64/evmcs_test
 - x86_64/platform_info_test
 - x86_64/set_sregs_test
 - x86_64/state_test
 - x86_64/sync_regs_test
 - x86_64/vmx_tsc_adjust_test

All of them triggered the following assert:

        ==== Test Assertion Failure ====
        lib/kvm_util.c:596: ret == 0
        pid=24507 tid=24507 - Invalid argument
            1  0x000056360774e468: ?? ??:0
            2  0x000056360774e609: ?? ??:0
            3  0x00005636077537a0: ?? ??:0
            4  0x000056360774d35e: ?? ??:0
            5  0x00007f3117571ae6: ?? ??:0
            6  0x000056360774d4a9: ?? ??:0
        madvise failed,
        addr: 0x7f3117350000
        length: 0x200000
        src_type: 0

I have tried the tests on both kvm(next) branch
commit 22a7cdcae6a4a3c89748 as well as
torvald's master  4.20-rc2.
-- 
Ahmed,
Junior Researcher, IoT and Cyber Security lab, SmartCI, Alexandria
University, & CIS @  VMI
