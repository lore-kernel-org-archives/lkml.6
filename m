Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897BAECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31122214AB
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Y4N1B7Lj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31122214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbeIWTxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 15:53:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35529 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeIWTxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 15:53:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10-v6so15950352ljg.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 06:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KKXqgeDuFIjHB9tsgiErsxirg35amaW8bpsqzHroHwg=;
        b=Y4N1B7Ljm10RLCsQdrMj1JgyL8pDmcMf4A54o9HakO5YqpUPh2bGp0uYhWnthr52DC
         M9hbNq//+xIh3qCBSXRo6gQC4LYZusGrBjK4zC6rHUV7jkSEvEw9T4Z6qjMNnmTwq7bw
         ubPUk0v3ZWXUEHqjo3vXMg4IMYjU+gsjGRJUp79g5sPxgrtTPAZXL0HDmVx8gP3X2AYC
         6dnzaK10pRGszOzE9xZtArvzb9ST45TKCO939nUbBuADECNlHzzjZ0XEAzEFn6y9PaQX
         83R8dL/aSOnmBkU2lKuNI2DwcTdd29zJ+s5QRl7wKFOUAMP9bGUKJt+cbkHwN9FyUpao
         wwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KKXqgeDuFIjHB9tsgiErsxirg35amaW8bpsqzHroHwg=;
        b=oX3gwsB928AZO8YuKnPPY4y+bxCptyVl5Wzzaf9MskP5EDfqtYaRjo1vOMr4WAhvb6
         7LlBPuqQ6mJ9Tq7uBIvPLDCEVYSsvW2S9054zjS0OKWYVK7H+XeD15I+CVcYHfPMvONF
         hQ3687A1Ku0P4rTCgA22lBfggCvZ8Trx7QdTzONDulR6vm3DD5i24y6M171kqSUHKJFd
         iFcz/OI53rFB05jXHsU5365Mq5XF2xXlW63EEim6OYH9+/CbIa4pYZKnIloFPMmhXQID
         8ioaWHjVfjtlwPziDV317LV2l8QAn68ZGEzqXWJCfsxaRBvNse+3UiGd//537burU5fm
         mSag==
X-Gm-Message-State: ABuFfojt4Yz8JgnBax94s4qHLTZT0iNIgtT6qI96CJ3hkyxq7J7yxU2w
        UWAABod4cUt1DUp1rnZcCC0hbA==
X-Google-Smtp-Source: ACcGV60eP7QOehTBhiL0aV16+Fs8ODKdJvNKQuvHPtrSHqr9354eBoUMlnsjM5HDoX2kvmsw9HwFkA==
X-Received: by 2002:a2e:6301:: with SMTP id x1-v6mr8422043ljb.9.1537710933085;
        Sun, 23 Sep 2018 06:55:33 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id f74-v6sm3302238lfg.61.2018.09.23.06.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 06:55:31 -0700 (PDT)
Date:   Sun, 23 Sep 2018 06:47:42 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 2/2] ARM: dts: exynos: DT for v4.20 (or 5.0)
Message-ID: <20180923134742.pugsdeozfp3lp56a@localhost>
References: <20180921174520.9126-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921174520.9126-1-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 21, 2018 at 07:45:19PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Nothing special, description in tag.

Hmm. Point 12 is special, I'd say.

I commented on the patch, and I don't want to hold everything else up so it
might make sense to separate that out and send a fresh pull request with the
base material while that part is discussed a bit more.


-Olof

