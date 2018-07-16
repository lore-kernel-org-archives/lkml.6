Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651ECECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDE02083E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDE02083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbeGPQBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:01:37 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39391 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeGPQBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:01:37 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so75549329oib.6;
        Mon, 16 Jul 2018 08:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jAzXWU2Vkmg++WJE2ewZlLxbe3dQ2LUoXhhf3OWIhPY=;
        b=p3F9NEBrFVA/s6Py752CG77qNNRbsVrDwB0pSvyJJzeD0BiHikIXlhWwZb3B1IlQsG
         Rg9NL8Zvwc8Q5gX7kIP2J9ka/WI4N7+4YmMsnR+IgRVYkrcA+X+PJsXY9hNDld+Hvl8f
         0xXgoQszk4JeQuZN13mvGoFRxEBpL4IwXngE6O0zmaZCmoRA6mxv1ylPQz997w7TRvHU
         GPLVr6h/Xu11+T+FeFuCPHrBCxSiMef5uGyaUqS+p/KNJQMwnmKx+ab8ZQm/jEjay4iH
         Q4e8eq0Qg93Fow4FaGagH7J1iyKUwtACT/R0TfStYQGs9fmYIjfyd6uyGPkdh1qpfQ7t
         Xtmg==
X-Gm-Message-State: AOUpUlF8cBfnGXcplHXaPX1Ms43Pt0b/7psD2RfsTv89HPl1VEMFEbhm
        nshGYVQzBLFtZtk7tpCVZcNijWM=
X-Google-Smtp-Source: AAOMgpc3J6eKN0Dr5suEoRjixJxu0d8oALsz7CqwB9miUZuNSdPdarGCoYdRQzlwL1h1RFdi/azATg==
X-Received: by 2002:aca:d5cd:: with SMTP id m196-v6mr17504387oig.160.1531755220623;
        Mon, 16 Jul 2018 08:33:40 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id s127-v6sm30614461oif.52.2018.07.16.08.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 08:33:39 -0700 (PDT)
Date:   Mon, 16 Jul 2018 09:33:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luis Araneda <luaraneda@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] dt-bindings: xilinx: zynq: Improve boards
 description
Message-ID: <20180716153337.GA14237@rob-hp-laptop>
References: <20180712041024.20583-1-luaraneda@gmail.com>
 <20180712041024.20583-4-luaraneda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712041024.20583-4-luaraneda@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 12:10:21AM -0400, Luis Araneda wrote:
> Change the description of some boards to make it similar
> to the value of the model property from their respective
> device-tree, using the format "<manufacturer> <model>"
> 
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/xilinx.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
