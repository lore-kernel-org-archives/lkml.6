Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C492FC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858DC2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858DC2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeHaQ1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:27:33 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45438 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbeHaQ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:27:33 -0400
Received: by mail-qt0-f196.google.com with SMTP id g44-v6so14190700qtb.12;
        Fri, 31 Aug 2018 05:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nXwabNGaR94AA1q5ca2PjAxdR5LHsdxSKM6U+fNutcA=;
        b=CGJRa2o79dbZ2s/ZWprlxAcsabxxRaveEVmH+a9WiYHJ7PwYiOFjMqohdrFROGFZp9
         jn6f8xYr960fa+vooGsnbxBMkyaeOMT27bERijJPeMP7JKVHOdPZobHLtNVYra3p4Ayq
         UgYGjusKURi3p5NDSrZPZ/pASuQBr9LHUkGJ0T0YOw3OJfhbl97KMK5AM5Bv+IyLlsbO
         J9lt45P+mvs9CDjbS+qYUUf5Cb3yCi66F9IsQLa8ZPry2d0PhReygi3K/KOZF/2TOuV0
         zU+ViJTx8HwRVVgyatKzU9HDunvwxebbaNxev0uuH7RUr5bM+eKdG+lB1zxr+Cu0MMon
         i5ag==
X-Gm-Message-State: APzg51CXx4QfNleo/+MYp1n3tymga1HF/7TSDOG1HWTqo0BgzoZjcg8J
        u1s6SbxcrWXoduAqjw5z+w==
X-Google-Smtp-Source: ANB0VdZ6IuVkXQveK0F5kSqwHjrnF0TP8u58pKprJeb2Aose+iaBlQ8sP8ZPXppfnsod/XnwT6WTnw==
X-Received: by 2002:aed:2f45:: with SMTP id l63-v6mr15857587qtd.267.1535718018285;
        Fri, 31 Aug 2018 05:20:18 -0700 (PDT)
Received: from localhost (mobile-166-170-28-234.mycingular.net. [166.170.28.234])
        by smtp.gmail.com with ESMTPSA id z123-v6sm5448597qke.68.2018.08.31.05.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 05:20:17 -0700 (PDT)
Date:   Fri, 31 Aug 2018 08:20:15 -0400
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] dt-bindings: dmaengine: usb-dmac: Add binding for
 r8a774a1
Message-ID: <20180831122015.GA25885@bogus>
References: <1535097375-5561-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1535097375-5561-5-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535097375-5561-5-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 08:56:13 +0100, Fabrizio Castro wrote:
> From: Biju Das <biju.das@bp.renesas.com>
> 
> This patch adds binding for r8a774a1 (RZ/G2M).
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
