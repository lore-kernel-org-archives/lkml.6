Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9B8C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7582921742
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUYQkC3/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7582921742
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeHMQbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:31:07 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41737 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbeHMQbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:31:07 -0400
Received: by mail-yw1-f66.google.com with SMTP id q129-v6so13563002ywg.8;
        Mon, 13 Aug 2018 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3fY520pK3MVFPuA8Ln4OHGZP00waF5d15Pwyeg+Ytn8=;
        b=hUYQkC3/S6+l5kvwBkMQDaPxUkwku2LiPeZqhpuv27PCvmRd/HvWPkoNCPx3mlaaRn
         7kkcZ6y1BMtfKlLGxjbJhKkpMwMio50GAcDr1K6lVdYStKqRCeLBG37psUDU++4ukXaY
         aF0nvgCvh42hC5SQQlzl8p7SdSQdTflDV73lrNI1MnFK0pJHgHNI0ob3MPjkozhatKgG
         pMg6KmmuveUEn91JRzGLcyocX7JG8rGRf9PDNup5E+FedYFigwatgPook4jRvRNCiZff
         lPYSZSLEIOAiDgD1x2nunW59dJPmnnh9NO54bEnEO5aYaaBiXzVyu0Z4Qo0P3j81eaiN
         UzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3fY520pK3MVFPuA8Ln4OHGZP00waF5d15Pwyeg+Ytn8=;
        b=fVSwIBxfYAM0BadNssxKWtYieP9PwL8Ta2gstrBuKxFv0EGCQCsiZ4gZh/yGKqOc/9
         G61JwNWAVHwhYnUT9x3YPhqRqktsViEZ6aVOkHu0VSXZU+L/gQp29GAseCK0cYJ/4nWC
         vfmYKdXXX0WId9kuK4dL4ldbsL34V+Kt6AFduYqR3Mo7DrzJIv1ayFykAE5zjr8HCXoi
         ouQafYh1t28Qo52PgOblCRk1VBe6NBckl0WBn+zH1verT4DjfyQl40srqTtPPjz3Ic5b
         tIUnWdOPwr1jx/08f0SYEWYWrXEuMNbDboKeacNb6xOP+oX9MByE+oufnZDE+974toi1
         Jg3Q==
X-Gm-Message-State: AOUpUlE1kxoyLWHDYINQMLkYu5I4E/ekjJ3pq+pS/uH+wvfg/RG8yKDd
        hNGtxVdRI3n9rMv8fjmC8NY=
X-Google-Smtp-Source: AA+uWPyNFMFX7TrAGbLsQwU/9p6gpyQGiRNZFREbhbEMiVPqvgTOtzny5iqp/1ZCKHDbeaC9I1REIQ==
X-Received: by 2002:a0d:f443:: with SMTP id d64-v6mr8913189ywf.461.1534168125285;
        Mon, 13 Aug 2018 06:48:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:6555])
        by smtp.gmail.com with ESMTPSA id b6-v6sm8662533ywb.78.2018.08.13.06.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 06:48:44 -0700 (PDT)
Date:   Mon, 13 Aug 2018 06:48:42 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH RFC 1/3] cgroup: list all subsystem states in debugfs
 files
Message-ID: <20180813134842.GF3978217@devbig004.ftw2.facebook.com>
References: <153414348591.737150.14229960913953276515.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153414348591.737150.14229960913953276515.stgit@buzz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Konstantin.

On Mon, Aug 13, 2018 at 09:58:05AM +0300, Konstantin Khlebnikov wrote:
> After removing cgroup subsystem state could leak or live in background
> forever because it is pinned by some reference. For example memory cgroup
> could be pinned by pages in cache or tmpfs.
> 
> This patch adds common debugfs interface for listing basic state for each
> controller. Controller could define callback for dumping own attributes.
> 
> In file /sys/kernel/debug/cgroup/<controller> each line shows state in
> format: <common_attr>=<value>... [-- <controller_attr>=<value>... ]

Seems pretty useful to me.  Roman, Johannes, what do you guys think?

Thanks.

-- 
tejun
