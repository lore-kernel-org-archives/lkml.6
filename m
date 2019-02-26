Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18902C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D2C2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551199317;
	bh=n6WkldLu0ebooC7v448JzEXAQoNzOERB32O/syu7+wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kTwEPLCr/wMJOUowP6lreNhom0uu+2g83EZSMhnwTa1FzC66Sqp3kBF9oLhJSOkxx
	 3DDOb/UqZRvFMzohZnwIRa1wzP8bD/Z1xRj1aADRODURoccQRte6hXPjeOVYOrGIaW
	 6swNhy52HcJOoJ3lZRV4Ek8dV79Hkroapy55qdO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfBZQl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:41:56 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42898 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfBZQl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:41:56 -0500
Received: by mail-ot1-f68.google.com with SMTP id i5so11604461oto.9;
        Tue, 26 Feb 2019 08:41:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zXdBWEtVZVITl36Yawq8ekbRUcZSxtesapL4HUq7wjY=;
        b=JGgphxXvYJtG1Y0aYoggjjfMCJsJnNzmvTbS9GFroOzmdJ4oEhZ0SxZStKPj0UCciV
         MWouqSffJTiD0jfq7+6UfiNlo9ZzaqKqgntK8TvnV1TF9bYNrbTILQrf81/I+rXsDyax
         CsQrez6p5TpFw46rfmrRvLukmY2G+uPglXuRuWNkiJQu9NSit6h9lC4sVdqHpsdrt9wM
         YNmdPPigQJP6edqIGIqkFoXvUA3joQk3Bh9UwqmqCSUS4JI7dhhtn8uV8iD03EjBWwKR
         x6UuWn/DOcqmF7hSM5QCyCrs9qmrQMByK26R/HiphPNrHxuIO0deP0lL1WuihhEgT7VV
         zamg==
X-Gm-Message-State: AHQUAubJwnrAXQLGP12WHwZ6n7i5bLVcJzXOnd4JGLCVY/dAErzQShac
        +/OBvrGT2bP4RTLkj5E+oA==
X-Google-Smtp-Source: AHgI3IYBJl28mYWIdst9a15OgS4FLz58Jl8Bi6t3ANluCWUUCa579wa+1s1U5giKH31upaW3DWM5tg==
X-Received: by 2002:a9d:6a09:: with SMTP id g9mr16085183otn.162.1551199315150;
        Tue, 26 Feb 2019 08:41:55 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q5sm5317238otf.73.2019.02.26.08.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 08:41:54 -0800 (PST)
Date:   Tue, 26 Feb 2019 10:41:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Qii Wang <qii.wang@mediatek.com>
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, leilk.liu@mediatek.com,
        xinping.qian@mediatek.com, liguo.zhang@mediatek.com
Subject: Re: [PATCH v5 2/5] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Message-ID: <20190226164153.GA10352@bogus>
References: <1551186660-16902-1-git-send-email-qii.wang@mediatek.com>
 <1551186660-16902-3-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551186660-16902-3-git-send-email-qii.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 09:10:57PM +0800, Qii Wang wrote:
> Add MT8183 i2c binding to binding file. Compare to MT2712 i2c
> controller, MT8183 has different registers, offsets, and clock.
> 
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
