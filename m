Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDEEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 04:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F9B205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 04:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VCyEPSCR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F9B205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbeJaNYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 09:24:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42318 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbeJaNYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 09:24:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id t6-v6so6613980plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 21:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AP5MKXk/53IpB8UH64SE7gzM72iQ/PrAUksIAac0HMQ=;
        b=VCyEPSCR9jvFJdqIVJRknQv1y6sQNtH3jXK5oqNIlBHB/KC0LlE99hwU1EHIMeUz6V
         V1cCOniRsqHb0CY0b//BDUEr5JXNb52AD7JNDh+tEMx/4nJq2BMLlfp36Pi/Osfv3+Gt
         DcH1UkGIGnFS3OiawJCP/xuo9mehSlsR0Rw90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AP5MKXk/53IpB8UH64SE7gzM72iQ/PrAUksIAac0HMQ=;
        b=eZy+dZyEt3ykdlHQQ60GLAkLWl70xLB0cWwPcME1xbfmBGD/2JmplFugTxHzvAJKjw
         Q+GHTFz/1atuBLpAuloddVgWTJaMcE1OYXT7RwElWPUtzzDfSHoXYY+sOANC/bFwB/RW
         kU/fnVgM50Yj6i8LOqhKvFRG/dwdoMTSaugNBXc/B3DrCkcXrrKttuS2Zxop9qcrOcdR
         A2RQaubYrPkNqWw8UMh7LCBsro/iveJP5If+SUF9SYhbSUITYMMAD/4+oLSwCr6tyJF4
         NspD0xlte/x1IGx2x0w0y6q3T7WS4tGG/Q/jYbjgN7bHdQMenE6tGikTn8E3aPCEySHt
         EKoA==
X-Gm-Message-State: AGRZ1gIYcsYpIQcA9fAqP7bh4CFGkiMNGNiJrSUjkvl40amvqXq9w9Tj
        GqEKcmJeIlcX7vkLbvt51ZqwmQ==
X-Google-Smtp-Source: AJdET5e7w4iST/D+i9R6bM+3jjzU3ZaVObVx3PkxT9qme61/qLU4PNt2WCV9CSHSZ8dPKwqIAWDIdQ==
X-Received: by 2002:a17:902:6ac4:: with SMTP id i4-v6mr1659875plt.153.1540960061731;
        Tue, 30 Oct 2018 21:27:41 -0700 (PDT)
Received: from localhost ([171.61.116.174])
        by smtp.gmail.com with ESMTPSA id m16-v6sm23698184pff.173.2018.10.30.21.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 21:27:40 -0700 (PDT)
Date:   Wed, 31 Oct 2018 09:57:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] base/drivers/arch_topology: Remove useless check
Message-ID: <20181031042737.ncpzf7unws4cjdis@vireshk-i7>
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
 <CAOh2x==y+7jEdC-3xpvhr6j+RTtXRwTnBFC2uRVUmuktbCvsKw@mail.gmail.com>
 <d689e382-e4f2-0b03-03a5-2ff4a6bb88bb@linaro.org>
 <20181030083308.5znognajpwjvdxfv@vireshk-i7>
 <318665ae-0852-1350-b43f-bbf929b1cb4f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <318665ae-0852-1350-b43f-bbf929b1cb4f@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-10-18, 14:35, Daniel Lezcano wrote:
> I'm wondering if having a statically per_cpu variable, even if it is not
> free at the end, isn't worth regarding the twisted code we end up with
> an allocation.

Maybe yeah.

-- 
viresh
