Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeENTU2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 15:20:28 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53323 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeENTU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 15:20:26 -0400
X-Google-Smtp-Source: AB8JxZreW69YhFXVQBj7Uo9G4D9j/f2CPuMR5eVmotZ9KCMjz3p1rcTTwi1FYiFyWdUPwC/Bjg93SypzAu0Uc6oL8mI=
MIME-Version: 1.0
References: <CAPcyv4g5p72aiXYh8Tf03tvZq8HNYmTFU95PJGG1iQ4JHcr9PA@mail.gmail.com>
 <20180514072603.GA14099@gmail.com> <CAPcyv4j2HQH1wdsGGWUAiXEKXeoMUWN_HeUEMmkv8PG7RUTtfw@mail.gmail.com>
In-Reply-To: <CAPcyv4j2HQH1wdsGGWUAiXEKXeoMUWN_HeUEMmkv8PG7RUTtfw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 May 2018 12:20:14 -0700
Message-ID: <CA+55aFwJ=DvvcrM725KOYAF_c=uKiQcuHz4taPjbKveOVPycKA@mail.gmail.com>
Subject: Re: use memcpy_mcsafe() for copy_to_iter() (was: Re: [PATCH v3 0/9]
 Series short description)
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 8:52 AM Dan Williams <dan.j.williams@intel.com>
wrote:

> I think "happy" is a strong word when it comes to x86 machine check
> handling. My interpretation is that he and Andy acquiesced that this
> is about the best we can do with dax+mce as things stand today.

Yeah. I definitely wouldn't say "happy", but perhaps "resigned". There's
nothing horrible going on, except for just plain nasty interfaces and
apparently disgusting hw problems wrt "rep movs/stos".

                  Linus
