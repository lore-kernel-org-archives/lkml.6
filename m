Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeERSZp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 14:25:45 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55876 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbeERSZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 14:25:44 -0400
X-Google-Smtp-Source: AB8JxZpSBRwtUfu9wcFTimJaTbRrnlwqf+sxTAkXBEp3tbqUeumO2OBHbP+V+xckv6Di2w5tpwHAjAMx348gJtcTPB8=
MIME-Version: 1.0
References: <20180517161402.78089-1-namit@vmware.com> <20180517161402.78089-3-namit@vmware.com>
 <20180518075853.GD12217@hirez.programming.kicks-ass.net> <CA+55aFwA7K0urWTy1CQysnNt8j5Njvz+76o2CuomucNA7mOymQ@mail.gmail.com>
 <6DB0E0C2-CCD2-4FCE-BD8B-5E340E308FF7@vmware.com>
In-Reply-To: <6DB0E0C2-CCD2-4FCE-BD8B-5E340E308FF7@vmware.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 May 2018 11:25:32 -0700
Message-ID: <CA+55aFzbWA1XJTitwX6DvHxr7EqDa-tEjpedn5yfYpC1edYQog@mail.gmail.com>
Subject: Re: [PATCH 2/6] x86: bug: prevent gcc distortions
To: namit@vmware.com
Cc: Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Anvin <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4IIPq00011013

On Fri, May 18, 2018 at 10:24 AM Nadav Amit <namit@vmware.com> wrote:

> Will it be ok just to use a global inline asm to set an “.include”
directive
> that gas would later process? (I can probably wrap it in a C macro so it
> won’t be too disgusting)

Maybe. I'd almost prefer it to be the automatic kind of thing that we
already do for C files using "-include".

                  Linus
