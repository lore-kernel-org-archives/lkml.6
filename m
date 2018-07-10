Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D59C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9C3208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cb2jrxrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9C3208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbeGJVNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:13:23 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37697 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732274AbeGJVNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:13:23 -0400
Received: by mail-pl0-f68.google.com with SMTP id 31-v6so8152430plc.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 14:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Vsl1A6J2DyVsZv9vOaRlEqxB/okex/A831ghcU9LurE=;
        b=Cb2jrxrDBmukjIpJK+9OyV0CPHULIf4seSHz9RUslcxq7QBRX213JGECsFAoOeXQzO
         TSMiZeWPJLvSQGBuHo8CWAZ1AgYnfnPpUhJGKRq0FxjB0HDKRrVjb8W/GBuuL8GzBYud
         +J4Zqd4IZ7CC/bMPLnXdxu/xvAjRvskJzs5j4YMZ0ukjS7cYGiq6DYaS7tv2TmmMjzed
         5dtA/m3bDzgwr5VTmdptysY2J67kNW2eH+VXF9LmjH32Au4ZTv6NQ6/JvOLqqIP3Q19F
         uTnZglYzjzNoTM2dEfw/5GNMOxBH851MOOfT08/tD2uKaUO+QAbp/R5BBhbTYeESpJF1
         w4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Vsl1A6J2DyVsZv9vOaRlEqxB/okex/A831ghcU9LurE=;
        b=OLwGmj6E72wg4fJiYm110EAmtAYWkfet0/HdTBDrWLUYNCmxtm5gDaxmvba49t1yal
         P2Umv5aCy7Qb3J2r6ClXt21d53hw6TS9lb8G55/YlosdAW1GEvGER3EbunpvJFXVXudf
         cT09hBr5kwinROpUR5MczUhhYqOUhqAYCdwCsWsm9ggbo6zHi22EVkq8ZobU/C8v4OWl
         srmHEUcOL6IqDdajiri7cn+m3UzJM9fPaGQWtQ4DZWiA5HzHXHuI8hP8oEHh2Oz8Ewl8
         6+6Cql15QrbZPU9EYONEltQJNGLxkTxP6baXBiJDhSBv52ZF07a8P5fdq9zTyEioErRu
         MMEw==
X-Gm-Message-State: APt69E1oBNU3UYdHtAJQtxgUYMobJH+stRbw6UUs5fRO8md5SKdXYQCN
        +kGl9q8dKDcIRl+3KjY9juCnDhcPygk=
X-Google-Smtp-Source: AAOMgpddCqd+vbO/OLrbcqta/U96Fgl+nyM06hH4jDSpKkDBIb1lEE7HOt52WxSaBcdfUsGuP57Agw==
X-Received: by 2002:a17:902:1a2:: with SMTP id b31-v6mr25610515plb.279.1531257149435;
        Tue, 10 Jul 2018 14:12:29 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id p11-v6sm23876556pfj.72.2018.07.10.14.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 14:12:28 -0700 (PDT)
Date:   Tue, 10 Jul 2018 14:12:28 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, oom: remove sleep from under oom_lock
In-Reply-To: <alpine.DEB.2.21.1807101152410.9234@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1807101411480.29772@chino.kir.corp.google.com>
References: <20180709074706.30635-1-mhocko@kernel.org> <alpine.DEB.2.21.1807091548280.125566@chino.kir.corp.google.com> <20180710094341.GD14284@dhcp22.suse.cz> <alpine.DEB.2.21.1807101152410.9234@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018, David Rientjes wrote:

> I think it's better, thanks.  However, does it address the question about 
> why __oom_reap_task_mm() needs oom_lock protection?  Perhaps it would be 
> helpful to mention synchronization between reaping triggered from 
> oom_reaper and by exit_mmap().
> 

Actually, can't we remove the need to take oom_lock in exit_mmap() if 
__oom_reap_task_mm() can do a test and set on MMF_UNSTABLE and, if already 
set, bail out immediately?
