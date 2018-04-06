Return-Path: <kernel-hardening-return-12867-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49NF/vILVOgqxw11XRsnKjAqcuCZsfk3mMINFrUZW7W2X2gbo070uf/RUWdgLAmFAjSh4WC
ARC-Seal: i=1; a=rsa-sha256; t=1522975984; cv=none;
        d=google.com; s=arc-20160816;
        b=yLxSEXgWR4326+Ip48EnKtoYEf/AE0L9xkzXyAjTbc9JJieXylcZltZHBOpWBK03YF
         eECFGxqjGgV/QrRMVsTSOIp00MsW3GkBGP2U+dKpLxKxZIK4oanUj2PhCHkBh/CEZ7Ho
         PsD6QPqAiUOdhbzYWWum+w4YltIJqLvBKFk21njJi/RzkKSfFEzgfNregOe01Efd4usq
         zESvfh3HZUxOF7vIhJmJD1UyTX9sAlwhINbTW8bfIAPhn4wEx7TnzBAT5W3xbweg0gl3
         Mc2S4ddN6ZXum3f2lIgU16nP+QglWjeoo4iS8sspSXj3QBuQCfqbzYmY45+emDbsTtO0
         +Cxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=f6U4Fs4IP4PbLwrs/JY5pEe7n0jRYztaHcaNHOoQl4U=;
        b=k5h0AXXad292mf/Ytl/X/GIWwHWr5cQuCM+BrnvddD/4s4JWTiZvh8uZR+ucyDcRzE
         Tq4wrDRJGfCX5daA3+vXD/MCVTexjlEo+ksBpBaVo11rRrATgCzfoZXLRQxKzqHmUCNX
         m2W+YhEfqiAmzexjbp0k/c0eFdey4ukhl3DwFzR6KVtJ4Hz7yGAdSfTS+CjsUxQXOc5/
         OSGOB2fpn4L6yc2gIAx/uQbe/B2N/NxjKfDG4KqHC7y6BN3ZeYxXdo6XK547mvru4Gx0
         LpCklaKnQ0RbQbfyf2kTnn6VEKXP1lAJT24/9rNfg8yp+hwukm4zT7uFhC5YIVwdqjcq
         IsMg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=EjjsmwLG;
       dkim=pass header.i=@chromium.org header.s=google header.b=QqKzFYDi;
       spf=pass (google.com: domain of kernel-hardening-return-12867-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12867-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=EjjsmwLG;
       dkim=pass header.i=@chromium.org header.s=google header.b=QqKzFYDi;
       spf=pass (google.com: domain of kernel-hardening-return-12867-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12867-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CAGXu5jKVKFmVN-esd5N7B-6mirZv5fm01=uOoq_02jL3idgCVw@mail.gmail.com>
References: <20180331015236.GA3852@beast> <CAGXu5jJsaB+FJJszkOwvW2VYbSHGVyTD+EE=n+k1p1Mg_wtkMw@mail.gmail.com>
 <CA+55aFxVvg=4cX6wTTVNCJMj-VzJp0KhLBY3yLP5Nd3eMXGt=w@mail.gmail.com>
 <CAGXu5j+yDnNkH2vaipGvExqqiAQLP2_SvvEtnzpobBgGvJrUAQ@mail.gmail.com>
 <CA+55aFxU66DqMtwWYh_WqXkdM-fapMyyQZSEZXVmVY=KV-7SLw@mail.gmail.com>
 <CA+55aFzN0B+ajX5ArsGYzqRMxDY26ptfTetSoYOOCVJKYHnZ7g@mail.gmail.com> <CAGXu5jKVKFmVN-esd5N7B-6mirZv5fm01=uOoq_02jL3idgCVw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 5 Apr 2018 17:52:43 -0700
X-Google-Sender-Auth: w8DOHC7D97nCeZqmPqWwfdRc4es
Message-ID: <CAGXu5jKVGtBFP2NuPwjyJjEmUG7N4Z+6o5v6-F4ipY9yUx+XOg@mail.gmail.com>
Subject: Re: [PATCH v7] kernel.h: Retain constant expression output for max()/min()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Martin Uecker <Martin.Uecker@med.uni-goettingen.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>, Ian Abbott <abbotti@mev.co.uk>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596416253887758070?=
X-GMAIL-MSGID: =?utf-8?q?1596956065555833667?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 3:09 PM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Apr 5, 2018 at 2:20 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> There may be others hiding that weren't caught by my limited build
>> testing, trhough. So please keep an eye out for build warnings.
>
> I'll spin up my full multi-arch allmodconfig builds and see if
> anything kicks out...

FWIW, nothing exploded on allmodconfig for x86_64, arm64, i386, arm,
powerpc64, s390, powerpc, mips, nor sparc64...

-Kees

-- 
Kees Cook
Pixel Security
