Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C111C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FC5218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="hz72O9Y3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfBFObV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:31:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37089 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfBFObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:31:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id c8so979341wrs.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 06:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aCkiqYNvxX1a9nJPU/Nbyv1sM4Ffext0Xrvmi7ouJ9w=;
        b=hz72O9Y3uWIkSfq8uoOTQBadfjKQoIu+JKa5XW82YFIX8YDAvNP66Bge7LiyeLclz6
         iPBBiywri00HnOkmsvfIc/NksPb07HSk8jXer0XE78ZW8L7mFpxmioQ+3EfmHPNsJTF5
         JykLNcbGm7+TicqSMwxXi2uVkhSjTHKf3tRMBTcDtSC2qmmWv0LS2Ns9wLSFiI2qXghd
         i4EHmd1mj1w/ML9rhwhf4shb5qGzH76VAeA1OghmUVOb9Ttn6cUxUKMEv3kneBKuZvWh
         ffvmXiQLHx75vnbCqvd6U/66s1f1zBv9QW353zZVBTPVbgi1gEyY0r/2TMhKQhoHWj2f
         xmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aCkiqYNvxX1a9nJPU/Nbyv1sM4Ffext0Xrvmi7ouJ9w=;
        b=dYidU45vGV4o2XkWUdYVJQWU1xc1Y6FLrQt7JFae5TQePEHUlmbC97wo1X+pX+Ji9c
         objJUet6uTUXiz+mJAbA6tBg9X01gBSQyicir7hT/Q4hZa1SKXZpBCXt8SI7usdTKG3A
         Cqd9VkG/BokY7n+/Iq3LEhqmm+LssJjJAXmwKm3bvI3K5eFf8R6HeQ3cWxkKq2F/InJs
         +nZ5pB0m88kgkRnxqQ+Fp83vGIknpwtS5lejm2RrMcknfKwvHf/WKIbzr5S+4F6QJJU6
         sTYhPJ/rH7MjLhpRxFuZDLNzleLZg21H9WAo3hZvdDvT0PZWfWv8MuwyE7oVSCu5a2hX
         EgnQ==
X-Gm-Message-State: AHQUAubNT8EFzsjABjnaeoZcX+cPyBj/oLN/UMCXb7Aw74LVT4gh+7hK
        /8vRK68D+vrPlZ3IyRCV6r3jUg==
X-Google-Smtp-Source: AHgI3IZvsq1EoXr2gnMPF40TTTg0xT0XGzuZVgnw6PZBuXQ3W9wXhBIbgXA918f8ZY33SV3Qj5Sm9w==
X-Received: by 2002:adf:fac4:: with SMTP id a4mr2062624wrs.110.1549463479578;
        Wed, 06 Feb 2019 06:31:19 -0800 (PST)
Received: from localhost (p200300C44723CCF50E7AC8E3657171F5.dip0.t-ipconnect.de. [2003:c4:4723:ccf5:e7a:c8e3:6571:71f5])
        by smtp.gmail.com with ESMTPSA id h135sm24452892wmd.21.2019.02.06.06.31.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 06:31:18 -0800 (PST)
Date:   Wed, 6 Feb 2019 15:31:17 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v4] mm: Make memory.emin the baseline for utilisation
 determination
Message-ID: <20190206143117.GA30357@cmpxchg.org>
References: <20190129191525.GB10430@chrisdown.name>
 <20190201051810.GA18895@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201051810.GA18895@chrisdown.name>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 12:18:10AM -0500, Chris Down wrote:
> Roman points out that when when we do the low reclaim pass, we scale the
> reclaim pressure relative to position between 0 and the maximum
> protection threshold.
> 
> However, if the maximum protection is based on memory.elow, and
> memory.emin is above zero, this means we still may get binary behaviour
> on second-pass low reclaim. This is because we scale starting at 0, not
> starting at memory.emin, and since we don't scan at all below emin, we
> end up with cliff behaviour.
> 
> This should be a fairly uncommon case since usually we don't go into the
> second pass, but it makes sense to scale our low reclaim pressure
> starting at emin.
> 
> You can test this by catting two large sparse files, one in a cgroup
> with emin set to some moderate size compared to physical RAM, and
> another cgroup without any emin. In both cgroups, set an elow larger
> than 50% of physical RAM. The one with emin will have less page
> scanning, as reclaim pressure is lower.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Suggested-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: kernel-team@fb.com

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
