Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E860BC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B413821479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546556290;
	bh=3shS789VK2Mi5kUOfioYdVgHaYMEpjl7TptRxbDkTBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ufrMgYbnFVy3IuLyd1kMUEJ/1j60gvSQpDgNWB+skBO/pHkRvYnHRNVAXXo8MYEpp
	 KxfP+JWOdPb5+ufiucYgs0yrxR7/0pvZUG2WQk/IQvs3eIYy5G3AKFH2DHWrhYIiLt
	 DsKOsCMBBbtOlMf91BU5jrvMD46DIrOpg+YFKYRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfACW6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:58:09 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52117 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfACW6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 17:58:09 -0500
Received: by mail-it1-f193.google.com with SMTP id w18so47596986ite.1;
        Thu, 03 Jan 2019 14:58:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/il+xr623PEYdFYItFXWIq2twAOe1+oGIS+GU5/qFhY=;
        b=hnDzqNUJHJWOfAFQLkmddvX25KQwMOkUJcucfoTCiAFQBFixMfRPXFGKPdOquYNRxq
         89LXz9OhQxIUTxm5fs/M5LS+Uy52w7edAhjclG9QSqL/RXKAh2PIf45NCrgPSaJn5Ose
         pogrirQVkSs56dCKOWM+ZWdAdQZc6pgCoTCo0/v+1xGctgGeu3xCHRkOVAg3E9kLjmpX
         7xGBZARowXvfMUVZOvo//8MIEUhwOh+vD2Qr5d4VrTHmP3pNvHTHamHKKbBdf7tx3wrE
         YCWnCFOD2vQKDSwBsjanIiPJ7Ut1ErlAjO8GDJqSlo2YC8HOjFW0ovtW6TN87g+xD9Up
         VrpQ==
X-Gm-Message-State: AJcUukdzR7512FY+FoeHAKrxqBDAqelTHAxlWf+SVcec7L0TyohlGvWC
        4NRLkLIZjb3jyA5eyYyrBQ==
X-Google-Smtp-Source: AFSGD/VP+4MSWuOy/4QXTSpTYNaVPGffAQa3kEHvIj/ag3/aNrxhjQ/koGqBMC/aBmmQVtAvB9RyMg==
X-Received: by 2002:a24:1490:: with SMTP id 138mr37808782itg.101.1546556288145;
        Thu, 03 Jan 2019 14:58:08 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id b73sm6658519itd.0.2019.01.03.14.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 14:58:07 -0800 (PST)
Date:   Thu, 3 Jan 2019 16:58:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH 2/2] devicetree: hwmon: Add bindings documentation for
 HIH6130
Message-ID: <20190103225806.GA15255@bogus>
References: <20181227151349.29753-1-andreas@kemnade.info>
 <20181227151349.29753-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227151349.29753-3-andreas@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2018 16:13:49 +0100, Andreas Kemnade wrote:
> Add bindings documentation for HIH6130 driver.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  Documentation/devicetree/bindings/hwmon/hih6130.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/hih6130.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
