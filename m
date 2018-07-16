Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9A5ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC64208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC64208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbeGPPsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:48:23 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44677 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbeGPPsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:48:23 -0400
Received: by mail-oi0-f66.google.com with SMTP id s198-v6so75495509oih.11;
        Mon, 16 Jul 2018 08:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gRMAQj+aJRwnopcQOX1V+gMwZocMe5UDtASeixyQ554=;
        b=SQ+Lk9i50zgy2/7U5tKMTp7Q/gUXEAbMIkIhq401TY5lzOJQUaOXaqep5OPsSPIKTY
         FNKhNy0USvp9qZNVLj6m6j/IKoRqRBzMvwxGadqv/fhPk8Soz8Ma5e51mwz3J4gicDYx
         OPKHPZ/DzRJYCY91+j7jSUaeqk17uUU13koF0byKRblmzGlcO0tFgmPGbn2yOaONOx/I
         ZGwrC937xmXcx5bA/QIpCpKsgAQOfILb38Vx/qADMyxINL0CUlj+b52qhc95tKn+/Gwu
         cKl/7f0PldaDiI7KkUsY7SKKWZTOm8fxes0DvP3+5UgPy0LnrT0h1U8/MUH3NSL1WIRG
         omoA==
X-Gm-Message-State: AOUpUlG+2hymiPIISMEmX3JkxwHMkl4YZXzIeTUnH2f/SaXF/QuMM9T4
        Xky43sx8kgjmRg4GXWQfAA==
X-Google-Smtp-Source: AAOMgpdtqnHUBYsrhmimC/Vlbv0gQT+h42fEN5XupOBbpCzJ7EnUes2lo7FMhbgO1CmAd2y0g7jfTA==
X-Received: by 2002:aca:b207:: with SMTP id b7-v6mr17626622oif.148.1531754429119;
        Mon, 16 Jul 2018 08:20:29 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id l204-v6sm6011738oia.45.2018.07.16.08.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 08:20:28 -0700 (PDT)
Date:   Mon, 16 Jul 2018 09:20:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        sboyd@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux@cubietech.com, support@cubietech.com,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, darren@cubietech.com,
        jeff.chen@actions-semi.com, pn@denx.de, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mp-cs@actions-semi.com
Subject: Re: [PATCH v6 2/5] dt-bindings: clock: Add S700 support for Actions
 Semi Soc's
Message-ID: <20180716152027.GA28696@rob-hp-laptop>
References: <20180715203524.11948-1-sravanhome@gmail.com>
 <20180715203524.11948-3-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180715203524.11948-3-sravanhome@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 10:35:21PM +0200, Saravanan Sekar wrote:
> Add clock bindings constants for action S700
> Maintain common clock dt-bindings for Actions Semi SoC's
> S700 and S900.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  ...tions,s900-cmu.txt => actions,owl-cmu.txt} |  20 +--
>  include/dt-bindings/clock/actions,s700-cmu.h  | 118 ++++++++++++++++++
>  2 files changed, 129 insertions(+), 9 deletions(-)
>  rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,owl-cmu.txt} (68%)
>  create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h

Reviewed-by: Rob Herring <robh@kernel.org>

