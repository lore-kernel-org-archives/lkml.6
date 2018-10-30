Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CDAC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1CF20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NUIzE54u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1CF20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbeJ3Rhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:37:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34258 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeJ3Rhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:37:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id k1-v6so3869053pgq.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 01:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HsbqmeqUUHDCv80Vveurlt74J0GyQZi497CBzLmlGmw=;
        b=NUIzE54uGbhwaN0b3fKFPLGoZpiK6aL57jloxH85pjqljfK7ZWx/RifO2mU3V2w2WC
         meVzQDV/eNoZiTAYwLAAShyUH6tiEDAHeIioHmG1NWXx+5MNr32gSOrJfIehkOOUFEa7
         RCLT6LvsFzTqzeR/uYlP69RWim78Ymv9NrcYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HsbqmeqUUHDCv80Vveurlt74J0GyQZi497CBzLmlGmw=;
        b=W1RKvgcjz/rJZq/RCKNzp77B++BSniw/thgmV7f2xc4pBJZ0x5ttHYk8LmVs3R+HOq
         FcpvOdpKBUUM6qkt03EoHiHlXbLPvzUs52ed/FymNjIudYeKCipbSpxvfStH5/HfMFqO
         kpfzEbU4Vd+Iu0mbkW36Keg9exG+OeeciRkGu2Rh6/A3gZ5R6XsD/dcCmRJLxB+zos7t
         fRqv48jXcntTtST2jjSirqvXdr5Mp5bmRWW+Lvv1G9+VpmEB6ajLuuqLG3ZsAaWINY1a
         joYYuto1FVwENzYz+HySpGYW02OmIviUavLTn2aWB4x+01ZiEQN8Jqzw+N8iACcfBh+M
         PD4Q==
X-Gm-Message-State: AGRZ1gLFure8PL+2YlLv2VxBMxyEhYQSf1H3KilGZueatPpu/BtvRqdy
        JbPfcEnce/6USIyO4vJJvwh0Dw==
X-Google-Smtp-Source: AJdET5egeg2oOdQXgeYpYs2S6+atMHfXGmHTQRvmSQ491OUpv1ydepRo0biXK+cKZ2ncDBpX5sg76w==
X-Received: by 2002:a63:455e:: with SMTP id u30-v6mr17158007pgk.30.1540889105798;
        Tue, 30 Oct 2018 01:45:05 -0700 (PDT)
Received: from localhost ([171.61.116.174])
        by smtp.gmail.com with ESMTPSA id i2-v6sm22739161pgq.35.2018.10.30.01.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 01:45:05 -0700 (PDT)
Date:   Tue, 30 Oct 2018 14:15:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 4/4] base/drivers/topology: Default dmpis-mhz if they are
 not set in DT
Message-ID: <20181030084502.r4ksevjn6ilfpyb4@vireshk-i7>
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
 <1540830201-2947-4-git-send-email-daniel.lezcano@linaro.org>
 <20181030071313.rq2d4cmfrla5boc7@vireshk-i7>
 <39cacba7-07e7-b06b-1502-0dc4496c58a8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39cacba7-07e7-b06b-1502-0dc4496c58a8@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-10-18, 09:39, Daniel Lezcano wrote:
> SCHED_CAPACITY_SCALE is the default value in this file.
> 
> eg.
> 
> DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE
> ...
> pr_err("cpu_capacity: partial information: fallback to 1024 for all
> CPUs\n");
> ...
> 
> So I prefer to use the SCHED_CAPACITY_SCALE for consistency.

> Yes, it is the default behavior as stated in the documentation:
> 
> "capacity-dmips-mhz property is all-or-nothing: if it is specified for a
> cpu node, it has to be specified for every other cpu nodes, or the
> system will fall back to the default capacity value for every CPU."
> 
> and also in the error message:
> 
> pr_err("cpu_capacity: partial information: fallback to 1024 for all
> CPUs\n");

Okay.

-- 
viresh
