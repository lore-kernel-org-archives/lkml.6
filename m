Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lZnpJ4tKGFvaDgAAmS7hNA
	; Wed, 06 Jun 2018 20:56:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 801A26089E; Wed,  6 Jun 2018 20:56:43 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bt3lmGMx"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0107C605BD;
	Wed,  6 Jun 2018 20:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0107C605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeFFU4k (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 16:56:40 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:44092 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbeFFU4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 16:56:38 -0400
Received: by mail-yw0-f195.google.com with SMTP id p14-v6so2327833ywm.11;
        Wed, 06 Jun 2018 13:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oEq8RfKwJYuD+6COTlowiE5qVzPl8iEYjnmxgan8HMs=;
        b=bt3lmGMx2YHf5xMnHKL7hZivSOnPbNPPFFO1DnI5xOtjZqFQPJv2ha3VnWwu1Scew9
         Nn2vGjpB7GVKOMqtk/TtVaWCp9tSwh+QJVGcJreo479iM/lYEuDf6+Cw+L2FYDruia/A
         LjcXiSpTq05dTABV/IBBDYVoVKuaCMmK3vLwenjkGAl1bDj2WtpOiaVPvL25mUDggr/s
         A6h9FEnmVT9gQXeBkI/5OG1rdyUj8zsWZqKNOc8hoXjkEmKvtW0XraAoJM4IX3jmIRkr
         piT0IPuYP9FccblRJKKe+/QJVhL58zKtVO1odXG8dlOU6LeoT2BDJOE7WqKEw7OyCKZE
         60RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oEq8RfKwJYuD+6COTlowiE5qVzPl8iEYjnmxgan8HMs=;
        b=OrR28pw6y6Lnm5+ubtbIUaMf3vT9JGP4/I0jgdY2DyNlkCLOLPsbpXnGi1rl6Ai0T+
         SRDBfRM010cAGeeybK2XNbAhlOPDnvAEivsfxUivk8SV8yIZE4K4fubBDurAWL49sEgq
         1EW1o6xABoRJ6YjrSKBMAArgG7oupa91/5SYL40XE9auJn02uJu0pCe2bmFz5ds+yyc6
         pzvmUkD1Yy3i2uTVkRDEH0D3yY3AbrQEY6zQ0KfssbdG0Ms4iLR4zePeQd5CvI4imMEw
         SKaETpHRJ8JknTi1Wa6vMFR1yF7XLcjvhhmqopVbErbboAhohNCwN0t8xr2a4BJHwrK/
         sikw==
X-Gm-Message-State: APt69E0OmxTHxMBRv+bjfE2R/hoDXJ5RXghpQgX0c2yOXDq2Ueffi//Z
        2a9sORo3Uiq3POoJ456amN8=
X-Google-Smtp-Source: ADUXVKJTN28TqIHc8oGfgoLEabx5SJbHqjMhlFJ9bV9eEiS9wybEHlOqoiJLGcxwBJxZ7RyuawgiFg==
X-Received: by 2002:a0d:d757:: with SMTP id z84-v6mr2140065ywd.284.1528318597867;
        Wed, 06 Jun 2018 13:56:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::d0a1])
        by smtp.gmail.com with ESMTPSA id x125-v6sm22877720ywf.106.2018.06.06.13.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 13:56:36 -0700 (PDT)
Date: Wed, 6 Jun 2018 13:56:35 -0700
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>, Zefan Li <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] cpuset: Enforce that a child's cpus must be a subset of
 the parent
Message-ID: <20180606205635.GP1351649@devbig577.frc2.facebook.com>
References: <1527687991-1431-1-git-send-email-longman@redhat.com>
 <5B0F4F09.9050100@huawei.com>
 <5B0FAE72.1090204@huawei.com>
 <20180531082613.GF12180@hirez.programming.kicks-ass.net>
 <5B0FB58C.9030705@huawei.com>
 <4dc718bc-4bd5-4998-853b-9c6ba67b89a0@redhat.com>
 <20180531155807.GU1351649@devbig577.frc2.facebook.com>
 <20180531161645.GN12180@hirez.programming.kicks-ass.net>
 <20180531161942.GW1351649@devbig577.frc2.facebook.com>
 <20180531163826.GO12180@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531163826.GO12180@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Peter.

Sorry about late reply.

On Thu, May 31, 2018 at 06:38:26PM +0200, Peter Zijlstra wrote:
> > Yeah, for cpuset, it's messier, but it isn't different from hotunplug
> > scenario, right?  I think the best we can do there is putting ancestor
> > operation on an equal footing as hotplug ops.
> 
> Right, but hotplug is exceedingly rare, while I get the impression you
> think it is perfectly fine to recind on your resource grants.

Well, yeah, for a trivial example, imagine dynamic workload management
where you wanna restrict what a side-loaded batch workload can do on
and off peak hours.  All other controllers can do that.  It'd be a
really odd design trade-off if we make that really clumsy for cpuset
especially given that we wouldn't be gaining any actual
functionalities.

Thanks.

-- 
tejun
