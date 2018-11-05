Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6767C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F85520866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F85520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeKFFeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:34:36 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34223 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbeKFFef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:34:35 -0500
Received: by mail-oi1-f196.google.com with SMTP id i138-v6so5676644oib.1;
        Mon, 05 Nov 2018 12:13:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q3r5NKxO2Ksj/vmkbvlQD7uRUgSDhVxSP39kwEGIUF0=;
        b=YlW01/m15L6SALRrrENeELbAgg6nU5VMl86wfy0Ix6CC9hMZ9vqDG+tkOcDCMOI7sn
         lht4rs9v0e3MPWdpWBxhVCYL9QRtPvfWFLcN6q8/jgjw14W1lx2trviVW/leIjqe6B2y
         ATery+Q3C4f+8WSwzZF9lLikzfYMdaGpqLQCIif0hVUcNeFbscN1tC8VzXeN0AatB8fq
         ANdYxo+Zp3iAWzwquY7Ey0D9YPeHxDzmA/pQM8a9FzMH0M5f5Eq99OnKowaQGfQxaArp
         dGYMoZB21jy7HbHGShwSHR85XB8fG7TnxI5mSuLSYkbSwSoV9riryJLDplL41tXxxuvK
         9QJA==
X-Gm-Message-State: AGRZ1gKTR0IdtwnSYiY8FlRtkZ9HCELHAKzHjy3yDAtu/Yi6a/IVrfQl
        +1rYQfQJFdggrvrt3OLgSw==
X-Google-Smtp-Source: AJdET5fTNaXJzQajqgpbnq0m41HUY0nODMlVZ26a4kJwKb6R0NMfDXk7EJwXEBk/WaR8k27JfTxQ6A==
X-Received: by 2002:aca:b2c5:: with SMTP id b188-v6mr13048287oif.160.1541448794011;
        Mon, 05 Nov 2018 12:13:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m65sm15501973otc.79.2018.11.05.12.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 12:13:13 -0800 (PST)
Date:   Mon, 5 Nov 2018 14:13:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, sakari.ailus@iki.fi,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>, Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: media: i2c: Add bindings for IMI
 RDACM20
Message-ID: <20181105201312.GA30170@bogus>
References: <20181102154723.23662-1-kieran.bingham@ideasonboard.com>
 <20181102154723.23662-3-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102154723.23662-3-kieran.bingham@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Nov 2018 15:47:21 +0000, Kieran Bingham wrote:
> From: Jacopo Mondi <jacopo+renesas@jmondi.org>
> 
> The IMI RDACM20 is a Gigabit Multimedia Serial Link (GMSL) camera
> capable of transmitting video and I2C control messages on a coax cable
> physical link for automotive applications.
> 
> Document its device tree binding interface.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> ---
> v2:
>  - Provide imi vendor prefix
>  - Fix minor spelling
> 
> v3:
>  - update binding descriptions
> ---
>  .../bindings/media/i2c/imi,rdacm20.txt        | 65 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
>  2 files changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/imi,rdacm20.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
