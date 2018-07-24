Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB80C6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33EB20685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uxdT4kbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33EB20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388907AbeGXWDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:03:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42971 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388640AbeGXWDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:03:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so3702435pgp.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 13:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=okBAlDaxM0DNqW7zvcq7HlrqbxW7pHlut6qsdwTqoyk=;
        b=uxdT4kbGdTtAvJ75Nx4Uy4Gs4UPePCI9Ha0khp8C4ZP6fll5CyFVvR+wCteneUJXy/
         Im3svmPSqS67CLvbBmQ+6grwETAKbPlDznYttjZKLmqQikspi+1KLSHFxwlrblHpiLQ4
         SwYmgmfKmknGbWkPnRrUyqHgj5fZlDSoTGvKelLHSr4zqQbRQZK2RdGA/x9RivL2OJI4
         W1H/P7iN2GoPnG9BBDZRtCYc2khgIy9hTe47+mIJD/AtA0YwLUQdUoHDkudTXwY3/JCm
         33Wiowd/K7L0fAIGNUv78alTKx2DMJoAgKq7bj7gppmk9/34hw65ha5UEka1KWBM5YTf
         qzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=okBAlDaxM0DNqW7zvcq7HlrqbxW7pHlut6qsdwTqoyk=;
        b=OuwGASXcUkPJfJqDKi3UxHbqph6xahtzYNigj8s0BuBMoswqfLo6LSxqNrkbbWXUOq
         a5gQVl1J8Sp0kw3gUkKG2Vt56guyRtBiOmkiEcEsdlNjsFHac82O7xh3jB+Qm9HOoNZZ
         +5FI+flloaC2aYQSlH9gjOF7lRjR9vEyzJquK2miz3MqqOj1CGy7Kldv1LcJ8+Vrtl9U
         U7TQ6wqfZ7kiRAhQ6DZTsYYwjEfvUWKC57X0aGGYh4Pgr1qdpF2Qkru7aC4GRTgErMeX
         0GyKO4vwAwcvTklo6/EYC7qu319KuLABS9KJ/rv+5Skd0aLLHRNiD2C/6WFce+FS1JVe
         Lq8A==
X-Gm-Message-State: AOUpUlG1oLYPE0hiGVMTKHaV6nPe4an7Zz/VTw0nS54N2/MUkxv0rDek
        zTyKSuKBWqG1vG9mT6vMweZtCOg7W/Y=
X-Google-Smtp-Source: AAOMgpcgt5sD63Bvc5e6WpgeMpMJTSrKFadmQq4Gxy1eqZ5iDdeqiOLAUa1Ygn4yJ7Kk8EXW9It01g==
X-Received: by 2002:a63:8c51:: with SMTP id q17-v6mr18229002pgn.236.1532465734584;
        Tue, 24 Jul 2018 13:55:34 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id l84-v6sm19409007pfg.3.2018.07.24.13.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 13:55:33 -0700 (PDT)
Date:   Tue, 24 Jul 2018 13:55:33 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm, oom: remove oom_lock from oom_reaper
In-Reply-To: <20180719075922.13784-1-mhocko@kernel.org>
Message-ID: <alpine.DEB.2.21.1807241355200.191886@chino.kir.corp.google.com>
References: <20180719075922.13784-1-mhocko@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018, Michal Hocko wrote:

> From: Michal Hocko <mhocko@suse.com>
> 
> oom_reaper used to rely on the oom_lock since e2fe14564d33 ("oom_reaper:
> close race with exiting task"). We do not really need the lock anymore
> though. 212925802454 ("mm: oom: let oom_reap_task and exit_mmap run
> concurrently") has removed serialization with the exit path based on the
> mm reference count and so we do not really rely on the oom_lock anymore.
> 
> Tetsuo was arguing that at least MMF_OOM_SKIP should be set under the
> lock to prevent from races when the page allocator didn't manage to get
> the freed (reaped) memory in __alloc_pages_may_oom but it sees the flag
> later on and move on to another victim. Although this is possible in
> principle let's wait for it to actually happen in real life before we
> make the locking more complex again.
> 
> Therefore remove the oom_lock for oom_reaper paths (both exit_mmap and
> oom_reap_task_mm). The reaper serializes with exit_mmap by mmap_sem +
> MMF_OOM_SKIP flag. There is no synchronization with out_of_memory path
> now.
> 
> Suggested-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: David Rientjes <rientjes@google.com>
