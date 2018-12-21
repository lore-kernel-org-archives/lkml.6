Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5561DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F56E21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F186KQzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390559AbeLUNJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 08:09:07 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54999 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387883AbeLUNJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 08:09:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so5263271wmh.4;
        Fri, 21 Dec 2018 05:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=xnsrJJLNBicerTp6x3Svy1p4UbHWS4+FK4J05dA7XMI=;
        b=F186KQzEoQ572Hi3DoDQjbd/XCJJumTlMorCiAOAbIlevMLEUjt8yJuU9s0Ns4Sxw3
         Ei6X2YI3QMT+OKibzaxsXf7io3/vq5n+gyHimC8lXcl4w9kKCJPPq+hncmHC5leM54zO
         Jyb+c0jgBHqOYS0ygpv1EzIdRz3o6NDh5gnPknAeqygTY8A/xlCSvenvlVUkKaaVDXjL
         u+dmH5S9+aVwFg+/UMXhuxuStTnjKgn9HXsgRs1/NAJXj4UXkraAwSMEt6BAHH82c7qu
         4jvQytnpfvnaWAthkOj5YJh6852B/EaneH/eNROe8+xxz47JBqljupZbOBEMk5Gi7iwv
         ebvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=xnsrJJLNBicerTp6x3Svy1p4UbHWS4+FK4J05dA7XMI=;
        b=Y/TERY5Tm3I5WICZlNJgYeXaa/xm+gcVRjuLB7TqkiHbMJ8OtF7RyTfxUk1reSpSIc
         NUYH7CJJIsIBj1ujpRxLuQdEN7V3t7aHgZufYPvuQE++tLoYWQK4HLOc6gdi+8tX3nKi
         eMfu5otLJnzGZ7FWYZeUXE84CWYOzX3oy6iTzvWBnWqK2rCjzOD0s7MEoB/vB9lKJCGJ
         8GP2U2UmV6jgk16ZFkye9Tv6GozXadZ4ChScODXm1Up0TGDG6lvIGG1YEqRf+t8o3QIo
         WsbSvGmBT/l7L8NplasrqlojtgLCVUnamZsen7/8dsWCRQcIpkO1K8ly1GQs0+/2JHYS
         TOgA==
X-Gm-Message-State: AA+aEWYxGE4bLgPk0lt46hpHHjzPIbw78xA5IoSAEjNI56nFa0iNY/QW
        0mkH/6Oy5g+WXQsm4tNGFWo=
X-Google-Smtp-Source: AFSGD/UvdpfCoa5i0kp6le7OBVeonXOu9xQB1qKHmTmBPTn8sXSqSjZ1OPftdSaGL7e2zBJzLhEalw==
X-Received: by 2002:a1c:760c:: with SMTP id r12mr2643485wmc.127.1545397744267;
        Fri, 21 Dec 2018 05:09:04 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id h16sm24907683wrb.62.2018.12.21.05.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 05:09:03 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, rkrcmar@redhat.com,
        kvm@vger.kernel.org
Subject: [GIT PULL] Last straggler for 4.20-rc8 or final
Date:   Fri, 21 Dec 2018 14:09:02 +0100
Message-Id: <1545397742-48818-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:

  Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 3cf85f9f6bd7b172122865432b4c6f0ec844e22a:

  KVM: x86: nSVM: fix switch to guest mmu (2018-12-19 22:19:22 +0100)

A simple patch for a pretty bad bug.  I haven't yet sent my 4.21 pull
request because currently I'm waiting for a patch to be removed from
tip (MPX removal breaks KVM live migration and was committed without
Cc or Ack from me) and until that happens I cannot finalize my
conflict resolution instructions.

With the vacation coming soon, I'm not sure whether Ingo or Thomas have
seen my messages about it, so I'll take a couple hours next week to
package everything.  Anyway, all pull requests from my submaintainers
have come and I'll try to sort this out as soon as the 27th or 28th.

Thanks,

Paolo


----------------------------------------------------------------
Unbreak AMD nested virtualization.

----------------------------------------------------------------
Vitaly Kuznetsov (1):
      KVM: x86: nSVM: fix switch to guest mmu

 arch/x86/kvm/svm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
