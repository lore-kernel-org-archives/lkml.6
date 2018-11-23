Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83B4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD51206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6OWQge9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD51206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502386AbeKWSVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:21:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37606 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731610AbeKWSVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:21:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id j10so11321642wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 23:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6qKMan9DxzWuKJunm8AKX6QwDO3EfjfugZ3rIsPprOk=;
        b=P6OWQge9KXnNshFObceCugz3GPKZYZn6P7gRlBJpIpV94SL/0FduDejvBU3NaSyJsg
         LNkhI2iZM5G+5DeAAeOVD5Y3g0Thg6D9Cgg7bbO1BZ85M2OMoXPeeNAvdnVjbRIwZEoP
         VmZbBl9nVZ6ropGVzh15mCfR9wfB+FGN3SoMyidjKPHpDwI7v7dckJjWJ+sQxQHWGaRO
         25YTQQtMfPNQjp/CSnqSvpPX1SavfqzpzxBapJ48mp4O+vPAKnJa08NNUW9EiMNGxGx8
         6Lk2ZYl4ayI7UGaQm8V/h62Kb2b8A/xkxp+Kt593TMw+z6xUrumEfHqCSxZq9MrX60mJ
         349w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6qKMan9DxzWuKJunm8AKX6QwDO3EfjfugZ3rIsPprOk=;
        b=lgxLFMChRATqDOrN9u04wV5hG5Mb7HrSRwkV9lu4hlhrbsKJuiOa7ZE+JoSXHTrBtk
         vZXY9t4uS4N5HElMV8Qj7VMUabXhEubFQeC5P+bSmrbReMMhfO3Jmk918kHuCMP57G67
         g9uZzZkcIrCeJRr7y0WEcab5M6N/6Uma0ftXVTHVmTwuU+QdW4I4jTjdYNSvtjRdL65K
         8c6M3AR83tPHDJIxUmtBUravjKLcp5ZM/aGGQngCo/y2JtO+XirRnJVcj/dgDslhodq/
         G9l0LqLe2/jCLlYLhM83IBVGoQb5l6UULFrNCQkVAEc6eX5ihgz59ChCoV1mcWU/dkiV
         vXbg==
X-Gm-Message-State: AA+aEWYcJS3o/byXcbueSzJijQT9sn3+xxtL+bGTZyhOAsTvRXcGCKYZ
        qf/II95DaGIhHTgRyL7XueI=
X-Google-Smtp-Source: AFSGD/V+C7u/dmQl/Eco9fd4n6bRDpSygx+E5BDYXWr9qSwT3jD+ubwDdBIqH4Mg0PDL96MY/Gtafw==
X-Received: by 2002:adf:be8d:: with SMTP id i13mr13029381wrh.235.1542958682895;
        Thu, 22 Nov 2018 23:38:02 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g188sm6609478wmf.32.2018.11.22.23.38.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 23:38:02 -0800 (PST)
Date:   Fri, 23 Nov 2018 08:37:59 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 20/24] x86/speculation: Split out TIF update
Message-ID: <20181123073759.GB12959@gmail.com>
References: <20181121201430.559770965@linutronix.de>
 <20181121201724.227260385@linutronix.de>
 <20181122074322.GE41788@gmail.com>
 <alpine.DEB.2.21.1811230000590.1665@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811230000590.1665@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 22 Nov 2018, Ingo Molnar wrote:
> > * Thomas Gleixner <tglx@linutronix.de> wrote:
> > 
> > Had to read this twice, because the comment and the code are both correct 
> > but deal with the inverse case. This might have helped:
> > 
> > 	/*
> > 	 * Immediately update the speculation MSRs on the current task,
> > 	 * but for non-current tasks delay setting the CPU mitigation 
> > 	 * until it is scheduled next.
> > 	 */
> > 	if (tsk == current && update)
> > 		speculation_ctrl_update_current();
> > 
> > But can the target task ever be non-current here? I don't think so: the 
> > two callers are prctl and seccomp, and both are passing in the current 
> > task pointer.
> 
> See te other mail. Yes, seccomp passes non current task pointers. Will
> update the comment.

Ignore my previous mail :-)

Thanks,

	Ingo
