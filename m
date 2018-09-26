Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA5AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4852154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D4852154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeI0Ev1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:51:27 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39430 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeI0Ev1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:51:27 -0400
Received: by mail-oi1-f194.google.com with SMTP id y81-v6so529891oia.6;
        Wed, 26 Sep 2018 15:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zHwM2nxCb9AvHJqxvm2FNd6KJNzgFm38TckTSvDYoEA=;
        b=QwxbhG1Yz2Irg9cvj9ctEFhxqyGYB195UPfaRVfCUUBgouKXiNg6led3fDBvBEbszi
         0aP5VQLg+rGtStHYfQMu8FtAIZGgjfK+d2iSEv2O+O2jjQdx7uEkp3Au4B7u7tQefXD3
         rW93va7OqEHJdK8Av3b+8U50GBpyeOFQM3vTTf8znq49yMKDvnUuzk9A/ocB9Y+Y6ENU
         wt9NtX8/IjxtHj4xIVyAxQ7oK3JIEbK7C/ambs/RjJ0BTwE7M2nATypFjoSoswXMvZdk
         rQC4/JcMMvfCnSp7msK+Y6EfZwxuXUO3ptb6vBX9USvBkjvgYTK9EGwMinQd6OaUX7hm
         OuBw==
X-Gm-Message-State: ABuFfoik6t+srB6jdBfHRc2Itf5udLn7EkuLaLtt+XPoUjO6dy3U3W0g
        fb9+gx+BgDHY5Ah1jLr9+w==
X-Google-Smtp-Source: ACcGV60qg5LBXBsK8hG5hLiJWkxKb07nBK9Q9tXjPUNGWWPem1AuUcTDwBpWjeQDTqZ2ObKMBJZ2Tw==
X-Received: by 2002:aca:e155:: with SMTP id y82-v6mr1839560oig.90.1538001377254;
        Wed, 26 Sep 2018 15:36:17 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x61-v6sm143577ota.39.2018.09.26.15.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 15:36:16 -0700 (PDT)
Date:   Wed, 26 Sep 2018 17:36:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: syna: add support for the AS370
  SoC
Message-ID: <20180926223616.GA26157@bogus>
References: <20180917160015.05a1fc5b@xhacker.debian>
 <20180917160211.7b1cd37d@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917160211.7b1cd37d@xhacker.debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2018 16:02:11 +0800, Jisheng Zhang wrote:
> The AS370 SoC is a new derivative of the berlin family. However, the
> SoC isn't named as berlin*.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  Documentation/devicetree/bindings/arm/syna.txt | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
