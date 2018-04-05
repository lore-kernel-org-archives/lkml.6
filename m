Return-Path: <kernel-hardening-return-12866-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48TVrq/eDj8iG3SM+JqVzJ4I5JPO8HNV85swhAB7q4Z24aIMnHBIy/tQsvW8Puwn5C1rO9W
ARC-Seal: i=1; a=rsa-sha256; t=1522966203; cv=none;
        d=google.com; s=arc-20160816;
        b=TfIeKm4c+3T9ZXz7CJEfvbjNunYkmXMy2zDQUPSXmHmPuHgY8hh9mTGi33oNFNm8cO
         jsFAODS5UNHkBJXd0ixIdMrw4ZeoC1CO7hYpQflrebdo2Uobg3c1M/urWlkkyUucwN3/
         76XF5Dbt3uROUfEcIBUgu+M6Rry2O6ndvr6TsxKCzgvx6lAyfQCY1/Symz+0FpjtgDKE
         X0iRmQtvPdRjdZjT2nSjhE2+WVMfEVUmQsdSWfQs/fXdfa7g+QGLkyex7GkbqUcPX8Fd
         m7roHd4FNr3S+daV4bUG8owPLXEyNjFDfF1ZFJx+txgkds5/tXRPM8K8WJSqe1xOe2iU
         YEXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=K7qjzdhTfiz8fpuvAj+ywwLMEdacfQFsLIN/juS/kDk=;
        b=cQD4GeGV/gipQvdl7R5aq9EcOUQNW8SDgKMTjHIjMeYafGi89rM+Nnl6CV2v9vuw47
         D7Q8TbE6KvTIYgLd++V7lXxFinokNkphiRrxyEVVhzwYL6JZcjXfsW/CPdfiUS4O2Xyd
         b4zgNAh8u8x2wvKUmZPlTxvbsHGNWH//T9OzbPzqiUJ7rGYLf14ytPT3pOD8zdL56iUN
         LeJHlefT2cyD7GpLcSgHO8hDZ+OJtaUT+LKijCqjrn7V5IdtoZVMbep3kYYaB8YLnl5s
         DM3wSB00L0Ru/sfY6TNGHEbf5Kc+pbPo9ES4J03Vp1c58ScTjQ9PMbUVN6l+7tz4j9/c
         Sc7g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=UPXvZyqY;
       dkim=pass header.i=@chromium.org header.s=google header.b=lYdjpkAn;
       spf=pass (google.com: domain of kernel-hardening-return-12866-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12866-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=UPXvZyqY;
       dkim=pass header.i=@chromium.org header.s=google header.b=lYdjpkAn;
       spf=pass (google.com: domain of kernel-hardening-return-12866-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12866-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CA+55aFzN0B+ajX5ArsGYzqRMxDY26ptfTetSoYOOCVJKYHnZ7g@mail.gmail.com>
References: <20180331015236.GA3852@beast> <CAGXu5jJsaB+FJJszkOwvW2VYbSHGVyTD+EE=n+k1p1Mg_wtkMw@mail.gmail.com>
 <CA+55aFxVvg=4cX6wTTVNCJMj-VzJp0KhLBY3yLP5Nd3eMXGt=w@mail.gmail.com>
 <CAGXu5j+yDnNkH2vaipGvExqqiAQLP2_SvvEtnzpobBgGvJrUAQ@mail.gmail.com>
 <CA+55aFxU66DqMtwWYh_WqXkdM-fapMyyQZSEZXVmVY=KV-7SLw@mail.gmail.com> <CA+55aFzN0B+ajX5ArsGYzqRMxDY26ptfTetSoYOOCVJKYHnZ7g@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 5 Apr 2018 15:09:42 -0700
X-Google-Sender-Auth: tAfUaVcwaVO-4tCEbYNLSJZ9OGc
Message-ID: <CAGXu5jKVKFmVN-esd5N7B-6mirZv5fm01=uOoq_02jL3idgCVw@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1596945810058146984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 2:20 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Apr 5, 2018 at 1:42 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Ok, applied.
>
> Ugh, during the merge window, we had actually grown a new example of
> that "different enum types" problem:
>
>         struct drm_prop_enum_list enum_list[max(DRM_COLOR_ENCODING_MAX,
>                                                 DRM_COLOR_RANGE_MAX)];
>
> in drm_plane_create_color_properties() in the drm drm_color_mgmt.c file.
>
> I ended up just fixing it up manually and added it to the commit. You
> should double-check my change, I've pushed it out now that the build
> seems ok for me.

Looks good; thanks!

> There may be others hiding that weren't caught by my limited build
> testing, trhough. So please keep an eye out for build warnings.

I'll spin up my full multi-arch allmodconfig builds and see if
anything kicks out...

-Kees

-- 
Kees Cook
Pixel Security
