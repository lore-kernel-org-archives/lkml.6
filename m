Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE45CC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE8B218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="gFVoNGd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfAYPLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:11:32 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33300 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfAYPLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:11:31 -0500
Received: by mail-qk1-f194.google.com with SMTP id d15so5595749qkj.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 07:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=I++XVxfiKjXV6KkxGWgqivb89xppHHENKhtBr0XDFgY=;
        b=gFVoNGd5AbqmS6Tvr7f58/xDGG0qBJlMcWiLVmAi71MThfb0Tdt9SJoTNijv/Z341a
         qjyolpauxzWfvhu6hgRkCewwUHYFY3fJT0ZL3BTG7QBsbiUcVLditZ8ON5z95Z6UzQ60
         aQaFOa4Mltbm0X7tHbtv2zBfV5RbHlCgp2MVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=I++XVxfiKjXV6KkxGWgqivb89xppHHENKhtBr0XDFgY=;
        b=VIaSVOhlHX12fzc8j4TVFGO7aPBYLKYJ1nWXuLdcGbH92PPEZmJS5QiHSs1uvZPS9U
         XdcC4W33JzJBxg88h6G2MUw35zJ+bJLv+j2J+r8Xw3Vp+yHkLekBc5dD/lIADZpr9jOX
         L8RkhDIGqmH0ZEytYAJl5QpWV6G9nI5CYEcnWsZVlqLjORX9PWt63SWbNw3CN5dupqKb
         RnQo8XRm5SPRqasT+pOfV4YXaYTi8cagj9bF4ZtZ+FkylUjM7ZSitMWYecUNPgCl4Sh3
         LQu/XjIxe2P3OjwKMeduNzLwmoWghZltX/5XfYajbFwRJ2ogt5uQuUIYOTgOyZQc8Bkq
         xX5A==
X-Gm-Message-State: AJcUukflqyVRqQUCfypkVVG/ancf9LbhMFH5M7i9ztP+l8iMUzMBVClq
        nu5nw1GuIE5BrwEvrjNTnw6NZg==
X-Google-Smtp-Source: ALg8bN7rT8LvDWPMxjzpkoGrws6pbPAyONaxyR6ej2Ej8sEubYBODxRjSZ1PCIvgq328sG812NZ9tg==
X-Received: by 2002:ae9:ddc3:: with SMTP id r186mr10075337qkf.163.1548429090658;
        Fri, 25 Jan 2019 07:11:30 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id x49sm98323625qta.89.2019.01.25.07.11.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 07:11:29 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Fri, 25 Jan 2019 10:11:28 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
cc:     lkml <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, eranian@google.com,
        vincent.weaver@maine.edu,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
In-Reply-To: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.1901251008310.32202@macbook-air>
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019, Ravi Bangoria wrote:

> I'm seeing a system crash while running perf_fuzzer with upstream kernel
> on an Intel machine. I hit the crash twice (out of which I don't have log
> of first crash so don't know if the reason is same for both the crashes).
> I've attached my .config with the mail.
>                   type = PERF_TYPE_HARDWARE;



>   ========
> 
> And, I'm running fuzzer in a loop with *root*. (Let me know if running
> as root is harmful ;-) ).


There's a known issue related to Intel BTS events that you can trigger 
with the perf_fuzzer, even as a normal user.  I reported it a few months 
ago but I don't think it ever got resolved.  The traces you get look 
similar to some that you posted.

It's hard to track down as it doesn't seem to be a simple issue, but 
rather it looks like the BTS event handling is stomping over memory it 
shouldn't somehow.

Vince
