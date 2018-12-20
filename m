Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86F9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7897D21904
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545341960;
	bh=lDLEiiFNxJYuDtkWm87MvPsVJlHqTdWZYrML2D6sXHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HFLqc5fnD0R+9HCw4wSwNcf8cjiSHqEYQV6uVVx9wXCGRuCwiPT+2plFirHlw62Kn
	 cE0JJOHUhFTFLSu7pjV/kE58OE8vgUiJL8tavNZMlhLw0SRHbdUuj9jzzRVvLzgSqr
	 NrFiKPXgNVsxdUnUZTFQ9BnXO/CogIsOoiW1skTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732757AbeLTVjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:39:19 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33250 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731515AbeLTVjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:39:19 -0500
Received: by mail-ot1-f65.google.com with SMTP id i20so3335725otl.0;
        Thu, 20 Dec 2018 13:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qYfUlyfdTFSzvnhly1xQ2zw/wrNbkf8eZk1/fJIxbQI=;
        b=uHz+h1AnUtfRZQ9Lz5SFo7ch7Hcx7ilAGQA8r0+DAGN8WMoMpIRENRMwwImkbHY/tb
         wt7l1jp5ZnCL2RN7PXnmLGWfyennxIWY8GLa3Pp62T5NkV0RfL1RJt2d1kSDucd+fKUo
         UX0eD0UJQcNC3kqsux4ny5Yup3yqk5KT7uyGujO6uK/4aBUHo4GlcOGOVrESSm3FawfH
         gCnzgFmIzerBtKzTDG8i95HgsiZOwiACulyiIYFBkcee71ZFUfEZfQfOBSep3HJyRqW6
         O3WMGib4NeT4sk746o3eanBaCr4goyrepJzY/dyfHUGWzBnIEaUSYd5bxf6He2f0MpV6
         K6sA==
X-Gm-Message-State: AA+aEWakodXF99jzved0eEQrIaoFHwaQxVubo+nVmCYdawjBaAhInT5a
        axmK8G7afLPb+FD84oB5MQ==
X-Google-Smtp-Source: AFSGD/Wx5he7Hc4IYcf1wiaeOKq8aeMnwf8oCv9slWCZfPCBUZ3IsE326wI28P/TWaNKZSLK82HN4w==
X-Received: by 2002:a9d:27e3:: with SMTP id c90mr18432795otb.21.1545341958313;
        Thu, 20 Dec 2018 13:39:18 -0800 (PST)
Received: from localhost ([2607:fb90:1cd6:97bd:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id m25sm10487093otq.32.2018.12.20.13.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 13:39:17 -0800 (PST)
Date:   Thu, 20 Dec 2018 15:39:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, hjc@rock-chips.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mark.rutland@arm.com, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, linux-clk@vger.kernel.org
Subject: Re: [PATCH 05/15] drm/rockchip: dw_hdmi: add support for rk3368
Message-ID: <20181220213915.GA10254@bogus>
References: <20181217123650.6773-1-heiko@sntech.de>
 <20181217123650.6773-6-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217123650.6773-6-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 01:36:40PM +0100, Heiko Stuebner wrote:
> The rk3368 only has one vop block and thus the dw_hdmi does not need to
> do the source selection.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../display/rockchip/dw_hdmi-rockchip.txt         |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c       | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
