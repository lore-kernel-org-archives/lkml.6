Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652D8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B38F20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550504730;
	bh=MLsmsbeEWVJLJi2D6/ooPSeBC3MweIXa1zp58zsT3i0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q7QCrx4S2B6s5PuwVrAqf15SYG61slyBHL3eQIzn0ZQ15SoNwhDYueLUZdqDTyLVw
	 faTTdHyr20lsiT4in+Cw4lJROcgSEgwQfu89bQiocc0f/v7UvfYuPIWHJYH+gTIdis
	 VJy6MFMBATqQkS2X5NGF7IQH/Fuv7gwas25gBowk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733114AbfBRPp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:45:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44292 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbfBRPp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:45:28 -0500
Received: by mail-ot1-f66.google.com with SMTP id g1so28893603otj.11;
        Mon, 18 Feb 2019 07:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M/GUVotTp+LLy8jCwDVGd5/UwDrykrdNLLHC7WDc47w=;
        b=CMwPIt9M6I98omGnV5bzDSgv14TqkEfp5kZWACpkM0CyC/y0a5eLO7Xr3EmesYSBQi
         HkMXjcXwWvehWu85F4/wVcaJlTSZzXMboWqhoG3LWSAxCBou6uIM3rcDHfy3e6IZo3P3
         9VLsW3toAjw1RJdx/phBtYEq39mbkudIykr4ykkPa6Q1rXCwy0HOAVGkJCIAOT6gSb8I
         K1Cfx3IpEnjhfl1aN1i+5Tcbu2mjigJ7GCmltumCsGyIxtFNx5sSq0DmuLPS6LL0Oco1
         n5ZFRBdu+3VCgQ8NlmYKpYvRn7pMGliX6LPPbBIq4CltB3qCKas0L4+0ArRbsqhbpqFL
         mKNA==
X-Gm-Message-State: AHQUAua7co+xLsZf4NfA4pSi6Wi9xkgJWNoHTkQaevEd0gbmXY6Mbuae
        anOKSUqcOLyS8vc7clvEDg==
X-Google-Smtp-Source: AHgI3IZMXIFZvnp73TVkd9nbQE+rcxkgmszvIUEigzQGqO0NtPiLd1TpWPzHaQIS0GOtN1CQ3GaWSw==
X-Received: by 2002:aca:aac7:: with SMTP id t190mr14172619oie.43.1550504727879;
        Mon, 18 Feb 2019 07:45:27 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r132sm3160991oie.20.2019.02.18.07.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 07:45:27 -0800 (PST)
Date:   Mon, 18 Feb 2019 09:45:26 -0600
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
Subject: Re: [PATCH v5 3/4] dt-bindings: input: touchscreen: goodix: Add
 GT5663 compatible
Message-ID: <20190218154526.GB28558@bogus>
References: <20190217091436.3702-1-jagan@amarulasolutions.com>
 <20190217091436.3702-4-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217091436.3702-4-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Feb 2019 14:44:35 +0530, Jagan Teki wrote:
> GT5663 is capacitive touch controller with customized smart
> wakeup gestures, it support chipdata which is similar to
> existing GT1151 and require AVDD28 supply for some boards.
> 
> Document the compatible for the same.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
