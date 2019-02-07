Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE42C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E952086C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgyncvRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfBGSMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:12:37 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:39530 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGSMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:12:37 -0500
Received: by mail-wr1-f50.google.com with SMTP id t27so864739wra.6;
        Thu, 07 Feb 2019 10:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=GB/lu2BZnDVmvkavd4tR3u5WMEafY6baYAFrX+CyqlM=;
        b=DgyncvRoghEzWQJ4FSi05bcPZqXbCJx0cSNyu/qNplREDEcBkgZTNcbf+LCflzU/xH
         wzOsXBVHxW4qWjG9W4dxJ2hJkeUZvfGDchgL4spUs0JUdVKNln6XK5WozK3odQ2E4zu+
         3Lul7ZGo0+KNOWtmnJ5YiwENOajYYeYET2dpTnCQzI39mAnOpb+5TKMgGzONzxYXl7Ux
         NLR7CL/usMy/Q2rKaU6mj4s6hExyYNgdwTYmKIFj+yRYqcEkEb23eAo4S6T7wDoxNw5Q
         XgcITzX5f6B0ADT/5tA2Oj3JT7cIjyx4gDWDTOSArroqDrpkDfA4JdlXOD7EJfovQy7i
         C4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=GB/lu2BZnDVmvkavd4tR3u5WMEafY6baYAFrX+CyqlM=;
        b=TlxGSBajmGQDFOJIIMcgfbwbt98wra/XsyvyFG4AoNiNyiLa1Yn2D1f/eRQsNlYD2W
         KvsSekDm/nWMwS6PQJC7HxL5BHa6vR6w1E3LPjoMEWsoB23IsBbP/XXG5sCfiAjzYTSJ
         GZEfd5bv6LTPGhVXvrkzvrm9MULD2AHd6Ctwoji1YAqWLWDElodzrK9b021GK7eikaGs
         0zeq9MPw6oN+KWcBlIYDpsSX7RwbAvtG/ELeXhYBs5dH42ds6SHKgT9wlcdjWYt46tve
         7yNUk4whkvsW/mWQgptf8MkY1qQ9WQAPHwp1abWmg766gkN2z8lxBasfbBHCuIjvz3ms
         1RJg==
X-Gm-Message-State: AHQUAuZL1spygpRbbqsXAzriRUZz9DxVs89tRdv9Ew+gfPRvXnU62Hv+
        sTOxcu8GGg9QYZ9mBC21UFA=
X-Google-Smtp-Source: AHgI3IZoXpZgcPvTF0omPnNd0q7wQlRp7S4qI0WkNYo5H8hNTdKH1UkKRxrep7+PO50taYkQTRf4xg==
X-Received: by 2002:adf:83a7:: with SMTP id 36mr13386560wre.13.1549563155211;
        Thu, 07 Feb 2019 10:12:35 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id j3sm17326476wmb.39.2019.02.07.10.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 10:12:34 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, rkrcmar@redhat.com,
        kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 5.0-rc6
Date:   Thu,  7 Feb 2019 19:12:33 +0100
Message-Id: <1549563153-6746-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to ecec76885bcfe3294685dc363fd1273df0d5d65f:

  KVM: nVMX: unconditionally cancel preemption timer in free_nested (CVE-2019-7221) (2019-02-07 19:03:01 +0100)

----------------------------------------------------------------
Three security fixes.

----------------------------------------------------------------
Jann Horn (1):
      kvm: fix kvm_ioctl_create_device() reference counting (CVE-2019-6974)

Paolo Bonzini (1):
      KVM: x86: work around leak of uninitialized stack contents (CVE-2019-7222)

Peter Shier (1):
      KVM: nVMX: unconditionally cancel preemption timer in free_nested (CVE-2019-7221)

 arch/x86/kvm/vmx/nested.c | 1 +
 arch/x86/kvm/x86.c        | 7 +++++++
 virt/kvm/kvm_main.c       | 3 ++-
 3 files changed, 10 insertions(+), 1 deletion(-)
