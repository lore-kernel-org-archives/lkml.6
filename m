Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5556C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00BD2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00BD2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbeKFGGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:06:25 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:43021 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbeKFGGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:06:25 -0500
Received: by mail-ot1-f46.google.com with SMTP id k9so9325225otl.10;
        Mon, 05 Nov 2018 12:44:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=moidK84xtAkg/EtIjFl9J0LlaBge2nOfQ47pXyoUsHY=;
        b=KG/lSYh1WPfTyDzt6kaFj0KKqYSya32YJ91zNss+Di8fBSupfASlbgxX3Kej0W9rnW
         lZ7qNoy3aqIaEd41MMaJF6Uxn8IhJ7CljjAELLaYYTwpTomKfiOl4C+7CafKeqdQqJ4Z
         2dnGKMgJJ6TPV/tZfg4Ys5FcEGYnFnkk3ryLHsweGr3gXPNVPMKpeZRA/QCnU+p6N4uh
         PkqY+qk+2sqFaoJfEoxBGFDwto6//3iMxq8xk+Njcje/hv1GuOZ4XHmjXDE75dElBHnI
         lwarNKzu+nudwTwr+bbRloGR7Q+/E5ojMw+usA6MxoZQzLYE66fSb0H3YH7uCT09cd1D
         nrbQ==
X-Gm-Message-State: AGRZ1gK7uKf+8NTWsv+xHWyif3iyOGRKA4QJNpR1SnmXT+JBUMUvvEI+
        YBVHChhW9OuJ9TzJ71JPQg==
X-Google-Smtp-Source: AJdET5fkcI5w3qtM5bEbzfktoiNuN5/mie09X6W2Qoq1UBdIirZ0mJUPiBuT50FGJXc4nWAjaRUPmA==
X-Received: by 2002:a9d:40ba:: with SMTP id n55mr9373976ote.26.1541450695082;
        Mon, 05 Nov 2018 12:44:55 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y23sm4565017oti.24.2018.11.05.12.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 12:44:54 -0800 (PST)
Date:   Mon, 5 Nov 2018 14:44:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     thesven73@gmail.com
Cc:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org,
        lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH anybus v3 2/6] dt-bindings: Add vendor prefix for arcx /
 Archronix
Message-ID: <20181105204453.GA17511@bogus>
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <20181104155501.14767-3-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181104155501.14767-3-TheSven73@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  4 Nov 2018 10:54:57 -0500, thesven73@gmail.com wrote:
> From: Sven Van Asbroeck <svendev@arcx.com>
> 
> arcx Inc. is an engineering company which provides advanced
> embedded systems and consulting services.
> 
> Archronix is a technology design and product engineering firm
> specializing in hardware control systems and enabling software.
> Clients include OEM's in the transportation, aerospace,
> medical and commercial sectors.
> 
> Websites:
> 	http://www.arcx.com/
> 	http://www.archronix.com/
> 
> Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
