Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbeBKKTb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 05:19:31 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36521 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbeBKKT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 05:19:29 -0500
X-Google-Smtp-Source: AH8x224z4Ln+w4iGquHUHBz/MstgqzGwHMUiplZsxGKfYT1+yVgBSe4MYx95dbX6nqtJh4iq/Kx8cA==
Date: Sun, 11 Feb 2018 11:19:24 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw@amazon.co.uk>
Cc: tglx@linutronix.de, karahmed@amazon.de, sironi@amazon.de,
        x86@kernel.org, kvm@vger.kernel.org, torvalds@linux-foundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        peterz@infradead.org, jmattson@google.com, rkrcmar@redhat.com,
        arjan.van.de.ven@intel.com, dave.hansen@intel.com
Subject: Re: [PATCH v2 5/6] KVM/nVMX: Set the CPU_BASED_USE_MSR_BITMAPS if we
 have a valid L02 MSR bitmap
Message-ID: <20180211101924.vztfslwqoh7km6q2@gmail.com>
References: <1518305967-31356-1-git-send-email-dwmw@amazon.co.uk>
 <1518305967-31356-6-git-send-email-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518305967-31356-6-git-send-email-dwmw@amazon.co.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* David Woodhouse <dwmw@amazon.co.uk> wrote:

> From: KarimAllah Ahmed <karahmed@amazon.de>
> 
> We either clear the CPU_BASED_USE_MSR_BITMAPS and end up intercepting all
> MSR accesses or create a valid L02 MSR bitmap and use that. This decision
> has to be made every time we evaluate whether we are going to generate the
> L02 MSR bitmap.
> 
> Before commit 086e7d4118cc ("KVM: VMX: Allow direct access to MSR_IA32_SPEC_CTRL")
> this was probably OK since the decision was always identical. This is no
> longer the case now since the MSR bitmap might actually change once we
> decide to not intercept SPEC_CTRL and PRED_CMD.

Note, I fixed the changelog to refer to the correct upstream SHA1, which is:

  d28b387fb74d: KVM/VMX: Allow direct access to MSR_IA32_SPEC_CTRL

Thanks,

	Ingo
