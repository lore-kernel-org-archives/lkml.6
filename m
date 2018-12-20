Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6669FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7CF218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545336312;
	bh=dG7hQoLpyfbdzsrYMX9s8Z2Zp+LdhLjzl/nZP5slWmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KplfH0R/HaJ445FCkvffYs25fDie6wP7xrG//b5jA/8fkzB0jhq98B+b4deSc+nS0
	 jRqqmP7fw81IN47RETK1QQEtWjCg8tB8DfiVS1VpRJcLzFi0ih53qt+G52fp+CIN3u
	 QZ/2x7xsFYaCUNgFgP/PwXWqG6I/MSLbUZ80alJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732942AbeLTUFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:05:11 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37309 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbeLTUFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:05:10 -0500
Received: by mail-oi1-f196.google.com with SMTP id y23so2931386oia.4;
        Thu, 20 Dec 2018 12:05:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=77+IhaNwDQKdDm12pZyQvD5jZoI+UvywPhjuVCxY9k8=;
        b=LP21TseQZ1mNTLTCK4G2Q4uVpHpPDGjt8Mn3HEZczAIwTIIw78XZ2D/s/QdbOl6+P2
         EwjUxVpC6mRF41EhQpyqPNcF6X4oRCfAVht4LIy4zJufNx1E01atKNPYIIwt3yrQapdD
         +Sqd5eY5u+uG6qdHmJ2L321uQa9XtomBMfD2WKEjL9Sn23tncJo72fiXVoWkUmjZbyn2
         Z7qcig/DNchkZw+aeMHZrO5J6/kcutT00Lg5yYSYGbNgdE1LFPUfTHUCoi/tzBL1zGiz
         +Sgp3ntX7cXsmakPxevkd8Y0aS+Q47A8Jw3LmOORU8GjMZr03jVNMCQSZZjWMwWcBSoj
         LyPA==
X-Gm-Message-State: AA+aEWZwgZLv/D4Ci2ebqzvsH4nIZbQkn5uh23soc0ixvCwVMYr5I80A
        UnhdeC9LGbnav1gcPE8LUQ==
X-Google-Smtp-Source: AFSGD/V49ajMvV7y2nvF/E74eDTcfrq3wsypBN3kSHCJM2saEhU+Lh9gM4YWXFWxoFYw+YlHOptIgw==
X-Received: by 2002:aca:5bc3:: with SMTP id p186mr101841oib.130.1545336309527;
        Thu, 20 Dec 2018 12:05:09 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id g25sm6181484otr.30.2018.12.20.12.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:05:08 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:05:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martyn Welch <martyn.welch@collabora.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Martyn Welch <martyn.welch@collabora.com>,
        Thierry Reding <treding@nvidia.com>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>,
        Lukasz Majewski <lukma@denx.de>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <monstr@monstr.eu>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH 1/2] dt-bindings: Add vendor prefix for Catalyst
 Semiconductor
Message-ID: <20181220200507.GA7484@bogus>
References: <20181211194251.12988-1-martyn.welch@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211194251.12988-1-martyn.welch@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 19:42:50 +0000, Martyn Welch wrote:
> Add vendor prefix "catalyst" for Catalyst Semiconductor which is
> already in use but undocumented.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
> 
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
