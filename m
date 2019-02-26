Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33115C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8D821873
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551220366;
	bh=pm5Zs4l8y1joXehsVqeqiq88zK7YsXAhCAQjCjJxyv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OxPJny5H8WZtzazjAvI3WQPnB5lNAkeCYfoBdGiO+Ru2ANsFCXKpaWejNK7iMVi9S
	 lUE7mi1W6GqB2u7BHer+IZC/ck3lmnL4SDmdUBPJTWFPQc4CtnrRssjPhygkZ/+6yU
	 AXF0B7x3hb/bBRpnNNZrDgCSIsO4BXD4/SfpmmTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfBZWco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:32:44 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46265 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfBZWco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:32:44 -0500
Received: by mail-oi1-f196.google.com with SMTP id j135so11783928oib.13;
        Tue, 26 Feb 2019 14:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vJKRJ/fSxcePULZfYSakgORctZ3ryZ3sejfiVGWNW1I=;
        b=pjoDjEnh1iL9qjxiH7iqub0WiT3/UkwFTmcCKdIK95VJ2gNHcJPWyPM7+u7AUL6IJI
         A6LF9uWAFpedEJFhwO0OZl6EfwNdg8cJhEWSQ51BTfemTPI3T3S2a9l1jZGUTnhe7hyD
         sf0Wal3IJzNZZVOt3Qg2zrmzuxRfmoELYzT/qHbzK6la4nWhZXyPW3c7ukekMzPEKnzh
         Wio+iWzVX0UWasZIcvu0B61/T8mBAr43ZmyoPjHjf5aTzea5Litg03h7R1GGyenI+wrr
         EIyXx2dTyYVAk3jkpRQ/O21tmYiLVXVIbo2wz4DEvfbpQYcP11b/NAqpZQxFNB1xyNJL
         auMw==
X-Gm-Message-State: AHQUAua3yNmsKOSXoL5uG3QO/OACxTrYA3FDaOXzlME2joDt2W1m/8bn
        uLN6PMkiiGb/hLTYLmYscg==
X-Google-Smtp-Source: AHgI3IacdPmyUtJwePB72wRcyWJRTdl1X7hbyiYt2Od7LhkXzfq4iqKwHT6vEfgj3kNcKjCxRWeTjw==
X-Received: by 2002:aca:ecd5:: with SMTP id k204mr3618991oih.153.1551220363613;
        Tue, 26 Feb 2019 14:32:43 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v62sm6087785oie.21.2019.02.26.14.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 14:32:43 -0800 (PST)
Date:   Tue, 26 Feb 2019 16:32:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: net: btusb: add QCA6174A IDs
Message-ID: <20190226223241.GA2365@bogus>
References: <20190222225345.69084-1-briannorris@chromium.org>
 <20190222225345.69084-2-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222225345.69084-2-briannorris@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 14:53:44 -0800, Brian Norris wrote:
> There are two USB PID/VID variations I've seen for this chip, and I want
> to utilize the 'interrupts' property defined here already.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> v2:
>  * drop leading zeroes from VID
> ---
>  Documentation/devicetree/bindings/net/btusb.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
