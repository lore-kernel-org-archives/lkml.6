Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC465C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FE02148C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBZfa0wp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FE02148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeJQH3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:29:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39876 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJQH3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:29:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id e67-v6so2757082plb.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CtEotWFeutC+Xtyw9ElzbIiw7CxA+mEwYLk2XisPzoY=;
        b=FBZfa0wpaBNnrvJbFgA96VwNrl+jwXFdy3xEYOhkXB33fQELiRef3FMkZg7uhWfjpo
         xooUs2L5T+NNLcq67V2eTZ4mziLI3USkLRddDLNrZ6pEDhLtvwYpNFOLO6p5ePStmKrZ
         zbmG9z+fzXX2sc9b5xpDdR0jU20DnFJmGuWA8wAtvPwAZBnF2Uxal3TFIGGC2VrJ+6jv
         kFe47hNPu8nCntVgNQrNdr+NpvY9R1xshfDdO5wG06pTdYCTCh/aPFJIx+glxx6lLFPm
         tFzrhcrQb5IlsGAISbaoB2hcizdABxPOIahTNdyqPzxQc50UUtf7i9Sce9uzwqBsb0Gg
         kQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CtEotWFeutC+Xtyw9ElzbIiw7CxA+mEwYLk2XisPzoY=;
        b=KIWzjy/2WrMN2lcCOg22MoWDCeUWOl1psCG2l9wXVnBc7IZs4CCpO6sJ+O/DeSvcuz
         DiR8lJJZqCle01OaO2qPL4c9qFpg73HIfTkyb5Va6f2gTk7drkMfheYYhlDIpwnm4UPU
         mgLu8cW5VnQ5NnvFcUvlhXMFarIn4+yB+/4bgLN1AqPAiIA6Mku3TjwdFi5iyX9r2+eO
         m1BiC+WzsC7Xb236N8mdgaXZ0IaQdkaWy4kOocRL1JHzysdHc9s4NiloKeBWnSaUPj1f
         ZKy0MF8n1pREDx6yX/iokM3dm64fZPBclAm7cmOTj8Rr2aIT41YWh6r0us5M/WDxreP1
         DMVw==
X-Gm-Message-State: ABuFfogkI20ZMkhasUh4/gJZ4wqT7dAnjkfuxBAZ+5W2EPlUVnNUvytr
        Oj47VYYQx2fvrQ/5gmulFeQ=
X-Google-Smtp-Source: ACcGV60yZlVC+BaYeso5mx1p72gzSRQoWNFMwG9aZZ+pIjlVttXAb/unZCBP7kQYGVnBxoqFbXIdEg==
X-Received: by 2002:a17:902:bcc3:: with SMTP id o3-v6mr23704916pls.66.1539733027368;
        Tue, 16 Oct 2018 16:37:07 -0700 (PDT)
Received: from localhost (c-24-4-232-171.hsd1.ca.comcast.net. [24.4.232.171])
        by smtp.gmail.com with ESMTPSA id o2-v6sm15525832pgp.82.2018.10.16.16.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 16:37:06 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:37:04 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [RFC PATCH 00/30] softirq: Make softirqs soft-interruptible (+
 per vector disablement)
Message-ID: <20181016233704.7foq5jxvi5mn57jd@localhost>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
 <20181016160359.5523ae90@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016160359.5523ae90@lwn.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 04:03:59PM -0600, Jonathan Corbet wrote:
> I have to ask a dumb question, though.  Might it not be better to add a
> new set of functions like:
> 
> 	local_softirq_disable(mask);
> 	spin_lock_softirq(lock, mask);
> 
> Then just define the existing functions to call the new ones with
> SOFTIRQ_ALL_MASK?  It would achieve something like the same result with
> far less churn and conflict potential; then individual call sites could be
> changed at leisure?

I was thinking the exact same thing...

Thanks,
Richard
