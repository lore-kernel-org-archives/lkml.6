Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00411C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D14208EC
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEQBqyGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D14208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934413AbeGJP5D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:57:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37257 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933872AbeGJP5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:57:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id q10-v6so15170783wrd.4;
        Tue, 10 Jul 2018 08:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BiCJVhSSHfA5nmHezhvuPqrlUUNffgNWGFWGLBeH0lg=;
        b=rEQBqyGawWP7Zv5pBQq//x68H7XLik+K9rFibcMoY+SQaLEgXFyA6HqLH08Gj+ilwp
         6QB0ADqljUuMmxcY37QVz3ShH/9wVNtBPBuQYAw1eI/K2ltpdFQLmf6SkYYgZE0aAXdO
         A2DInh9AotsN0lWEGY8PhvI6JLCSfsosAa5tqPAxLxZ4rHi9zYywSjUF85vRDvYsjik3
         IlbLqjOD5RFarUKA92Jq3VzShgRThbwmt2TaEBwno0BvrlERwzQMfvVPWYZLDflt0WK2
         UpMrFiV2mTKPlzQvjrQQ9gXStsqI8yC/m1lyx4Y1vncSzhxkFxIsAiJuEglpTdCmol4Q
         s6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BiCJVhSSHfA5nmHezhvuPqrlUUNffgNWGFWGLBeH0lg=;
        b=d79wLBcFpENPi4tqX8N7dBFXe8arb+2mgCTmBgCHa7KU9BCklFQB8wNfLZDITr7G3e
         HUMsO2VmYpVFETIMzIH14NXZebBocPjj/3DBn5y5KOVRgtyEWDWDXriOMrJ2KmSIplQn
         SyJ8OLkEjeo71QLjaMfx0j+3YPIQRExRuG6ZnJ1tISQAApEzwbeELwKYOfjUrYRPSFYt
         hAGb5OmUO9xDkdF6RdL/HF/YTepk1mYHqh1uDJfrsS66eUYZc7CjwQsywzQM3xIzHZ+r
         znRJGkZ1e2hE+kxrWps1U9luazCK0sAqQ6PtYJzujIQUjvA0aP2HGltFG2S+WJqts2JV
         OgGw==
X-Gm-Message-State: AOUpUlGS1tLQlm19qswpU2YV2tPfXrSk2YFaoaEofzxE91bt/WaHi4XY
        YHaKqC3tJ25Xns6kBh7qS4A=
X-Google-Smtp-Source: AAOMgpenRTYOeVRRtn+oK8ozeeMJoGK4C+ZLD8vh4pcWhqOzmT0if5X/ipURo3zHD6rt0hDO4TtgWQ==
X-Received: by 2002:adf:9e84:: with SMTP id a4-v6mr5585212wrf.70.1531238220447;
        Tue, 10 Jul 2018 08:57:00 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 73-v6sm4739555wmu.37.2018.07.10.08.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 08:56:59 -0700 (PDT)
Date:   Tue, 10 Jul 2018 17:56:57 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-next <linux-next@vger.kernel.org>,
        stephen Rothwell <sfr@canb.auug.org.au>,
        mpe <mpe@ellerman.id.au>, sachinp <sachinp@linux.vnet.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] watchdog/softlockup: Fix SOFTLOCKUP_DETECTOR=n build
Message-ID: <20180710155657.GA13019@gmail.com>
References: <1531129883.6480.7.camel@abdul.in.ibm.com>
 <20180709114716.GN2476@hirez.programming.kicks-ass.net>
 <1531159814.6480.11.camel@abdul.in.ibm.com>
 <20180710114210.GI2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710114210.GI2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jul 09, 2018 at 11:40:14PM +0530, Abdul Haleem wrote:
> 
> > Thanks Peter for the patch, build and boot is fine.
> > 
> > Reported-and-tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> 
> Excellent, Ingo can you stick this in?

Sure, done!

Thanks,

	Ingo
