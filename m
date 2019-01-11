Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D5BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98248206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218606;
	bh=PNaSA5oi/G6SLSRjD9v6KUhmfX6uGarCAkHaMrloPNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wXcYQSj5kIUu+a7FrOsFcLMfizw+cpIAXMZJonBHXKHEcfBbucfyXJCMaqZjKu8q5
	 aKEBvIEpxWz2IeeZYy2UmnhxoRgavwtyjnioKTimNv/ENpfCY5PXmw4zfLRZqZ6I0V
	 3SXgvYl0wpiQ7sXEZgzskW3t+eJeZDORoGl7heCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390776AbfAKO4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:56:46 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39693 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfAKO4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:56:43 -0500
Received: by mail-oi1-f193.google.com with SMTP id i6so12408245oia.6;
        Fri, 11 Jan 2019 06:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dOZ7ydKjrFInmblb4snE5E2ZFfXlu7+y0nbTinIkDn0=;
        b=OXthK1Aqdo5jYbbkqtkDj4rnOiOP//5KN6/mJpmCy9CezSpOU/W0udLHfE9bIpgVZD
         ExteE09dQWSzJw4RVYy4oX6D+LMsnvWYeKl5ZO8Tym8ZoANti6jVMQUeI7huhHlPZoLu
         Pbx2ZVzuJ+JZhIQ/baRvPyNCXUcefp1ri2wS4toGtStVQNJD6w1YK/IQfdy/QHX0kSvs
         2kGKYC+RaK98SpQlulsCyP6mXViySqRlbVeDId1fKao0tTrfsmnzF7uTHSnGv5i/0O92
         cijnE7ZswvFaJCIGskvIr4096ho3NmkWakDVMz4NIj+aw7hBBQPJbhmWwvvbgEoIV/GR
         Cr+w==
X-Gm-Message-State: AJcUukc26I7fkgrJvRViG3GZL2SLiRwn+hPx3dHmX1MOCrFpHJn3fMZV
        rowPGO9NK/bfAHTjYz3/2w==
X-Google-Smtp-Source: ALg8bN6MHh/sH867VMmlp3MFoU+z+L15kBA8wRT0Ao/QgxP+nngTy5tg2TecIHSSwviwWTPgrZzHNQ==
X-Received: by 2002:aca:bc42:: with SMTP id m63mr8971423oif.323.1547218603102;
        Fri, 11 Jan 2019 06:56:43 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k13sm59192406otj.19.2019.01.11.06.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:56:42 -0800 (PST)
Date:   Fri, 11 Jan 2019 08:56:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Subject: Re: [PATCH 2/6] dt-bindings: clock: Add DT bindings for Actions Semi
 S500 CMU
Message-ID: <20190111145642.GA25726@bogus>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
 <20181231185517.18517-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181231185517.18517-3-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2019 at 12:25:13AM +0530, Manivannan Sadhasivam wrote:
> From: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
> 
> Add devicetree bindings for Actions Semi S500 Clock Management Unit.
> 
> Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
> [Mani: Documented S500 CMU compatible]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Rob, I have removed your Reviewed-by tag for this patch since the
> earlier revision contained only bindings constants and lacked the
> compatible documentation, which is added now.
> 
>  .../bindings/clock/actions,owl-cmu.txt        |  7 +-
>  include/dt-bindings/clock/actions,s500-cmu.h  | 78 +++++++++++++++++++
>  2 files changed, 82 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/clock/actions,s500-cmu.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
> index 2ef86ae96df8..86183f559022 100644
> --- a/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
> +++ b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
> @@ -2,13 +2,14 @@
>  
>  The Actions Semi Owl Clock Management Unit generates and supplies clock
>  to various controllers within the SoC. The clock binding described here is
> -applicable to S900 and S700 SoC's.
> +applicable to S900,S700 and S500 SoC's.

space needed after the ','.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
