Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFE2FA3758
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 10:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD75C20870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 10:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHMldbGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD75C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeG2MWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 08:22:05 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41509 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeG2MWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 08:22:05 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so16426871oiw.8;
        Sun, 29 Jul 2018 03:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=t4YKe8PI/APTpoq9R2skXAv8xWrHif4se99u244LeJc=;
        b=FHMldbGaxH6oujdARhMhgoY8MQMRHYpPVub7wrDQUkbkoQ4IPP5f2Q4iJGvFwJO3zE
         f4BDgiNRhqjxBBDyaVcyN4nSWv4bLsFvilEG7hfA5AXK0rcNXwLqdhjUrEyFDaIpgql8
         EdiAQPZcx5zdKvV92f3tK7mbivpLPtGlP4Uj3lPpDoaSl3WqSkPPcfL+87wneaqq2l3c
         5pisLTj/tl4KhANo3a80sCKIHku4jUsBFLHFmyxoi5ZgYqH48SW0w9fhnqThePw0fMdA
         8AMl/6qJWHNh050XUTgvT4puIVe/gmfF5CAwQlFNo3Hp4eVP0613QXkaIzwSkfFlas0v
         kg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=t4YKe8PI/APTpoq9R2skXAv8xWrHif4se99u244LeJc=;
        b=Nka3+4DSx5s8yJNe/euHf1nuxkUEN88EfUvrAwXQWd8sdTKdfoeOgu8buXCsiC1pEh
         jBssK45Az7ZUQyHEVVuMwUuf3tNlIPFOBAYlsfOuqwVJroNemrSVaSlT5KMpU4NtdRp3
         hj3TtLQIJtkHA3HPZdLcZXeM6+XlnrhEOy0J/cySyEiJPAOOigTvIl8jgRU6+p1ZsxkR
         nDKA79WtCvkZ1UzdnkeyqDzjvvo43SSsqCg6jQY8m1I+PArLgUBt/u1U2qdEy8RHUnhB
         d4U6B3X3prZOttPlsrTGguGWkblODyCdmFnFFQft/BFPVrurVqBj4m+UrLaUY/aOqE8n
         aNcA==
X-Gm-Message-State: AOUpUlF6Dq9fwBF0rNvAEcviBkB9IF7bX9ATxmvk1fhFEQbmYWRcmv61
        m+HHbah9TreR7n4SVZfch3tiLYSaJq9n73/4ypQ=
X-Google-Smtp-Source: AAOMgpd02D3cZM2rLfZIC8csa7pQ4gh/taYxHla3zr4OrgloQlgY3PV4mbhOC1HVGTj8o5/SNHPdbU8Au3jayD2pv5Q=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr12496670oia.154.1532861522898;
 Sun, 29 Jul 2018 03:52:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Sun, 29 Jul 2018 03:52:02
 -0700 (PDT)
In-Reply-To: <1532750217-8886-1-git-send-email-skannan@codeaurora.org>
References: <1532750217-8886-1-git-send-email-skannan@codeaurora.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 29 Jul 2018 12:52:02 +0200
X-Google-Sender-Auth: 5HdYuV8Q1APiPjBidqqM9hA5QjI
Message-ID: <CAJZ5v0grRtkm5mZto-UW3Dn=OnbAbBARyH12T22V5gZfSaV5dw@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: Generic cpufreq governor
To:     Saravana Kannan <skannan@codeaurora.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 5:56 AM, Saravana Kannan <skannan@codeaurora.org> wrote:
> Many CPU architectures have caches that can scale independent of the CPUs.
> Frequency scaling of the caches is necessary to make sure the cache is not
> a performance bottleneck that leads to poor performance and power. The same
> idea applies for RAM/DDR.
>
> To achieve this, this patch adds a generic devfreq governor that can listen
> to the frequency transitions of each CPU frequency domain and then adjusts
> the frequency of the cache (or any devfreq device) based on the frequency
> of the CPUs.
>
> To decide the frequency of the device, the governor does one of the
> following:
>
> * Uses a CPU frequency to device frequency mapping table
>   - Either one mapping table used for all CPU freq policies (typically used
>     for system with homogeneous cores/clusters that have the same OPPs.
>   - One mapping table per CPU freq policy (typically used for ASMP systems
>     with heterogeneous CPUs with different OPPs)
>
> OR
>
> * Scales the device frequency in proportion to the CPU frequency. So, if
>   the CPUs are running at their max frequency, the device runs at its max
>   frequency.  If the CPUs are running at their min frequency, the device
>   runs at its min frequency. And interpolated for frequencies in between.

While not having looked at the details of the patch yet, I would
change the name of the feature to "Generic cpufreq transition
governor" to make it somewhat less ambiguous.
