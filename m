Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AF0C7112C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35412075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="yCoKAAuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35412075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeJXXYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:24:43 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40446 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbeJXXYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:24:42 -0400
Received: by mail-qk1-f194.google.com with SMTP id x11-v6so3450155qkl.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 07:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qZ2514qk1H7lrT6V2q7uwHgptwI/uC+DgUUVl41xFxM=;
        b=yCoKAAuPKizyRRLcbeJ4eLSHRX33vdSWumR/8HFlQem5CnxmTYc2hglr1JtGYrc/KB
         OvOW9R3RqwQjOh1V59ockJlflL4/agZNKHdnOcHGNQOKRtS9l61sUj1ZmWR/BNdmSr/w
         kUzcD0WFwIvI8nI8kWkLuMk9WND0liCRLaeJ0vxK5QEN5dDOyA2EX8mEyaM5d4n9TLG2
         FfkKWaQzRCX9u/87dXy7Kyk+3n/+Om/vkQ8mCaRciHxMUUEUnhs3fQJHYGiiOb5rr+Ob
         XvuiqzUZW1jQe/UZ394W1QZDgkdTrxZfhKRoCkTtwtu5VjW8kqPf22XQ0I5TlLGZoKWH
         TInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qZ2514qk1H7lrT6V2q7uwHgptwI/uC+DgUUVl41xFxM=;
        b=Bgw11vV/ubvfIY/yrnGd/CODtWak13LvLU3oLnCXT2hHBaG1+0WzHhVer1INDXL2WV
         H3Jvj5ZCZGUIuPstUBU6q/dDzPsI7Ub64BCseUj/4xmFN6h0Zwgw3r0RBZlbhmqrvlFH
         mrmDQDQPj2EtO8GZJIElxhl8+Q56WKLvtcfoOS/m7qgileC/yyPk5dIGcnihXN799/fa
         jTzS9AYVFr+aQ4H1ABxbjn3uVyWuXPB6t7c2abUBmbl9WArdgbCNeCPLypDDMxH4W/T3
         uGRp2X1S8dLNbAYkElctAaPiW1zUei4d1Oay9DB2yYTNlS7sbGFGjV/Ed3aoFe0eggoi
         UKtg==
X-Gm-Message-State: AGRZ1gKSks/fsxS4DJNc/wWQEC3L+COCjpVfKTgRpoVXla/Bg54tE+H8
        brah/BwkcN1WD/el/+wloVXHmg==
X-Google-Smtp-Source: AJdET5e99wyv4PKWEz3r3V7UFK7qWXI3xrDG/D67w1jWqdNZ+/ujU1pdTkq7DJAH8eq9uZPMIQ5sNw==
X-Received: by 2002:ac8:27d0:: with SMTP id x16-v6mr2695782qtx.61.1540392975547;
        Wed, 24 Oct 2018 07:56:15 -0700 (PDT)
Received: from cisco ([192.241.255.151])
        by smtp.gmail.com with ESMTPSA id v5-v6sm2732998qkc.75.2018.10.24.07.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 07:56:14 -0700 (PDT)
Date:   Wed, 24 Oct 2018 15:56:06 +0100
From:   Tycho Andersen <tycho@tycho.ws>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        igor stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/17] prmem: llist, hlist, both plain and rcu
Message-ID: <20181024145606.GA9019@cisco>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-15-igor.stoppa@huawei.com>
 <1634210774.446.1540381072927.JavaMail.zimbra@efficios.com>
 <243a8ff2-889c-089f-a1ff-c882933ca5c3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <243a8ff2-889c-089f-a1ff-c882933ca5c3@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 05:03:01PM +0300, Igor Stoppa wrote:
> On 24/10/18 14:37, Mathieu Desnoyers wrote:
> > Also, is it the right approach to duplicate existing APIs, or should we
> > rather hook into page fault handlers and let the kernel do those "shadow"
> > mappings under the hood ?
> 
> This question is probably a good candidate for the small Q&A section I have
> in the 00/17.
> 
> 
> > Adding a new GFP flags for dynamic allocation, and a macro mapping to
> > a section attribute might suffice for allocation or definition of such
> > mostly-read-only/seldom-updated data.
> 
> I think what you are proposing makes sense from a pure hardening standpoint.
> From a more defensive one, I'd rather minimise the chances of giving a free
> pass to an attacker.
> 
> Maybe there is a better implementation of this, than what I have in mind.
> But, based on my current understanding of what you are describing, there
> would be few issues:
> 
> 1) where would the pool go? The pool is a way to manage multiple vmas and
> express common property they share. Even before a vma is associated to the
> pool.
> 
> 2) there would be more code that can seamlessly deal with both protected and
> regular data. Based on what? Some parameter, I suppose.
> That parameter would be the new target.
> If the code is "duplicated", as you say, the actual differences are baked in
> at compile time. The "duplication" would also allow to have always inlined
> functions for write-rare and leave more freedom to the compiler for their
> non-protected version.
> 
> Besides, I think the separate wr version also makes it very clear, to the
> user of the API, that there will be a price to pay, in terms of performance.
> The more seamlessly alternative might make this price less obvious.

What about something in the middle, where we move list to list_impl.h,
and add a few macros where you have list_set_prev() in prlist now, so
we could do,

// prlist.h

#define list_set_next(head, next) wr_ptr(&head->next, next)
#define list_set_prev(head, prev) wr_ptr(&head->prev, prev)

#include <linux/list_impl.h>

// list.h

#define list_set_next(next) (head->next = next)
#define list_set_next(prev) (head->prev = prev)

#include <linux/list_impl.h>

I wonder then if you can get rid of some of the type punning too? It's
not clear exactly why that's necessary from the series, but perhaps
I'm missing something obvious :)

I also wonder how much the actual differences being baked in at
compile time makes. Most (all?) of this code is inlined.

Cheers,

Tycho
