Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2C6C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D6921904
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545338643;
	bh=Z5rOK3u6ymh9OW532rWSwHVNF0K+yfxQkXwvJ7jVE/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rpbe4psScFGLw5rg4dlX++B67oPIdo+1O8lbIWnB1DRuWR6zXEccQa73b1rRrVBcy
	 2DtR6ip0yYt6gNBkvu625UG0uB6nxi8vDE927hXrm8TvJyeoB0+x3JGeeTer9r12N6
	 aVOQcwIzd3hodGrCxQwUrovlxgzaA0t7BLIk0gZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733283AbeLTUoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:44:02 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40506 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730558AbeLTUoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:44:02 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so3174217oth.7;
        Thu, 20 Dec 2018 12:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EXWVS91ufBJJfiGUyJ5XnKh030tDRBDxANLyB1KtJw4=;
        b=nryqrxdRMhF4s/jFS5eGpT295Nj4WWcf8OnFVX6pGTI62nqblNYjhliu5y5r8RdRWP
         vahwrcJTwpsGcxT3FqhefSrFwbS7H2ZIUyrN2T8O3yrziUSG5ZowXO7QKy6BnkKCHdtt
         nSIVLm5hnKBUNtZai+OCLY13DlTqiCC90TreWL/mC49MO0c06wfx7fSo8Wq4NbdlYChk
         R/AoHkbFSLyNgadtaLMZa/NZZ2q8gaBqopw3I7i9VKdxspzTfk1aSiWny6Z90RMRkQWV
         8Hu/QyB4cPcb6z516XmL7pVl0uEayCErRd/Zi4i5j/cKmgFgPMBNo2TlhiMmqkV1V+OE
         iymg==
X-Gm-Message-State: AA+aEWYlFxE2uMj+eN1soWppq+kR/S/ck0C7z+D5mNVwpnhtoH1yA30i
        dsrUp2IjEg7s6B37Lunz7A==
X-Google-Smtp-Source: AFSGD/VXe0MhHlsYdG17qfGX5cvIdirTzp/umiPaI7RmnuoamVBohj2bxUJpJOAUvGWmHALBR5IOyg==
X-Received: by 2002:a9d:65c8:: with SMTP id z8mr19516975oth.338.1545338640975;
        Thu, 20 Dec 2018 12:44:00 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id k11sm10648077oib.35.2018.12.20.12.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:44:00 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:43:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: Re: [resend PATCH v1 1/2] dt-bindings: clock: add clock for MT2712
Message-ID: <20181220204359.GA30122@bogus>
References: <20181214020417.2871-1-weiyi.lu@mediatek.com>
 <20181214020417.2871-3-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214020417.2871-3-weiyi.lu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018 10:04:16 +0800, Weiyi Lu wrote:
> Add new clock according to 3rd ECO design change.
> It's the parent clock of audio clock mux.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  include/dt-bindings/clock/mt2712-clk.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
