Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2265C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9320218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfAYLTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:19:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43202 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfAYLTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:19:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so9849446wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 03:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bhmVmZg0IsRr0QRkKy+8IlFO+IurIQ26O9vAwevldoY=;
        b=duNFRlK5kl3IK87zxhp8sN6a1JF9vEoyswt/IVK1CNa71kxj/ENOXwyYw3+oZqFzGh
         ekxG0G/MmCy9QIvPJz/d7F0qyiuQvsNaMsoKcwrBlyOBZBNDY0AnTfu0BN0/e4Uoq9xQ
         AcY7ak8xdEScAcjrDXCrnqDy2Gcx4dhOkYplRRJaLnuUxdGbOCdSaynb0G3a9v7/B1Jz
         5k3RwNVrqyqz3ZLpmlJ4U7fx4ZYGt19Ax1UNJY7TJInJhWwcm3nrz8ySYuXNmYPPqZXM
         tPCD2p0H6B/w/0D7zqR5tZljjP/0nppyl+stq/yRFHYLySHYa24n/nMcq3oSOb0VqwnB
         EMRg==
X-Gm-Message-State: AJcUukdBhiinffXvEYlVHA/82F5Q1bNKN1dhOhu/ETAUizrWERGsQgyp
        1HWTeYajBF/0vx6a5yk5cU8g/w==
X-Google-Smtp-Source: ALg8bN7gmzzbA6snYmn6KsZB5HV0F+P1F1TwUvIpz4FVc9VLPQETIEZHx6i2yoEjyuuA1LUODl+wKA==
X-Received: by 2002:adf:8323:: with SMTP id 32mr10672237wrd.176.1548415182246;
        Fri, 25 Jan 2019 03:19:42 -0800 (PST)
Received: from vitty.brq.redhat.com.cz ([147.229.117.36])
        by smtp.gmail.com with ESMTPSA id f2sm98101713wru.14.2019.01.25.03.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 03:19:41 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] tweak HYPERV_CPUID_ENLIGHTMENT_INFO
Date:   Fri, 25 Jan 2019 12:19:32 +0100
Message-Id: <20190125111934.28782-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Be more consistent with genuine Hyper-V: don't recommend using Enlightened
VMCS when it wasn't enabled, don't advertise reset via synthetic MSR.

Vitaly Kuznetsov (2):
  x86/kvm/hyper-v: don't recommend doing reset via synthetic MSR
  x86/kvm/hyper-v: recommend using eVMCS only when it is enabled

 arch/x86/kvm/hyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.20.1

