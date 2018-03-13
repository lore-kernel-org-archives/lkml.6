Return-Path: <kernel-hardening-return-12512-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELudYFHIJruyJ8tUh7d1nKheqNSg5DIDJFQt05EBfglkJXfKfn5GbZQHFhaJOf8NRHcfzWKN
ARC-Seal: i=1; a=rsa-sha256; t=1520965969; cv=none;
        d=google.com; s=arc-20160816;
        b=t8P2D84YtKvzoFYIFlC2IpatCATkgXWnVFVIYkFQPZT1JGsu0RSXpXkXWPQqS9mESL
         Mc9ssG6uDYx+g4jveFYWP13rtv0RRJzoy+UF+8ZdziAL822k1YWxlN8PJuLEV0548uac
         kflLChQy8MNRT5ZrtxmWneHWkkIT2we3c2g9DA6U6/rinoyK/yo9kLRw4Ia7KTq60f+H
         5+87iGbhilqNAMeAlq3dT9XzWufFZYJ2u3L4+FkCKVL03GJtORaoNKk5+0uvunuqPku1
         SWgXJrbOx8Qm+9vY1BDjMGZGc1DNWH6KpUVfZXfiNxMvxi3W7h08QSCwK41VMIAq7TUN
         Vrkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=S1VLBPT/odgGlddQrwtNkyByUo1oVNuaX4VY1sxg2UU=;
        b=G7vpE/eFy8vHpJ35TZqbS8bgxOcMoHpv9J+CPBCo2R+KGrgpl1HOCsk9oRwhPL5Snu
         DERqF6+Ym01Mnj4IuGmYrAAvNNk4gS/T7JrjUvTMPG3RRqxcCsKdB1ns8eXMQpzSti5M
         or/5nTuLQjiGUj87o2bzW16feBUXZNL5pymG+eMcKrQLZg9dUQVWjXz4vRXgm1VBZgOD
         U05Q1C3rurElCnw9LVp7TxgEFgAYTMTbnpGuW4ez2LcU/ytfzPvFvP5ac1TT6o8A/TxC
         jtvhbdfE8ZbAKr3LajgLNMXZ5kXzBEbqomZRNv+iqVh3J5wtQKuX6eu0WGPbORvJSMRy
         5hqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=E70S/7I+;
       spf=pass (google.com: domain of kernel-hardening-return-12512-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12512-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=E70S/7I+;
       spf=pass (google.com: domain of kernel-hardening-return-12512-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12512-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 13 Mar 2018 11:32:20 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	cocci@systeme.lip6.fr, Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 2/2] mm: Add kvmalloc_ab_c and kvzalloc_struct
Message-ID: <20180313183220.GA21538@bombadil.infradead.org>
References: <20180214182618.14627-1-willy@infradead.org>
 <20180214182618.14627-3-willy@infradead.org>
 <CAGXu5jL9hqQGe672CmvFwqNbtTr=qu7WRwHuS4Vy7o5sX_UTgg@mail.gmail.com>
 <alpine.DEB.2.20.1803072212160.2814@hadrien>
 <20180308025812.GA9082@bombadil.infradead.org>
 <alpine.DEB.2.20.1803080722300.3754@hadrien>
 <20180308230512.GD29073@bombadil.infradead.org>
 <alpine.DEB.2.20.1803131818550.3117@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1803131818550.3117@hadrien>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401933337716102?=
X-GMAIL-MSGID: =?utf-8?q?1594848411971523025?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 06:19:51PM +0100, Julia Lawall wrote:
> On Thu, 8 Mar 2018, Matthew Wilcox wrote:
> > On Thu, Mar 08, 2018 at 07:24:47AM +0100, Julia Lawall wrote:
> > > Thanks.  So it's OK to replace kmalloc and kzalloc, even though they
> > > didn't previously consider vmalloc and even though kmalloc doesn't zero?
> >
> > We'll also need to replace the corresponding places where those structs
> > are freed with kvfree().  Can coccinelle handle that too?
> 
> Is the use of vmalloc a necessary part of the design?  Or could there be a
> non vmalloc versions for call sites that are already ok with that?

We can also add kmalloc_struct() along with kmalloc_ab_c that won't fall
back to vmalloc but just return NULL.
