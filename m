Return-Path: <kernel-hardening-return-12865-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+DSqpmsYt8IFJNbSJ80L86VKJ0IwPJpXcPUZuoYQfvs57WVZ82IiuILl20b/f0wTWIv8Tj
ARC-Seal: i=1; a=rsa-sha256; t=1522963224; cv=none;
        d=google.com; s=arc-20160816;
        b=FJV3cK5auzngXI9pub97YE7p8RPWcnZgQIZG1he1DO1ydmrDXf2fKlrYHQv1D66xz0
         3ZC4K2pUdcp79lhr6HBesf9OKZ11R4GC7rxjnBU6hlmYd7N1jXOl6PtBcDJddZB8Xo2P
         fhrEvUu2m07lKsPhHJknlL1YbnzLTFdU2aJvkMhQJmgDZjc3tpCEARA0cAWDuw5Xt2a9
         rbe7mRuvImlhAncm/YGafPBGDSdh9K8Flf6FxIvivQP5IdDzh3YHR2P51uQ82Sm/8Ir/
         tc2Ff6D2wlwb/VFu1u2SVaVOLFNxgSx+OVtluiml9ZYHJ8FgP9QK5MGw9s+ObRUH3xyB
         LHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=OmZty7OBh/c9r+GdB3EsReGfGCbt+FOwWHC6PZ/TIJI=;
        b=whKONEaqcEl38oE+lLY6b0YRrOPAP9j5FiCyyAcB3GywSc3v5noOT/PRBxax7QT2UT
         KcguWRBxiFL5ZzRZdDevxFFXS5t3TnpcuSJxNf/hlLotfKIAtlKWTjHnc4Qscclo3Igp
         nqrkxWL76tIyoykdgAh5IKv0eWBE0hNYCnnVUr8u/1svGPAGvx3P80YcCkIp7NGowfXm
         qTKjQ32TajM9nv2cP8Ynf3pRFvu2RJSkkMBnzBVKdZA2/3Xwh9Zj2E8ix508BKWXN0F8
         qEpLSDNXn2MqSihMacv2Ytwv5bawa7qU4uaUNEx5qM8ADqtrw2WWmkBnzahqG4+M4Ybg
         paDg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DRw9tPAH;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=NRRkpC9o;
       spf=pass (google.com: domain of kernel-hardening-return-12865-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12865-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DRw9tPAH;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=NRRkpC9o;
       spf=pass (google.com: domain of kernel-hardening-return-12865-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12865-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFxU66DqMtwWYh_WqXkdM-fapMyyQZSEZXVmVY=KV-7SLw@mail.gmail.com>
References: <20180331015236.GA3852@beast> <CAGXu5jJsaB+FJJszkOwvW2VYbSHGVyTD+EE=n+k1p1Mg_wtkMw@mail.gmail.com>
 <CA+55aFxVvg=4cX6wTTVNCJMj-VzJp0KhLBY3yLP5Nd3eMXGt=w@mail.gmail.com>
 <CAGXu5j+yDnNkH2vaipGvExqqiAQLP2_SvvEtnzpobBgGvJrUAQ@mail.gmail.com> <CA+55aFxU66DqMtwWYh_WqXkdM-fapMyyQZSEZXVmVY=KV-7SLw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Apr 2018 14:20:05 -0700
X-Google-Sender-Auth: a7I22Yngi6vB7E4x-FkYbTTpvWU
Message-ID: <CA+55aFzN0B+ajX5ArsGYzqRMxDY26ptfTetSoYOOCVJKYHnZ7g@mail.gmail.com>
Subject: Re: [PATCH v7] kernel.h: Retain constant expression output for max()/min()
To: Kees Cook <keescook@chromium.org>
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
X-GMAIL-MSGID: =?utf-8?q?1596942686355695801?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 1:42 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, applied.

Ugh, during the merge window, we had actually grown a new example of
that "different enum types" problem:

        struct drm_prop_enum_list enum_list[max(DRM_COLOR_ENCODING_MAX,
                                                DRM_COLOR_RANGE_MAX)];

in drm_plane_create_color_properties() in the drm drm_color_mgmt.c file.

I ended up just fixing it up manually and added it to the commit. You
should double-check my change, I've pushed it out now that the build
seems ok for me.

There may be others hiding that weren't caught by my limited build
testing, trhough. So please keep an eye out for build warnings.

                   Linus
