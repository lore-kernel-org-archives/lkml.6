Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20C0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1C020856
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRmKMgw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1C020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388567AbeGYBdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 21:33:33 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:38689 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388488AbeGYBdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 21:33:33 -0400
Received: by mail-pg1-f176.google.com with SMTP id k3-v6so4011686pgq.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 17:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=QgZvssnrKTIHli3Rh/G+1VC6ypzQuPStSJ35oZ8g1HE=;
        b=vRmKMgw+/5Tbbk108qba5qHB3t1vXkjjuA2zJQknc+NYn3Z8Qy84XuPE/+PQAW0M79
         hEUwrx70hH2H1BVcg6VVKSIxG1iBb83+z9/c5Hn1T5PVxjJJE7iY6e+SOEwI+DZq2N6q
         SynV7NPSL3MFWR5ONODjRxGlq4SU70i+EOLH/wb/itcG9jEeMypySaf6WphSbq3ZlOOq
         kJ7zSrhjjgavTld0LMsQVn+rXZaB1Yyc09R5CsCGJAEfDQU3nNhST8NY8fzf8JbPpgzx
         hL7EsswakCwRaG4dUK8/F46wpiuuOhvwDJ0rzrWmvePMG4XyBzKiEO6ZX377QGz9XhvT
         Vr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=QgZvssnrKTIHli3Rh/G+1VC6ypzQuPStSJ35oZ8g1HE=;
        b=B97yL8ULXAi5QmP2MIarrZQaYrVLPZ8qdC6gJylFuUKjniFAETWUndYkObYju2ZXiI
         sguCDTEEXEKGTjfMXszbDsmE4MhGS2R0hzQ6aw+8dNsa5YMK8udTX1FRsuxUY+QNW0gK
         CijgG2y4ezA+COM7yi/jAE3jWFYw1xmlhaHIJTWyyQk2iPt9ChBZ7Ce78YHA3Ra/3W3E
         dhR855GLbVl7JkXgzDWOgOpcdS4laDWlHAA8KvA06GmNiGG0wSDI9Q4jtIb/S7jf5zAp
         fY2JP1h/PvxxYF0BDRRJYuoJG6joS12lEoeX8OdaSDFIVQ+kH12xb84ThYpwL8iMcxfp
         ZiAQ==
X-Gm-Message-State: AOUpUlHT7G2uECgjo1BEkspOGt2F+d6afp0T3codk1vv1L2/7OWq+lBr
        luIaDJ+SMRNNr09PceEYCoF/rJ/oDYk=
X-Google-Smtp-Source: AAOMgpdPPnHMWI513scXLUXxMHNKR2Zs5Ly28t4PlLTQxXwa+90SsOppmh3JtJN3PiqkjAD5ORjkNQ==
X-Received: by 2002:a65:58c8:: with SMTP id e8-v6mr17993121pgu.96.1532478273140;
        Tue, 24 Jul 2018 17:24:33 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 86-v6sm23429019pfh.0.2018.07.24.17.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 17:24:31 -0700 (PDT)
Date:   Tue, 24 Jul 2018 17:24:31 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch v4] mm, oom: fix unnecessary killing of additional
 processes
In-Reply-To: <f2e09fbf-700c-19d6-7dd8-42683507b5d1@i-love.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.1807241722580.49968@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1806211434420.51095@chino.kir.corp.google.com> <d19d44c3-c8cf-70a1-9b15-c98df233d5f0@i-love.sakura.ne.jp> <alpine.DEB.2.21.1807181317540.49359@chino.kir.corp.google.com> <a78fb992-ad59-0cdb-3c38-8284b2245f21@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.1807200133310.119737@chino.kir.corp.google.com> <alpine.DEB.2.21.1807201314230.231119@chino.kir.corp.google.com> <ca34b123-5c81-569f-85ea-4851bc569962@i-love.sakura.ne.jp> <alpine.DEB.2.21.1807201505550.38399@chino.kir.corp.google.com>
 <f8d24892-b05e-73a8-36d5-4fe278f84c44@i-love.sakura.ne.jp> <alpine.DEB.2.21.1807241444370.206335@chino.kir.corp.google.com> <05dbc69a-1c26-adec-15c6-f7192f8d2ae0@i-love.sakura.ne.jp> <alpine.DEB.2.21.1807241549420.215249@chino.kir.corp.google.com>
 <f2e09fbf-700c-19d6-7dd8-42683507b5d1@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018, Tetsuo Handa wrote:

> > If exit_mmap() gets preempted indefinitely before it can free any memory, 
> > we are better off oom killing another process.  The purpose of the timeout 
> > is to give an oom victim an amount of time to free its memory and exit 
> > before selecting another victim.
> > 
> 
> There is no point with emitting the noise.
> 

If you're concerned about too many printk's to the kernel log, 
oom_reap_task_mm() could store whether MMF_UNSTABLE was set or not before 
attempting to reap and then only printk if this was the first oom reaping.

We lose the ability to determine if subsequent reaps freed additional 
memory, but I don't suppose that's too concerning.
