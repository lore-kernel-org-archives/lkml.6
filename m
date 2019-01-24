Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEB7C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D024621872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="r5uoAxGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfAXBGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 20:06:41 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34154 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfAXBGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 20:06:40 -0500
Received: by mail-yb1-f195.google.com with SMTP id k9so1190242ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 17:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0AkmJA1QYcuNJ5TIP/Rznolsmj53RzAhmVndjUnRVJg=;
        b=r5uoAxGebrDBWOF9OJn2bE4s7TsgVYb4fgBaOXGxU4FWKr/zdeuE2H7v6JA02b/R2x
         d0GEE7UMADZLceRGSNsQP6t6zul1wJHInN4LWH4qXhrhcekXHT0yIPVHQMOPPdaIuCoU
         ng38WFvux3gqwU9dkRgxFHoC2QSaj+/ueAQFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0AkmJA1QYcuNJ5TIP/Rznolsmj53RzAhmVndjUnRVJg=;
        b=GsgL6xDYPxMl5PfjT97DPoGM2gemgP64XQzgzDDo+R1Haollx6pwhs/9kx4uGEZIBM
         nWvHOG3xx3F0cfyHXoa4gexAZ9dW7SIoejRCsS5+2rFkCwNdPcTlbYqvrLUBYsX93RYC
         5C7KwBMLvZ5OhGae+ZbJVqEUA2AowcK5VnZ1dACVMmzyvmkPLei2yJFIEX+V4DToRlfz
         E6bk1WhmSNUYNSq6CxBe/YO1FamwQQH4CnwKGcIknF3+HVKQlJpnuk0I5NPHnnOB19RY
         Mi55f6L/aUCL867V5eLzwmojblwgAh5cHKQXizuCiBtPeEe5XrgChJithXeSenwxyEvi
         z0Ww==
X-Gm-Message-State: AJcUukcgUDLmZ+9nTtL3WAyYjL705l2yRijVx4jwnn2t7p0ivphlF2Li
        FzFV5y+xFCrPET0nxlcGWzSmDw==
X-Google-Smtp-Source: ALg8bN4zkB1/MKt6rz5DzFpRgpM08YPbsGepu0JMG6l0Tky706Ynes20US8s4jSGvBPSrKQgRC8aaA==
X-Received: by 2002:a25:8003:: with SMTP id m3mr4276462ybk.337.1548291999812;
        Wed, 23 Jan 2019 17:06:39 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::4:a24b])
        by smtp.gmail.com with ESMTPSA id l140sm9682395ywe.77.2019.01.23.17.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 17:06:39 -0800 (PST)
Date:   Wed, 23 Jan 2019 20:06:38 -0500
From:   Chris Down <chris@chrisdown.name>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 1/2] mm: Rename ambiguously named memory.stat counters
 and functions
Message-ID: <20190124010638.GB9055@chrisdown.name>
References: <20190123223049.GA9149@chrisdown.name>
 <20190123235940.GA21563@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190123235940.GA21563@castle.DHCP.thefacebook.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Gushchin writes:
>I'd personally go with memcg_vmstat_percpu. Not insisting,
>but you end up using both vmstat and vmstats, which isn't very
>consistent.

Yeah, we also have similar naming in accumulated_vmstats. Hmm, let me think 
about this a bit and get back to you tomorrow. The main bit I was concerned 
about was memory_events vs. events -- I don't really have strong opinions on 
the percpu struct's exact naming/plurality.

>Other than that looks good to me. Please, feel free to add
>Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
