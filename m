Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D7EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB91821906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1PoHdwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390533AbeLUNAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 08:00:10 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43304 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387690AbeLUNAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 08:00:10 -0500
Received: by mail-oi1-f196.google.com with SMTP id u18so4668484oie.10;
        Fri, 21 Dec 2018 05:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhOUNi2BURW/oJMQHdq3jAOE7mhlMlhIopCWrHWu/To=;
        b=P1PoHdwdyCmQehx9TT5KvPSLu8eO5vtfhalYYS9QK4LQnQ07fL8wzwzJw38w/sKkqD
         vK4RanL2zY4z7DqNflIhdBzy6Gv//b8+AjLi6aoti3H6CXaY4P+gYl496+Rjd06ntvNM
         +XBV/Sh4lIgaZ3tZeEt8x4/d59i4kmL9x+y26UK3Y6yFr/AtLKmYP+OXJB9Xf9CQOEg1
         qfmnwcQA3wlL6i8q9Kjc2MUgncFdI9hicXh4SyO3kXZeBu++is65EbZuNcj6G30i2wki
         DRSaU2nTIKqvzU1sReYZKpTSzJQRC6XE+Q8H1SGVc1W2Ba+T4Vusr0hqOGA7BrVVCtRH
         MkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhOUNi2BURW/oJMQHdq3jAOE7mhlMlhIopCWrHWu/To=;
        b=NK4WNwx0IMr+by/nfjhKJwm0cDFWefqWgr9IEzQdXmk6mUXvRppBIsFBuHqvXmbqn1
         +VP6XpjQ8yLB17yzFTRXjHMy38QTey+wqABK0ggOx1UpO4vuYHN99JKI2pbKhTZMW7bW
         hSz952Cil8NkoXnJd4PnHo9FeziczFnyRU/XcFF90BfJWeGa9g6TXKhkYz8luZg6EavL
         Gcyi07oBV/JukXADZdkcgPlh9et0BlVNCVMEA2+hlYY0qZVN9MteFvgxVaivRI8UsF69
         sHFmyU4dOjdlyObVfPKfdw8Y5oC3e03mahl7h/1DLk+W0VI60p7nPsW1/0WFcgkQ30Uo
         WeTA==
X-Gm-Message-State: AA+aEWalG4EVehJMN0Q+PuvrNRfPa2DDCoDvlpHNr2zsyzJNboR05GSP
        xYV1o8qJSzjsgGhM7BVtdGPpgUsWDXs31ajvHaU=
X-Google-Smtp-Source: AFSGD/WrG5r/fTlhKZN363XjNKzAciBuPFsoWJa3UaEzHS642/Aq6rB/4feBNmydpywof79+ZPbhpIs5A50KNCTzwNM=
X-Received: by 2002:aca:3c06:: with SMTP id j6mr1294703oia.126.1545397208995;
 Fri, 21 Dec 2018 05:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20181220085922.332225035@linuxfoundation.org> <20181220085923.488666294@linuxfoundation.org>
 <CADVatmPEbBoEeVvAOMkcrsge19ceAkDT5fzEZbMAdTnD5wg6eA@mail.gmail.com>
 <20181220154030.GA9962@kroah.com> <20181220184941.ykfjubbo3nj2mnpm@debian> <20181220230509.2lwlz2w46iqac2px@linutronix.de>
In-Reply-To: <20181220230509.2lwlz2w46iqac2px@linutronix.de>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Fri, 21 Dec 2018 12:59:32 +0000
Message-ID: <CADVatmPOFLH2fe8VON1ohra+QOzaAZE+tT-uiKZhfceFwobjTQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 29/72] locking/qspinlock, x86: Provide liveness guarantee
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        andrea.parri@amarulasolutions.com, longman@redhat.com,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 11:05 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2018-12-20 18:49:41 [+0000], Sudip Mukherjee wrote:
> > On Thu, Dec 20, 2018 at 04:40:30PM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Dec 20, 2018 at 12:14:00PM +0000, Sudip Mukherjee wrote:
> > > > Hi Greg,
> > > >
> > > > On Thu, Dec 20, 2018 at 9:28 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > > > >
> > > > > ------------------
> > > > >
> > > > > commit 7aa54be2976550f17c11a1c3e3630002dea39303 upstream.
> > > >
> > > > Another upstream commit fixes this.
> > > > b987ffc18fb3 ("x86/qspinlock: Fix compile error")
> > >
> > > Maybe, but that commit doesn't apply to any of these stable trees :(
> > >
> > > Care to provide a backport?
> >
> > Attached now.
>
> Are you sure that it fails to compile without that patch? I have here
> Debian's gcc version 8.2.0 which probably isn't affected and I can
> compile kernel/locking/ in v4.19 + 4.14.
>
> I'm asking because in my backport the GEN_BINARY_RMWcc macro is used
> like in all the other functions which use it - unlike like in the
> original commit where the macro is used directly in the if condition. So
> it  might not be affected by the problem.

ofcourse.. and I overlooked that part. Sorry.
The original problem was using the "goto" inside if() and with your
backported patch the problem should not exist.

Greg, please do not add it to your queue.

-- 
Regards
Sudip
