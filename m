Return-Path: <kernel-hardening-return-12705-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsfQxlIVV86W23T0EQE7huO1b3yWgCf4ag4K55sh1KXBBXJzbcdLoDWqqYmHXAp6P3CdOtj
ARC-Seal: i=1; a=rsa-sha256; t=1521502189; cv=none;
        d=google.com; s=arc-20160816;
        b=MSkJoek2eCUANSh0VJmh3DAlgEDQiXVVbthFhNqXoVnudqhXx+lSWW38Yjo7LKqYQP
         M2FdL0lsFNC7LV7Nqalj2j0AdjiEkWBthSV3HnmmIT2EdR3SscdCyXmKdL+v/O6NDgLV
         xTc/18wVu0pfrMe9qDKw2kZH02vzt+UPx2lysLWJXdRNNQuopnb51aOHVT915+7hS5e1
         RXglwjhlqaYeclRZN8ayDYsKftLDzNhQXVjdqxCFEhm4AbknyCkZ6gGEuqKJRCFqYHcB
         qNi6yaeuzdnm7zBEVLggLPfor92XEwBD1axeohtLCNJy2uSQmmHPDGGfG0voE5BwDxe3
         gViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=HTCFOPNn3TRWULan/e/NLCWZLmpMLqMsRlzp24aCvZ0=;
        b=z0FrPMjMoryVZwTFhAo6hOaCkVx1Px+ckkiLNGuyLe8m9d9Hmb65MwQaCyI5M4QeLI
         fVyRGlNg312cXwhoLvcHIzLTp1dd9hXBUb4gjxf4C6UIWGzgfDn13+ig0wyRgSWeftW1
         INHs6dF8KqNtBm67IzXJhTAE2AZexZp3uiD1wRmU0IHvH498DNI1i2vnMRW5wpY5GQoz
         +b1Q6mayRFaysapN5erkfadIEEvSwHIiNbm9YliRf1u51CxedHhHBawA7OzdUI+Jw9XZ
         R/ZTfcFHj39dUbXdTPNWlvq940cu2lpCBTfNGGE4qo+sHWiLM8oOwRwFxDGohSnmp3pb
         SctQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fb/rd+QF;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=PHX0oHfL;
       spf=pass (google.com: domain of kernel-hardening-return-12705-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12705-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fb/rd+QF;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=PHX0oHfL;
       spf=pass (google.com: domain of kernel-hardening-return-12705-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12705-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <0e94e9582bec4373b5e21c612be179ac@AcuMS.aculab.com>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com> <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <20180316175502.GE30522@ZenIV.linux.org.uk> <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
 <CAGXu5jJmAAgaq3VCsUN2yjpHLSc7P-kNrM_4c4cqP=ysFcETXA@mail.gmail.com>
 <CA+55aFwv0VC67cx2W9yrf7qSFKf6ncVRrsVyLGqdmfSBn4yTYw@mail.gmail.com>
 <42b4342b-aefc-a16a-0d43-9f9c0d63ba7a@rasmusvillemoes.dk> <CA+55aFwFoTapX2niPiaET5kg7K85qxhav1_PoDDxY0o_VRA5Ag@mail.gmail.com>
 <38b6da49-1138-017e-7307-f39ff067d6d2@rasmusvillemoes.dk> <CA+55aFw0WC+S3TTE6x_vkLbRV6YLeR4-1S9LsBXhE+E2KZqBuA@mail.gmail.com>
 <0e94e9582bec4373b5e21c612be179ac@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Mar 2018 16:29:28 -0700
X-Google-Sender-Auth: N8RTqiNR02xbrZASOmfjpruv_P4
Message-ID: <CA+55aFwZnkR5uA5Oe19Xzox=+Bcab-j6-+a=XGqS8yokDU3Dog@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
To: David Laight <David.Laight@aculab.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Kees Cook <keescook@chromium.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Florian Weimer <fweimer@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Ingo Molnar <mingo@kernel.org>, Ian Abbott <abbotti@mev.co.uk>,
	linux-input <linux-input@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595410679835707495?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 2:43 AM, David Laight <David.Laight@aculab.com> wrote:
>
> Is it necessary to have the full checks for old versions of gcc?
>
> Even -Wvla could be predicated on very recent gcc - since we aren't
> worried about whether gcc decides to generate a vla, but whether
> the source requests one.

You are correct. We could just ignore the issue with old gcc versions,
and disable -Wvla rather than worry about it.

                  Linus
