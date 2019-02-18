Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0732C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CE02177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550520857;
	bh=sOxAesjZVElS8IIBFeX7pzeAp26m1jG/eS6Ws36ZB8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ip9wiBtn7zrUgB1o03LUVB1PGiqGuy/TxDqfxjM/EUyix8eqZyaoYpxB9NqYYFMyK
	 +1mEPgPyZTAnOcxeDJFJBylMpJfQwpuCMWnONBqR8y/3j2c3uUbZCCsA0h+cjROTzc
	 ldEhcbctKcGG0omiZ4OIJi0s+pMBU86d6o77eGzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfBRUOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:14:15 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36684 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbfBRUON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:14:13 -0500
Received: by mail-ot1-f66.google.com with SMTP id v62so21551135otb.3;
        Mon, 18 Feb 2019 12:14:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TaGq6Swi6t0rjyTIWUdp4Spul3J3+8Z15uErkox673M=;
        b=V0KHBaI+enihakDr7lm6Hq2mRcs1Htlu/Ak2dxzfLtRP5IL9ml0svjTkTkfWBDT2AI
         FKP99ArTKMl4wO9QkcFEFXAG4QcsrwlLi+ljd6BM1E2dx3Nr+8R0hzB7AtZCX5rB2+XB
         3Aiu9k4U+44BCy1+VQTL8dt/ULIe1HbwXfrUaZb6+8Cdt9M9e8Bn903NkCkQ9KuBoti7
         D0bQF5uYeNvV35Dipr2kaT2BbLVoKyK5O6piA/IA+Sgg9ZpqamkeG5XeGbV6BHOKaEgx
         g9CHTkDk2LqFo2Sx+oshh3NfN3VWFxF4YaYt/qqfF7y+Qi2gEagYmvIyboXpJozWB66f
         /qyQ==
X-Gm-Message-State: AHQUAuYW50/dmgWGi9niquELnssQsZWHSJl6UrC6mRp1qSSZgemoOB2h
        PBF6BYEYFDaR3KIZmrXP9g==
X-Google-Smtp-Source: AHgI3IYPxQickug7brkMAIEcQez16rN96JR79Q3Ko5kWNmErFq/3PKFVM240evm3ddIemJvQM9UDCA==
X-Received: by 2002:aca:e886:: with SMTP id f128mr395222oih.68.1550520852489;
        Mon, 18 Feb 2019 12:14:12 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v20sm5416635oto.31.2019.02.18.12.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:14:11 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:14:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        marc.w.gonzalez@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: clock: Add support for the MSM8998
 mmcc
Message-ID: <20190218201411.GA19332@bogus>
References: <1550377885-10618-1-git-send-email-jhugo@codeaurora.org>
 <1550377934-11377-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550377934-11377-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Feb 2019 21:32:14 -0700, Jeffrey Hugo wrote:
> Document the multimedia clock controller found on MSM8998
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,mmcc.txt   | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
