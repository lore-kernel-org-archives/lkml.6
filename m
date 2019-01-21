Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D75C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8974820879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548090624;
	bh=yE+HOTHQOUEeF7ujANnjrF6XFyNMugiPYoQLqqF35Fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JoZnxecMEEzh5n9M6miaIX050lZQGtXFgCGplIjnn4pZaDcYLj1eO8LQ33hYQX1fv
	 0fTmJLs5XgC5I5UNoQeLwsG5qbmHQ4YfPgxdZvxReN++JOLZh9piJwY3QIzJ4DwTdm
	 uwltGsKzkEfCPDzNFhdoAGto7CybyxuxjHaTyqNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfAURKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:10:23 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45201 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfAURKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:10:21 -0500
Received: by mail-oi1-f195.google.com with SMTP id y1so15071432oie.12;
        Mon, 21 Jan 2019 09:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LQZ0RN34D2hW12PR3UPXkOMhkhpjo0tL1Zas8kCCPco=;
        b=WA5Ic4+NPhB3YXisnOhg2OIdAOAr349R3/Qdf3g9t+8rR8t/1FesT9SbafWayqA1aN
         3DmMPMFyG66NjkFQgsJyMy6yrPD2PjfZblxjn/LYTHl4B6lOnESHI9e1nYH9Bt4IC/Ff
         v9FvGgPPjSedHl0tJTtQvWO0X3MUQp5srQe7SPRre1pG4ZvTX7uwVil+oUNEQzGLp8sz
         MgpMb2JxS9vDfC8YWbETiiuRPIyBEfDcBiiLuuneyvT26o9frnVXsN3feS/7Eb19BqYA
         DErMW7+13dMb19X/qePiirYXmd58LEZE+w5tTiusHPLH/OAhb+eu0iUkBKR5rUy+HiaJ
         ORGA==
X-Gm-Message-State: AJcUukdq4hBb0yDLW+I1q94T8PIl2t1hakK5iSc+GqAc/HRy/Xgm9ExD
        GOvAYt3ZuB1LzB1A71NFs6fO4hg=
X-Google-Smtp-Source: ALg8bN6vlKKmgSljeMVxbOa2VFpltgrb28B5/EXX8WtrovBjZqgkEA0Pz3WFpXGzoUyVaZ71ts4u2Q==
X-Received: by 2002:aca:5241:: with SMTP id g62mr3103336oib.354.1548090620362;
        Mon, 21 Jan 2019 09:10:20 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v1sm5775452otq.80.2019.01.21.09.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 09:10:19 -0800 (PST)
Date:   Mon, 21 Jan 2019 11:10:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Loys Ollivier <lollivier@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190121171019.GA2903@bogus>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 17:54:32 +0100, Loys Ollivier wrote:
> Add binding for Mediatek-based GNSS receivers.
> 
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
> 
> v2:
> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> Moved current-speed as an optional propertie.
> Removed the status line in the example.
> Added "mediatek,mt3339" compatible.
> 
>  .../devicetree/bindings/gnss/mediatek.txt          | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
