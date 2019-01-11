Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464C0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188A7206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218469;
	bh=S6ElH7k6esPaLtiC5jX9RX0OZYVYFi1FXOVpTZQXqGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ioloPppty40cGNn8DyMY+KIAcIcMGKGUaHvg/TD6i0F4jicUPJIBfVL4ZDtAaU+Cj
	 Dk14Rf9mx+SSdi8saNyelyUCLPG8tayLmzWcGTK0N+GJLqwv9+X6XHfFD2O+OUVdAk
	 XGkXfqRXRvIBTKxpfliK5TZSKOexPaE6EqYmv/0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391695AbfAKOy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:54:28 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40773 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733133AbfAKOy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:54:26 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so13299437oth.7;
        Fri, 11 Jan 2019 06:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AxBTm/miHcpzTWrZ6oK4vYugnLB4OJ4qPCXeYxBcs9I=;
        b=LupztZU59vq4bf2BLj1nqyWo5GuK24RfUht9oLknUXNU+zdZkpOCw6QF9sAqYVcR65
         CGmNg0xmh3ats325UUopYp8C4PZ+SlxSC/xkEtEGMhfYyM0IDdENU6mzldUFH6H3agug
         yR9ZskfXeIruTmMNzb6l7IIvaWkhmASpC7XnGvkVV+nnkLfolLfEekYxl6/9F02qdnfU
         cR/ivk+A4/hDKbzJIOuIgR2QIgHHn4CXWBXmVgtZek+wYSFpAmemdSW1XfKNZqSJY318
         12tYOjPU2Ro1wZpShMngWx6dxjwHpWHEka69RZanUSNBvp3qiCbE57yMKK8IoL75hyDv
         SN/w==
X-Gm-Message-State: AJcUukcsxXtByXBSlLT6cEuTCfq1qPM1WE82Hkk1tUbkNt8zVJWY6WNF
        7HEyxaoqGnUS3jH0WVIe6g==
X-Google-Smtp-Source: ALg8bN7V0LmbKUmrNricS3ji6iXmjFN22dEwo5X+zsrnshlMFJPUSzs6OlleaePLksTmKgNq0jURtg==
X-Received: by 2002:a9d:4b0f:: with SMTP id q15mr5119413otf.201.1547218465767;
        Fri, 11 Jan 2019 06:54:25 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d3sm35589465otb.79.2019.01.11.06.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:54:24 -0800 (PST)
Date:   Fri, 11 Jan 2019 08:54:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Johan Jonker <jbx6244@gmail.com>, hjc@rock-chips.com,
        airlied@linux.ie, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 3/7] drm: rockchip: vop: add rk3066 vop definitions
Message-ID: <20190111145424.GA21604@bogus>
References: <20181229133318.18128-1-jbx6244@gmail.com>
 <20181229133318.18128-4-jbx6244@gmail.com>
 <154632658.xpTMZOjgxT@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154632658.xpTMZOjgxT@phil>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2018 at 06:22:00PM +0100, Heiko Stuebner wrote:
> Hi Johan,
> 
> Am Samstag, 29. Dezember 2018, 14:33:14 CET schrieb Johan Jonker:
> > From: Mark Yao <mark.yao@rock-chips.com>
> > 
> > This patch adds the rk3066 VOP definitions.
> > 
> > The VOP or LCD Controller serves as interface between
> > framebuffer memory and a display device (LCD panel or TV set).
> > 
> > This SOC has two symmetrical LCDC's for a dual panel application.
> > 
> > A LCDC has 5 display layers.
> > Only 3 are used here.
> > 
> > - Video layer 0 (Win0)
> > - Video layer 1 (Win1)
> > - OSD layer     (Win2)
> 
> Patch itself looks good, we'll need to wait a bit to give Rob a chance
> to look at the (simple) dt-binding change and I'll drop the paragraph
> about the display layers when applying.

Don't wait on me for simple oneline compatible additions.

Acked-by: Rob Herring <robh@kernel.org>

Rob
