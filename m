Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9CBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149D320841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149D320841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbeGaW3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:29:54 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35068 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeGaW3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:29:54 -0400
Received: by mail-io0-f195.google.com with SMTP id w11-v6so14237459iob.2;
        Tue, 31 Jul 2018 13:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kw7m9ECsqBt287xiBhl5zxoJ4Qna/MsUWGJvOoGhXiw=;
        b=sipvFie0ZnmhedzNQ8BduQsPF88j2Ta67HtEeyOMGnJtxcVVDTc1cYEFRMOqfWZ5q4
         GCWNNgFjHuCgfusN/EczZD1l2DD9CIPPGeWOlnsxgC1RgOtBzO7BvnSNWGvuMPoWStw/
         jhKvGVH/DKgCwO6jQs5/VZ4KiblfGAr4j0QkTkQt480CszcdhDBIrJE1MNYkrmD92Ir8
         mqm6wbRasjRmLRIJzy0vUAPI8NY5ZTOOwEAed8ecLuWZsr2RDfBvtDNdvOefZAoPYIPm
         HFK7Txevzgm7K/3mvCkpAAIH6UtmNGJooxqHeJNysURqAPcSueXM4HLbavq0T2DYOx/M
         Bukw==
X-Gm-Message-State: AOUpUlGMYQcitAXQHoZAI5DNf8mtkexO+bH38C08OkeffACCLX7CtYd7
        SoWUk3a8BIjZz0SBnEl6cA==
X-Google-Smtp-Source: AAOMgpfDAVgviwWm33UTj6cOwvVvciqkztU4BRkm7MQ0NPJKwRQT9jKj3mINOfOrX4J02WSEbklkkw==
X-Received: by 2002:a6b:88d4:: with SMTP id s81-v6mr1136972ioi.98.1533070066129;
        Tue, 31 Jul 2018 13:47:46 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id z2-v6sm1824743iti.3.2018.07.31.13.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 13:47:45 -0700 (PDT)
Date:   Tue, 31 Jul 2018 14:47:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Arun Parameswaran <arun.parameswaran@broadcom.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 1/7] dt-bindings: net: Fix Broadcom iProc mdio mux
 driver base address
Message-ID: <20180731204744.GA9993@rob-hp-laptop>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-2-git-send-email-arun.parameswaran@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532726613-6483-2-git-send-email-arun.parameswaran@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 02:23:27PM -0700, Arun Parameswaran wrote:
> Modify the base address of the Broadcom iProc MDIO mux driver to
> point to the start of the block's register address space.
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
> ---
>  Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

The example is just an example, but okay...

Reviewed-by: Rob Herring <robh@kernel.org>
