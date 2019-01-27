Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080A7C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 11:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB00214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 11:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548588553;
	bh=bn6H0v7k9AXYWOQng7XMn/oVRcFutBN0m0Kx1k8mmSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=atEN5KvoiP5jPg7cjCYhL1Ew49BujZTKdDXUezUTUFp9bfBMQkdIMVakJkXUGG2M1
	 2MkHYrHVJEaAVkrEAjXacmCzbxXilNSvFxvJ0dcM1cr8Iy+yj9eObxsWWhPBSRsl0n
	 68Sj943N+YwlcFLKODeQjyU5fdH4dQum9e6MSCZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfA0L22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 06:28:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38450 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfA0L21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 06:28:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so14787996wrw.5;
        Sun, 27 Jan 2019 03:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QByIMK8RGoexfaTjKblFOtlddWPFTVGItmNwoWL3lUc=;
        b=iH/2zo6g0YMo5Lf4y6r93YjuirKzWoAxS9Dw++aLPy1ytcwzvoWX4kokiPM/rHs8uV
         uKiA2bK+ZQc8T5Wb9rbRrSMN2M/59EpHenkVa41oV3iz54xj4NK4XefhnwolADP2ySO+
         PrNKwBPaKkPC61NuaE8qPMO8M7xFz+uBCDMFcIIzmBeIpDma1f9j9JL4ILTnxeQhwJ4l
         1t/pQluAdMIhcdpjCLwJbcjzvCf4JvcMW//azD462UQAE8h9IdTX9G3x2OClqQVxpRug
         JL4PSsybePia0UGq7XuRcvrF4GuzZP+0OUdHBqkkKhQ95FsGyQj9iGtkPWNCX9X+X9so
         OYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QByIMK8RGoexfaTjKblFOtlddWPFTVGItmNwoWL3lUc=;
        b=mo3qd7S5pwcJetYXLRi2k8ai/HaAhMypUS6gxdcYZddLGN1gZSn++zlwhIVNcVG/kj
         QIYDvQaeh9mnaKqlNmsLj/ceX+miWW9wY3ar1gadbrZ1AXCT6/lcJr9f09W7AuOcMC5P
         RiLfWbV85SQqHtHHalJazPrcjF4hEMGz1A4rScRf1DKUkBNkJ+37FtSy+oD2mi9owYqN
         1POir+0g7YrvdlckAHpsOuA7/VMBtLbho5wmxlTKHhAcGjg16FQP982I3Agp1Tb9acn9
         MK4JQcGJhhdu9rpbyRgZ7iahm/w+ToZbaa74WdCOJdPD387LlsXyOaQohcvNEiM/jG+8
         +OIA==
X-Gm-Message-State: AJcUukc5Q88obs7KRLAPuMqhamp+0PKYjJi2DJno92zK985h3IneaoE2
        kCDSWlWp8LRXp3bFzT6VtY4=
X-Google-Smtp-Source: ALg8bN5vzRCdz/BYpZrl+mQMJnauGVa5ds+vbW9zasPd9WOSJF9l4Tx5O1KSTJ6b+lp8B8y73AX7Vw==
X-Received: by 2002:adf:c108:: with SMTP id r8mr18686955wre.233.1548588505560;
        Sun, 27 Jan 2019 03:28:25 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t199sm57873480wmt.1.2019.01.27.03.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 03:28:24 -0800 (PST)
Date:   Sun, 27 Jan 2019 12:28:22 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kjlu@umn.edu, hpa@zytor.com, stable@vger.kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/core: Fix a potential double-fetch bug in
 sched_copy_attr()
Message-ID: <20190127112822.GA34170@gmail.com>
References: <20190109074524.10176-1-kjlu@umn.edu>
 <tip-120e4e76857ddbc9268e1aa3f9de61a498e84618@git.kernel.org>
 <alpine.DEB.2.21.1901271201170.1622@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901271201170.1622@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, 21 Jan 2019, tip-bot for Kangjie Lu wrote:
> > Commit-ID:  120e4e76857ddbc9268e1aa3f9de61a498e84618
> > Gitweb:     https://git.kernel.org/tip/120e4e76857ddbc9268e1aa3f9de61a498e84618
> > Author:     Kangjie Lu <kjlu@umn.edu>
> > AuthorDate: Wed, 9 Jan 2019 01:45:24 -0600
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Mon, 21 Jan 2019 11:26:17 +0100
> > 
> > sched/core: Fix a potential double-fetch bug in sched_copy_attr()
> > 
> > "uattr->size" is copied in from user space and checked. However, it is
> > copied in again after the security check. A malicious user may race to
> > change it. The fix sets uattr->size to be the checked size.
> > 
> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: pakki001@umn.edu
> > Cc: <stable@vger.kernel.org>
> > Link: https://lkml.kernel.org/r/20190109074524.10176-1-kjlu@umn.edu
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > ---
> >  kernel/sched/core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index a674c7db2f29..d4d3514c4fe9 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4499,6 +4499,9 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
> >  	if (ret)
> >  		return -EFAULT;
> >  
> > +	/* In case attr->size was changed by user-space: */
> > +	attr->size = size;
> > +
> 
> Just when pondering to send that to Linus, I tried to write up a concise
> summary for this which made me look at the patch.
> 
> If the size changed, then its clear that user space fiddled with the date
> between the size fetch and the full copy from user. So why restoring the
> size instead of doing the obvious:
> 
>    	 if (attr->size != size)
> 	 	return -ECRAP;
> 
> Hmm?

Yeah, indeed - and that's a much more reliable interface behavior in any 
case. It's probably also faster.

Thanks,

	Ingo
