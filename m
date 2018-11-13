Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4634FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1442086B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kdeake6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1442086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388071AbeKNBsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:48:45 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39092 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731721AbeKNBso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:48:44 -0500
Received: by mail-qk1-f195.google.com with SMTP id q70so2667607qkh.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 07:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B4FDl8gF++ePL+rZRXgmtdo+s7tKVT/ZbykWmpI+HlQ=;
        b=Kdeake6Vtg4qV4zyz3IFquVZ3+cD7tK+5WYcsw7kbMYW5y2OsgK57uHHSZKeiu/RsZ
         AH1kQZrSBg3otdUt8IF1TRYzgXKoTXSUUdWoLP8XzpQw625o8AUMu2sUBWpjVhqFw/l9
         DNM2xpwXDwtMv1tBejB2VLQjCFUMIYehAcEdi4LRkpUWRJXugkZ1dXp7okVguizqmRRl
         vtSfloed6Xrp5Oh3SG4LZwOs24W1GkERFqsDV8eGRMSog6zeq0fEFsvkzaeodeEzU2Zm
         8Q5ZYEB0CZVpfLJgpqNkXZaIpOXuq4F1tA07aRSth11s9iSflMIkXt1MScPLXHeMZc49
         wS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=B4FDl8gF++ePL+rZRXgmtdo+s7tKVT/ZbykWmpI+HlQ=;
        b=f2Mz6XqcGNKG+WnkrXHwEfVV22xhv3dhCAft/m3X4VP/xVkIsNCCfX+Hy6Ogp3BnvD
         XwfU1lly/kUHVT5Xl/cFskXl/EAK1Jv1X3FfmAG5Vvg9Sim38aj7Ry2P9gyqM+2x7j2J
         BIli3i7bwOBP3/iuJ2O45yTaWs4aE8oclgFT6EchOShlDOnY/tCgVERw+YkBicpMVy8O
         3QT1oWssekBLyJFKlBst7CRnjqrGmYqO0ph7nxjeyKqshD4j5O17x0WjO+dF4gAJTSPT
         58Bkxtk7un3bt6aeIIEPV/XhftBzdYvjg8YtumTvXF20XiucyAdBIBpTH69IlfiKlLYa
         Cw0Q==
X-Gm-Message-State: AGRZ1gJyIA4pkIWIKCA56FiLTMNggA9nSCQDb9ntsHGLuuEpppC0IqA7
        +dkgt9QVx5DXqEkUYDYy6yQ=
X-Google-Smtp-Source: AJdET5fTQCA2HhohI+3XlTw0Di/gDHyBU9c4mttLex3Fi0rDpePq8kSrT3fBJC4ip/kBVULgyOoMXQ==
X-Received: by 2002:a0c:87dd:: with SMTP id 29mr5868200qvk.212.1542124204959;
        Tue, 13 Nov 2018 07:50:04 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:e2a7])
        by smtp.gmail.com with ESMTPSA id c77sm13931632qkh.82.2018.11.13.07.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 07:50:03 -0800 (PST)
Date:   Tue, 13 Nov 2018 07:50:01 -0800
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Jens Axboe <axboe@kernel.dk>, Dennis Zhou <dennis@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: Re: [PATCH tip/core/rcu 36/41] cgroups: Replace synchronize_sched()
 with synchronize_rcu()
Message-ID: <20181113155001.GJ2509588@devbig004.ftw2.facebook.com>
References: <20181111194104.GA4787@linux.ibm.com>
 <20181111194410.6368-36-paulmck@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111194410.6368-36-paulmck@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 11:44:05AM -0800, Paul E. McKenney wrote:
> Now that synchronize_rcu() waits for preempt-disable regions of code
> as well as RCU read-side critical sections, synchronize_sched() can be
> replaced by synchronize_rcu().  This commit therefore makes this change,
> even though it is but a comment.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
