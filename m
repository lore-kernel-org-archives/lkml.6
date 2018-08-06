Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAE7C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422E821A64
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DTp+SXvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422E821A64
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732944AbeHFXz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:55:27 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38351 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731200AbeHFXz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:55:27 -0400
Received: by mail-pl0-f68.google.com with SMTP id u11-v6so6186608plq.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=CYPNUrzOit/m6eDwlnNAerqtHtfUsuqj0cN7WJ/sDSg=;
        b=DTp+SXvJelsRjixbyK4pFnUGsXEa++emQ5OYKW4S0TkPR1aOxXhnNnQiRK9VJUMV6R
         nK8FjkceqNsbdN2Jrniok6BQ4vDsiTC+DuYF5gZxRG9lszpDg91HhfKBAIhE5fcCGrGH
         Afi/15H1P+ZAyITWW7baTiJj8dz2wLcOAdX3UEH4N+r3PGX2cx4Oj0oiTWSLV4MNWLD9
         2LHjQZgwOhD7tHmEKBKJpKzlr/5WimvbMvXHgsJ6bosZg5fKTKUzzcgAu9m542D8KrZ1
         x5ZIeQA/pJpe0kLbaPR6AYBI0cU0EnnqMAgRxXQWyQZHPhzuz8xGI2f4y6yPA+X5jLbC
         FK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=CYPNUrzOit/m6eDwlnNAerqtHtfUsuqj0cN7WJ/sDSg=;
        b=gJY2YnmLi7oE/skaa2mvDRJb3tPWr2k/4vYAHZHeGEpAUujRRMzNXopbky7zOr+1Mp
         UUbBXoFM22Ydp2jyttkyaX0Qoi/nrhXIinz3/h2y9MY35pjnfRyUgBJK5bb20w8v0rsd
         ddj0aj8Qy9fGSS16CAanhB8iUTDdvbc919+DCS5MeUOlgMHl21Xwp74b2TW0ou2F+qUY
         ZGbvapApzJOHjw5vEc6wPN89WOz2kcVAGp+73h4nYd8apRb/QJPcAOWVQEKsQ07stWLI
         nOd59BGb29QTwYyHeXT2UVsY11eMb1pgga2Mi1ZTvhND0+Dx+TbHhqX8ubtCJld4hRiR
         b1iA==
X-Gm-Message-State: AOUpUlFnfgRENWiQMuALTJEStP894LURwh8TWQWereFbWj8oiXcYaNw3
        ZOdZEGUKNGejVnsyffQN23MlnA==
X-Google-Smtp-Source: AAOMgpdT4vIdtqQem8U278w6j8//Dug8EpqZ61QCMe4mDprgwfcH6scZ0WQCV0leXGUjysiMcpd7qw==
X-Received: by 2002:a17:902:3a2:: with SMTP id d31-v6mr15694458pld.287.1533591865587;
        Mon, 06 Aug 2018 14:44:25 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id c1-v6sm16251936pfi.142.2018.08.06.14.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 14:44:24 -0700 (PDT)
Date:   Mon, 6 Aug 2018 14:44:23 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Roman Gushchin <guro@fb.com>
cc:     linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2 1/3] mm: introduce mem_cgroup_put() helper
In-Reply-To: <20180802003201.817-2-guro@fb.com>
Message-ID: <alpine.DEB.2.21.1808061444120.43071@chino.kir.corp.google.com>
References: <20180802003201.817-1-guro@fb.com> <20180802003201.817-2-guro@fb.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018, Roman Gushchin wrote:

> Introduce the mem_cgroup_put() helper, which helps to eliminate guarding
> memcg css release with "#ifdef CONFIG_MEMCG" in multiple places.
> 
> Link: http://lkml.kernel.org/r/20180623000600.5818-2-guro@fb.com
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: David Rientjes <rientjes@google.com>
