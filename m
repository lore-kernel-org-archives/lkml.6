Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109AAECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79572075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79572075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbeGRVuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:50:05 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38016 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbeGRVuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:50:05 -0400
Received: by mail-qt0-f195.google.com with SMTP id y19-v6so5387910qto.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 14:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=4v4689d6VSRmJPYPTZQMx7VROhH9CjwpkvL47blReT8=;
        b=cabVnHbkyBmfvUPc4gg60rprQhIwCiFyjSp22sldJGBo8JT8y01uanw3iYuKMU6Zxd
         TeZBUrnLu+xtoVj5b0KRbhGplCwBmbflqrr6VdpgbkkKNgh48oRMBwj4jWGR7Q1i8Gij
         wFhQqrgrunex5lzfA4ooEGFfqsqnHDjoBQXc7+2shmYFmphj4kRx6HKOf1++KkZF2Els
         QqvD37sfNwp1C38DCqAbxyg3dzFEEi/xKo4s+sKe3PobyNPijtV6xRdStzOPm9WJnGNK
         RFkMOtj6cYD/eNMo9v2/HKy+B0DikNGkhbLDRVEprrgoF75oyuqOoeTqCduBJQjSwgHn
         KrWQ==
X-Gm-Message-State: AOUpUlFvKoXuGAIo9c+/J0DaJ2G8EJvgpPZJEfTL8o8VzZ3TxgLex6zU
        0uRsVuovsi4Dcxynp3nNT+mKm23Wlk0=
X-Google-Smtp-Source: AAOMgpcZoqThdgxCkTL/75HwY7WiQjkFLfCGnlAX4jkeV1Y8WYuSYFXsksgB9CfeHU7/viYkerj9mQ==
X-Received: by 2002:ac8:2e2f:: with SMTP id r44-v6mr7144347qta.357.1531948222888;
        Wed, 18 Jul 2018 14:10:22 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc:4eb2:6dae:ab32:e5b0])
        by smtp.gmail.com with ESMTPSA id k3-v6sm4143463qta.37.2018.07.18.14.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 14:10:21 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Alexander Popov <alex.popov@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 0/2] Stackleak for arm64
Date:   Wed, 18 Jul 2018 14:10:11 -0700
Message-Id: <20180718211013.14512-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1531341400-12077-1-git-send-email-alex.popov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the new version of stackleak for arm64 to go with v14 of the
series for x86. I have a cover letter and few more cc's to go along with
some of the prep work.

I also apologize for terrible versioning on these series. Usually I try
to just reply to the top level patch with this addition and not actually
put a version on it. I negelcted to do that last time but as mentioned
this is inteded to go with v14.

Laura Abbott (2):
  arm64: Introduce current_stack_type
  arm64: Clear the stack

 arch/arm64/Kconfig                    |  1 +
 arch/arm64/include/asm/processor.h    | 17 +++++
 arch/arm64/include/asm/sdei.h         |  8 ++-
 arch/arm64/include/asm/stacktrace.h   | 94 ++++++++++++++++++++++-----
 arch/arm64/kernel/entry.S             |  7 ++
 arch/arm64/kernel/process.c           | 32 +++++++++
 arch/arm64/kernel/ptrace.c            |  2 +-
 arch/arm64/kernel/sdei.c              | 21 +++++-
 arch/arm64/kvm/hyp/Makefile           |  3 +-
 drivers/firmware/efi/libstub/Makefile |  3 +-
 include/linux/stackleak.h             |  1 +
 11 files changed, 165 insertions(+), 24 deletions(-)

-- 
2.17.1

