Return-Path: <kernel-hardening-return-12430-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu9ZLX3L45OSlo3BBJbwFrH1AHxIB97r1bARTV4c2svhUKKbkZ1lephh4Q9i2PMhtJIFsJT
ARC-Seal: i=1; a=rsa-sha256; t=1520857463; cv=none;
        d=google.com; s=arc-20160816;
        b=eZtjRF3BiG2hflSFbVo8iy6iQi2VGPUshEw1sziCJucm4LqJBmAVzdtSqxlOjhDQOp
         6wrtqoU2rjK6qLoYs6vUTgKO4ZBqdXonDwTPXMzj9s17/91poQyqDfCOYn8O64HQBTyP
         400wTOUff5jpEVK4ru5oi1PCsg+SBaf2yemNhpSJ1Vihbw6liIWvKsUz0B5webKVvqTd
         YmMAPYhGFAArIN/XHwQvPnOG62NChwTZVvMcU1a1lIflxvPWPmFfjy3TP9qLxmhuISJt
         0hwTY614chgnAzyifjUU9wK1yBVcWD5v+E9sLIIzD2iOU/GiKhDZjG4LxkFhb2eAW8AA
         3zWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=H2+SvRy6b44MNjtpS+5tree87cm1YEgb7KhvSWbDWsE=;
        b=1A+FZd0EEihUtpGl6/tfUqYqziVaHNKHSs8SgQ7aOVVO9BDBPYkLbBG5zjvLpG5OtW
         JMMRSTBVcmLiIpqvgjKgChib3z9HmQOnebH8L8UQW1wE0Mde4RNrOzr+u2P65sOgAkwi
         YEeZFSkoRpNvL5WVIEpf8/4kitNtpk+4IlSLkTAnktIKSGrTHnBm2/wZNJbqFV7c1IXq
         h8RDQ0qbZ/40Ft5xNI1FW6GKRjRsFeYajuTdY7NziinpLrXPEboyHga7r8P4GGhDQ+Kj
         gNJ045zmcSzQak0AqNANw8fxMK2x236f0aWIdnQWzKOW/rfJbCKxiR9X+ttj8YcFvFHj
         KxIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12430-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12430-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12430-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12430-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 12 Mar 2018 13:24:03 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Stefano Brivio <sbrivio@redhat.com>
CC: Kees Cook <keescook@chromium.org>, Andreas Christoforou
	<andreaschristofo@gmail.com>, Kernel Hardening
	<kernel-hardening@lists.openwall.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI
	<yoshfuji@linux-ipv6.org>, Network Development <netdev@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: ipv6: xfrm6_state: remove VLA usage
Message-ID: <20180312122403.tkav5d3plfll63vp@gauss3.secunet.de>
References: <1520667645-21975-1-git-send-email-andreaschristofo@gmail.com>
 <20180310094327.685d181d@epycfail>
 <CAGXu5jKwWRzK8EJOo2zraxi9ghQ7an5d4yr8ktGa+ijWX_aJZA@mail.gmail.com>
 <20180310192644.3fcbb69d@epycfail>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180310192644.3fcbb69d@epycfail>
User-Agent: NeoMutt/20170609 (1.8.3)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 912AC1C5-CE00-4ECA-B7BE-D7957649ABCA
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594535997865166060?=
X-GMAIL-MSGID: =?utf-8?q?1594734635472937403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 07:26:44PM +0100, Stefano Brivio wrote:
> On Sat, 10 Mar 2018 09:18:46 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 
> > On Sat, Mar 10, 2018 at 12:43 AM, Stefano Brivio <sbrivio@redhat.com> wrote:
> > > On Sat, 10 Mar 2018 09:40:44 +0200
> > > Andreas Christoforou <andreaschristofo@gmail.com> wrote:
> > >  
> > >> diff --git a/net/ipv6/xfrm6_state.c b/net/ipv6/xfrm6_state.c
> > >> index b15075a..270a53a 100644
> > >> --- a/net/ipv6/xfrm6_state.c
> > >> +++ b/net/ipv6/xfrm6_state.c
> > >> @@ -62,7 +62,7 @@ __xfrm6_sort(void **dst, void **src, int n, int (*cmp)(void *p), int maxclass)
> > >>  {
> > >>       int i;
> > >>       int class[XFRM_MAX_DEPTH];
> > >> -     int count[maxclass];
> > >> +     int count[XFRM_MAX_DEPTH];
> > >>
> > >>       memset(count, 0, sizeof(count));  
> > >
> > > Can you perhaps initialize 'count' instead of calling memset(), now?  
> > 
> > Do you mean:
> > 
> > int count[XFRM_MAX_DEPTH] = { };
> > 
> > instead of the memset()?
> 
> Yep.
> 
> > I thought the compiler would resolve these both to the same thing?
> 
> Yes, for all practical purposes. With gcc 7.3.0 for x86_64, starting
> from -O1, it's exactly the same. With e.g. gcc 4.4.7, even with -O3,
> they can be a bit different depending on context.
> 
> > The former looks better though! :)
> 
> Yep! :)

If Andreas does a v3 anyway, please also consider to trim the subject
line to something like:

xfrm: remove VLA usage in __xfrm6_sort()
