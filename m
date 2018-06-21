Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5131FC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6DC20846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGtymijq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6DC20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933164AbeFULAH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:00:07 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:39990 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932855AbeFULAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:00:06 -0400
Received: by mail-wm0-f45.google.com with SMTP id n5-v6so5151292wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 04:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vAqT2vreZfFDHsID1yRkzNBLpGjON/30LCnDn/luwMY=;
        b=NGtymijqDoz9eIkz4YjUZaNYmk0J4cqcBbe2HUsQYkP7EKXt4o4gDnIpOUFNEYYMOH
         oLKRcvQ2rPB2wcY0pskne5xQ3Lyu3B/oXurRX1iw++mQEpbPG896lPDbbf0RZjRVUWCf
         8j66gFezjIP/PtVR4OewbKvU3fcX51cmyXNJvvBcPRoOu15AuzX6rX7xDfMEPsWJuJmS
         HfiZnvJBk7+yM9yBB15Qk5kaQqWGLAORs4LAAjXo2HkLMPzd3Y9gi6OsSv10p/YEmkxf
         6iEUq79lL+0iBQI1ooWyxjFZVRBmFMEecH7+Oxt7MGXD1TGJvSS7wZSAwT8gZRhNd7Os
         L+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vAqT2vreZfFDHsID1yRkzNBLpGjON/30LCnDn/luwMY=;
        b=lBHWTK+jussKUL3YwVvwLrTNqIhNmRpXrdxc5IAL2xLphOf6NXvwHGUcsAzGQv+sYy
         55o+Ll2oxZAi7v5goMoFbSU9WtOVKnLpYDdjrhgGYX+M/YpdZwHvsaN83s1rhb1WTU6N
         WOGgU5BuTtAWZ4JdPLYX/OI0EheW3JoiCiF3P07CGZxBOrJYNATbZAWrLMmBPZpG/QU6
         aY3Vz/Q6SUwL/JI6UwrRjqFCPuyMefwtSsDHZUcKRHTv3qtzgAzITYoH9yUUHL8ULJVA
         e2oGUC/oJTinHPTF9YqFvPIJnvEfhIdiGiXDEuq4ObO8BQuM8d1t1/VaxzvlHk4svahD
         Y6GQ==
X-Gm-Message-State: APt69E02F87eO1OJK2r4pRbf532TPjYQNrLhq7y48jrxeXMR0k391dC8
        2EBcw64zXURQRzk5KNuBvrg=
X-Google-Smtp-Source: ADUXVKJO4fB9iRNVEy7eiRt6ZM76k2tzRq6dNAY4YuOQe5kelkhNILh54B1KOMKw6GSU88QQaQSa6w==
X-Received: by 2002:a1c:a010:: with SMTP id j16-v6mr4537931wme.61.1529578804994;
        Thu, 21 Jun 2018 04:00:04 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s132-v6sm5543864wmf.5.2018.06.21.04.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 04:00:04 -0700 (PDT)
Date:   Thu, 21 Jun 2018 13:00:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Subject: Re: [PATCHv3 09/18] atomics/alpha: define atomic64_fetch_add_unless()
Message-ID: <20180621110002.GA1057@gmail.com>
References: <20180618101919.51973-1-mark.rutland@arm.com>
 <20180618101919.51973-10-mark.rutland@arm.com>
 <20180618155439.GD11612@arm.com>
 <20180618160829.5jrscmfkorjxdvod@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618160829.5jrscmfkorjxdvod@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Rutland <mark.rutland@arm.com> wrote:

> On Mon, Jun 18, 2018 at 04:54:40PM +0100, Will Deacon wrote:
> > On Mon, Jun 18, 2018 at 11:19:10AM +0100, Mark Rutland wrote:
> > >  /**
> > > - * atomic64_add_unless - add unless the number is a given value
> > > + * atomic64_fetch_add_unless - add unless the number is a given value
> > >   * @v: pointer of type atomic64_t
> > >   * @a: the amount to add to v...
> > >   * @u: ...unless v is equal to u.
> > >   *
> > >   * Atomically adds @a to @v, so long as it was not @u.
> > > - * Returns true iff @v was not @u.
> > > + * Returns the old value of @v.
> > >   */
> > > -static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
> > > +static __inline__ int atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
> > 
> 
> Whoops; yes.
> 
> From a scan of the series, I messed that up in the instrumentation, too,
> but the rest sems fine.
> 
> I'll fix those up and push out an updated branch.

Please send out an updated series via email as well once it has all settled down.

Thanks!

	Ingo
