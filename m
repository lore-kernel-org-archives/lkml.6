Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD5EC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2879213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYnfOa1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2879213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJINqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:46:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41223 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeJINqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:46:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id x12-v6so431787wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 23:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xFHdCqYQbtTlvChbzju08shdLm2VKeOzlRsNjY1A7c0=;
        b=nYnfOa1ZTpfwsWPvyrDsTxVRdfmih1EEYB53uX2U1B/L18457/7QzsItMITwGTT790
         tkBgJFTj4bVNe9Wie+ZgUPULfbUYwuhIsy25KuG3vBxm0/ANbVLUcrpR5jMKmy+MAiiU
         3KL7acLqMC13RfFLTehLLZoLxiQCAOglIOtUB1ChRoLWUprd6UFKEfK/MIkT3LKPbpcL
         zjf4TKx+hAHCSurqxLhr4cp/Mni78Ovi92OuDmOr6XPqbIfT4VA/iaACt/2TlZO61Oo7
         pcneUEBFcrD6fnD3zrf40vS6AkRZKiCi2lejwdWTsB0ZbnpbUhnDfP+S0O5Yrgv+4oDG
         ua5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xFHdCqYQbtTlvChbzju08shdLm2VKeOzlRsNjY1A7c0=;
        b=baZwXrq2vS2rkOaXoTXXy4bel3XKmpRAuQ9D/1HZVarUwQ02gA+9XmRQNSYV/umzaW
         l7Hr7PYOHiQpibvUiuQBmz0qOf24FC+l/x6JSkDC1oxBteA+68qkbbCJAZXkpLlCrB2Y
         hhVLLig2/wzXROmlVTkwA1VK4hvUmRKyA6vyn+ZphxIcbaAVUiKOz53fIkByo7x+HhXe
         tmSN1RyxTwBBv7mYnBLCf20qvr9HS67yx5eeC6aIDgwgsSXl8IeH4rA9O2kI3ranM2wf
         skpvsw2N1bMhR22JgCHOw31yb1YB0Pitc6t+Qe6vN4UOOaIDZawVw6Ly5lC5wAiCylzM
         Pbcg==
X-Gm-Message-State: ABuFfoiHH8Mvfnz0RfF49g/q+McqI+BHWj6U7RPRjvieaptIPNrhjTN0
        S6pcn+XA1nNGTcF+4E5F3mU=
X-Google-Smtp-Source: ACcGV62rSWytnArzQcj0p9jRhN6jQjGn90P6VNvamh7r/v2s5DfgdXXdJs7SdQXH5NiP3pb5yeeovw==
X-Received: by 2002:adf:bf11:: with SMTP id p17-v6mr18153380wrh.235.1539066686258;
        Mon, 08 Oct 2018 23:31:26 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w2-v6sm1516228wre.57.2018.10.08.23.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 23:31:25 -0700 (PDT)
Date:   Tue, 9 Oct 2018 08:31:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm,numa: Remove remaining traces of rate-limiting.
Message-ID: <20181009063123.GA66632@gmail.com>
References: <1538824999-31230-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20181008170149.GB5819@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008170149.GB5819@techsingularity.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mel Gorman <mgorman@techsingularity.net> wrote:

> On Sat, Oct 06, 2018 at 04:53:19PM +0530, Srikar Dronamraju wrote:
> > With Commit efaffc5e40ae ("mm, sched/numa: Remove rate-limiting of automatic
> > NUMA balancing migration"), we no more require migrate lock and its
> > initialization. Its redundant. Hence remove it.
> > 
> > Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> 
> Hi Ingo, 
> 
> Can this be sent with the rest of the patches that got merged for 4.19-rc7
> so they are more or less together? It's functionally harmless to delay
> until the 4.20 merge window but it's a bit untidy. The mistake was mine
> switching between a backport and mainline versions of the original patch.
> 
> Thanks

Ok, agreed and done - I queued it up in sched/urgent.

Thanks,

	Ingo
