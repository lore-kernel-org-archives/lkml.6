Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775B0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A732070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550853831;
	bh=qfFhsNJToDfE/4K06lqop8BFQ0U3bBuJ1HqEsTcp95Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DdlRpyZdJFRywy5cyaZBn/KdgzfTUaxU5hYsj6NdacFsCMfyxdeNt4vb7O5zkdJln
	 27uRlXzusG8g+h/IdurxrWatKy9UwHByQZODA7CqDEQG/joyeuPzfDHTFuOR1L1CZI
	 XdrvmutgnPviHpcJfb89BG8arqEUnnl5rPFjJio8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfBVQnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:43:49 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45741 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfBVQnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 11:43:49 -0500
Received: by mail-ot1-f65.google.com with SMTP id 32so2342656ota.12;
        Fri, 22 Feb 2019 08:43:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xtQPnEsXL1B9s1lft4BTJwQQVa28+TAInDN1KoU6Fn4=;
        b=T6frCGZCHINT0H27O5XbjGeNITa8pDo/yfE9sv7OqrtwFs7HQRpYcXgxj7OjUtt6l3
         wXohyVM4V/HzDTkLKhXpsacrI0iNwAVr2ZKjivqGHIUjeUZn08C8h+7N9DaKxq2l1G3/
         j/KfDCAIsN3ntWvxuFmiEdzqVdYD3RtibuXZt4xONIulHDkljLipqq0q8S1MRwf/TX4f
         omAsSy0wPehQ/NyJisIYkgbYeL3MdswXiZFbdiw9FMgKeMfb8pG7B/66+6jNwPjy+3ua
         uLS9A4t3nCkRhwwyUlvHq23zMw9/q2M+tggmCXaLIPOiFbJKX6XIScJ7pQE1Q++fdW8G
         V25g==
X-Gm-Message-State: AHQUAuYzz74BFvLNCJOZTbl5xjJHRJgj25KvPLGdmxiecab6F68k0VhS
        IFuixVWdvcHFhosJcTa1mGBQ+q8=
X-Google-Smtp-Source: AHgI3IbhwL8qTxGpYuj90sOuycWSfDaeHqBZ//65Ng04GUsWQD1ymQBSD6pbZbJqhW4FMUhRSEtCcA==
X-Received: by 2002:a9d:5617:: with SMTP id e23mr3307108oti.193.1550853828482;
        Fri, 22 Feb 2019 08:43:48 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s21sm810279ois.2.2019.02.22.08.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 08:43:46 -0800 (PST)
Date:   Fri, 22 Feb 2019 10:43:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v6 1/4] dt-bindings: input: touchscreen: goodix: Document
 regulator properties
Message-ID: <20190222164346.GA26256@bogus>
References: <20190219101629.15977-1-jagan@amarulasolutions.com>
 <20190219101629.15977-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219101629.15977-2-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 15:46:26 +0530, Jagan Teki wrote:
> Goodix CTP controllers support analog, digital and gpio regulator
> supplies on relevant controller pin configurations.
> 
> Out of which AVDD28 and VDDIO regulators are required in few goodix CTP
> chips during power-on sequence.
> 
> AVDD22, DVDD12 regulators have no relevant functionality described from
> datasheet [1].
> 
> So, document both AVDD28, VDDIO regulators into optional properties since
> few of the goodix chip do work without these regulator power-on sequence.
> 
> [1] GT5663 Datasheet_English_20151106_Rev.01
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
