Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F67C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D0D20864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZFUjJG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D0D20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404650AbeKVQxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 11:53:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43130 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731512AbeKVQxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 11:53:42 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so8752974plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 22:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kKvFcV8GXe5sfwl54XYN3WvaxSKT99J5HiXdICjfEKk=;
        b=nZFUjJG5myh3f6OaSvNYJK+wAO7L3PrPP6sxWnk1dncHjKC3jEFaUfLfmgHw7rcThD
         vhHbkzvpp1FXOQlZX5A9c0R3scib2c2X/IW5VBMNzx8/P5QK+cAbPGpkkpvqnw7GXR9y
         9xLU6isVsxZ/5a9597rcFAI/kI5bRZU2KOf1cWBzozsbzYNlscvUZ5lNTi3pEai89Ik/
         /7YAgvEOODG74dZU5FlxlcfduCMRZoT3Oavt+wApKbcibUHP+6SKajlFY8bmFm0aD7CS
         5HF30sT10v24Xx8HtB978WJC7fqzPJT/a7Qg+rBVFnqg09WhNW+n3E9UunzEb26J80Pv
         /Elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kKvFcV8GXe5sfwl54XYN3WvaxSKT99J5HiXdICjfEKk=;
        b=WkCyqEs4iXZp32fCeepmxjdjSegnT3Oj7nM7ZCwbK3UYhIZnghJbUeQ4WvUSrIb5tf
         pZ3EVM5eRGY+r1GMRTKbdnlJimTCVDzp3ZovydiqwhNTG4gzS+pDqwYOyBuOXSWjgtKy
         jq19zwmHZsNjg+zWl0nC+ITJxKxLxDQ4KsGRb4uwVWMUxsMHW2nkWWGZOL9e9LejrA/l
         MaRiluiN+tqCTUwhonugLHxSci7OxKmCeO4lGgRr3JbAGkoPwHykYCqT28RelrCf2VAP
         2x1AS1IAQHApn4o63P9rgLkd6bqqnmpRBXUH+v8pyOZAsk8/gS/6OL31O5me+LKhk60I
         sMSg==
X-Gm-Message-State: AA+aEWZQKWhRhiBMCBD//wdE7td2Ah07Z1ewndAWrbBUp3/C4v3luitQ
        zJjA5IcsXZkPgCSyNFcUjMg=
X-Google-Smtp-Source: AFSGD/XU9DKxLRh5eZJRRtEnV8MWDd9FF5/5blzcfAtXyBZUbDbl69079DFbArXerl+1K18L7J2qsQ==
X-Received: by 2002:a17:902:6b03:: with SMTP id o3-v6mr9942159plk.208.1542867347055;
        Wed, 21 Nov 2018 22:15:47 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id r26-v6sm21649132pfk.157.2018.11.21.22.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 22:15:45 -0800 (PST)
Date:   Thu, 22 Nov 2018 15:15:42 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] zram: support idle page writeback
Message-ID: <20181122061542.GA211816@google.com>
References: <20181116072035.155108-1-minchan@kernel.org>
 <20181116072035.155108-5-minchan@kernel.org>
 <20181121045551.GC599@jagdpanzerIV>
 <20181121133408.GA103278@google.com>
 <20181122021442.GB3441@jagdpanzerIV>
 <20181122050437.GA182024@google.com>
 <20181122054040.GE3441@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122054040.GE3441@jagdpanzerIV>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 02:40:40PM +0900, Sergey Senozhatsky wrote:
> On (11/22/18 14:04), Minchan Kim wrote:
> > 
> > > additionally, it's too simple. It writes-back pages which can be
> > > swapped in immediately; which basically means that we do pointless
> > > PAGE_SIZE writes to a device which doesn't really like pointless
> > > writes.
> > 
> > This patchset aims for *IDLE page* writeback and you can define
> > what is IDLE page by yourself. It doesn't do pointless writeback.
> > > 
> > > It's a whole different story with idle, compressible pages writeback.
> > 
> > I don't understand your point.
> 
> Seems you misunderstood me. I'm not saying that IDLE writeback is bad.
> On the contrary, I think IDLE writeback is x100 better than writeback
> which we currently have.
> 
> The "pointless writeback" comment was about the existing writeback,
> when we WB pages which we couldn't compress. We can have a relative
> huge percentage of incompressible pages, and not all of them will end
> up being IDLE:
>  - we swap out page
>  - can't compress it
>  - writeback PAGE_SIZE
>  - swap it in two seconds later

I got what you mean now. Let's call it as "incompressible page wrieback"
to prevent confusing.

"incompressible page writeback" would be orthgonal feature. The goal is
"let's save memory at the cost of *latency*". If the page is swapped-in
soon, it's unfortunate. However, the design expects once it's swapped out,
it means it's non-workingset so soonish swappined-in would be rather not
many, theoritically compared to other workingset.
If's it's too frequent, it means system were heavily overcommitted.
