Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeBHReT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 12:34:19 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:37952 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbeBHReS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 12:34:18 -0500
X-Google-Smtp-Source: AH8x225FBXBhQnyLNLrRM+SIcdZBl0NN9dfUv5VrD4+PCGekFOVPrna7uPBBXuCxYaFilJpkq7yxadZ6Up9ZkGcfgLc=
MIME-Version: 1.0
In-Reply-To: <20180208130232.GF25235@hirez.programming.kicks-ass.net>
References: <20180208130232.GF25235@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Feb 2018 09:34:16 -0800
X-Google-Sender-Auth: VOwOchLbm9wDCVCCNlPMeRJJLS8
Message-ID: <CA+55aFzxm2CdhhJME8C-aC1MhU1ovTV0A9BZe2V-xw_oyktJiA@mail.gmail.com>
Subject: Re: [PATCH] objtool: Fix switch-table detection
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 5:02 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Fix this by creating a 'jump-stack' which we can 'unwind' during
> reversal, thereby skipping over much of the in-between code.

I'm assuming this will come through the normal tip trees, since that's
where objtool stuff generally comes from, and this is not very high
priority.

> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>

And assuming it's the same patch, just with the extra comment and
jump_orig -> first_jump_src rename (and MAINTAINERS update), that can
be a

  Reported-and-tested-by: Linus Torvalds <torvalds@linux-foundation.org>

since the previous version worked fine for me.

Thanks,

                Linus
