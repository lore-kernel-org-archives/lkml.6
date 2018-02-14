Return-Path: <kernel-hardening-return-11769-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224jCRf5XNGx7RwNfhJ82zjxndqJtpzXp2pl4xAKvikPYwPs+2LSypLvD5q+r2/5gXrr5oUM
ARC-Seal: i=1; a=rsa-sha256; t=1518638179; cv=none;
        d=google.com; s=arc-20160816;
        b=Bhz54XTt6OYjv2SizyoaAej2cS52jPlxhr3jvqwGbv/ILjeW338XAezaB7ip8/axUu
         zASo2S94Iwk3ROkqEuKXgA/Tnd0qYH4NiGK6VqLMDfmwK1ZVvX7VvcD+RrOaFOv/9m1f
         yWuEB9BpgLPvZI79bxraiTAbkDPqTs2xLtVVwFuFk5mMnuNs0c0khawcHhCkeiDv7QMF
         VMSg0n/zlmEn9ZlOecu3nehFtqudc6G1BfjzVk2gjKj/M3Aog6L3cuX1mVaMlCYyu/z7
         f67QHpR+SrPG2y24ZT5K6RIWuPjroREQSQMO3E9IuLALsa7fMqrSfFl8Na7J0Sk189ID
         unew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=kM82RYpaMfXj+19Sojlx+KaaCt+2rTu6EyFgbJe9RZk=;
        b=dZDqPP4WweNc2+uOxJUSjLgDzBf7keD8fckSmi5N/YMkebrQq6PzOv67ATzHDW+e2V
         FS1vdZAePPynY1iLbD81q0Ne0cTdDH98HWL//paTuwHLcYIOHnLAhLc4Pb9GfFA5m+NT
         I/uzSusE2cBcfO3ueMZzLyuFvNra+OcV8/GkzqORodyBw8Q3iTG5H7CC9J9mzAwgynY3
         Io+Qcd4TxY5raD+ccFXyCz72Oe1nqFtZxHZ7dmD7FpnTsliHle7Ylr7z0f6MXAs84+MF
         QqqtZGLZdepFI9j8ghNvjMUPcotO8tFD9xzruduJ/xxnHgD2ImyDaB5S6d+Pnpj35ZDS
         oLZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11769-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11769-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11769-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11769-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 14 Feb 2018 13:55:59 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Matthew Wilcox <willy@infradead.org>
cc: Andrew Morton <akpm@linux-foundation.org>,
    Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
    Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
    kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 2/2] mm: Add kvmalloc_ab_c and kvzalloc_struct
In-Reply-To: <20180214182618.14627-3-willy@infradead.org>
Message-ID: <alpine.DEB.2.20.1802141354530.28235@nuc-kabylake>
References: <20180214182618.14627-1-willy@infradead.org> <20180214182618.14627-3-willy@infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfGWYWk8bma8PDA9hdUtGQQA4iY+vdeuRNFpb8Gce5u6Fq9wE1MKVSTn1DsyczItyaE1sOG92beNgiv0D6RJBS1lptX2tpf+7+1ATVSf/wISZh8iqtFa9
 NT+hUz1K1sd9Ifg9wr7LdTuNMIcl1XQeD0Om7wA/fZkgTGb9lljKY7VHREq8g0Z2rCjdmGIuXisGve+hNnzAaUjAT0GClzXxmLC3HHTuI54D2FlUv1onecd9
 CHd0vzEYEi4Ks/2sSe2nNUQWNFYgBxPslTlALWvJs2mL1HntZSJ06SBKVQTTAriU4CQTvV2j2NV/DYViLlofYGr518dYy8p//cilNGd9wrTraoWYlhipxRg0
 +pd1RXBet2UeXbwHqmpqHBw15HgUPw==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401933337716102?=
X-GMAIL-MSGID: =?utf-8?q?1592407548414175153?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 14 Feb 2018, Matthew Wilcox wrote:

> +#define kvzalloc_struct(p, member, n, gfp)				\
> +	(typeof(p))kvzalloc_ab_c(n,					\
> +		sizeof(*(p)->member) + __must_be_array((p)->member),	\
> +		offsetof(typeof(*(p)), member), gfp)
> +

Uppercase like the similar KMEM_CACHE related macros in
include/linux/slab.h?>
