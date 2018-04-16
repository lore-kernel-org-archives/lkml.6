Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751149AbeDPPQk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:16:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750946AbeDPPQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:16:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B821721837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx49EY5FyVvq60D6OgwOmo93bLRoSfPiaMpGhaQoP/H7COC+TQv0MfXWUzEwCMXKWP1mFVDrIDhp9XrHoHleZUjA=
MIME-Version: 1.0
In-Reply-To: <1523871837-8378-1-git-send-email-joro@8bytes.org>
References: <1523871837-8378-1-git-send-email-joro@8bytes.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 16 Apr 2018 08:16:16 -0700
X-Gmail-Original-Message-ID: <CALCETrVgQspiO3nnyhqiXi17iaGG7bRDsr3gpHwdDnYfFDZabQ@mail.gmail.com>
Message-ID: <CALCETrVgQspiO3nnyhqiXi17iaGG7bRDsr3gpHwdDnYfFDZabQ@mail.gmail.com>
Subject: Re: [PATCH] x86/ldt: Fix support_pte_mask filtering in map_ldt_struct()
To: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 2:43 AM, Joerg Roedel <joro@8bytes.org> wrote:
> From: Joerg Roedel <jroedel@suse.de>
>
> The |= operator will let us end up with an invalid PTE. Use
> the correct &= instead.

D'oh!  Looks good.
