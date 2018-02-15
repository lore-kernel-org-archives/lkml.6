Return-Path: <kernel-hardening-return-11799-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x22698ee9Ql0JPMr36E1cOID371Kw/8PatYeJgZmpa8sksszOYlBulrryD1Y1cPwvtMvkY2OP
ARC-Seal: i=1; a=rsa-sha256; t=1518710133; cv=none;
        d=google.com; s=arc-20160816;
        b=F7PQtNgxHsSefp6+IHWkOyPLqBF7r5f+rTFKU1XX/V+h27P/BiZuGUvGrJ7PfgTF3r
         kJa9B/OGk+PJl0TFSTKFkqsjaPogiqIyd6GO0Ac0Cmnw9DKXu/WWCVAYdXYUti7zq7jH
         JC/yMq8kHlPQR8DHGkfTMH1rZ4E2k1NJrtZU44I4077flBstDvvYBBTI5DHVkflpVQYZ
         DFrMmMXsipt/VpdTzhlSP8yrCX8M8hiFSaUpiDe12JWZgXThJjbVCkllR4ZIQ3ZYFxSG
         Iy7ruIH+r/vDYO1POALQQf5+151xkQa/vyUfp2PEgorH1J2o0s9lBS0T3Y6d6qr3Bqy7
         1HQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=LEQUhwUneM6e+kjidNd7RSM/o2/hS5byPj9+LdHKN8E=;
        b=WvQa0fIWSNofvSqENM419RRRZyGOdVMqAOYoBhoqflniYqcYf1CLGKBaSzTW015qsd
         dgJFlIvkXWwVDFjTlTIvjEmaG465cNDw9BVAoS00wCMDZePM7Z/CAm35unfyvzCwHyda
         vU02Lp3/tEpjiShT9/apMU4pNrwMQj8ZmN931zscEqWRkTdNZq+KldMpJ23eDg4pQk1I
         zPe0bhehl71DhZa7FA0nHgmkZHi74gGRepT6bYtFR+QISCRHqgQ0DIbvpaeI3W96fKXO
         Jd5oW97vp/Cl5NVUt86DuSTigSfdqjrIcw/tBJGPkEnFxHRqmE5zycuueRhaUDmACF6w
         DG5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11799-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11799-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11799-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11799-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 15 Feb 2018 09:55:11 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Matthew Wilcox <willy@infradead.org>
cc: Andrew Morton <akpm@linux-foundation.org>,
    Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
    Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
    kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 2/2] mm: Add kvmalloc_ab_c and kvzalloc_struct
In-Reply-To: <20180214201400.GD20627@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.20.1802150953080.1902@nuc-kabylake>
References: <20180214182618.14627-1-willy@infradead.org> <20180214182618.14627-3-willy@infradead.org> <alpine.DEB.2.20.1802141354530.28235@nuc-kabylake> <20180214201400.GD20627@bombadil.infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfNVaI+XgawwFVUGU20lFuYHE16cSGBBejKwvpTCgvKFXfJsfHor9PVo85ag26Wmk/668QQpkzNM9JcHOM12Yv0jHWQISo4XXEjNuRhgUMzGjmV9FjKiR
 E3p9PkrnZ6IzdJAmJQbBtMSQwb2BgEmGLJ1iH4zCrcOyydLzsn06PwEhJVTLJAHOK70Lcp1hglCXNIWxXryqPm554JZssXLMqxtfOKlcgqAB2l162NjhLUIo
 Il/K0DzlxiwkW9hSzbIYAVNuKQx+5ZPYVDSoVdSuwP0i/rpSczU1/n91uUiMDUM6whV/vjd7EXCOZZkFXkml7pqPqEw36Yi6UaoimXDvOUCyyx+LzwSrf4WQ
 LZ6Xgs3BT0S/REcZCzzD9aMQ1pCFFA==
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401933337716102?=
X-GMAIL-MSGID: =?utf-8?q?1592482996469648636?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 14 Feb 2018, Matthew Wilcox wrote:

> > Uppercase like the similar KMEM_CACHE related macros in
> > include/linux/slab.h?>
>
> Do you think that would look better in the users?  Compare:

Does looking matter? I thought we had the convention that macros are
uppercase. There are some tricks going on with the struct. Uppercase shows
that something special is going on.

> Making it look like a function is more pleasing to my eye, but I'll
> change it if that's the only thing keeping it from being merged.

This should be consistent throughout the source.
