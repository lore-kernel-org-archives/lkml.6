Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA8DC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8F32081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CDqo1FKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8F32081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeLDX7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:59:17 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42670 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeLDX7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:59:16 -0500
Received: by mail-ed1-f66.google.com with SMTP id j6so15465036edp.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 15:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SqoyHVYj/uLGolRV4jdUgg7Lv7ReizNW/bp9vefhxxE=;
        b=CDqo1FKulmo9s37ik+eLl5nIpbW0DcWIFENtjvirsB7VnxedkR66kkJSQBkl4/dRjQ
         uOuOjdiQFznTwhpMgBjEr6WKcqHREnDi62MXbEeGqsLIDg7wjM8v/UjD6CKZwKWrBg0N
         jHI0NtCUR7NFyVU+lexd4bWte6N3NH2h4xPh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SqoyHVYj/uLGolRV4jdUgg7Lv7ReizNW/bp9vefhxxE=;
        b=lxSRPKRd6hoQdJQwGu1toiUUXB7VntjKOfY6WSYJymloNWemha3FSi0WnSellk0uW6
         CGj/JJKncpryKitx5q7hHLjrz0dvkgKIUhwsV2EOwntg77QAtrWGvUggjY8GPxaRwYg9
         PKBgw1QcAYUDy5wlCJxeCmdo0njw06O92w7RXRx+VvynfvYQ0pMpUx3KH4C8x/8t2VE2
         nvmtz9Triw6iFE3qt/fnjEhyyjPRRYIRDOtQHsinZWu3WGzspKhEX1sEQsIFlNouRehe
         vD1M5Alu0h50wX3gvP3uljS6AmpABU1FrbaU12SzMxQRWwZZFOmzBMsTJ/zEWnfec3T8
         7wmQ==
X-Gm-Message-State: AA+aEWYvGlsq/EeuWzUWnwO6IqShCRyAAS+R1fYWxonb85DdHrb4DZpt
        WSOIebo+DDdpl/aXjwq/7AHWpqBnZWvXtA==
X-Google-Smtp-Source: AFSGD/XcOPIvNmKooDif8JB2aBHSsyaJFB6uJxb9D7Hhb0Jg1bphYtHh8PTZUTq2N6TrUXSx9/0iQg==
X-Received: by 2002:a17:906:6b99:: with SMTP id l25-v6mr16717548ejr.154.1543967954635;
        Tue, 04 Dec 2018 15:59:14 -0800 (PST)
Received: from andrea (dynamic-2a00-1028-8386-da8a-eacb-c188-78b9-634c.ipv6.broadband.iol.cz. [2a00:1028:8386:da8a:eacb:c188:78b9:634c])
        by smtp.gmail.com with ESMTPSA id x10sm4933356edb.58.2018.12.04.15.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 15:59:13 -0800 (PST)
Date:   Wed, 5 Dec 2018 00:59:07 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/1] epoll: use rwlock in order to reduce
 ep_poll_callback() contention
Message-ID: <20181204235907.GA5388@andrea>
References: <20181203110237.14787-1-rpenyaev@suse.de>
 <CAHk-=wiQX4HnBpyrxCwJmhBRff0GG65tOhsRnA=2KdYL=PBdyg@mail.gmail.com>
 <83edf06ce9db540495b53527eca3248c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83edf06ce9db540495b53527eca3248c@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On Tue, Dec 04, 2018 at 12:50:58PM +0100, Roman Penyaev wrote:
> On 2018-12-03 18:34, Linus Torvalds wrote:

> > This also ends up making the memory ordering of "xchg()" very very
> > important. Yes, we've documented it as being an ordering op, but I'm
> > not sure we've relied on it this directly before.
> 
> Seems exit_mm() does exactly the same, the following chunk:
> 
> 		up_read(&mm->mmap_sem);
> 
> 		self.task = current;
> 		self.next = xchg(&core_state->dumper.next, &self);
> 
> 
> At least code pattern looks similar.

Maybe add a comment on top of (your) xchg() to note/justify these memory
ordering requirements?  As Paul said: "if there are races, this would
help force them to happen" (and simplify the review, this/future).

  Andrea
