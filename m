Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2B6C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF695240BE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CCrBj/5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF695240BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754180AbeGESoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:44:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34914 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754066AbeGESoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:44:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id h40-v6so1833594wrh.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 11:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5K3HX8P+DS78q1je3+GlAYV3fJdA1B0AAjgU1XeNNeY=;
        b=CCrBj/5HhGaEfSqiWobfoLTnJITYCTuLIGx8ZyswpoeVUIgXeE3u5p3qN8ueyN6M9j
         oSeCeTWT6z4OupJcLpWPnYmFViHLdLoTY4uJZT9tn1Al1auIGM4/cc7cV4S32JvhD4Nc
         9aB5UCbjkYunJmhZvuZOPkaA4CyIn9LlD4ZVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5K3HX8P+DS78q1je3+GlAYV3fJdA1B0AAjgU1XeNNeY=;
        b=H/fmU85l0A/bKHd7hf/VVOgBx5iteM8EqPdYc0igoO1hwOZ6ljAi3XHMADPUHz9M3w
         nswhVDdfH9LOzkHweqZuv/lapKW+NUjCgMQm2bqqZ04W67mXqjz+JlWgaI6w8xGboE5S
         MKDRwdW4lmNXKzEVQNtXusRVzfC2OjgFn7K/Zeop3h+m/88DhMoO+VTl0fogVZpnawpg
         rrWcW90Fq5HsUQmOx6lrndo+udzwGsTXAtKoqYg7JCnIZJLk973X0kDgzCrwhw82sBGS
         myN3T5fitAaJALwkzsJheMVQ0sjGWT3Qal2+0yxvw2ZFANWmROJ1fqusRus2J/GBwnNJ
         iY4w==
X-Gm-Message-State: APt69E3IaaswWyFLk4U1BueUc7q6lgMC+Oe9jPKMVSKvM1cH+0B/kDW9
        5nmbk7bkAHQzBkrauo7aPcKw/A==
X-Google-Smtp-Source: AAOMgpcvtrI72KCvFCpL4ss6qhqx3C14d4uxQlFfSd24h1Jyg0nYzdwFjkj0D1Nwv7XQxZvfXwr6sA==
X-Received: by 2002:adf:a6e2:: with SMTP id t89-v6mr5829209wrc.231.1530816256756;
        Thu, 05 Jul 2018 11:44:16 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id 24-v6sm17075124wrz.94.2018.07.05.11.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 11:44:16 -0700 (PDT)
Date:   Thu, 5 Jul 2018 20:44:10 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Daniel Lustig <dlustig@nvidia.com>
Cc:     paulmck@linux.vnet.ibm.com, Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180705184410.GA3417@andrea>
References: <20180704121103.GB26941@arm.com>
 <Pine.LNX.4.44L0.1807051010380.1697-100000@iolanthe.rowland.org>
 <20180705153140.GO3593@linux.vnet.ibm.com>
 <b41849a8-76cd-2375-dd80-c1bdeb9ea7d2@nvidia.com>
 <20180705162225.GH14470@arm.com>
 <20180705165602.GQ3593@linux.vnet.ibm.com>
 <eeaf2ad2-39a0-2ce9-b628-6775baad4e8a@nvidia.com>
 <20180705183836.GA3175@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705183836.GA3175@andrea>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 08:38:36PM +0200, Andrea Parri wrote:
> > No, I'm definitely not pushing for anything stronger.  I'm still just
> > wondering if the name "RCsc" is right for what you described.  For
> > example, Andrea just said this in a parallel email:
> > 
> > > "RCsc" as ordering everything except for W -> R, without the [extra]
> > > barriers
> 
> And I already regret it: the point is, different communities/people have
> different things in mind when they use terms such as "RCsc" or "ordering"
> and different communities seems to be represented in LKMM.
> 
> Really, I don't think that this is simply a matter of naming (personally,
> I'd be OK with "foo" or whather you suggested below! ;-)). My suggestion
> would be: "get in there!! ;-) please let's refrain from using terms such
> as these (_overly_ overloaded) "RCsc" and "order" when talking about MCM
> let's rather talk, say, about "ppo", "cumul-fence" ...

... or bare litmus tests!

  Andrea


> 
>   Andrea
> 
> 
> > 
> > If it's "RCsc with exceptions", doesn't it make sense to find a
> > different name, rather than simply overloading the term "RCsc" with
> > a subtly different meaning, and hoping nobody gets confused?
> > 
> > I suppose on x86 and ARM you'd happen to get "true RCsc" anyway, just
> > due to the way things are currently mapped: LOCKed RMWs and "true RCsc"
> > instructions, respectively.  But on Power and RISC-V, it would really
> > be more "RCsc with a W->R exception", right?
> > 
> > In fact, the more I think about it, this doesn't seem to be RCsc at all.
> > It seems closer to "RCpc plus extra PC ordering between critical
> > sections".  No?
> > 
> > The synchronization accesses themselves aren't sequentially consistent
> > with respect to each other under the Power or RISC-V mappings, unless
> > there's a hwsync in there somewhere that I missed?  Or a rule
> > preventing stw from forwarding to lwarx?  Or some other higher-order
> > effect preventing it from being observed anyway?
> > 
> > So that's all I'm suggesting here.  If you all buy that, maybe "RCpccs"
> > for "RCpc with processor consistent critical section ordering"?
> > I don't have a strong opinion on the name itself; I just want to find
> > a name that's less ambiguous or overloaded.
> > 
> > Dan
