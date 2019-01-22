Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D21CC37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED45C2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548115873;
	bh=hqQ5jTr/nyZCL4ST1j3HCJ5Gc8lc+pWnMkYI1N7NaZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fnXdLNOU9b5tAUdpZZIm86JwlVl6M8dg/LwfrKbekGadZqkBdLh00+F46AvpivDRV
	 jNodtdfbJHkLYzDDtTO/A7HQbOAbhmwlGUUPqVpc0nFKkvJMpOMSP8YIIWKzPhZzRI
	 aiZsTvzC5m5fN8GjjEREvU7/EtziVqm+j77UhRl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfAVALL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:11:11 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36350 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfAVALL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 19:11:11 -0500
Received: by mail-oi1-f195.google.com with SMTP id x23so16002638oix.3;
        Mon, 21 Jan 2019 16:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SlBAzvDcY1ghfp+H+vLuKhWGoM3q4e7m8XPsVtVcKOU=;
        b=QyUFsPfScEY4PtD7anOeP3yd+NHc1mY/+96vFwkNOt+kdhMAWQ0Lij+fW9yVn4xRA5
         vQy3qxjjWrY1oLls5FeO10V+llR7lhSWeeMKRqVSJKBmkqgMs860Z6AcrHW6Kcjoc9/Y
         NBKUzveY33JdioNeDv/a6GBN9tbMLw8KoOkziUulEDB41iv+3JISzU9bS8vrw/wu6UVy
         Gg8/IzHpcu812IdZ4gMLw2FQ5OM5mV/N68mASoNNI83LEzq2xjpALWLoCcyZpZo4P+ns
         Gbj6oFsSn6MUY614y0hFhhOcGVFDSMn+1DPYRoR2tzJnvDTi3N5Vh9nqS/LLnqiCqBgT
         PaKA==
X-Gm-Message-State: AJcUukcLtE4NIKwN+1wfzoL/Xjt6C8vE2WpqNnI4FUFxguqqGLS4jOH6
        18kjZzu1GxZxN2DCocQ+4g==
X-Google-Smtp-Source: ALg8bN45gppOteInuhGGenZuH/Ov4qQwF1OnLeormHbkyhMwCFDrqKgjPx4jnxRTW3ersDJuNb9Q9A==
X-Received: by 2002:aca:c443:: with SMTP id u64mr7213507oif.136.1548115870265;
        Mon, 21 Jan 2019 16:11:10 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 14sm7484704otg.68.2019.01.21.16.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 16:11:09 -0800 (PST)
Date:   Mon, 21 Jan 2019 18:11:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 01/11] MIPS: ath79: add helpers for setting clocks and
 expose the ref clock
Message-ID: <20190122001107.GA28193@bogus>
References: <20190111142240.10908-1-o.rempel@pengutronix.de>
 <20190111142240.10908-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111142240.10908-2-o.rempel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 03:22:30PM +0100, Oleksij Rempel wrote:
> From: Felix Fietkau <nbd@nbd.name>
> 
> Preparation for transitioning the legacy clock setup code over
> to OF.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  arch/mips/ath79/clock.c               | 128 +++++++++++++-------------

>  include/dt-bindings/clock/ath79-clk.h |   3 +-

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 68 insertions(+), 63 deletions(-)
