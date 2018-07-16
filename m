Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25649ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A962098A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A962098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbeGPWcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 18:32:10 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45210 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbeGPWcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 18:32:10 -0400
Received: by mail-oi0-f67.google.com with SMTP id q11-v6so52200567oic.12;
        Mon, 16 Jul 2018 15:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rzC9AAxbNtMMgdy0IB+d06MxdFquzdPEU35oZUfyrys=;
        b=QFRxeC5Uiwn/3smjS8off8vCdP+dVHx9vOhsJynGZGkTs1hHmwNQ703V/vnJUKE/7O
         on7tu9zMm5jM4G3UcHNhcQyNugwiUFT4C9SdXqfRTMGfV83R7qV93sS528hgQHRAWmWO
         bGN6W0jLd9r42Pe+XTDEI6SouCij0vQb8+ahWBsQxdnwLfpzRofPBUcwXXsJoDUa39Zx
         kGSqlovAII5nwBLk1Eup6EnjWh6t9coaUTOzSpM6BpGRClxNbKkDwOy5LLP8BiuCRjxq
         y4T8IPWaAMef04OKvtooPbsti4g14lxaOeeSzT790bDSu/t1CowO6X9sMESOdaxwhJYe
         VV8A==
X-Gm-Message-State: AOUpUlFaroDX9Ns71c2a/Cgxp29lwh7jvZHkXGctc7cYyVi4f2Og8TY3
        X+GEIz3G2ctmMzAxb6Ag/A==
X-Google-Smtp-Source: AAOMgpe2OR5IwKoVyklkDg2tTgjTgUcq3C+GSKMFHeRtnw9cyV+rxbeNehck2bcUxwnfkZ9xAa48+w==
X-Received: by 2002:aca:c357:: with SMTP id t84-v6mr1244419oif.327.1531778566986;
        Mon, 16 Jul 2018 15:02:46 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id x5-v6sm15559646oix.3.2018.07.16.15.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 15:02:46 -0700 (PDT)
Date:   Mon, 16 Jul 2018 16:02:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, olof@lixom.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: thermal: Allow multiple devices to
 share cooling map
Message-ID: <20180716220245.GA20750@rob-hp-laptop>
References: <cover.1530766981.git.viresh.kumar@linaro.org>
 <bdd735da9a3c8159756b084ca96b555437057fa4.1530766981.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdd735da9a3c8159756b084ca96b555437057fa4.1530766981.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 10:39:23AM +0530, Viresh Kumar wrote:
> Allow cooling devices sharing same trip point with same contribution
> value to share the cooling map as well. Otherwise the same information
> will be duplicated for each device sharing the trip point.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
