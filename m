Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16068C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75F621872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550094737;
	bh=dYdKR2ZcvPaNfx+sw+dWbbZfDIGk1po2vkzK1yuV1Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tcPTE/dV0EfOUdbaQFhy9sbO6NMUH1nVfTO9E18GHIfr1BmLOUCsh+O9eomvN7FNa
	 6IJQNPCPmIDTQ4UTDTPJCnEB5VD1Rq2B2vg0ppcon/eJ0L6Iq4150hnQfSdk2Bibw1
	 2DE6i37CkioTVSobOYPxH1anOBfujIVCcSO7La0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392073AbfBMVwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:52:16 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41953 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbfBMVwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:52:16 -0500
Received: by mail-ot1-f65.google.com with SMTP id u16so6980266otk.8;
        Wed, 13 Feb 2019 13:52:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3S9sAIGewehKg/nbY5R2QaNjBWBytoIHyvzFfxiwTr0=;
        b=EIA11d7uYL0cQRunb+NenHLVW8lyzGYMhoKRsOIVc446VG4XbaG2praQtfsCBDztz0
         8dmLGCWkaoTlc0I0LaLhNW3viTr7h9FK8MMI0C9l9DaAOr82+mbqfC34xbQFsntks+L9
         IaNK02xWvGC+qtd80xLp+dfyNVJaUAYnG/eXyohhYRG5f7WS072rKL6fJdM8/ang+JPb
         4mdC6/E2hBbpuwfrRHPMzXEFY0z670y4Ju8BNI5XYeotM4Q62CtVs2tEQtpFYbCPZDux
         RUL8QEwXUgNz2mboiLuQjigFj+6nneRPS8OgNZ3PVqrQWbXQl4zPOij84zXVOPdn7JDt
         TKFg==
X-Gm-Message-State: AHQUAuajTbV0W2jcOYa6a/8LROi2Gn8PMNcQwZDOz/ydSGO9hVYvFsGn
        1Xys2ffyn7JMDVZM5L9lKg==
X-Google-Smtp-Source: AHgI3IZn16uMYfhwOb3mKgNJELNHCgd5gFxkDiTmsPlxDOhUrmM+ojUhsXWcfDtluO0aC53VtfXSCA==
X-Received: by 2002:a05:6830:ca:: with SMTP id x10mr243945oto.122.1550094735089;
        Wed, 13 Feb 2019 13:52:15 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j9sm190985otp.30.2019.02.13.13.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 13:52:14 -0800 (PST)
Date:   Wed, 13 Feb 2019 15:52:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: input: touchscreen: goodix: Add
 GT5663 compatible
Message-ID: <20190213215214.GA12927@bogus>
References: <20190212112439.2025-1-jagan@amarulasolutions.com>
 <20190212112439.2025-4-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212112439.2025-4-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 16:54:38 +0530, Jagan Teki wrote:
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
