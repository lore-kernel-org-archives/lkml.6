Return-Path: <kernel-hardening-return-11841-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225CI17/ZRMn3jCPIDNsAAWLBz4tXrbYiGyw9zBMkXvc5SzvjKojpuQDimZPNatt/Z5ZShvG
ARC-Seal: i=1; a=rsa-sha256; t=1519175614; cv=none;
        d=google.com; s=arc-20160816;
        b=k32JBo/tC5Wolot3lDdm7uzmrOZkldY5OC9TkgY/RvLuoir59jKnKVD/VIM5NFM7yZ
         CXD5k4kNPiLIuGh51Hnm4RcG7fFarfdxWAYmsuVJj0ncqVOwVOoAgCe6QxewWV2Djatl
         dbSZiGIAzHPwmEQ+/E3CwNtKpRJ1TkkkZH9O4nOEb+tJQ0L3dL1XVbMz6cPFcrkAqu6v
         wI44XXSvf2EJCeBhAPOCA0sN6zfHCCfjmp4Fnbk2KcEWALk/oHAWzzl+CKkLn+fFUam2
         00jBiBadnoADPhyXxz8IVerz68R/d+c9/Bx/I+7KdQKGcXeJeYZ6QCnV+8kn28yMcA2a
         iAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:message-id:date:subject:cc:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=2DodRybBUoVpk+tBN8BpkouRwrJdqiuqgtWyrevh6EI=;
        b=oBipg8QA5NSmkvf3faQ4TIANmbrHwq842GEE164gof+k78tIw9RI3b4YHxWTfRF4En
         oqjdz2HDcBvJAiA6ea6V3R9UwXE7BdPovAtP+WR35tFobt+aXFqr7LlNeA/iU8oJyTt4
         ChLSqI9AWKOojh3a7YTAEftMp43Rdl4UtHUbSJ5XOBrMrNaEu/jkb7U6TmgMWJlP/AIj
         xPDS7PfqNThguYP0JkoABUfgOgc/y9vOYE4JBXMK+aymrOrsy96Ho1rSgIW15EfA5+3G
         OHjn+b0uC/oxpCfR1U4hBEnUlku6I2U8MX9MXPTKwD6yL4n8xUjkonzwhoxA4wMKDM4x
         BRgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11841-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11841-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11841-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11841-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Alexander Popov <alex.popov@linux.com>,
	Kees Cook <keescook@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Laura Abbott <labbott@redhat.com>,
	kernel-hardening@lists.openwall.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Stackleak for arm64
Date: Tue, 20 Feb 2018 17:13:01 -0800
Message-Id: <20180221011303.20392-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <dc76a745-3fa7-4023-dcc1-3df18c9461a6@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592971089304510513?=
X-GMAIL-MSGID: =?utf-8?q?1592971089304510513?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the arm64 version of the STACKLEAK plugin originall from
grsecurity. See
https://marc.info/?l=kernel-hardening&m=151880470609808 for the
full x86 version. This is based on top of Kees' branch for stackleak
and has been cleaned up to use a few macros from that branch.

Comments welcome, if there are no major objections Kees will queue this
up to get some CI testing. This passed both of the LKDTM tests.

Laura Abbott (2):
  stackleak: Update for arm64
  arm64: Clear the stack

 arch/arm64/Kconfig                     |   1 +
 arch/arm64/include/asm/processor.h     |   6 ++
 arch/arm64/kernel/asm-offsets.c        |   3 +
 arch/arm64/kernel/entry.S              | 108 +++++++++++++++++++++++++++++++++
 arch/arm64/kernel/process.c            |  16 +++++
 drivers/firmware/efi/libstub/Makefile  |   3 +-
 scripts/Makefile.gcc-plugins           |   5 +-
 scripts/gcc-plugins/stackleak_plugin.c |   5 ++
 8 files changed, 145 insertions(+), 2 deletions(-)

-- 
2.14.3
