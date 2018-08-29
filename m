Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CCEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD9E2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD9E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbeH2EaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:30:22 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45927 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeH2EaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:30:22 -0400
Received: by mail-oi0-f67.google.com with SMTP id t68-v6so6128282oie.12;
        Tue, 28 Aug 2018 17:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IMfiBKdFMuNNnugwJzProl6/I0/rCr4H6I5x1ilqA3w=;
        b=HWN1ecXKwSTxtoAaT3AYZS6neje4wKu+8c/UpwZfW93gxjt33NZqfNqje2q2AKxN9q
         WEUbov8qXVSj/MVTnfoWZzWs71OviIOHnvBzbB/Wnxe0FF1CszsqXLgSSqkpClRVlmlB
         ZYeHtPr6MncE32xdBQMgVc71lWW0jr0zY7jiqva1zinoMcVKbq9UCd+3JYEb302gmh4O
         DjOw77k2IdqJrsu1pi9TKdcFneA5WOSvOkeATIKfKzyDmB4uW420mIAJfHK06GQhYelX
         Mlcqim0nCyxnyPwHmOCgh7ghbTMyQnnPSpCaBNf6BoZMUJX6fDWnKaOjn+8JUvkqgdSH
         6MXA==
X-Gm-Message-State: APzg51AuxyZBEQK54eGctMiTKpMMRKZPdn7V15H/FfrbqkCo3OxcDwhw
        GdBUZQAL7ZseAYz5ORf7pw==
X-Google-Smtp-Source: ANB0VdYIgUEhBY95bAkR3SIFc99j7opAQxycIhHwxeN4JSKVj36aO19AHH5toSrLBB4OyG2LshKicg==
X-Received: by 2002:aca:4aca:: with SMTP id x193-v6mr472225oia.211.1535502971368;
        Tue, 28 Aug 2018 17:36:11 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 22-v6sm1254401oix.58.2018.08.28.17.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 17:36:10 -0700 (PDT)
Date:   Tue, 28 Aug 2018 19:36:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 3/4] dt-bindings: clock: Add jz4725b-cgu.h header
Message-ID: <20180829003610.GA23941@bogus>
References: <20180823131744.744-1-paul@crapouillou.net>
 <20180823131744.744-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823131744.744-3-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2018 15:17:43 +0200, Paul Cercueil wrote:
> This will be used from the devicetree bindings to specify the clocks
> that should be obtained from the jz4725b-cgu driver.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     No change
> 
>  include/dt-bindings/clock/jz4725b-cgu.h | 35 +++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 include/dt-bindings/clock/jz4725b-cgu.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
