Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3540FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14AE2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550868080;
	bh=TQDPPNfDVNNt2lGJt94RG5qwxmw51YpufJJsaRxUgso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RrKSj+t9NA01mws0R7nLy8QLEIFBOeDB8qjksbtti8OXOxFyIB/5kQHc4On5fiTZq
	 KB7pgOYNUE9sisq/i24/kY68fYyiugH4zTz/dntyYuJKW6D7EKB7dMTwyLf4odi/AV
	 VFiNtUojNTQzq00y7rF4uqrXHq1wUCo7KdY+3DI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfBVUlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:41:18 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39246 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVUlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:41:18 -0500
Received: by mail-ot1-f68.google.com with SMTP id n8so2995553otl.6;
        Fri, 22 Feb 2019 12:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3+gCNdMA0pa6pnYLwz1SdMO+iPmhzsS3hSVhIJ8YpgU=;
        b=boAGBMI/0F954v0uAYmy8maUIvChDjFU4v3U/FTXEwLd7tciX0JMN5pdyj/9IzzbST
         jtl36y2huvuqIfAohCQYTpojVPPJEfTkKd4Ah1DvatfiNzdVU2y2A7CumU6Gn0Sro7Ic
         53JgyyritIBx78jBG9+wID+5DkzsHcrWi9L7NeWaPoBAcWlEhH4X+PFab8XIMd8lKQEH
         FWTwaRf0v6UlUtKbyme5IztSwd2QWQArVMbQPlt4qfqcShrFbqoYwgJEUdCKd8p18E4Z
         3lSslQeU6o0fmczp7rOLnwS7MgH7PLGO7bUOgflmAXTKF/yFSlbTS4JEvtiUbX/cNems
         Ho4w==
X-Gm-Message-State: AHQUAuYm7KlhAfRtSgVu4Bq1ZtZvn29XIKT9z3t2nky1pTBkwOv18JLU
        xbgmHryDU9LHkqhrxd4c7g==
X-Google-Smtp-Source: AHgI3Ibeg6o4/louD6BhwdNQigpsOTGtd2UDAEKCGh4dhyC6/WmltldZZjDh39Y7/Y6MlhcWAacOFQ==
X-Received: by 2002:a9d:4e8b:: with SMTP id v11mr3779521otk.316.1550868077377;
        Fri, 22 Feb 2019 12:41:17 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m89sm976461otc.7.2019.02.22.12.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:41:16 -0800 (PST)
Date:   Fri, 22 Feb 2019 14:41:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     michael.kao@mediatek.com
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Michael Kao <michael.kao@mediatek.com>
Subject: Re: [PATCH v2,6/7] dt-bindings: thermal: add binding document for
 mt8183 thermal controller
Message-ID: <20190222204116.GA25502@bogus>
References: <1550665893-22561-1-git-send-email-michael.kao@mediatek.com>
 <1550665893-22561-7-git-send-email-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550665893-22561-7-git-send-email-michael.kao@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 20:31:32 +0800, <michael.kao@mediatek.com> wrote:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> This patch adds binding document for mt8183 thermal controller.
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
