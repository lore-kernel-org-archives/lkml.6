Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7605C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351D92081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="RU/pEJeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351D92081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389388AbeKGCVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:21:13 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34721 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389214AbeKGCVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:21:13 -0500
Received: by mail-qk1-f196.google.com with SMTP id a132so18934384qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 08:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=skMHNOoJD4yOALOm6YOjjkiy8VSgLfR1zLFcpNeSm+g=;
        b=RU/pEJeZfjNOUbRUXgAbrqgLe/r5V2kWoKFhLTi1l3ED+LcQDVdR0Kzpsgv5ofLVmF
         FV35E9YYK6LW7YesucQFlCG1kPmsmVYOi/0xmHLQ8swKJdCFGHg/8gGG4OYP5kKCt0cx
         OH+IxfdGgjzr6oz2LuT4X49Tn56h+y+PGhqKbBoKhpV+bDEMSzkALEWKPcOCz+nEUMB4
         9WywMgcL1iLs/1MUf+kOIpz69HIXNKsAQIU3QvC1lYGdH96KaUQUgK1PpC8TfRTxUyWy
         bC+vsfD1KQvy3rDvutcNjHWWUai/NKDIr25icSIjI+2OQ9kTV7TqgaccGikegUBq1vAm
         2VJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=skMHNOoJD4yOALOm6YOjjkiy8VSgLfR1zLFcpNeSm+g=;
        b=p7UPFJGom/RFJlWW9Rx0Oh3Ym0rSjcmqXw3vFzCscviOe6Du9oi1uPiMIVvXs0V2e5
         DKANBOkcNUK5mkfLxmzFLtpC9Vc8aLvXF9MLvnv29elQNLtOP0Zd6AYsdUSpDGHBLYp+
         MLtAtx6UkLaEaW01TaQ8BeyqUqnf2jjfAtIi9W6zJSjb2f8SiBnF/sXv/ltrZOvDeWaA
         yhRg5w8mCU8BVxJRPJDV9oSBaS9vALIkDS7D0XOLw87VAtAG/4cEiIevlGrmfk3JqbPy
         I7ihioYawUcA9bvuqZg1w5oDUhVCwcQTaWvUUX1QPOzR45KLJkgwRxYFwueY5RDzu/88
         L8SA==
X-Gm-Message-State: AGRZ1gLNarASUa2rsYo3KCn7+akQlpbGkXxiFs+oryT7VYGN99V8Ds9z
        X83sOJxntwk9hWxcqW/ayk00Lw==
X-Google-Smtp-Source: AJdET5cz4HsPdM8GKDpMk3fomRwqlQTPTyatRjYKoCxickpCQH0cc1peMAwNXCgqtiLGTqBxNJqo3g==
X-Received: by 2002:a37:2bcf:: with SMTP id r76mr24638975qkr.218.1541523306806;
        Tue, 06 Nov 2018 08:55:06 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:2772])
        by smtp.gmail.com with ESMTPSA id h49-v6sm34838884qth.32.2018.11.06.08.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 08:55:06 -0800 (PST)
Date:   Tue, 6 Nov 2018 11:55:04 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] psi: simplify cgroup_move_task
Message-ID: <20181106165504.GA16718@cmpxchg.org>
References: <20181103183339.8669-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181103183339.8669-1-olof@lixom.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2018 at 11:33:39AM -0700, Olof Johansson wrote:
> The existing code triggered an invalid warning about 'rq' possibly being
> used uninitialized. Instead of doing the silly warning suppression by
> initializa it to NULL, refactor the code to bail out early instead.
> 
> Warning was:
> 
> kernel/sched/psi.c: In function ‘cgroup_move_task’:
> kernel/sched/psi.c:639:13: warning: ‘rq’ may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> Fixes: 2ce7135adc9ad ("psi: cgroup support")
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Olof Johansson <olof@lixom.net>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Olof!
