Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236A6C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD09C2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJXMSba2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD09C2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbeLCIwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:52:40 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54474 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeLCIwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:52:40 -0500
Received: by mail-wm1-f65.google.com with SMTP id z18so4817524wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 00:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lE9j27DvC1/srbXNmFA9deLjffoHkZ89jSlYii0k6L8=;
        b=kJXMSba2ZEkLvqNWKpvQpy9ALpRwuGjt+f4X2ybrW9NpuiZUAy7zr8lk4+Ai8/IXsY
         diUCRl/X4GthvWGqzRKlJfnWzAnpGPpj1KIw6REzy7irT6ZRZVs7JkUsWd5OWmBm2QNH
         shoElaRl0w1Vk4a4GDRXqIO3ilSsHkcQLITIaB1mQDSCzsqbqJX4CRDplcagMHcB5aix
         wdsdc2GVeOta8mXdNMyTeInucet4pK8k2VvlAz4pelLlLtUAqd1cXZpbTIhbGRViBSmq
         Jji0I6iI9+nV/rbY9m6sHRv9OHpGk2slF7tz6lV92zt82OJ624oHh/yOFDBr+fdE8Zbq
         JIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lE9j27DvC1/srbXNmFA9deLjffoHkZ89jSlYii0k6L8=;
        b=bSH/u4J8KZE0OLbPNJwv0XRwFq7F8LcvCsPyKnPgHetX6xv/8oETxS50mVkMf3diH2
         paQ+AGV4+0AwwdNEmKQB32hAqPjuSnD1EkXrgGUkjXq3+6eWxuqTO+fcIg66vbnXJMzU
         X63GzCqweNxT9KfgJlCqOv9WHS7Kbju6v1/jukEBjo1+i+wtkh/Kex/UEabBRyO12OF5
         f16COVgCyBiqDI633ON3kMtTIJDVHTJI2DV+Tu4QWQan3VWbmXFe8JUme7H8V4rVIvEm
         XGSAt3s9yeMpD5DhbpP2Q3YahmG4If+288lFpkiwm0s2LuHBOpFj75vexaZm9GvZzgzd
         w3Og==
X-Gm-Message-State: AA+aEWaF5FyHGuYqpm8wusko5sTdr9ADwbDzMP1FhUQRvH9dZcYTbBSc
        2yb0/dtD7F2JjzM3JDX+t4c=
X-Google-Smtp-Source: AFSGD/XKAxEjR5LCa4GStDlHaWRBfeOhi2COxz9KGGWfGLTdLQ57B9/2cdbdsU9A60BmxsoeYNwJwA==
X-Received: by 2002:a1c:cbc7:: with SMTP id b190mr7899854wmg.13.1543827152787;
        Mon, 03 Dec 2018 00:52:32 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s202sm5985603wme.40.2018.12.03.00.52.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 00:52:32 -0800 (PST)
Date:   Mon, 3 Dec 2018 09:52:30 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        mingo@redhat.com, will.deacon@arm.com
Subject: Re: [PATCH] locktorture: Fix assignment of boolean variables
Message-ID: <20181203085230.GB2516@gmail.com>
References: <20181201083149.36972-1-wen.yang99@zte.com.cn>
 <20181201203700.GW4170@linux.ibm.com>
 <20181203083500.GH11614@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203083500.GH11614@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Sat, Dec 01, 2018 at 12:37:01PM -0800, Paul E. McKenney wrote:
> > On Sat, Dec 01, 2018 at 04:31:49PM +0800, Wen Yang wrote:
> > > Fix the following warnings reported by coccinelle:
> > > 
> > > kernel/locking/locktorture.c:703:6-10: WARNING: Assignment of bool to 0/1
> > > kernel/locking/locktorture.c:918:2-20: WARNING: Assignment of bool to 0/1
> > > kernel/locking/locktorture.c:949:3-20: WARNING: Assignment of bool to 0/1
> > > kernel/locking/locktorture.c:682:2-19: WARNING: Assignment of bool to 0/1
> > > kernel/locking/locktorture.c:688:2-19: WARNING: Assignment of bool to 0/1
> > > kernel/locking/locktorture.c:648:2-20: WARNING: Assignment of bool to 0/1
> > > kernel/locking/locktorture.c:654:2-20: WARNING: Assignment of bool to 0/1
> > > 
> > > This patch also makes the code more readable.
> > > 
> > > Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> > > CC: Davidlohr Bueso <dave@stgolabs.net>
> > > CC: "Paul E. McKenney" <paulmck@linux.ibm.com>
> > > CC: Josh Triplett <josh@joshtriplett.org>
> > > CC: linux-kernel@vger.kernel.org
> > 
> > Adding the current maintainers on CC.
> 
> So I strongly disagree with this. Anybody that has trouble with 0/1 vs
> false/true needs to stay the heck away from C.

Indeed, and it's actually *worse* to read, as 0/1 stands out more and is 
more compact than false/true...

The only reasonable case where bool is recommended is when functions are 
returning it, to make sure there's no mishap returning something else.

But for a plain .c variable? Nope.

> I would suggest we delete that stupid coccinelle scripts that generates
> these pointless warns.

Ack.

Thanks,

	Ingo
