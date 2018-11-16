Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDD7C04EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713192087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713192087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbeKQJVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:21:54 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33049 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQJVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:21:54 -0500
Received: by mail-oi1-f194.google.com with SMTP id c206so15454939oib.0;
        Fri, 16 Nov 2018 15:07:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yA90HrzucEsXYbHaLwROgoEpClkp/PLx7/OAhqHHN8M=;
        b=cKdJTcn5qJK5qa5Sdc9CRva3+5QqLLQj7YW7CLskzOKqDPoC+3CnsjJq03aubh9YUH
         lw/Mr61fqZ56YG+ufzSrP84YUY6r2840HcgfsE6c5s8HaxfI3lCOuEGdZIkpmuoNNsmV
         0U0do7X/MkBGiVUkBFQNjoQ+MpAnIuRvdTJ7UHx1v7AQBQVl1zOSrAhyT8HKDUsuFH4F
         6Oj5HVh/Kr88p2kVrX0UDHZ50901KsElrCeWY4K4g6CZu5lJFCfeUtqsZjkxti4OCNR0
         c1WORoz7Fm9ti+mXmxUoKjqLLlJ5zdEFbqsS1ZcjDSpn89BPNzYuvGJHB8cbm7nKYzG2
         VTBg==
X-Gm-Message-State: AGRZ1gKamknmpOZ4WAbwSkelDUsQZaZ+JeIdGpg3qSi2RF48DXlG05NB
        VTnXNtgQXtn1L2Td5LbsaA==
X-Google-Smtp-Source: AJdET5egmCIYCQCHsIiA1mY51EDqQ8zWY7eVFBqV/Zn5rW2jJMTV/BCvGSFUT4NFXHXjd46gIg7f4A==
X-Received: by 2002:aca:390b:: with SMTP id g11-v6mr2165627oia.201.1542409655558;
        Fri, 16 Nov 2018 15:07:35 -0800 (PST)
Received: from localhost (mobile-166-173-57-127.mycingular.net. [166.173.57.127])
        by smtp.gmail.com with ESMTPSA id e42sm37102095oth.36.2018.11.16.15.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 15:07:34 -0800 (PST)
Date:   Fri, 16 Nov 2018 17:07:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     matthias.bgg@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, ck.hu@mediatek.com,
        p.zabel@pengutronix.de, airlied@linux.ie, mturquette@baylibre.com,
        sboyd@codeaurora.org, ulrich.hecht+renesas@gmail.com,
        laurent.pinchart@ideasonboard.com, matthias.bgg@gmail.com,
        sean.wang@mediatek.com, sean.wang@kernel.org,
        rdunlap@infradead.org, wens@csie.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v5 07/12] dt-bindings: clock: mediatek: delete mmsys
 clocks
Message-ID: <20181116230733.GA17794@bogus>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-8-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116125449.23581-8-matthias.bgg@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018 13:54:44 +0100, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> Some SoCs will now load the clock part of mmsys via
> a platform device from the dsiplay driver.
> Remove the compatible from the clock bindings description.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.txt        | 3 ---
>  1 file changed, 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
