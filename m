Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5831CC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE9520684
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1bA6YEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE9520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeKUCnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:43:16 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42059 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeKUCnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:43:16 -0500
Received: by mail-qt1-f193.google.com with SMTP id d19so569519qtq.9;
        Tue, 20 Nov 2018 08:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bgwKqPKTuNIZc8ZNsu7oVmFBZQ8IygAJo53SBFGFiIQ=;
        b=V1bA6YEeXrAtNVoYUUFf0jskgCq4F6fh+L1tUr4yzb8+4XauJAgjqEJT4vZI8S7ryQ
         g7yt1a3lwu4fXWSLPSLAO7F/D9UgZkLc9uVpsqIi+bszk5j0RQlf4j4oTC874itO9Lvc
         4fxRpShIc5ARo8KqCeVpAQY5Cx/MKFkuAeEXM3hGPRGI+pa1kZ0adZq+4RLqhKTU9SAO
         JkjtMmTV1v5movdnpcR7sg4IYmloHCavOT/Hmit++RUJfNucmgbnbNyEF4R5tpe4sKQ+
         ufzT0OaMpBZumOBDp6Q52NQ2isscfdZb0uhux60HLPaVJkUlAVyfyBx8Ty1te+A094jm
         0TCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bgwKqPKTuNIZc8ZNsu7oVmFBZQ8IygAJo53SBFGFiIQ=;
        b=XVr9UaN+1wzA72mms+ZA9HYsUg3NmBLAIF0EJP8yq1UfOcOqkbzVu+6D+4ayxHi4mc
         av08EZQ51mNATsPdGH1qa7cEVu5zwh3QpxZweBqbYWE5Hsk/tqXYJyqPUTPoFOjyVJSJ
         U185hQbra3y//6vMjaSo/R21n0oJK4hLc5Xh19z0CHXIZYzio3iIlIlKwCJgP/nuIGqC
         iKosL5nUT6UYRsKdhwfXulZ19A9at3EtLOysO/6WZ/R1vX9iACPT2GuTo6SKHKLaIP+w
         vFLBBLJheKtDwyYIh7b/dUoZ10k0yxocrvCXchVh4JyH2fXJXC+ICoXNUF/0KaDJrPBH
         k+gQ==
X-Gm-Message-State: AGRZ1gKXBdevhM5J4yglMUamFY2StGB+jp2HuWdq845xWW0NvuuY2IB6
        Lh2TB5WDkOk40PNOsiVfICY=
X-Google-Smtp-Source: AFSGD/VIsW4gD8DLFVSWgSyD0xUcqdl2qV3TzzosDMIBTVBGqkHNjhPMkYs9krS3b9n7OVz3LONANA==
X-Received: by 2002:aed:2c87:: with SMTP id g7mr2422356qtd.52.1542730402507;
        Tue, 20 Nov 2018 08:13:22 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:4b6a])
        by smtp.gmail.com with ESMTPSA id r47sm28373586qtc.77.2018.11.20.08.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:13:21 -0800 (PST)
Date:   Tue, 20 Nov 2018 08:13:19 -0800
From:   Tejun Heo <tj@kernel.org>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH for-4.20-fixes] cgroup: fix CSS_TASK_ITER_PROCS
Message-ID: <20181120161319.GR2509588@devbig004.ftw2.facebook.com>
References: <fdb057a2-342a-d49e-587a-f1ca8680033e@gmail.com>
 <20181108201515.GC2509588@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108201515.GC2509588@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 12:15:15PM -0800, Tejun Heo wrote:
> CSS_TASK_ITER_PROCS implements process-only iteration by making
> css_task_iter_advance() skip tasks which aren't threadgroup leaders;
> however, when an iteration is started css_task_iter_start() calls the
> inner helper function css_task_iter_advance_css_set() instead of
> css_task_iter_advance().  As the helper doesn't have the skip logic,
> when the first task to visit is a non-leader thread, it doesn't get
> skipped correctly as shown in the following example.

Applied to cgroup/for-4.20-fixes.

Thanks.

-- 
tejun
