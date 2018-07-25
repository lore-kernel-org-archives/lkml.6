Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFA1C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6404120844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6404120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbeGYUWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:22:32 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53935 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbeGYUWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:22:32 -0400
Received: by mail-it0-f65.google.com with SMTP id 72-v6so10252974itw.3;
        Wed, 25 Jul 2018 12:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YNi2CoT+YJmkW/WdGVF5eOwy/gh3AFH+KB8FqTITHVI=;
        b=dgKRGB+yD/3eYVSSdFotuRy0wHEmYIIackfABZHJk1E/9Qsj7gKHmVc9H+Z99b4ILR
         YFlzD/G/zudFGkxzyDgBb+qX5hDxaGakTbzHhgz69sdw6Tzc1F1RnjT6Z3491uRtQE/4
         +KvL3rz3nV/SuvJtE1kn/azj9z+ByiobKcLfMhYCM4W1gOeTg09HEFGhW0KFHeHyJfOR
         9RbnN32NKuSzotpADpomFBkjK+rL59/TVeoz/xPVJauAh60qNJanN1EfhNB+e+y33uAf
         FBobgwNq0H57kXqnbuv/ypR1sr2xpT/U/KWF8EQ42YJ89E4CKcrzbY2k1WGN+6KYKLL7
         ecZw==
X-Gm-Message-State: AOUpUlGkryCpFsbUk1oO+/vE7RetkNeu02X0q3s4btiOpyauqKccCoN8
        ldnmxbANS9I6Z4mQVgfE9A==
X-Google-Smtp-Source: AAOMgpfIw8b1pbGo6NAHOXjyLr3gwF5Be//LnHPTM2cWspd4WyVecPtYZ/S/tcNHIrNN7DEiA4yn2g==
X-Received: by 2002:a24:9cc7:: with SMTP id b190-v6mr7660370ite.118.1532545772060;
        Wed, 25 Jul 2018 12:09:32 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id j126-v6sm963258ioe.17.2018.07.25.12.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 12:09:31 -0700 (PDT)
Date:   Wed, 25 Jul 2018 13:09:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/16] dt-bindings: clk: at91: Document new PMC binding
Message-ID: <20180725190930.GA27482@rob-hp-laptop>
References: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
 <20180717222757.10253-9-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717222757.10253-9-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 12:27:49AM +0200, Alexandre Belloni wrote:
> Document the new PMC binding with only one PMC node for all the PMC clocks
> instead of one node per clock as this proved to be problematic.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../devicetree/bindings/clock/at91-clock.txt  | 523 +-----------------
>  1 file changed, 21 insertions(+), 502 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
