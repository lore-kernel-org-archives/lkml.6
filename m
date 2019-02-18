Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6D2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6412320C01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550524359;
	bh=xOrgE668MU+18R+f4xN0gIylXMM7H5i95KH61GQgEis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hpw9yWc+GDvwNbL6GZ2UKR4BZe74Er1gt0DcZ1vGiGQdAbfIIEQFiKdSI9QP3WZUj
	 9dG8H6mZ/Ce2pxfmDDesPDgyr/lCSG6EqfhNAz2TvGWjF6J16LJOEi+L5z7LnoZLI1
	 X8fO2l4TuhtQ+mv+VPJ4WWdrrzqLZQbkZssSSwOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbfBRVMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:12:38 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42879 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfBRVMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 16:12:37 -0500
Received: by mail-ot1-f66.google.com with SMTP id i5so30609848oto.9;
        Mon, 18 Feb 2019 13:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=belrf9S1ZRx9yo0wr3HYzIUiLBsZIziEnB/8D0iwtAc=;
        b=hewxuxTaKgUUOaR1xwkWqhpgAj+3/GJba5GeoX/j9bHGK43IMYtwIb9eupnO0rXMyT
         WzW2yanaKJHMdOldjF24/E4LzUwQUFvqTr1HiVCN4AYE90rzO4P6Obku2r152d8PFVx3
         oVNLCJLdjqP1aATkDIcxPWIPH1ocAO/6qtS3ubEi3eCEdpqZJqEHsT9zASiYouQjiULm
         23MHxJWWi31JHred5D1X21kDe7nIYIYpdZrjfGjMwzGGB6wAYL0KKNXm9AGC6Vn6aCNW
         BPy9t1pr6mEeEV+ZFPaesqviRW96T+cGFlNHilECqUsFvU03SguBPIejR3co37B7USRh
         NN9g==
X-Gm-Message-State: AHQUAubUC/YE22qMOzMiEqC/NixEwo1y5QkjUR2OjQP9yazlDdmv2gln
        9OuhmDGxnd7QLeqleZRm+w==
X-Google-Smtp-Source: AHgI3IZhb5LhrgIgI9QpoFlcozLFQh2H8yTUBg57KQdiTyuyJbXVDwvI1+O2AWQFoa8xzhgXAyHVvw==
X-Received: by 2002:aca:4d53:: with SMTP id a80mr534949oib.154.1550524356636;
        Mon, 18 Feb 2019 13:12:36 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i5sm6513068oia.46.2019.02.18.13.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 13:12:35 -0800 (PST)
Date:   Mon, 18 Feb 2019 15:12:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu.Beznea@microchip.com
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claudiu.Beznea@microchip.com
Subject: Re: [PATCH 4/4] pwm: atmel: add PWM binding for SAM9X60
Message-ID: <20190218211235.GA17147@bogus>
References: <1548073783-22640-1-git-send-email-claudiu.beznea@microchip.com>
 <1548073783-22640-5-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548073783-22640-5-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 12:31:01 +0000, <Claudiu.Beznea@microchip.com> wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add PWM binding for SAM9X60 SoC.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/pwm/atmel-pwm.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
