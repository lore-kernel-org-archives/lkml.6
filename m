Return-Path: <kernel-hardening-return-12384-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvXQ10i67n6H/FK+e6JOlP6dKrRjth+eEbMw104dJCkKd/NWVCdUlbN9JqR3us/f97Dt8PX
ARC-Seal: i=1; a=rsa-sha256; t=1520707378; cv=none;
        d=google.com; s=arc-20160816;
        b=ItpmKNqt/OXS9Mr3QjuJ6e651wb4rF4qRlTrS3hnw4ZmPrWGa+nela+SNfyv40gizl
         FzJYvGtGqzRlrzKIXhTfmZXyHpiQpEh7T9nfS7JRJ5sc0pkuRQsj/RWrwMTxwRRiUHxo
         FEMNhkgLr+CiaaBKCunmP50leVbd7VMr3VGrnY62Q7j5sa5KdmGuSkVvUsf0QAEGkXC2
         V2EDabxrxaGQMC1OVYdpDAy0GlfDbgWnTZuzmdXVgF0CjpNkA7+wFT1lvlDXm+k0pR7a
         1qAbzMDAQ6N2vDz1juNcn0tYCXOhdRefqj8i136zholt6N6F+nK2kPEpYKb/awhiOoUj
         fraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=6iPCUHqZYN2TBkHNCfAvyC1mbf1NC4z9Z0LlXIQqcG0=;
        b=XWza1KldBJCubHcisYSpPqJS+34n/GYCmUTUEa69buwqFBaZyJDTdcfPl5uGGPgbOQ
         B0QMhQWswY+Os6HsrPXmv0S7K291v/H9b4nsUCGGAQ15hz/Dk8JzfL5DAc9UfxFzN4vU
         uYwqrETPMhrK46gZtkLdWJgeOcNy2f+esP1Xt1hOBHZb2MoxhkLJURcBx/7rfsWDGUU+
         sKTKQzRZBhH8wkIInwW92dar14KUNmuXBWtYnzs2mwpPme+QK9p6qryOJUzEZMXkLYyX
         hChspOr923JJTj8Nor5Nb1a8xbZdIpk14fYgLaU0u9Pg2VtHkHYN1J/+DIdv5sxpjPnK
         rkew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12384-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12384-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12384-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12384-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sat, 10 Mar 2018 19:26:44 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andreas Christoforou <andreaschristofo@gmail.com>, Kernel Hardening
 <kernel-hardening@lists.openwall.com>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov
 <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Network Development <netdev@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: ipv6: xfrm6_state: remove VLA usage
Message-ID: <20180310192644.3fcbb69d@epycfail>
In-Reply-To: <CAGXu5jKwWRzK8EJOo2zraxi9ghQ7an5d4yr8ktGa+ijWX_aJZA@mail.gmail.com>
References: <1520667645-21975-1-git-send-email-andreaschristofo@gmail.com>
	<20180310094327.685d181d@epycfail>
	<CAGXu5jKwWRzK8EJOo2zraxi9ghQ7an5d4yr8ktGa+ijWX_aJZA@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594535997865166060?=
X-GMAIL-MSGID: =?utf-8?q?1594577260133478405?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 10 Mar 2018 09:18:46 -0800
Kees Cook <keescook@chromium.org> wrote:

> On Sat, Mar 10, 2018 at 12:43 AM, Stefano Brivio <sbrivio@redhat.com> wrote:
> > On Sat, 10 Mar 2018 09:40:44 +0200
> > Andreas Christoforou <andreaschristofo@gmail.com> wrote:
> >  
> >> diff --git a/net/ipv6/xfrm6_state.c b/net/ipv6/xfrm6_state.c
> >> index b15075a..270a53a 100644
> >> --- a/net/ipv6/xfrm6_state.c
> >> +++ b/net/ipv6/xfrm6_state.c
> >> @@ -62,7 +62,7 @@ __xfrm6_sort(void **dst, void **src, int n, int (*cmp)(void *p), int maxclass)
> >>  {
> >>       int i;
> >>       int class[XFRM_MAX_DEPTH];
> >> -     int count[maxclass];
> >> +     int count[XFRM_MAX_DEPTH];
> >>
> >>       memset(count, 0, sizeof(count));  
> >
> > Can you perhaps initialize 'count' instead of calling memset(), now?  
> 
> Do you mean:
> 
> int count[XFRM_MAX_DEPTH] = { };
> 
> instead of the memset()?

Yep.

> I thought the compiler would resolve these both to the same thing?

Yes, for all practical purposes. With gcc 7.3.0 for x86_64, starting
from -O1, it's exactly the same. With e.g. gcc 4.4.7, even with -O3,
they can be a bit different depending on context.

> The former looks better though! :)

Yep! :)

-- 
Stefano
