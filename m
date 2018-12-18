Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BB1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E769321852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545145564;
	bh=95o5H5p7Dy37rEj5e5YiEo/96JOdLJR17pg3p35Q2qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pO9NfWtVGWTeppKItbQtAon3+pcPinnmMuNwUVCGCgSFnZlBOPInyrwuaDQoYRDd9
	 C/UGYKeXrRzZa7fVz3tHWYN8HDz2NNimnqcjCsJTgcH3v0KaxysMitm3R3ogNFq0CV
	 0yCDKTEiod2ULNjL8bwtbuvdjdxDIVNSNiJnaC4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbeLRPGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:06:03 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38694 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeLRPGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:06:02 -0500
Received: by mail-oi1-f194.google.com with SMTP id a77so2183388oii.5;
        Tue, 18 Dec 2018 07:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iINXAnsEg25OH0YeS97fnge0Mfj0Jw4WrrlUvScm9AQ=;
        b=pm8OvueiTVq1OKaXVAOKEuApJfn574bAjHGZgA8CGEDpwXY9UAkSz3oGA9WcqcqnFg
         vgiYDClroKDxLb9fyLmpOOF7DgjFHLAwQ5zZa5GCOJz89GDNdCdRldxlSQUs6c8vynQg
         Fh9q2Rm/e0dcv1xWjtt7wv4m0woYwk1e3lH0CzYkHwocVWPL98DEtpgA7Z7817iojnmm
         9s/HJoNr+Wl8E3zJm5nBXmwkHaqXLzYkMA2GYQ2SDfftFuMvE2XFPA1AZF9MF+2uRFig
         aOEUEbqHulY7jn3aqdE1V6p+hFxSP8vNp9EoFug5mhxnyrd3TI7rxffNBjFUAfuXUNxY
         Q7nQ==
X-Gm-Message-State: AA+aEWa7b8xU1ERFoDbrjQDzBTAJPms+GtjIaQudsnVd4iL12LDxcmsB
        kKJRMaF92RwTcVYOc9RR2g==
X-Google-Smtp-Source: AFSGD/UeTPd0Y0oj7yBH3XX5RoHGytSRUYjrR74cVTSj+0LMI0iIZRmwckMYcSWViDiehOrwXUmIrA==
X-Received: by 2002:aca:f389:: with SMTP id r131mr8254816oih.58.1545145561814;
        Tue, 18 Dec 2018 07:06:01 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s186sm7495833oie.13.2018.12.18.07.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 07:06:01 -0800 (PST)
Date:   Tue, 18 Dec 2018 09:06:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: Re: [PATCH v3 1/2] dt-bindings: irq: add binding for Freescale
 IRQSTEER multiplexer
Message-ID: <20181218150600.GA26309@bogus>
References: <20181217140120.12009-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217140120.12009-1-l.stach@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 15:01:19 +0100, Lucas Stach wrote:
> This adds the DT binding for the Freescale IRQSTEER interrupt
> multiplexer found in the i.MX8 familiy SoCs.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> v2: clarify channel and irq-groups properties
> v3: switch to onecell IRQ handle
> ---
>  .../interrupt-controller/fsl,irqsteer.txt     | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
