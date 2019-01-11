Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADF7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267152084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547245513;
	bh=naLvD+FpRefPSLp0sWXy6vZvw1NniRQ7aK6XisYegVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IfVPfboAbdzGmqPDkakiO0/d3CklZ/Jm1APfrfkvDEguhmn7ix+w6V8KNaKjNLWnm
	 WaZbIz/hLY17Hwniprm8yxD5X8M7ddIC30R0XNECw+9aVi30IjjRvNriz7jQ9bTQYd
	 Bl4hDfPB+i4VccYS3Mal/mI0Sd0ijcEcm2nykFWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfAKWZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:25:12 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43260 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfAKWZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:25:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id a11so14512375otr.10;
        Fri, 11 Jan 2019 14:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jhAkMNvb6M5SiqQtcjhe3QeygTMXC9GQ3+0Ij0ePi7c=;
        b=RCHU3/BxYxd4L2eSUJOCn6Ahf65NI6TbppOYud/xFPJGUAPX+FFCxC8Tb6TX2tYb2p
         hNfKstXha00+trw7mDzkambUeeGu02Y9W4JVEvwD29j8di4TDRV+IT1rescumAipwMyK
         kON99Wx7trmjyn5TLPhzujjC6Lm77yrmfUsqU9imw8MUV+nXkdKIrnr24OjPobq0s0Uo
         IK7kkdf4O1AK0bSr9HxP+5RUSps4o7fDHzJLTht4lk8LyZ5Wu2zxbNuVwykQUidnK+3C
         aY98t/zsWChhJiBRZcTNEe573fpwn2qctKJ7jmmOfqJTvEudpYhQXC1OX2GhnF3IsEUm
         3POQ==
X-Gm-Message-State: AJcUukfqV3xM2ehxJ5AaEr0LLJEk1MFCMaXpW0W6r+Kd7yhP8G3dzObC
        tuSVG8x6eViJtrsReXJq7Q==
X-Google-Smtp-Source: ALg8bN42FkcADg+ATt56j+6pLQyeQuUD3BIMjoBtp+CLidNGIqImusOfsS67y1cdxQ4BUNk9pgJWYg==
X-Received: by 2002:a9d:588c:: with SMTP id x12mr11176024otg.139.1547245511131;
        Fri, 11 Jan 2019 14:25:11 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b12sm33599027otp.75.2019.01.11.14.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 14:25:10 -0800 (PST)
Date:   Fri, 11 Jan 2019 16:25:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maxime Jourdan <mjourdan@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: meson: add specific simplefb bindings
Message-ID: <20190111222509.GA14462@bogus>
References: <20190107095307.15233-1-mjourdan@baylibre.com>
 <20190107095307.15233-2-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107095307.15233-2-mjourdan@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 10:53:06AM +0100, Maxime Jourdan wrote:
> Similar to simple-framebuffer-sunxi, we support different display pipelines
> that the firmware is free to choose from.
> 
> This documents the "amlogic,simple-framebuffer" compatible and the
> "amlogic,pipeline" extension.
> 
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  .../display/simple-framebuffer-meson.txt      | 33 +++++++++++++++++++

Use the compatible string for the file name: 
amlogic,simple-framebuffer.txt

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
