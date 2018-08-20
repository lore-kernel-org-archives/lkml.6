Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36705C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E600521756
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 22:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E600521756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeHUBwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:52:03 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36332 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeHUBwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:52:02 -0400
Received: by mail-oi0-f67.google.com with SMTP id n21-v6so28753179oig.3;
        Mon, 20 Aug 2018 15:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=69MXWh/CS2LDbrNRWWbYQh9ZaBT8+w8aoNQ+I4dOTrs=;
        b=iAKpKTVR00hgOrP3KXkyYx/E0N+LE/Gt98QR5t/f3XI73UN0Xf6TejTd4B7fjgZM6P
         yC2j2XYUiBJDbItNEqmN1k4zVd2xk/qj4PmHaUPfea6M6jBktQeOGnVexIVsgYjqrW/V
         GXJ0HcrRlHGludnsA5/JNqaoUET0lRIIRWRqyM5gAzXr9lDFUs67LRWC1kCQQbMSJXg0
         OgrQ/YqjSlz7oaHfszD0Tm0L6Ti8wt16nMzeMYv8PHRt0XRsTA29Epro2obndXpw4SFx
         kqIFMpMWX1HHejICAspZv05neQQ4D0ONbyTk1Grpb/vuMxzTSx+a1/bFzLHFf+95IrbU
         AS7A==
X-Gm-Message-State: AOUpUlFc7ptgIva8ihZejkSpSakoksmzc8dYBoq4rGmCamsOR209WvdM
        LREbaNggOisB9dbMSL22qw==
X-Google-Smtp-Source: AA+uWPw3MGwwPSIoaRKgSjXsYAHDhQq3AuobWTrvXktRL1kadCmO9jk52yxqGnTcRq0ZwGqIwT3uPg==
X-Received: by 2002:aca:d4d7:: with SMTP id l206-v6mr15044308oig.52.1534804474693;
        Mon, 20 Aug 2018 15:34:34 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n15-v6sm5525247oic.33.2018.08.20.15.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 15:34:34 -0700 (PDT)
Date:   Mon, 20 Aug 2018 17:34:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: sh-msiof: Add r8a774a1 support
Message-ID: <20180820223433.GA1580@bogus>
References: <1534517914-15406-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534517914-15406-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 15:58:34 +0100, Fabrizio Castro wrote:
> Document RZ/G2M (R8A774A1) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
> This patch applies on top of next-20180817
> 
>  Documentation/devicetree/bindings/spi/sh-msiof.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
