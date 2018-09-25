Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04FFC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EA820867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EA820867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeIZBTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:19:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34457 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeIZBTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:19:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id i12-v6so25653668otl.1;
        Tue, 25 Sep 2018 12:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sIsZiHs617Wh+D1iJdGQQbf9qhZk1690B91FcRWvdTc=;
        b=GSqFhzXb7McYFtdHEAvsxRKNlPrSoC7jXgwV0OtZN9uGoHkIsqSDINOTztnlNRkOlu
         7uI/cblGyiylpoxAGlrhmdq21qIK4rO63f/RZAfEISKeQ3cSPdNqw75D5YyadCfdSvbL
         jiaPqlcI1yIEDZwH89IViVzQBrEajsqcehj8Qlu38NNaUG6E0H6RuGH/eSf+vpXKiai7
         h7q+44SGTzqlCEtgo4bSLbzDFXP8HUWcTJ5EpJRBT4zxUKrpDFzjj18YlqIuEbekwHzr
         dK2fJjbgrUacbNtXwour4cvv+PgdGQyP/nYYE1iuDSfHIAJ/lu5MYGknI8aW1+snlnLA
         gqLg==
X-Gm-Message-State: ABuFfojrgU7Zoz/J6OLsIaD1T+nIusJUnOsfYCzToiKj9ygK1px7q5Sk
        yajjoRZMC3kdDcnwFBOmGQ==
X-Google-Smtp-Source: ACcGV60RwH5yrKNhXI45WBlcG/fKusEDz6KlbtmTd9AXhNfnFl/iwaSma8HOICRs8O0MYoVXgyywxA==
X-Received: by 2002:a9d:2dc8:: with SMTP id g66-v6mr1637450otb.311.1537902649222;
        Tue, 25 Sep 2018 12:10:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u17-v6sm1282723oia.43.2018.09.25.12.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 12:10:48 -0700 (PDT)
Date:   Tue, 25 Sep 2018 14:10:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux@armlinux.org.uk,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Guilherme =?iso-8859-1?B?Ry4gU2lt9WVz?= 
        <guilherme.simoes@lsitec.org.br>,
        Jon maddog Hall <jon.maddog.hall@gmail.com>,
        mkzuffo@lsi.usp.br,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        sboyd@kernel.org, mark.rutland@arm.com, linux@cubietech.com,
        support@cubietech.com, catalin.marinas@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        will.deacon@arm.com, thomas liau <thomas.liau@actions-semi.com>,
        darren@cubietech.com, jeff.chen@actions-semi.com, pn@denx.de,
        mp-cs@actions-semi.com,
        Laisa Costa - LSI-TEC <laisa.costa@lsitec.org.br>
Subject: Re: [PATCH v2 01/03] dt-bindings: clock: Add Clock Management Unit
 for Actions Semi S500 SoC
Message-ID: <20180925191047.GA14410@bogus>
References: <CADHB5bBkyE90LVrWjt0ziU+oe=4sc8G_513VGECc++6xQ2ACdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADHB5bBkyE90LVrWjt0ziU+oe=4sc8G_513VGECc++6xQ2ACdA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 12:36:36PM -0300, Edgar Bernardi Righi wrote:
> Add Clock Management Unit for Actions Semi S500 SoC. Dt-Bindings
> constants added.
> Tested on a Lemaker Guitar board.
> 
> Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
> 
> diff --git a/include/dt-bindings/clock/actions,s500-cmu.h
> b/include/dt-bindings/clock/actions,s500-cmu.h
> new file mode 100644
> index 000000000000..34e5849ffcf1
> --- /dev/null
> +++ b/include/dt-bindings/clock/actions,s500-cmu.h
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0+

Headers should be /* */ style comments.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +//
> +// Device Tree binding constants for Actions Semi S500 Clock Management Unit
> +//
> +// Copyright (c) 2014 Actions Semi Inc.
> +// Copyright (c) 2018 Linaro Ltd.
> +// Copyright (c) 2018 LSI-TEC - Caninos Loucos
