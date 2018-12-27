Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F12DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06326218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545946071;
	bh=DHjklQVXM5Uk6SJPnYz8Z8aqPah9crZ/KmNUumVKTA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DtWAeMfIwLThEZLpJ9sWlhk5xrzOO1x4SUF37pulSrOaeJaR/dK23kJidmHYoY+42
	 FoBk6xhUHiwdu/vF772VvyEfBl6J0AO2kLi9L0X/dVCUB4qBcbK+WTBW95IIRsk1XA
	 8JYoIgXwc4jSetOBSb8Ap11GXoziNuA9g1PeiWkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbeL0V1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:27:49 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39329 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730299AbeL0V1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:27:49 -0500
Received: by mail-io1-f65.google.com with SMTP id k7so15451564iob.6;
        Thu, 27 Dec 2018 13:27:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W83RMqRpkFT7ZXKMM3/XU/dfahsl3UZaRT4tQfBdXPk=;
        b=P5flagA2/xTa0y/zkurBDw/wgbspsOWyY4mHZWrmLIVduciiRg78+pidg+TDNUqcIx
         jHz50169CsSEsjEx0md1Aik6KYbUHLysVlK6p08KJE1b4WQFkZKb0P4TXQ3R9TPhknwm
         T3ytE5591vgWPvyN6eociLLk+T56+b1xwjQGXfVn3fvLL0GDCnXTGueZt5o5FEddGpOx
         xlgrfFsipkGs+/k4F1PKdlkPEjymn9zKAlSDxiOxS7akovRlkZatp69sSN1jbbeDeQnb
         cLzcqNJ6dgocs9Z/KvP+/EW9we67Fd1V5NV70yo9NvajTm3SPTXQqPrIRascm2Oem2to
         jrbA==
X-Gm-Message-State: AJcUukdZMUXDUSiPxuRBhOTIJHy+TC+1R4nlaNUqN5QXcBN82Bze/LOO
        cHg+a848hxMzS0YuUJP4cw==
X-Google-Smtp-Source: ALg8bN6tLW+G/lWCndC30L6AoYTZhwfUPr5w9i2j+USZWWJiHfBss6rIMyVDqsnz2n2zSqKBVIZwSQ==
X-Received: by 2002:a5e:860a:: with SMTP id z10mr14634830ioj.35.1545946068235;
        Thu, 27 Dec 2018 13:27:48 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id p19sm18256594itp.13.2018.12.27.13.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 13:27:47 -0800 (PST)
Date:   Thu, 27 Dec 2018 15:27:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Rosin <peda@lysator.liu.se>
Cc:     linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: display: bridge: lvds-transmitter:
 cleanup example
Message-ID: <20181227212745.GA32760@bogus>
References: <20181219130449.31641-1-peda@lysator.liu.se>
 <20181219130449.31641-3-peda@lysator.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219130449.31641-3-peda@lysator.liu.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 14:04:48 +0100, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
> 
> Drop #address-cells and #size-cells from the root node in the
> example, they are unused.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  Documentation/devicetree/bindings/display/bridge/lvds-transmitter.txt | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
