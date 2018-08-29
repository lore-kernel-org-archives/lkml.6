Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC26C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DF9205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DF9205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeH2EUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:20:50 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45872 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeH2EUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:20:50 -0400
Received: by mail-oi0-f65.google.com with SMTP id t68-v6so6099284oie.12;
        Tue, 28 Aug 2018 17:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kTjiQXr5neHj4ouEKwaqw3Pa840CXhtdfVJnmlpoXs8=;
        b=gR0aE/4wLem7gF9ZERAWXJj73dpNmpzoQcLb5OgZ/9Ly14ozlmjg5leGf/U3pVZkvY
         gHeR2raFjeDdoetONQRpfPWcV+qLUk9kWLXwwE85NVD0RrhecfBshyFFSBLffJIIBDQL
         /14LaHBZTTmTJwI28aMTZCG8OBhC9jx93Xr9HWFX9M0Y5uzPDsvQ1sR/WmXrIRhgPV7A
         YPN8h4a7YzCy6CZLxjNeuc0cPJkgUvdxC0e3pKfEEQ+RKerYQvBuUNGvuEErA+rKb28h
         Bg7Bi9qhCr+pQ0vDJUoCVsGsK/bugAHaVlCLeaaLw12RQJSYP1jvZ/zriQk0jCoLtnPK
         OGbQ==
X-Gm-Message-State: APzg51DJ64Hsfdr9X+JWHyazPgVmtcvP/jn7N4B7xuW/nr+x97gM/taO
        4pD74erxFGChqKfQoGWDJQ==
X-Google-Smtp-Source: ANB0VdYdVCKUWz4dZA/UM176HFt0vPl4E3Idc87qg70TG5MkdyrZNXWB/Cjd3xh6yvT+DBLYWJfDqg==
X-Received: by 2002:aca:4107:: with SMTP id o7-v6mr498046oia.76.1535502401483;
        Tue, 28 Aug 2018 17:26:41 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a144-v6sm3231182oii.30.2018.08.28.17.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 17:26:40 -0700 (PDT)
Date:   Tue, 28 Aug 2018 19:26:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH v3 2/2] dt-bindings/interrupt-controller: pdc: fix
 example to match actual bindings
Message-ID: <20180829002640.GA9822@bogus>
References: <20180824191111.14571-1-ilina@codeaurora.org>
 <20180824191111.14571-2-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824191111.14571-2-ilina@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 13:11:11 -0600, Lina Iyer wrote:
> The PDC map should use the GIC SPI port and not the vector. GIC
> internally adds 32 to SPI hwirq numbers.
> 
> Fixes: 1ae8862e27e ("dt-bindings/interrupt-controller: pdc: Describe PDC device binding")
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  .../devicetree/bindings/interrupt-controller/qcom,pdc.txt     | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
