Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB368C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7837F217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="aOZLgnWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfAXQAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 11:00:13 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35496 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbfAXQAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 11:00:12 -0500
Received: by mail-yw1-f66.google.com with SMTP id h32so2619459ywk.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 08:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hCxh8cKbdjdveceYE2dpaNIbo3dOi85oEdfOpSI1M70=;
        b=aOZLgnWFCiEp/DgAqJ0ZNWqNTjzcc5vJt9MAo9H/VK+bDPLL728DCs/dQTYumayW9b
         hwEBKayaUcXB/Sm2wVblmZUXpmcYCgw5srU72fEnOiwv6GvjLFt7QQLCA15lf/iLKQTe
         I2LZ9iXuNZVAc9x6w0w1nXX6r3sUSWtCQcX4vldjXpJSKymA1bOwkAdtqaA3BVwhK1pi
         6XP/Xvmi4a2Fkd60WeR1k85nxSzSrbRmyv8/HOAf2fs9EJyFHmoNqroNwCqPIdMxMz4e
         dNaWR2UqiCiGbVN1MaIK7kUOEqQUqWZbXjT6WX1XVcLMZ5aPHFeN5L19jQqp84gLGZ8p
         iglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hCxh8cKbdjdveceYE2dpaNIbo3dOi85oEdfOpSI1M70=;
        b=YcmoaulMETt6dSboOQxzWA0CdLRcfyISbm8O/XDZ5EC9/mssh/rqbo+jn5qWfP0+pA
         TnHip3yCeoYKjY/9ue3Iclt7c2qjkXvkbIovSeMWg2w2sFBYP9+uXdI6fybSzQmL9+Gv
         DJFLl89dRaEwAamgfevjGFl6ArF62xBc5xCSdTmxWKr/t1i1trIyf3z+484Cz+Kcwszm
         GJgbQC6c081hxW8XZ3A0o521f3pGK3acZl9SKUSaOevaFqnQD9rJBC9Fcfe/USaKEWvM
         936wv99KgteDVx8wOv7xE7MhkRMX3wKGYlieYFMRZCL+WFszlMGMTA2Ad9nqkYR8HzSw
         twLQ==
X-Gm-Message-State: AJcUukfvH4DdFtkJTCvqrR6KCdlwm+gIQ5NFqKr4RGnCPXqFXnfQTGuI
        /AYYKJTdPwxeEN1gner3edjVdA==
X-Google-Smtp-Source: ALg8bN4aBCGv35jkyWZhnUPF09RZsGCyquxrn8LBm4z5TdGfoUswZlR81XbS9m6yHGE0HB/Lw6uFvw==
X-Received: by 2002:a0d:df87:: with SMTP id i129mr6886876ywe.474.1548345611594;
        Thu, 24 Jan 2019 08:00:11 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:9b5d])
        by smtp.gmail.com with ESMTPSA id w2sm13081675ywl.10.2019.01.24.08.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 08:00:10 -0800 (PST)
Date:   Thu, 24 Jan 2019 11:00:10 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190124160009.GA12436@cmpxchg.org>
References: <20190123223144.GA10798@chrisdown.name>
 <20190124082252.GD4087@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124082252.GD4087@dhcp22.suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 09:22:52AM +0100, Michal Hocko wrote:
> On Wed 23-01-19 17:31:44, Chris Down wrote:
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> btw. I do not see this patch posted anywhere yet it already comes with
> an ack. Have I just missed a previous version?

I reviewed it offline before Chris sent it out.

I agree with the sentiment that the non-hierarchical behavior was an
oversight, not a design decision.

The arguments against the change don't convince me: the added
difficulty of finding out local values is true for all other cgroup
files as well. This is traded off with being able to detect any
subtree state from the first level cgroups and drill down on-demand,
without having to scan the entire tree on each monitoring interval.
That's a trade-off we've made everywhere else, so this is simply an
inconsistency, not a legitimate exception to the rule.

We cannot fully eliminate a risk for regression, but it strikes me as
highly unlikely, given the extremely young age of cgroup2-based system
management and surrounding tooling.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
