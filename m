Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ri6unn1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9017060555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933714AbeFFRLV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:11:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933527AbeFFRLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:11:20 -0400
X-Google-Smtp-Source: ADUXVKKWpS1VFgBzfz2HUAZHDydmsXxHhPeUfjfiELwfPpZv2O5104ZjwmZFs1GRaldgLEGbHfxFyOOe9vRysJdVU7E=
MIME-Version: 1.0
References: <1528302199-29619-1-git-send-email-chang.seok.bae@intel.com> <1528302199-29619-6-git-send-email-chang.seok.bae@intel.com>
In-Reply-To: <1528302199-29619-6-git-send-email-chang.seok.bae@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 6 Jun 2018 10:11:06 -0700
X-Gmail-Original-Message-ID: <CALCETrV+qJMZJrnb3fTWVaDAGRR0RXoVThMj6BgbdPnM1xa-Ng@mail.gmail.com>
Message-ID: <CALCETrV+qJMZJrnb3fTWVaDAGRR0RXoVThMj6BgbdPnM1xa-Ng@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] x86/msr: write_rdtscp_aux() to use wrmsr_safe()
To: "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 9:23 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> Using wrmsr_safe() can make code a bit simpler by removing
> some condition check

NAK.

If we really want to stop checking the cpu feature and unconditionally
write the MSR, then there should be a single patch that does it.  If
we don't, then we should not make this change, since it will make the
very useful warning  if we screwed it up go away.

I think we should continue checking the cpu feature, personally.  I
also thing that, if we make the change, it should not be part of the
FSGSBASE series.
