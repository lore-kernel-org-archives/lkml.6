Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B245C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0944216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEwxqEmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0944216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbeKLQtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:49:51 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:46993 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731867AbeKLQtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:49:50 -0500
Received: by mail-wr1-f41.google.com with SMTP id 74-v6so7979703wrb.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 22:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0PMQeNNvzzkv4NagLClsrul4K0k3T2RMZFpN/QCe0rw=;
        b=fEwxqEmK9ZM9pRbduPIRHAH2O8RUa94VlpW69bxU8/mAj8vppzX5AjPIC4BVtG613k
         dvttGSIit1feL0KRVuyUgDDdxWttdBZpEFXEWP3oq8OtdQWEVUcVCc4KaKTtJEu3weVn
         SMzEzBbx/rNE+jf93qPF4QUUV77e4dh4LS5h+R8WAeAm0S+3fC0Jtf8JYjR3Csncw8CJ
         HjhVeLIA5HrK71eE+E4UdMLcNB3wY1RcYiFbZb6Dl4VKW8LRdSs6yEH6FJ3wwmdVk2bx
         435r2Q8k5H99FhFRGlmAR0vk0eigbXNIK2irpkfmea4JpW+I61252EFkVcZYVxFi69XF
         M0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0PMQeNNvzzkv4NagLClsrul4K0k3T2RMZFpN/QCe0rw=;
        b=ZY/BJmsImLiTD8NnC0EcT8egL6HWqXjw+BUsDoxEVGV01enYh2l5SJAQh+xbV+RewH
         fli1gPezOIIu9hZvvaUsI1sQ5B3RLkKZ37TYIyzlZfCpzsdrJrvjkxY/5v3S6Ir+hZWH
         iyoh9Zaskju2mlzWPjTq5CpdGbKvlUI0zdeEd/dzLYZ3gfggxJ6dPPQienz6uEGaxPkH
         U9CBPKyN4ZUKwDNkAvweBzjACw9mtu5qZaRI3mwWRC7nQvUHh/Wlp71RC7rDr6OjO4WL
         87dDOk014q5cQKPjagqr/N2Ge/WIy5n2hHMAsStOr5XwmX8O6XfmTwP5NcXBSNcmyEXl
         ij6Q==
X-Gm-Message-State: AGRZ1gK1sZhnhI8iTqImnlcb4pdNPZnq5HwpKLAE4GGz/z0cjr1TzKHS
        jiOUXLGEI+U2WgrIxUw+Zvc=
X-Google-Smtp-Source: AJdET5eTwRp1isiuT7L7kbF9ypWE589K1OOb6Y+afsnVDetq8DwwHWKZuMhgfJpfOvCBXoeJvxnR4Q==
X-Received: by 2002:adf:d090:: with SMTP id y16-v6mr15672988wrh.314.1542005875259;
        Sun, 11 Nov 2018 22:57:55 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 6-v6sm4665295wmg.19.2018.11.11.22.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 22:57:54 -0800 (PST)
Date:   Mon, 12 Nov 2018 07:57:52 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Muchun Song <smuchun@gmail.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/rt: Introduce prio_{higher,lower}() helper for
 comparing RT task prority
Message-ID: <20181112065752.GA97934@gmail.com>
References: <20181107161505.42769-1-smuchun@gmail.com>
 <20181107173140.GK9761@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107173140.GK9761@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> I think you only need the less thing, because:
> 
> static inline bool prio_lower(int a, int b)
> {
> 	return a > b;
> }

I'd say that should be named rt_prio_lower(), even if it's local to 
sched/rt.c, right?

Thanks,

	Ingo
