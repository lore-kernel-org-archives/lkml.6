Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062F3C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC3B21502
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC3B21502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389864AbeHGRQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:16:14 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:32979 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733213AbeHGRQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:16:14 -0400
Received: by mail-io0-f195.google.com with SMTP id z20-v6so14275698iol.0;
        Tue, 07 Aug 2018 08:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2bfpvkev53o9yaQQ9M/RxMH9P5Wk+KrNDI7wCnruyCI=;
        b=qFZj/m1HirzR3rLg2iZZffSGjkQbSNjWaKBplRsbg3j3uSzBOBNOvBNg4S3DIaGMG+
         yQHvbRxqWx9fL/9JWgJ7Vf1AoQFNnULouvI1fzIYeIzlRJNHknNITprsXwv8sQpRlPWW
         IkACK9kgz1uth5I21Y4J/ccjgOe670zhrns6aFAbhPA6c8XI4Fsltc9JRLmKq5/YHE/9
         X+QuYxKueHsK3sU88oIMKotq2/1fX/VLMqarvcYyL4w9AeQ2MoWemtJsV+t7ZK7va+1m
         WvIpfcdIZtkRhGWPYKSsyQVJCEvd5iMJCxdaYxUtcHRhR2X3g73JxrZehInrkGZF66kU
         3xQg==
X-Gm-Message-State: AOUpUlG2oVVXo/M7iKtAxNMEhtm9zs3xmWSzCT0dXh6BUivdkJ+qbpbK
        AYe9Vd/dbFK2dn6VbuutYw==
X-Google-Smtp-Source: AA+uWPykaNvmyvc3jHpflAD0xYgGa7mWtrnlTVTYN0KZIC+effdXwuPbUjP7f4YXuLxmxFbtvMfobw==
X-Received: by 2002:a6b:9bd1:: with SMTP id d200-v6mr20540129ioe.147.1533654090218;
        Tue, 07 Aug 2018 08:01:30 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id l10-v6sm913816itb.27.2018.08.07.08.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 08:01:29 -0700 (PDT)
Date:   Tue, 7 Aug 2018 09:01:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Vinod Koul <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v4 01/18] doc: dt-bindings: jz4780-dma: Update bindings
 to reflect driver changes
Message-ID: <20180807150129.GA9404@rob-hp-laptop>
References: <20180807114218.20091-1-paul@crapouillou.net>
 <20180807114218.20091-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807114218.20091-2-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 01:42:01PM +0200, Paul Cercueil wrote:
> The driver now expects the devicetree to supply a second memory
> resource. This resource is mandatory on the newly supported SoCs.
> For the JZ4780, new devicetree code must also provide it, although the
> driver is still compatible with older devicetree binaries.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> ---
>  Documentation/devicetree/bindings/dma/jz4780-dma.txt | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Drop the 'doc: ' from the subject if you respin. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
