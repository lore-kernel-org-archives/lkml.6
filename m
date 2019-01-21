Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6438CC37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3329120844
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548104902;
	bh=X4ippRdzlMJKRul854Wd6OiVIDhTL6qnIifniw23njQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F0SBmRNJgod8Y/c+1ILbbGro/SZuV1BFsK5v/75HJA+K5ZqzzrOhLWlPtkoFRc4mv
	 un0PPqObaezuQoF4COXH3EqVjhX07q5/q5decF1ZzvnWcUK2hVVcGrfienJlbBqhei
	 Hrv9M9VooCq8Dy4FrmpiEIpZ+IBTyAD3hOK9RofI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfAUVIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:08:20 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45743 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfAUVIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:08:19 -0500
Received: by mail-oi1-f193.google.com with SMTP id y1so15630686oie.12;
        Mon, 21 Jan 2019 13:08:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oFPqhi1BSNrHF1r/hqVr80FYHFjvKB0P1PtH+zOaZa4=;
        b=m5MvbD1m71nhFbjMhWsfAn0yPo/4zJyYILOchpfXpEnyxhMG+1aCzvIXxgeJSjI7xq
         WB9rVM7qYX4w090F10Qm0hePGFFHlnadFF6PL6sC4Ly3qcGMoVA3P/rgyd/FiWsG9Vl2
         YFi11cXjdNg7S5fQyF+0yxU2TyQSjys6GMhNw4XJZ/75zeFQ2tq0PlOTgmm41Ucnuf+S
         ZPWDS/VzVsphQQ2NBGenkXWKGhIATmMHCoJzw12e32ycHg8YlYK5ZjhqgYQgNN/QAAQl
         mPuFuEw67KAW/+Nf+fpyaxY6AwFnnJlVscKf2mh21hmpLFkDxpwenLie75/ECWiRYg5o
         JmOA==
X-Gm-Message-State: AJcUukeeWb/37f+kmzItiT4AJ1tOH6vVI9AO8ruT6YhGPHn0Xo/6s8HQ
        jZwFyK6kv/boJf4SSQGLrQ==
X-Google-Smtp-Source: ALg8bN7UU1lZxDDMBtqxW0/2MQmsetQwnUH1MC5LPv0PdHqdm7sgZ68CJyfyx+ouOVGBXTvOgoPY2A==
X-Received: by 2002:aca:2803:: with SMTP id 3mr3988388oix.85.1548104898477;
        Mon, 21 Jan 2019 13:08:18 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 187sm7012051oic.12.2019.01.21.13.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 13:08:17 -0800 (PST)
Date:   Mon, 21 Jan 2019 15:08:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: serial: omap_serial: add clocks entry
Message-ID: <20190121210817.GA28521@bogus>
References: <20190109091206.25759-1-vigneshr@ti.com>
 <20190109091206.25759-3-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109091206.25759-3-vigneshr@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019 14:42:05 +0530, Vignesh R wrote:
> Document clocks property used to pass phandle to functional clk.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  Documentation/devicetree/bindings/serial/omap_serial.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
