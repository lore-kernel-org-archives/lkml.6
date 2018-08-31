Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770D5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9E82083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ML0DipMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9E82083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeIACdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:33:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34961 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeIACdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:33:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id 7-v6so1090785pgf.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 15:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=muhsxbhe1qDbUQ4jcUrsoThKcresfAmhuSXs9ng5ZKI=;
        b=ML0DipMyHn9/d4Pwq+z2C7gSrjYcSqb2c1HOUX+SX14vnDiJCyruHN66zylXn19W7r
         VVihxNNOoMSnd0NZi9y7bZDhZynS8Hf9lAplTodKprFuy/US/gAw0Xki2Jdrr+svZDD/
         frjaVSyBvgN6M4u/KGPYtshEWSeFPgVsZUDHAuN4gS2WwuELhPEjPlI1aLp98Tl/7Np7
         puFdXYQA5oVo3u7wvChcAF5im7yonaKQECgrWE93OZHGfh+fr7OYs5VFhT6SXQ3EAU4O
         Q6iDRWNHIHCek0JMgAj9FBi2Pv1zysZvglew8nVfneNQp8h7zYfnxkZZpWPtuK5X68Ec
         dDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=muhsxbhe1qDbUQ4jcUrsoThKcresfAmhuSXs9ng5ZKI=;
        b=qXj8Qvf2+I8bZurUy1OXIqNWNf1tMzOPZ91eyuUmUuAuqRIHZxcaqYSNRiluEyCQ+x
         xCIcGzI17k066h1WgJLLJhoNAg71fzpwr2de+Y4rTwuFU3Nr3QvsXYQ9kEaddzsaw/WU
         0n9gt6JvUTgXBlmCwI5ddyUcWs5SWC99WAqQDENIEQ7VFL8MmqwMssEaBtN2YIvLTN/C
         UFagnpMlVS/t6bzNSER6rasTlTadDvwHvrHC2V7LRVkPmQZd5Iz1OZSL/G7bNHfwl+Tz
         0254ypR8jvrHiRpLbO9pMz6t9slcz1IMwEVojtnaWbf4Rz7IWW2zPXV0WL9CpryAGWQM
         9ung==
X-Gm-Message-State: APzg51DR59fvW6XfnVEDFMnVzXLdZltDIy0xIfMabfMpUOBmQRtuGsT0
        2tudcbp4/rexnuu4XmLbz3N1sA==
X-Google-Smtp-Source: ANB0VdauRun3gd9o7fA2CF/z2PiJpPhNXk07BLblPuiG20aey7/5dFGLvfBH95C58idQbO3sNMjnVw==
X-Received: by 2002:a63:24c:: with SMTP id 73-v6mr16830562pgc.252.1535754246938;
        Fri, 31 Aug 2018 15:24:06 -0700 (PDT)
Received: from smuckle.san.corp.google.com ([2620:15c:2d:3:fa74:b312:5fef:6cbf])
        by smtp.gmail.com with ESMTPSA id d81-v6sm15072750pfj.122.2018.08.31.15.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 15:24:06 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: vruntime should normalize when switching from
 fair
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Miguel de Dios <migueldedios@google.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Todd Kjos <tkjos@google.com>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        John Dias <joaodias@google.com>
References: <20180817182728.76129-1-smuckle@google.com>
 <dcd2fa21-7fef-d648-017d-9d42d11793e0@google.com>
 <20180824093227.GN24124@hirez.programming.kicks-ass.net>
 <20180824094742.GJ24142@hirez.programming.kicks-ass.net>
 <ae94fb88-646b-1d82-b61d-103792965dbf@google.com>
 <20180827111458.GB24124@hirez.programming.kicks-ass.net>
 <2ed346fa-dbe8-4928-928b-a34338b2d8c9@arm.com>
 <273b9b52-8c00-0414-ea11-214d81cd57c7@arm.com>
 <20180829115954.GS24124@hirez.programming.kicks-ass.net>
 <f7c5a86f-7d76-bf26-4763-94a9ef4bba2e@arm.com>
From:   Steve Muckle <smuckle@google.com>
Message-ID: <52ea5cf6-b22b-f026-5796-f52b3e40415a@google.com>
Date:   Fri, 31 Aug 2018 15:24:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f7c5a86f-7d76-bf26-4763-94a9ef4bba2e@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 08:33 AM, Dietmar Eggemann wrote:
> Yes, this solves the issue for the case I described. Using
> 'p->sched_remote_wakeup' (WF_MIGRATED) looks more elegant than using
> 'p->sched_class == &fair_sched_class'.

It's confirmed that this patch solves the original issue we saw (and my 
test case passes for me as well). I will send this version out shortly.
