Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526667046; cv=none;
        d=google.com; s=arc-20160816;
        b=CKOjysireHvJGGlTawHNBqDJPrfFWKFtDHPclD+qnL7C5+xr3EsNGyls/7D3+Ucvz8
         MgJq2eU+JjT/xyfiODbw7yR1rzDp+mizuokmAzfIdaEQQ2AlD+vst9hYzmho5Q5A3Nc/
         GYeToBsLZ5fHWMxJlFwBe5oAj4+CEwUj8y6f/bBYzng1vV/EmV5sN6GFgpGZTGENENp5
         Ii2trb6cjfMl5ieKDdtiG9NaEM/hLvYxFXPG2Y9gsImh1ifm+1hEE6WRC8GfQhsqLOo8
         +TRhfk648T4t96NdlSmwXoWNdVeY1UZkKk9PHosTqFfb6UM5jim3LUon+PksFXKQvLmG
         Hhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=AtASgK93GPoVHXdGre3as7mXsHKTbqDePV3XrCajnNo=;
        b=V8EZuaKcwkbW5oB406fY4KnnyCfXzWXI3tB98r5UrKnbGeVWkqi2odiwsZljhPJYr8
         LpItcppXFVOUyp4CsFXU1eC24AyoQSpFTbFS7nNje4lsgRvh5crm3k+0iWt7b4tSQzTh
         B4g2QQiWyzY8LoKn3If52TTqboQz1PIyU4AI4F9g8Wn/+psUBeyWYHU02nIEV0ozSA1x
         gBQMDRDTsRNPMr5oJODN7PbuGFQtImomoBSM36U+bTSKOetwJUWy/8J79EXDkibjF92O
         8XrT/SjDdcNZvau9xBvZftvTbOahGYFFjfywJscSUhFOHVjSjD8QwA2gNGbd07z4yg6G
         UF0A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ryQqNztO;
       dkim=pass header.i=@chromium.org header.s=google header.b=njeab6dY;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ryQqNztO;
       dkim=pass header.i=@chromium.org header.s=google header.b=njeab6dY;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZr/MVEU2CkOeZn6bsWOrKUOsKlvN0KGKmAAYJQTntD4t9+Ny1xIcysgDSeZOGAeeen+GGWHqz2ZkBoLx/DKrmk=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180518065419.GB10080@gmail.com>
References: <1526488097-20611-1-git-send-email-alex.popov@linux.com>
 <CAGXu5jLwnbcMqoV_LYPjEUHZ2Lgv+35xVxYO0FNSqGPD-P7Pzg@mail.gmail.com> <20180518065419.GB10080@gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 18 May 2018 11:10:45 -0700
X-Google-Sender-Auth: H1jrlIcEeFzeW0L6qmIsMmhXhSY
Message-ID: <CAGXu5j+SgB2Ux=3yP4NOWnzDptrHiwau0mg=3n_M7W-v6ggiwQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/6] Introduce the STACKLEAK feature and a test for it
To: Ingo Molnar <mingo@kernel.org>
Cc: Alexander Popov <alex.popov@linux.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>, Andy Lutomirski <luto@kernel.org>,
	Tycho Andersen <tycho@tycho.ws>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, Borislav Petkov <bp@alien8.de>,
	Richard Sandiford <richard.sandiford@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	"H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Dmitry V . Levin" <ldv@altlinux.org>, Emese Revfy <re.emese@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Garnier <thgarnie@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Josef Bacik <jbacik@fb.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, "David S . Miller" <davem@davemloft.net>,
	Ding Tianhong <dingtianhong@huawei.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>, Juergen Gross <jgross@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Mathias Krause <minipli@googlemail.com>,
	Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kyle Huey <me@kylehuey.com>,
	Dmitry Safonov <dsafonov@virtuozzo.com>, Will Deacon <will.deacon@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
	Boris Lukashev <blukashev@sempervictus.com>, Andrey Konovalov <andreyknvl@google.com>,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600638805272204332?=
X-GMAIL-MSGID: =?utf-8?q?1600826424736368541?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 11:54 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Kees Cook <keescook@chromium.org> wrote:
>
>> On Wed, May 16, 2018 at 9:28 AM, Alexander Popov <alex.popov@linux.com> wrote:
>> > This is the 12th version of the patch series introducing STACKLEAK to the
>> > mainline kernel for x86. Some code is made common for easier porting to
>> > arm64 (will be done by Laura Abbott).
>>
>> Thanks for the update! I've pushed this for 0-day testing here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/gcc-plugin/stackleak-v12
>
> Please don't commit this to any stable Git tree yet, it still needs more work.

Sure thing and thanks for your review! I put it up on 0-day to help
with build testing -- the kspp subtrees aren't considered sha-stable.

-Kees

-- 
Kees Cook
Pixel Security
