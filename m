Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbeCFSr6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 13:47:58 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:38649 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeCFSr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 13:47:57 -0500
X-Google-Smtp-Source: AG47ELtUxN62O/+F0xZcZaAHdhq5SrOv1UCWU3Rl75avOKehl7Xw9FzXIhmS2B3hNkKURJWfm+pVculJbGp+f7FwLWs=
MIME-Version: 1.0
In-Reply-To: <20180306094920.16917-6-bp@alien8.de>
References: <20180306094920.16917-1-bp@alien8.de> <20180306094920.16917-6-bp@alien8.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Mar 2018 10:47:56 -0800
X-Google-Sender-Auth: GYFhYFcOUvfY94nsrfI-tcrA290
Message-ID: <CA+55aFxwdftN1KcA=Q26oN_GYWyeuyjmMPs-whxZcmz=-ARPFg@mail.gmail.com>
Subject: Re: [PATCH 5/9] x86/dumpstack: Improve opcodes dumping in the Code: section
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 1:49 AM, Borislav Petkov <bp@alien8.de> wrote:
>
> Make it read the whole buffer of code_bytes size in one go. By default
> use a statically allocated 64 bytes buffer. If "code_bytes=" is supplied
> on the cmdline a new buffer gets allocated.

Are these always serialized? For oopses, I think we end up serializing
with die_lock, but is that always the case?

Maybe at least a comment about why a static allocation is ok?

             Linus
