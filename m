Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC255C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F4F21524
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F4F21524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389457AbeHGRLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:11:37 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51773 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732510AbeHGRLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:11:36 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so22425465itf.1;
        Tue, 07 Aug 2018 07:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KCaBC9LZ2zHHfhpLG7+1mO0FXFyjbroTTdJodgtQW5I=;
        b=szOr0obQMnWXyJsnpM/Trw86u3nc+6pK+7pqVIssLnukHku0qVSl0ExO7vfeeBc3WL
         gv3n5iPRdcWlyMYzvgwisRw7RR0ArW2K0abGHZ1tDEnS5POsdDapz+gg+rW8QxcQBXr3
         VIUWIWx9gIdUjKPxQBh9tbz4AuiAxhp1F9alFhv39Bgn4mfJ9A5+VrO5hMMwOcDjm1PF
         jpGyDGjZLj30C1CggxWr5o6FNBzcOnnhZ7vwEX80tN3d5onp3yO46oK/J+mBTuOVCEcU
         1Hyf7xAG62O4s76Teih6k2Gi4DNkMPQYBO1X89q/qfZM/CoAMJlADMkN6uezf3TUnL9t
         qD8g==
X-Gm-Message-State: AOUpUlGfh4uQVWZbXzFM00bFArPuae44NbeCBommhL9EsO4GtcVl+wGn
        8P4fJB0IkEzMOxU/7GS8tA==
X-Google-Smtp-Source: AA+uWPxAE6ExNr9JIi8d5pgsulqsmH1+Vb4cts/Kmh4nmE2KhTcB6i8H/6ymuYN8N/cj7NO/46WaeA==
X-Received: by 2002:a24:d30d:: with SMTP id n13-v6mr2261560itg.87.1533653814214;
        Tue, 07 Aug 2018 07:56:54 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id v5-v6sm481122ioe.61.2018.08.07.07.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 07:56:53 -0700 (PDT)
Date:   Tue, 7 Aug 2018 08:56:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        michal.simek@xilinx.com, bp@alien8.de, mchehab@kernel.org,
        mdf@kernel.org, edgar.iglesias@xilinx.com,
        shubhrajyoti.datta@xilinx.com, naga.sureshkumar.relli@xilinx.com,
        bharat.kumar.gogada@xilinx.com, stefan.krsmanovic@aggios.com,
        sgoud@xilinx.com, anirudh@xilinx.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt: bindings: Document ZynqMP DDRC in Synopsys
 documentation
Message-ID: <20180807145652.GA4106@rob-hp-laptop>
References: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
 <1533374735-16662-3-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533374735-16662-3-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 02:55:33PM +0530, Manish Narani wrote:
> This patch adds information of ZynqMP DDRC which reports the single bit
> errors that are corrected and the double bit errors that are detected.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../bindings/memory-controllers/synopsys.txt       | 27 ++++++++++++++++++----
>  1 file changed, 22 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
