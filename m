Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7FDA3C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8852086D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8852086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934362AbeFKS0x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:26:53 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40714 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933758AbeFKS0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:26:50 -0400
Received: by mail-pf0-f195.google.com with SMTP id z24-v6so10674612pfe.7;
        Mon, 11 Jun 2018 11:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K+gdSqTAujuludx8vQ5vX0OOtXtzYNTdTnoED2rgchs=;
        b=CKoKXi237EHTQa1y+jUSymWYirHjGwKlV19dJM7i1kkvEjXiqcQl8HWA4KncWgmB7h
         6LDHaV6jEO0nAsodoIyjCb5nuaPLNw2HZJ+lTVusQkf7LxO035mWrnnKNtAjge9mgOyj
         R4fxYef3x+Vdzl9BpMWTccIMndnLouSD91ks2DuWGW0R7Ws018z9Bxu5Qoy4IdZXkCXQ
         wetIMRO3THjQj/LRw0Jw8qROI0WK4PgLfIj3jfsKvJK7WWj9QNuGe12GUWar0qUTSc//
         8gO8p/3szXGVfAD41Q0wkjUCCef3+/2SK18YX3UtVMODTQLueFxpBhwFeMzuIvKaGV2v
         NPIg==
X-Gm-Message-State: APt69E3jEBM+o4mfL3vZIm30fwinH3t9IGWtgll2Fd3q7aErIEIpmRsV
        2TFZrG0lAqlEwsygs+OZEiHX+ls=
X-Google-Smtp-Source: ADUXVKL3co4uTzfmAVPvOvYw6frId1kGANETGcpsItxS8iy9ZVuKxWWZ6zQSRIP/iHnV9JIVT3meSQ==
X-Received: by 2002:a62:6b06:: with SMTP id g6-v6mr322051pfc.96.1528741610334;
        Mon, 11 Jun 2018 11:26:50 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id x19-v6sm72284642pfi.5.2018.06.11.11.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 11:26:49 -0700 (PDT)
Date:   Mon, 11 Jun 2018 12:26:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt: bindings: tegra20-emc: Document interrupt
 property
Message-ID: <20180611182646.GA16835@rob-hp-laptop>
References: <20180603223654.23324-1-digetx@gmail.com>
 <20180603223654.23324-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180603223654.23324-2-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 01:36:50AM +0300, Dmitry Osipenko wrote:
> EMC has a dedicated interrupt that is used to notify about completion of
> HW operations. Document the interrupt property.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt        | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
