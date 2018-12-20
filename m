Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1EDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C5E2070D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545341879;
	bh=DN/CJVreNvWjfET5WnHXH5izOp6u7ri/uZzMHfYaAz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2oHEiJlPfPPteuCODI6F6waowZVkPUmDewXDMtTdAnqOsoUaY91t4DvOmv/uUNSID
	 keSztMBTmrUNrNKRtZSPJDreqae43xcLqzzWdB1txMC0P8EuT0/AuORXK3Fw+FKIg6
	 dVt8KfiDzgcAP5bcPO9FLzaBcZJud+vHwgFcmzGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390001AbeLTVh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:37:58 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44458 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbeLTVh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:37:57 -0500
Received: by mail-ot1-f66.google.com with SMTP id f18so3292041otl.11;
        Thu, 20 Dec 2018 13:37:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M1Mb5ZZmqRzVXpJFEwetW2OU5YkngUp0rn8ckubybWs=;
        b=ebcQSZ/4xoX563Ee6Mth7yiS6HaFnRjLoD5Lq8V/BbkxiCbxPbUb1PEkh6cP/8yDZI
         5ar04ojIPrrBQsBRnMY9Dj/MWBbS7VF3uyQDBMmaQII8Zo0a0t9Mze5kQ/j5IR/hvm7o
         gfEvU4drvzWLNGSLLf0CtisObIw7WlVe7RQJ2ZaBvGJHHJq7TU8TpW33jq0WuQz+xuNv
         /7T+4dzszLd7SZeVyNpVGrjIKFl+x3+/iDcjKxkiU7DoSrBkluZ6duuFs6bZ/w/9nAMb
         Ap0OW6pZPnyPfd1G6ZhLD0eGBajCLjYc81MIHem1mrdatzUmV4L6lg4eGtPr3LmGzXuU
         dj7g==
X-Gm-Message-State: AA+aEWY3Xz4FwIqaoGHjEt+E7qjq7WRUam/TatTR+vokWKuXNbi+aZhl
        ssJy70fisM2XJETyTFiNRw==
X-Google-Smtp-Source: AFSGD/XtvXqt0oZftKijt7Iu2VHOaj9Kmnis9QGu52DgirVpVQcxypA9sO9TGYxerZRR6BmUPL+OBg==
X-Received: by 2002:a9d:245:: with SMTP id 63mr18963313otb.135.1545341876746;
        Thu, 20 Dec 2018 13:37:56 -0800 (PST)
Received: from localhost ([2607:fb90:1cd6:97bd:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id x4sm10324225otk.37.2018.12.20.13.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 13:37:56 -0800 (PST)
Date:   Thu, 20 Dec 2018 15:37:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, hjc@rock-chips.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, Laurent.pinchart@ideasonboard.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/15] clk: rockchip: add clock id 24m dsi clock on rk3368
Message-ID: <20181220213754.GA10095@bogus>
References: <20181217123650.6773-1-heiko@sntech.de>
 <20181217123650.6773-3-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217123650.6773-3-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 13:36:37 +0100, Heiko Stuebner wrote:
> Needed as input for the dsi controller.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  include/dt-bindings/clock/rk3368-cru.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
