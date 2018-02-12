Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754017AbeBLQvI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:51:08 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:53192 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbeBLQvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:51:06 -0500
X-Google-Smtp-Source: AH8x224mSD4tdn8QsTZldoFTUvHTFSNxKaQP/l7XLPqZkfVpk+LWJpBgvmz+oETyzeLWbAJSWPlPE+uhGCfb0mX84rA=
MIME-Version: 1.0
In-Reply-To: <22559e63-5b78-21a7-27cd-a985957d5879@redhat.com>
References: <20180211104949.12992-5-linux@dominikbrodowski.net>
 <tip-7b7b09f110f06f3c006e9b3f4590f7d9ba91345b@git.kernel.org> <22559e63-5b78-21a7-27cd-a985957d5879@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Feb 2018 08:51:04 -0800
X-Google-Sender-Auth: J1xTnFnCK61P2bXQB-uQWzWgOA8
Message-ID: <CA+55aFzM_setx0jZ-nEi+TVFv7wSf6WPJ_bByhFqcUnOfLbHGw@mail.gmail.com>
Subject: Re: [tip:x86/pti] x86/entry/64: Introduce the PUSH_AND_CLEAN_REGS macro
To: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Peter Anvin <hpa@zytor.com>, Andrew Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 5:29 AM, Denys Vlasenko <dvlasenk@redhat.com> wrote:
>
> xorq's are slower than xorl's on Silvermont/Knights Landing.
> I propose using xorl instead.

Makes sense, and matches the other 'xorl'.

I suspect the only reason it uses 'xorq' for the high regs is that the
register names for the high regs are "odd" and don't match the legacy
register names. You need to use "%r15d'" for the 32-bit version.

               Linus
