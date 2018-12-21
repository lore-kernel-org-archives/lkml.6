Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A523C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277372190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545416340;
	bh=6gP6LwTz3rZD2izOuUS0UL1U895eN1k3+aFdbqnwwFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E2Yac7+Da512yY0dXtRwfHLWQNGazBugZiYBuYj5bukW9PBzVdol0GYtsyV7NkWHg
	 8AyCKJIhV2p+FEwd5IbBCvxtKa/LsItwjDbUGRInIAdOP0R7OmxBPsGIy6E+89+4RM
	 ypgCYfOUw7TFFgCjMatXSmryxUxFQMby5ARxdxE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389380AbeLUSS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:18:59 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46598 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731660AbeLUSS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:18:58 -0500
Received: by mail-oi1-f194.google.com with SMTP id x202so5482539oif.13;
        Fri, 21 Dec 2018 10:18:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YMUcRmedR1+TWGOjoz0Wlfhqc+rkPb0GF3TzBUuCLYA=;
        b=oNYQAPTTzQcoz+MCnRqhLAiesiiOGl7+i40OqUFReszcocumSySBklnbuKes0ER+hN
         Gf5XclMrRGR0v670AS2vf7jb9KcQW2uO/XWQk75xxbSS3p1ZmnAcCF3tmueEoNRCxqme
         mudbmUwRolKNff9jHxGQcbyuO3IEnOtIs8XVXdUHc+y0uGjekyGj+IVjkhqzfGqFfb8v
         4DdhEjPbqo1mpIoTP1xH5jYrycDgNhDBvubeZTuk7KSH4ef1bwA65tqs2ulBy2T4hAT8
         9IUmrU+f1b6HoG46uGcaWwMWCXIpntCsfjvFbLJ1tYUi3wPlrsG8v7zBPjo7zE3wgz9Q
         /iWw==
X-Gm-Message-State: AA+aEWZ1dTboG3gP6HtJUtJM+MaAJSGWW6DzhBpJfslTlGH65Y8LEZbx
        TZ5d9rZULA5zn1eMqjjFhg==
X-Google-Smtp-Source: AFSGD/XUXMmQl06uZgiT0gemqrUbdmLYDxBCg8xj5pPNaYPvlxeYPHFVVh1FjXAvR1cFBY/kZRHHWA==
X-Received: by 2002:aca:5d84:: with SMTP id r126mr2157519oib.227.1545416337485;
        Fri, 21 Dec 2018 10:18:57 -0800 (PST)
Received: from localhost (ip-70-12-27-227.kscymo.spcsdns.net. [70.12.27.227])
        by smtp.gmail.com with ESMTPSA id f18sm12822700otl.18.2018.12.21.10.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 10:18:56 -0800 (PST)
Date:   Fri, 21 Dec 2018 12:18:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        jbrunet@baylibre.com, narmstrong@baylibre.com,
        khilman@baylibre.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sboyd@kernel.org, mturquette@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 1/5] dt-bindings: gpu: mali-utgard: add Amlogic Meson8
 and Meson8b compatible
Message-ID: <20181221181853.GA29842@bogus>
References: <20181208171247.22238-1-martin.blumenstingl@googlemail.com>
 <20181208171247.22238-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208171247.22238-2-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  8 Dec 2018 18:12:43 +0100, Martin Blumenstingl wrote:
> Add a compatible string for the Mali-450 GPU on Amlogic Meson8 and
> Meson8b SoCs. Meson8 uses an "MP6" variant with six pixel processors
> while Meson8b (as cost-reduced SoC) uses an "MP2" variant with two pixel
> processors. Both have a reset line to bring the GPU into a well-defined
> state.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
