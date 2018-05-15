Return-Path: <akpm@linux-foundation.org>
X-Google-Smtp-Source: AB8JxZowPC37ixcN6NXAOxdGR539DMY+tE5xDqjGHlf+1oc/guwRyMYneWZTTSZdimIc8Wc8nWCF
ARC-Seal: i=1; a=rsa-sha256; t=1526425166; cv=none;
        d=google.com; s=arc-20160816;
        b=wXHbXsTlk2LCIsMFKi0/y1q+poCKpRO+4/zcty+V8SelokjVKnCgSSDZrXb4IedRiC
         RBKPDpGm7SaMGOMOkiC6sUpCiHVZ7Ar6DplezwxWWh9vM6S0iFdcNfbyblJisBMYjWLY
         fDH+r7cBxfaLTVAxFlvAm268shiAVc/2EtZLVZsF+Z0E7ENKV7//O68pZc0IdpqxmK7v
         7bP++r5tDBp5JE5n4u0CjJLInI29l3a/s63Q5Wknm2L4ayptssrJAQOqU2skx7M1xWPn
         jTDfVm43MsklwI9M0zAtUJQ0ShNd1XbFTiK+FCdfsHb56YdJhQEFawy+UXybNRVUCzN+
         mFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Leqdh9z1bNWRo34l1f8ITT8J8FqY9B6DaC0HyhqLLMM=;
        b=uPMO26TpnoYrxiTbx2vxJh5XdZD45aZZnBDmDv+U8lgmZ7J1ouw1ufZwfln9aYPYiO
         uqkyGYC2QOOguW4NCQliFWhbOrDF2DK8eu/5q9TqYpz+rJ+KHn1j3JhIxHqI3G9bfu9J
         vJjLFcd7bsDOH+Fba3q9jrSRMp22nTbXU+bLi4o94t6e55mYsa2n7ASHrJAdvjD/GmXD
         b1nMmVb2rdcM5QXwGUlXWwCSYtiI1E2tADm1WHpaDfPNW16hz/xfCXBnTtmzS0LcOn/u
         Fyu3cpgMuLWqIUsq1M0UclPhjXLbet+w9jSrztvmvamAhyggxaBVWgAE4pckoygQ7X3u
         iEtA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Date: Tue, 15 May 2018 15:59:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Alexey Dobriyan
 <adobriyan@gmail.com>, Lihao Liang <lianglihao@huawei.com>,
 linux-kernel@vger.kernel.org, Philippe Ombredanne <pombredanne@nexb.com>,
 Pekka Enberg <penberg@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] types: use fixed width types without
 double-underscore prefix
Message-Id: <20180515155925.9c16962e2b416e5f507c07b1@linux-foundation.org>
In-Reply-To: <1526350925-14922-3-git-send-email-yamada.masahiro@socionext.com>
References: <1526350925-14922-1-git-send-email-yamada.masahiro@socionext.com>
	<1526350925-14922-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600495013490118173?=
X-GMAIL-MSGID: =?utf-8?q?1600572796013095021?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 15 May 2018 11:22:05 +0900 Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> This header file is not exported.  It is safe to reference types
> without double-underscore prefix.
> 

It may be safe to do this, but why is it desirable?

> index be15897..9834e90 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -10,14 +10,14 @@
>  #define DECLARE_BITMAP(name,bits) \
>  	unsigned long name[BITS_TO_LONGS(bits)]
>  
> -typedef __u32 __kernel_dev_t;
> +typedef u32 __kernel_dev_t;
>
> ...
>
