Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 29967C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D7320839
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D7320839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934258AbeFKSWs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:22:48 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:39889 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933481AbeFKSWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:22:45 -0400
Received: by mail-yw0-f195.google.com with SMTP id 81-v6so6632359ywb.6;
        Mon, 11 Jun 2018 11:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KUofI82ltsyfoFwT1WRZ8y+c7wJI6H6CQAZID4KzvcQ=;
        b=i975pS1E7k5jMtGAW0qfcPQa4wyt5zOjryOq+G1T4i+pFji72l0ya6HI7Ux/I9y6U5
         TpvoTLiphwaxss/EKwB+9BCGpyBxwhPBtxHN51teht9gfhN/plmKt/fgUKtvzIoYRnoY
         tVwUcLUbKLMF75gKSmKw3eVWb63wdGGj3GK/KvXZQkT+G8PYDU/M6rRholRzLr8XlNm3
         95M4IQ7uBd9voSTWiZUvGyaWcNOyXd+3HU39MrN/Ww/jisf8fSYI3gHyHc5pOwbamuav
         ygAdou7hdqrqpNylL/WFazkTKvSFXOmHOB2zoxF8eQ1pBA3ChrW5pPihcmzfmYsKk2UZ
         C/Cw==
X-Gm-Message-State: APt69E3DiXEjC1/uY8MQiOpwkkS2veQKRYPOEiS8Avxg4cVG7QcVh0kk
        uDwBZgpDhLYi4Q7fsA44qg==
X-Google-Smtp-Source: ADUXVKJKqG+j9TiL8qLjo8knseHEhaHXt3fscTbf6m2T3akK5ir6YnElV/S5MQZ/nS30I9/SUi7S1A==
X-Received: by 2002:a81:1c4:: with SMTP id 187-v6mr156126ywb.93.1528741365236;
        Mon, 11 Jun 2018 11:22:45 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id b68-v6sm7923418ywh.68.2018.06.11.11.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 11:22:44 -0700 (PDT)
Date:   Mon, 11 Jun 2018 12:22:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com,
        paul@pwsan.com, t-kristo@ti.com, mark.rutland@arm.com
Subject: Re: [PATCH v3 2/6] clk: ti: dra7: Add clkctrl clock data for the
 mcan clocks
Message-ID: <20180611182243.GA12727@rob-hp-laptop>
References: <20180606060826.14671-1-faiz_abbas@ti.com>
 <20180606060826.14671-3-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606060826.14671-3-faiz_abbas@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 11:38:22AM +0530, Faiz Abbas wrote:
> Add clkctrl data for the m_can clocks and register it within the
> clkctrl driver
> 
> CC: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/clk/ti/clk-7xx.c         | 1 +
>  include/dt-bindings/clock/dra7.h | 1 +

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 2 insertions(+)
> 
