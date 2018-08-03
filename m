Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDB1C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38382174C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IOolczik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38382174C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732190AbeHCKfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:35:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36409 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeHCKfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:35:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so2883849pfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WWSBlAuFbBnurbwjNrZHI2QuBkFg3gAEOBUGtPctIxo=;
        b=IOolczikuxSZE4MtrRO8INR4C0IzehtLrJOBLVb42BJSDZOoGnk5dtZelQPmKVUdZ5
         2Cv2gCXx7SclNw72rQyJrdyg7Q20qZQNoS2qpXHg9gt/RHHGRySrxHcbIpWrJr2srhuW
         BhqvFqaprq7QgKU0vxApuW8GzvWojeHeagQRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WWSBlAuFbBnurbwjNrZHI2QuBkFg3gAEOBUGtPctIxo=;
        b=iZpEFbjOdcf0P0K9ypLlbO3fuNKyXswsOhvVqsO6bIkhpR2mb+BbUHaFxa0y4tbGSo
         oj3R4W5G9EUMrNzBhjmKa+kJRjDPf6M3TJiRogbw2x9SEuF35nCFi1Ex5s5w6vVKNc61
         VI03fNP+18aRXtZ5NAhh4COGyek5XSv5300EpN4VZaNrLTQnDD9DX5wuqhX9PWk2An4I
         TdqALQ9yX66drSdPlFSRQEkjScOlJgStSlJYSDh5an/OEt2jpcLFfUDyYNBRad+vZ6ka
         qsHx7gvuHNhA0Xva1GnAbVbTtoXpWVxBZ6ZkJ+db4zomk/KYTIakJqIve/WghAFTuffG
         Fquw==
X-Gm-Message-State: AOUpUlFxi9KkdPmJpY/wBcp6Uwr8iITN/kpRz5gMyHb4MFhpAiWXVhIu
        eXqeQ9lp4bzWS6XI/HiyNsxPRw==
X-Google-Smtp-Source: AAOMgpctuedWVa29CHv6j29/pGKJIwWp8I7IheoJF3U3BbyanzMIT7MuTQZr6xlZRmW/WS5smMHzlQ==
X-Received: by 2002:a62:bd4:: with SMTP id 81-v6mr3362216pfl.67.1533285604040;
        Fri, 03 Aug 2018 01:40:04 -0700 (PDT)
Received: from localhost ([122.172.85.89])
        by smtp.gmail.com with ESMTPSA id w72-v6sm11545143pfa.26.2018.08.03.01.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 01:40:03 -0700 (PDT)
Date:   Fri, 3 Aug 2018 14:10:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>, robh@kernel.org,
        Wei Xu <xuwei5@hisilicon.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] dt: thermal: Fix broken cooling-maps
Message-ID: <20180803084000.73ofs6cttnqc6uiq@vireshk-i7>
References: <cover.1530766981.git.viresh.kumar@linaro.org>
 <20180731045151.gqsgsm6l3gwr5m4z@vireshk-i7>
 <1533016858.2550.21.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533016858.2550.21.camel@intel.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-07-18, 14:00, Zhang Rui wrote:
> I suppose this patch should go via Eduardo' tree.
> Eduardo, can you please take a look at this patch set?

Zhang,

Since Eduardo isn't replying, will it be possible for you to pick it up as I
don't want to miss 4.19-rc1.

-- 
viresh
