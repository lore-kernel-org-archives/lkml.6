Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF1DC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DBA20854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94DBA20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbeIJXOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:14:35 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38772 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeIJXOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:14:35 -0400
Received: by mail-oi0-f68.google.com with SMTP id x197-v6so42052630oix.5;
        Mon, 10 Sep 2018 11:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S33nWUg8CV1oc6NTRJOawkQ1nCnx3JYGc3IXR07efzU=;
        b=nBgtEyLDGpc1HT4vU5fvQ9DzzaWAwYwH49bsB+u8KE4GEuHhKVVDbNkf4F9jGIJSjy
         ghOvp2bbEtqovUzcx02Nug4/B+WPmHqn6hSyBavIUAGF/HW6yTqETrND7zVqk+o4LBJC
         OkKGND9VrwBNgqlR25AWzz/3KauLn4Iog8rAtWMHNQemYCgc9NdtWU0k/MRJWOGrtK43
         8OzpfMU0b2oxB7286pRv3LaQskc8wSMAJHPz0ybDfxYh8iLu3/pVI0W9qRQJPqWcRY/c
         kZZkbc+GnWFgQ0Cat5G1sGv9hJZV5iyNnWzkgFS/l7yoxiQDyoPQcfH4Dhav57AH5hUV
         a0IA==
X-Gm-Message-State: APzg51AJRwphfB9TjrYQbzQw5yQyW/LbUk7pOSfE/Z4Y9TOJ0622BTCJ
        HasYe0UK8wsYtUwGv8v84g==
X-Google-Smtp-Source: ANB0Vdbt9TlK5Jk2dI2q3MBUqRygx8ywZhO3L71HyBQaaPfW7EEkF34Gvi3bYWGyQSIAMp8NbvaLZQ==
X-Received: by 2002:aca:3357:: with SMTP id z84-v6mr21951034oiz.49.1536603554957;
        Mon, 10 Sep 2018 11:19:14 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p132-v6sm25051853oia.31.2018.09.10.11.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 11:19:14 -0700 (PDT)
Date:   Mon, 10 Sep 2018 13:19:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, appana.durga.rao@xilinx.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        radhey.shyam.pandey@xilinx.com,
        Andrea Merello <andrea.merello@gmail.com>
Subject: Re: [PATCH v5 3/7] dt-bindings: dmaengine: xilinx_dma: add optional
 xlnx,sg-length-width property
Message-ID: <20180910181913.GA13764@bogus>
References: <20180907062502.8241-1-andrea.merello@gmail.com>
 <20180907062502.8241-3-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907062502.8241-3-andrea.merello@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Sep 2018 08:24:58 +0200, Andrea Merello wrote:
> The width of the "length register" cannot be autodetected, and it is now
> specified with a DT property. Add documentation for it.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
> Changes in v2:
> 	- change property name
> 	- property is now optional
> 	- cc DT maintainer
> Changes in v3:
> 	- reword
> 	- cc DT maintainerS and ML
> Changes in v4:
> 	- specify the unit, the valid range and the default value
> Changes in v5:
> 	- commit message trivial fix
> 	- fix spaces before tab
> ---
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
