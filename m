Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DB0C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011702070C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 13:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfADNJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 08:09:58 -0500
Received: from foss.arm.com ([217.140.101.70]:42032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfADNJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 08:09:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28F1AEBD;
        Fri,  4 Jan 2019 05:09:57 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 15DEF3F5D4;
        Fri,  4 Jan 2019 05:09:55 -0800 (PST)
From:   Dave Martin <Dave.Martin@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Alan Hayward <alan.hayward@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: [PATCH v2 0/2] arm64/sve: UAPI: Disentangle ptrace.h from sigcontext.h
Date:   Fri,  4 Jan 2019 13:09:49 +0000
Message-Id: <1546607391-3850-1-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch refactors the UAPI header definitions for the Arm SVE
extension to avoid multiple-definition problems when userspace mixes its
own sigcontext.h definitions with the kernel's ptrace.h (which is
apparently routine).

A common backend header is created to hold common definitions, suitably
namespaced.

The extra header guard in sve_context.h was considered redundant and is
now gone, so patch 1 (kbuild: install_headers.sh: Strip _UAPI from
#if-defined() guards) from the previous version of the series has been
dropeed.

Dave Martin (2):
  arm64/sve: ptrace: Fix SVE_PT_REGS_OFFSET definition
  arm64/sve: Disentangle <uapi/asm/ptrace.h> from
    <uapi/asm/sigcontext.h>

 arch/arm64/include/uapi/asm/ptrace.h      | 39 ++++++++++-----------
 arch/arm64/include/uapi/asm/sigcontext.h  | 56 +++++++++++++++----------------
 arch/arm64/include/uapi/asm/sve_context.h | 53 +++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm64/include/uapi/asm/sve_context.h

-- 
2.1.4

