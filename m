Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E797EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47D5218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dwKPCXl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfBLIi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:38:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50749 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbfBLIi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:38:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id x7so1957903wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=P66M9vPQ6VNIjiKED9BAzxRQ8E8kuyOXCyaOR0TCTNE=;
        b=dwKPCXl6jW4H6otT0dIM3QvM83Q7f0HJ5PKXocYDDeGHX36XwzGEiglNg5XSEFt0/J
         XZ+q8q20R8MRZ1mhs9kEH+TAZUkiW7ZPs0wkXCEDDUNJCsyYT2fYU0LmUmLXtnEy/3ai
         NsA9PR3tikrzqLvKSwhedC7rMxtrQPu8Qxg0mBUxdOZpL7jknKjfyRLil5eCUAnKuN9M
         Pw4l3livYKoSwyjhQ9S1YucUd2b41ZkGEFsjBZEqxBOg2FuuqpTKIfA6XrOIQf1SWTLA
         VLgL80bcK7gECeekdij0tzzxOTcIYcK1j89g5ZG5OhcuE6+vtnEkv+y7TuWKhPEa79l/
         aK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=P66M9vPQ6VNIjiKED9BAzxRQ8E8kuyOXCyaOR0TCTNE=;
        b=rh5h3hTj+VERCMcbZHhUGEkhKaP2VPL6rLGi8/jbfGLEUTHe2AKbXo1dWMFUVYYnAf
         83vwcwdqB1MXTlMnbpcgN3IH0DuvmVUqbnxVX9ajL0hwjw9wQeQ5g+HFDA/uxIoChMzG
         xLXP3SUDsZFDROrqg58x5MkxL/oCsDeBCp7FflGpIEKMhh379GfEqsyulbo/gr9wgTSc
         I5wRqyWce5NyXfafBKCCE8e3KlYsZ+nRzSvIk0yOFPOcMyFq9GuUyxSTmh7N+hT13KG+
         5vyiImQiq/NzxedoSIgDev38QnV625qOI74K/ykf1OeySLaPhcbIhfIIlZurp1NrVETk
         gDTw==
X-Gm-Message-State: AHQUAubzcG5JGmtYkNPsEq4nK4i3PzAz6YNtsXt9CKYWQeeIzTyIEAPX
        DS+KVAo7bwuIA7S0mImh8xV8fA==
X-Google-Smtp-Source: AHgI3IZ15p3VC0QRB7jsiZ63aF7IqoGfNmEb6m2fywEHSviJitfegfzYfIkOCxTGG6WYpgT1xfZKqg==
X-Received: by 2002:a1c:7fca:: with SMTP id a193mr1979670wmd.36.1549960736516;
        Tue, 12 Feb 2019 00:38:56 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id v4sm2359318wme.6.2019.02.12.00.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 00:38:56 -0800 (PST)
Date:   Tue, 12 Feb 2019 08:38:54 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, tglx@linutronix.de, shawnguo@kernel.org,
        dianders@chromium.org, linux-gpio@vger.kernel.org,
        nicolas.dechesne@linaro.org, niklas.cassel@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 04/11] mfd: pm8xxx: convert to v2 irq interfaces to
 support hierarchical IRQ chips
Message-ID: <20190212083854.GU20638@dell>
References: <20190208021631.30252-1-masneyb@onstation.org>
 <20190208021631.30252-5-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190208021631.30252-5-masneyb@onstation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Feb 2019, Brian Masney wrote:

> Convert the PM8XXX IRQ code to use the version 2 IRQ interface in order
> to support hierarchical IRQ chips. This is necessary so that ssbi-gpio
> can be setup as a hierarchical IRQ chip with PM8xxx as the parent. IRQ
> chips in device tree should be usable from the start without having to
> make an additional call to gpio[d]_to_irq() to get the proper IRQ on the
> parent.
> 
> pm8821_irq_domain_ops and pm8821_irq_domain_map are removed by this
> patch since the irq_chip is now contained in the pm_irq_data struct, and
> that allows us to use a common IRQ mapping function.
> 
> This change was tested on an APQ8060 DragonBoard.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes since v1:
> - Put u8 config[0] at end along with a comment
> - Hardcode the IRQ flow handler as handle_level_irq like the original
>   code.
> - Don't set IRQ handler in pm8xxx_irq_set_type() since this is already
>   done in pm8xxx_irq_domain_map(). Linus: This is different than what
>   you tested but this *should* be fine.
> 
>  drivers/mfd/qcom-pm8xxx.c | 75 ++++++++++++++++++++-------------------
>  1 file changed, 38 insertions(+), 37 deletions(-)

For Linus:
  
  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
