Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0549C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE382064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 19:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE382064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeH2Xe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 19:34:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:34795 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727392AbeH2Xe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 19:34:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 12:36:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,304,1531810800"; 
   d="scan'208";a="66959349"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga008.fm.intel.com with ESMTP; 29 Aug 2018 12:35:59 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 112E2301B8B; Wed, 29 Aug 2018 12:35:59 -0700 (PDT)
From:   Andi Kleen <ak@linux.intel.com>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 01/16] x86/cpu: create Dhyana init file and register new cpu_dev to system
References: <cover.1535459012.git.puwen@hygon.cn>
        <c4610c537e5e5774d8d7486e0867ced8ebf0fba1.1535459012.git.puwen@hygon.cn>
Date:   Wed, 29 Aug 2018 12:35:59 -0700
In-Reply-To: <c4610c537e5e5774d8d7486e0867ced8ebf0fba1.1535459012.git.puwen@hygon.cn>
        (Pu Wen's message of "Wed, 29 Aug 2018 20:42:49 +0800")
Message-ID: <87mut52cf4.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pu Wen <puwen@hygon.cn> writes:

> Add x86 architecture support for new processor Hygon Dhyana Family 18h.
> Rework to create a separated file(arch/x86/kernel/cpu/hygon.c) from the
> AMD init one(arch/x86/kernel/cpu/amd.c) to initialize Dhyana CPU.

Standard approach would be to move the shared code into a different
file and call it from both amd.c and hygon.c instead of duplicating.

-Andi
