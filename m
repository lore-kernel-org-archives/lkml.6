Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BA0C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C655B21736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z75bsn59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfA1HWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:22:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40400 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfA1HWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:22:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so16776682wrt.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 23:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=H8eWfSaO4Xwlzv2KBCcLMhFKoVG7eT7Nv2Cq6gg9n9g=;
        b=Z75bsn59pHWAu+WyYp/dNmfeg5UnFzDIi5gdbs8gxvbaAEVemQejKzKi+lmTw8/5+F
         T2xQct0eIWucru56aD9gCC3FeoLoIgY3wPk9/msegsJ+HHZTCzeuRbOS5/oLujM1eHh9
         47Tvc4PV56bEYhI/nfoYgXcubsh0NLV/LXtIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H8eWfSaO4Xwlzv2KBCcLMhFKoVG7eT7Nv2Cq6gg9n9g=;
        b=e+uNfuJUeLXwMsqzoIOp8xnHYbNhsXpcm2ooWOXyM4qcnZot+B4Awkni41AI7GpgPC
         1ubjrrmDb6dWYyapYHAOZm6AO6LKD7/r+G6DNVMuSlOPDmnDYrQzUyOYFd2Mre/Huqqd
         ILbLSFmrJe46miuUg10ch+XU86OuYu0B3mGA2HNdHk6ZcjqCLOBWPSKahq6X9qUuOD9t
         CKFCMGoRrvz12Bb+Noeuwc1r/Git57fs1iApmu3fA50ApggkB2kpkyZlbFtFJn1oBsI+
         02oPap8hr9eai+2MbQEhMUrKjltd0qY1qu1qlO0pHVXAIoDuloubi+RYuwOpVPMWVMOp
         /xNQ==
X-Gm-Message-State: AJcUukfv1wWranLzCsGtIQBv4w7RHCis+Q6dCYO/Ljup76ggf+pxfshG
        vNK0MXXYDs8G0M7cOAXYGd1S6Q==
X-Google-Smtp-Source: ALg8bN5D1tAYw3VCtjeo9PMKP7Igm4wthFOQiUMhZYV67mrDoq8FFZoF76lSnsxTskzBcsDNLDkynw==
X-Received: by 2002:adf:d089:: with SMTP id y9mr21147633wrh.22.1548660118503;
        Sun, 27 Jan 2019 23:21:58 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id a12sm100095355wrm.45.2019.01.27.23.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 23:21:57 -0800 (PST)
Date:   Mon, 28 Jan 2019 07:21:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-next@vger.kernel.org, linux-acpi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [for next][PATCH 1/2] mfd: Fix unmet dependency warning for
 MFD_TPS68470
Message-ID: <20190128072156.GE4678@dell>
References: <20190121231958.28255-1-okaya@kernel.org>
 <2222147.2pZxjFhHIY@aspire.rjw.lan>
 <f4bc6037-7c0f-f053-a150-8ae6f683b1bc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4bc6037-7c0f-f053-a150-8ae6f683b1bc@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019, Sinan Kaya wrote:

> On 1/24/2019 5:51 AM, Rafael J. Wysocki wrote:
> > Is anyone taking this or should I?
> 
> Nobody replied to this yet. I was hoping this series to go through acpi
> tree like the rest of the other fixes.

[post-vacation reply]

That's not how these things are usually handled, but I taking into
consideration the trivialises of the patch, I don't really mind.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
