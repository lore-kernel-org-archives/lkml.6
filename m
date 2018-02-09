Return-Path: <kernel-hardening-return-11665-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227iJ4RMXFHymeolLSeOH2TSqSMKt4epL02+3K7Ve0fSdoIHN7ZOpwYqeZWivKHE+GtbcGjk
ARC-Seal: i=1; a=rsa-sha256; t=1518140896; cv=none;
        d=google.com; s=arc-20160816;
        b=sjC+ZGYKshXMoWMGXs1Mm+4sIGoXG8A+6gM0WwgI/61SFLoLhAViL6mAPd9G6WCtJr
         FHB+oOw4RjL/kJ2X7FjaTvobMhNu7JC8nThpUEoKK0/yEa6K0pa9EPwfr7K9kow+ARht
         p9hZ7XNIjcKMJNWk9GRsTmtgrd72F2wG0iLDpmIJwiodnVBm7S+lt8uF36U5w4memUdu
         oetezDruR8irXImX+iLbCaYss5ISaM5X/Oils2pNDMGVy/TIdMQXOsGMKLp+AIqz/38a
         LaZqpNbz5yZE+pgcdiqQ8KHKou6x8HIidipBgszzLjhS1FIZdNY2ATGmFHTLy5LPJLNg
         g0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=lQHdmt+zeBygz2f7EFnLJqQmvEzc0W9igWrWSIl4q9k=;
        b=OdBpMXiicTKSHQNrw5DEZ3aIwngXSeDdQUkKfDy3N/eqgovpkcleleDsGvAIWex8ur
         GucRw3rofHrva+U4qbrENn/cStdlr+26JMk7C7Q3pf8DteAz2OwEd+mPLXRhp8GX8099
         vy8qyux4ys9F8w9ViFvPSAXbMdjkm/vVoq+hsGuQhzCVoEBQie5XKtDEFrSwHzoVm6K5
         Iue3IMBpFfkJ+bdy0iQdxJGp23nwXXREdQiphtCa3zO4FDojdPejKkgaMKFUU34adfRl
         SS62g+25y9lcIGeTS/gy8xzh9RJ3Uvsuk/GCQj/TEDdlwLGLfTMCcD1mopdHQb5dB5jN
         2oyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gG3fOAVt;
       spf=pass (google.com: domain of kernel-hardening-return-11665-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11665-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gG3fOAVt;
       spf=pass (google.com: domain of kernel-hardening-return-11665-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11665-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180208202100.GB3424@bombadil.infradead.org>
References: <20180208021112.GB14918@bombadil.infradead.org>
 <CAG48ez2-MTJ2YrS5fPZi19RY6P_6NWuK1U5CcQpJ25=xrGSy_A@mail.gmail.com>
 <CA+DvKQLHDR0s=6r4uiHL8kw2_PnfJcwYfPxgQOmuLbc=5k39+g@mail.gmail.com>
 <20180208185648.GB9524@bombadil.infradead.org> <CA+DvKQLHcFc3+kW_SnD6hs53yyD5Zi+uAeSgDMm1tRzxqy-Opg@mail.gmail.com>
 <20180208194235.GA3424@bombadil.infradead.org> <CA+DvKQKba0iU+tydbmGkAJsxCxazORDnuoe32sy-2nggyagUxQ@mail.gmail.com>
 <20180208202100.GB3424@bombadil.infradead.org>
From: Daniel Micay <danielmicay@gmail.com>
Date: Thu, 8 Feb 2018 20:47:57 -0500
Message-ID: <CA+DvKQK_JAmy9AyJgX6wp=nMatYiAb5882JTzDuoD4Bcuzo2Cw@mail.gmail.com>
Subject: Re: [RFC] Warn the user when they could overflow mapcount
To: Matthew Wilcox <willy@infradead.org>
Cc: Jann Horn <jannh@google.com>, linux-mm@kvack.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591796976786547518?=
X-GMAIL-MSGID: =?utf-8?q?1591886108989235780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I think there are likely legitimate programs mapping something a bunch of times.

Falling back to a global object -> count mapping (an rbtree / radix
trie or whatever) with a lock once it hits saturation wouldn't risk
breaking something. It would permanently leave the inline count
saturated and just use the address of the inline counter as the key
for the map to find the 64-bit counter. Once it gets to 0 in the map,
it can delete it from the map and do the standard freeing process,
avoiding leaks. It would really just make it a 64-bit reference count
heavily size optimized for the common case. It would work elsewhere
too, not just this case.
