Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82770C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366592081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366592081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeJaGlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:41:44 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39650 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeJaGlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:41:44 -0400
Received: by mail-oi1-f195.google.com with SMTP id e3-v6so11866737oiy.6;
        Tue, 30 Oct 2018 14:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yPYyFjH2r9KpJWo3TYxktv0S7LP2BThQhN5BGpLDqYc=;
        b=jmYOisGPirlPXbdtUWQ5iDPUxZfOw1L0QFybLMG1jsgFhb9+T9LKg6srCH9wQ75b8r
         miFlCjynSc6CHZKSpuV0ZbTlPZwnOcjaVGJHstCDHTtGBHGr03DebWrD2QtKzFhryY1+
         NIQgVEv7JCn6MiocWQFqrqkdIXVjbMqH4TsHCo0s/t5dbE2BCDWc41K+lFdtqWW6YKbR
         pk0R4WZ9H2hcvrBQadPiNj0yO9UgdDu3aiWVy13Fs/FMuNxYm57203imzKP/4brhs3a0
         uTAyuV5UTkToG/FtW5oBcVC2Zk8ttRafBcXdKtenFpekc/zlUbCthje91bC4Gybc2o8E
         xYvQ==
X-Gm-Message-State: AGRZ1gIM1C+pNYQs1oXj117X9xzixlDDDUQEXKNfPHy2dpGLbtUqib3t
        wbjfHZC0iu7D72oLc24fTg==
X-Google-Smtp-Source: AJdET5dUx2aDQGNEqB7jXQqHDcEKwbknqkrYj3jvex3IzSAJp5KwnJcda/sugADISbX17ePELPnPTw==
X-Received: by 2002:aca:e84d:: with SMTP id f74-v6mr268053oih.87.1540935993310;
        Tue, 30 Oct 2018 14:46:33 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v10sm2275936otk.11.2018.10.30.14.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 14:46:32 -0700 (PDT)
Date:   Tue, 30 Oct 2018 16:46:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        yamada.masahiro@socionext.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org, masami.hiramatsu@linaro.org,
        jaswinder.singh@linaro.org, linux-kernel@vger.kernel.org,
        hayashibara.keiji@socionext.com
Subject: Re: [PATCH v2 2/2] spi: uniphier: re-add addressing properties
Message-ID: <20181030214631.GA16773@bogus>
References: <1540533525-1816-1-git-send-email-hayashibara.keiji@socionext.com>
 <1540533525-1816-3-git-send-email-hayashibara.keiji@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540533525-1816-3-git-send-email-hayashibara.keiji@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2018 14:58:45 +0900, Keiji Hayashibara wrote:
> In commit 7662d1dc17d4 ("spi: uniphier: fix incorrect property items")
> addressing properties of #address-cells and #size-cells were removed.
> Since it is not necessary to remove them, they are back again.
> 
> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-uniphier.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
