Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B68C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E674C2147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjpX8+be"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfBHIF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:05:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46294 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfBHIF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:05:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id o6so1312070pls.13;
        Fri, 08 Feb 2019 00:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tVgQ3y9G451aI3dNsMnjzMg2iBV+ifnwDuy5Ag+598k=;
        b=YjpX8+beKoeAVxg6i5fjb/S1KUnvHCHvn+TT0f1Q3OadM1Q77XSpbuWqwNQbtYKPKs
         fM1F4ShJo2WjIwv5ptuFsj+Z7vTL+a00VNp6FTeAoplNk7u2c7yyGEqr+kt1C8ov/zB5
         1EghUFAGpL0ISpX1k7GqjmHuhAhHU6F25XdriGDhazoKejkkvndgZS5hZkQ6FRFWV09g
         n+RsCbG+NGR0CDu3UxrA1k6pxUjC7xIAuDZy+qPQT/q4yjx6Z/WsF16fosvN5NjXjLKK
         fX03uFqwxEUWWSQVvY+OqBNQajSTEZYvL5kZFMXavgzYHHu3wYWm0LWtEvmTO1lpmpDC
         i5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tVgQ3y9G451aI3dNsMnjzMg2iBV+ifnwDuy5Ag+598k=;
        b=Dajhtv7p2y0VdNW+7W7Kn29J2GXMtN8iPu17Nxb2q9Sn5RkxRmgK9rQjOQAfFuR0Fy
         yURhnebZWzWVpClUcSRzqP24qxrBJzG2dXGqwRPN4jvyRL7XKy2CL4lRTLthINijXg4L
         Ose+fCMxTP1DkzIVj2PtuhaG5Us2s50n/AMhWK3AfwVxDQvRWFoGXIbx/6Pny1PGaalz
         t0+Kh6KlzdQBhBaaybnZUzV6z6UmeCnW/w2WH/6k6XbrNu4hkILyiOtWaIP7awRqhfNp
         LG9KS2PDgQEaRRLoTTUnvQBpAREUwczu+6qLu8NxRrP5UUa2ctabY6P6K0V4A0Hbtg6i
         ssvA==
X-Gm-Message-State: AHQUAubVKRq1PuKhq8pHS5vURN1gEQpBUeZLUPo/zFiv/3C6PNmkmjWj
        DwOnAsgr+LW4CIpU8ZgJTW8=
X-Google-Smtp-Source: AHgI3IbJSAzIGAtZNQJKhmMrcG1Z1w7uir6xqCaPDWULh+5VlvAx6VpG6b0Bcj7IKCZi1GGMuxZwrQ==
X-Received: by 2002:a17:902:2f03:: with SMTP id s3mr20911058plb.277.1549613158364;
        Fri, 08 Feb 2019 00:05:58 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id k71sm2874461pga.44.2019.02.08.00.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 00:05:57 -0800 (PST)
Date:   Fri, 8 Feb 2019 00:05:55 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc:     Martin Kepplinger <martink@posteo.de>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: st1232 - switch to gpiod API
Message-ID: <20190208080555.GD31622@dtor-ws>
References: <20190129102347.27754-1-martink@posteo.de>
 <20190129102347.27754-2-martink@posteo.de>
 <83a86244-f40b-44b1-d7be-1fcbeb4c359e@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83a86244-f40b-44b1-d7be-1fcbeb4c359e@ginzinger.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Tue, Feb 05, 2019 at 11:20:16AM +0100, Martin Kepplinger wrote:
> On 29.01.19 11:23, Martin Kepplinger wrote:
> > From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> > 
> > Use devm_gpiod_get_optional() and gpiod_set_value_cansleep() instead
> > of the old API. The st1232_ts_power() now passes on the inverted "poweron"
> > value to reflect the correct logical value.
> > 
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> > ---
> > 
> > Tested and works. thanks for your help Dmitry,
> > 
> 
> is this what you had in mind? any problems or questions?

Yes, that is what I wanted, with one exception:

> > +	ts->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
> > +						 GPIOD_OUT_HIGH);

This breaks compatibility with old DTSes, please try changing to:

	devm_gpiod_get_optional(&client->dev, NULL, GPIOD_OUT_HIGH);

Thanks.

-- 
Dmitry
