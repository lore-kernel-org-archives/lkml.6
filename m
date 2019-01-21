Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7DFC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91A520861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080300;
	bh=U/4vRbxmtcvt+yEWKO7t6O50xujYOC9Mga+FTjRUk4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mHmmGxDVoHS+oGA+2tGMpVr+/hgg5amaGQ9TJaK+MzdmGOOar85tKMFX8aX7SiWIT
	 FKIegzAj+COT6rxckWTTS3irvKOknfAW5gl2nCT2aSD21M+NhmXw6n00rttWLCh33I
	 AuDrro9LDOru91YKl9YkCSuk6uCwBzWMgVpwBItc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbfAUOST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:18:19 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36068 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbfAUOSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:18:18 -0500
Received: by mail-oi1-f196.google.com with SMTP id x23so14655481oix.3;
        Mon, 21 Jan 2019 06:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OvUHUMbMfZNovD6rICuVB0Zp+DaCsmoZ/tqxPoP4GMg=;
        b=konuZ67gYuhNz4TT34Cqu7au2btCpC/5GC+9IBb2LZm9xw7Gd5eGMjm/4cJZO+sDLj
         C4TTGYoiDZAG5VhHIPU2kKPhSzZZ6amAFnKDrZzpRxZwUERMt4hhWD0uTCVImdGVOulC
         s41qFuSBbYOhxQJqyBlnSLHdgqkMZGC/kBAEWSI5LyHI/SabWKqbdfhUITYvzTh1/LCl
         Wx1F44P2Sr0NsIdh3AT5+Sa0ESCU+I5ytx/sL5ChdEkbqInkkVahvaIw6EjLEgfnZ/7O
         yxRimi4hNL5C1lr8szd19cEsAh67/OVX3tpRNtL9mPjkrvKo8tXTWHEHtBR/S8nPmgbT
         /ULQ==
X-Gm-Message-State: AJcUukfOuSJbBL0rYpgxUvmhxDvrmL1yq/dOlt84Po/XMcW4/WGUgxjS
        AHxdMgeTYiP/JOeqHb93Rg==
X-Google-Smtp-Source: ALg8bN72treqidZ7nfLMCjoeyZCbGvMfwPXQqxDxN4DSHCZSwSlZAbKwMPwb0lC/QHp3gUhB+9Udgw==
X-Received: by 2002:aca:e386:: with SMTP id a128mr5477048oih.79.1548080297415;
        Mon, 21 Jan 2019 06:18:17 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b128sm6378833oif.7.2019.01.21.06.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 06:18:16 -0800 (PST)
Date:   Mon, 21 Jan 2019 08:18:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Long Cheng <long.cheng@mediatek.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, srv_heupstream@mediatek.com,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>,
        Long Cheng <long.cheng@mediatek.com>
Subject: Re: [PATCH v10 3/3] dt-bindings: dma: uart: rename binding
Message-ID: <20190121141816.GA18109@bogus>
References: <1547781016-890-1-git-send-email-long.cheng@mediatek.com>
 <1547781016-890-4-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547781016-890-4-git-send-email-long.cheng@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 11:10:16 +0800, Long Cheng wrote:
> The filename matches mtk-uart-apdma.c.
> So using "mtk-uart-apdma.txt" should be better.
> 
> Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> ---
>  .../devicetree/bindings/dma/8250_mtk_dma.txt       |   33 --------------------
>  .../devicetree/bindings/dma/mtk-uart-apdma.txt     |   33 ++++++++++++++++++++
>  2 files changed, 33 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
