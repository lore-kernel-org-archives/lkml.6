Return-Path: <kernel-hardening-return-12720-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs4OHDCj1e3CocVPbpmSy6pf6VUmHwqHYGMEIhHz4+jAONBbD5AZiQoULeRChDc17mHAa+b
ARC-Seal: i=1; a=rsa-sha256; t=1521738277; cv=none;
        d=google.com; s=arc-20160816;
        b=hj0N8JpwGUkAhSt3GWxnLThpFY9yqvKhwPiYY5Aw3jhjpVbv/A8ElWBM8yIGyYaUog
         PSXxe8N+ZPndufZ0f9Hyemgdd1ztaAdve0Lws54aMZXMpODmYZHYwPLtsH9Rk1MyBxst
         pNEocY2TO2G+tCx6Vh6tsrcqwuvyHuCJ+mBAi+TEnRNeHy/MVNKAj8D+9Ob2WRhGpJJX
         GqmjdIicKbniw+YfB1PrlF+7wHRvMMdelOoPzpsr+SRbeylpA/F+NZgxKiIJdDN+tygt
         WgYm2hCpHnVjCBQ2qjuU5P/51v89CwoX4vpailoT2bggLB/EFsypGyvAs4Zv55My7qCm
         /YNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=8iakfsKuLcka2vj5cjC5ZPB2nL5DjM1/05ZgYPZ+TAs=;
        b=liKi15ENWUeQcnNNSrVuLQOSj9klL2/4VwWvTVoxSvz43juH4wlniQXaZJn4dKVLGp
         YaiqjdYku+X1DOw427D6J6TgAZyh5GeCLJfvzLdJMSUw8S0OoD6TTJjXZbUqKLuNtvfm
         F/dLNplbrFTUJRC8hKD1MidZQAv8uT3+zReDBndZDE+5mdFUBGf5HiW3qrrzmFUqHWCT
         qUV4QDcO9v5QngUYF/vwjGwin9jgUTucOmOmJwnRp2KN7Ll4yLiQiKTZj0aKx0Dk7EHE
         r7Q/9se4r53/KhazDnSRADTzHWarVFW2PmIsLXxwUzKC5TyvMs0K8o2EbZ47jm8maGNi
         cKvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EWlFx/7K;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=S4HSt1m3;
       spf=pass (google.com: domain of kernel-hardening-return-12720-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12720-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EWlFx/7K;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=S4HSt1m3;
       spf=pass (google.com: domain of kernel-hardening-return-12720-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12720-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAGXu5j+5i+56R0KDLMDA=+_DRW5w9aUGCEo0dq6PZvHPBWkM1g@mail.gmail.com>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com> <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <20180316175502.GE30522@ZenIV.linux.org.uk> <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
 <CAGXu5jJmAAgaq3VCsUN2yjpHLSc7P-kNrM_4c4cqP=ysFcETXA@mail.gmail.com>
 <CA+55aFwv0VC67cx2W9yrf7qSFKf6ncVRrsVyLGqdmfSBn4yTYw@mail.gmail.com>
 <CAGXu5jJ=ZYpf=30H6hsWn-R-CEVYAgVMHxjmoLUC00QYq0r17g@mail.gmail.com>
 <CA+55aFwxk=tUECYQkd4cog08qW4ZT=r2K7FQXzGnc-zuMc7JQA@mail.gmail.com> <CAGXu5j+5i+56R0KDLMDA=+_DRW5w9aUGCEo0dq6PZvHPBWkM1g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Mar 2018 10:04:14 -0700
X-Google-Sender-Auth: PBso_vYTCV7C_B-jyAybvlAnrrA
Message-ID: <CA+55aFwG6gzgyDNSGXs+E3HmhPnAXpuZ1tAmFG4QgGeF5m9tAg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
To: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Florian Weimer <fweimer@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>, Ian Abbott <abbotti@mev.co.uk>,
	linux-input <linux-input@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595658236824951638?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 8:01 AM, Kees Cook <keescook@chromium.org> wrote:
>
> Seems like it doesn't like void * arguments:

Yeah, that was discussed separately, I just didn't realize we had any
such users.

As David said, just adding a (long) cast to it should be fine, ie

  #define __is_constant(a) \
         (sizeof(int) == sizeof(*(1 ? ((void*)((long)(a) * 0l)) : (int*)1)))

and is probably a good idea even outside of pointers (because "long
long" constants could cause warnings too due to the cast to (void *)).

                Linus
