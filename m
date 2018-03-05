Return-Path: <brgerst@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520282283; cv=none;
        d=google.com; s=arc-20160816;
        b=pN5PZ5N1cjBLoOCqtdPQQTPHtij70/IVwRac2JeLg5CnSkeqJOzSsLgYUsjHykE47p
         8AF98qRcVEfWkyRmNuusFvd5NxN4LsksW3Rc6ILXaoNhsNK1WRbT8JvxL/YDbYxqX4oj
         bHEn29yiGczBkDT2jssFnTW/rZrmhK3sdroJi78qeJzbpflSxkmHLZ9Eh8IFSIOx0nxM
         NnU/Lu+n7F2GASUfcfwbhEjWZfkCfPBkfxnED5eX7NGIUKeoOgjnXbBjdH2vDyGOUUTB
         SV5fM5S8pXIoJUV8cBqSB2PvPeGOtLVlT4sE59TcBjn/SbVnrw03kzhdywCqUZYLGID6
         9iWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Qv0mZ5U5KTu2VG974MfhNhnFd2t+ZU7nh+lhR6LOf8Y=;
        b=Wx7ayTzA1wG/6gYSvQb6Ag+g0DHBsjSgEdYHFOtYLWNTUroAgadKzJ/VWGB2PZ15ep
         e3FHUtqrPAwhtI50tHKzrdZcR87u5SZT7Q9MzubqEgL+vtOUTH4TKg7W5NV1zgJEEPhn
         3BbvlTn1H6nOKcZmfW+FEFVEFw85vX4o0Z6qQM7/QmTvXTbRDYRTwMCenYWcBg++wTD9
         28QUyOtxneNoi78v2wmmWCM+Kj1P7QsrCfJv1hBNWIlLFFmHHgaf858S4loFp5/RLUsn
         DIoTsT3k1jwjQ52hE3WaESZqfph5Oum1jhV9M69bm2+vCXBJJKp9bagXNBZrPAlVqHQs
         gKhA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XgLA4fP+;
       spf=pass (google.com: domain of brgerst@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=brgerst@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XgLA4fP+;
       spf=pass (google.com: domain of brgerst@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=brgerst@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELstdoNN/P7jwCH3rGk9F3GFBWY4AwgGv98jyXkNQbKnjohsgTjUwHPcn6eR51lh6sJXGoW52AH5/vStvifhwNQ=
MIME-Version: 1.0
In-Reply-To: <CA+55aFwn5EkHTfrUFww54CDWovoUornv6rSrao43agbLBQD6-Q@mail.gmail.com>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
 <1520245563-8444-8-git-send-email-joro@8bytes.org> <CA+55aFym-18UbD5K3n1Ki=mvpuLqa7E6E=qG0aE-dctzTap_WQ@mail.gmail.com>
 <20180305131231.GR16484@8bytes.org> <CA+55aFwn5EkHTfrUFww54CDWovoUornv6rSrao43agbLBQD6-Q@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Mon, 5 Mar 2018 15:38:02 -0500
Message-ID: <CAMzpN2hscOXJFzm07Hk=2Ttr3wQFSisxP=EZhRMtAU6xSm8zSw@mail.gmail.com>
Subject: Re: [PATCH 07/34] x86/entry/32: Restore segments before int registers
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joerg Roedel <joro@8bytes.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	Peter Anvin <hpa@zytor.com>, "the arch/x86 maintainers" <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	Andrew Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>, Eduardo Valentin <eduval@amazon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will.deacon@arm.com>,
	"Liguori, Anthony" <aliguori@amazon.com>, Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
	Hugh Dickins <hughd@google.com>, Kees Cook <keescook@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>, Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093021030252223?=
X-GMAIL-MSGID: =?utf-8?q?1594131515629067037?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 1:23 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Mar 5, 2018 at 5:12 AM, Joerg Roedel <joro@8bytes.org> wrote:
>>
>>> The things is, we *know* that we will restore two segment registers with the
>>> user cr3 already loaded: CS and SS get restored with the final iret.
>>
>> Yeah, I know, but the iret-exception path is fine because it will
>> deliver a SIGILL and doesn't return to the faulting iret.
>
> That's not so much my worry, as just getting %cr3 wrong. The fact is,
> we still take the exception, and we still have to handle it, and that
> still needs to get the user<->kernel cr3 right.
>
> So then the whole "restore segments early" must be wrong, because
> *that* path must get it all right too, no?
>
> And it appears that the code *does* get it right, and you can just
> avoid this patch entirely?
>
>> The iret-exception case is tested by the ldt_gdt selftest (the
>> do_multicpu_tests subtest). But I didn't actually tested single-stepping
>> through sysenter yet. I just re-ran the same tests I did with v2 on this
>> patch-set.
>
> Ok. Maybe we should have a test for the "take DB on first instruction
> of sysenter".
>
>            Linus

There already is a test: single_step_syscall.c

--
Brian Gerst
