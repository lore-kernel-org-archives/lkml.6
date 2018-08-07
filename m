Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0795C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC8121524
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC8121524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390245AbeHGTgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:36:25 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33330 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389148AbeHGTgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:36:24 -0400
Received: by mail-io0-f194.google.com with SMTP id z20-v6so14677849iol.0;
        Tue, 07 Aug 2018 10:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sFQqwzqZOuyvE4C9DS98xkFcdfezxA9gpaDgX0tFYeU=;
        b=gFA9euGmc3/3iygy1ftxte49EmeKVL6yjGrupfSW+Kn3HhKrSpi4vYdGSdVoaX4PuS
         YOQ9xy0ZgOkketQ0xDPfvPmI5DWIy93fpoB4BlesKe2ni6LoPFXOPWzwdeN3Xfk9qFdK
         zdYrFSonE5V2M/1XR9EcsXbqu+kP4a3kyOdDr60utPdBWSl+NlCF2mFaKHx381qpEq9h
         mrsQjQKtBhizpJi8oO0drlnRdrBMEFMoy7BvsXlSLN4RqYSTgVoqXsxJjPNLRwSDXA+X
         gc9z7bKTRjVaVTh4KlIiGOPjcb8sCODCqzwWIy9c/EpOTEyLRvYvF03qis/KcYtDSp/1
         gGyw==
X-Gm-Message-State: AOUpUlFUGoqUX2Mcxe4mtyrnkhva58TZD72fW32rjD3iS8v4AKqah4YC
        07Lc0TxhBddwSQi79+5o5w==
X-Google-Smtp-Source: AAOMgpe6Qt4XTBQ085ZPjKqkekHrrDXPnAhnT487kxj2OZ4zVfqTIZlgL3CaC+hYpDbsHypkhE/P2g==
X-Received: by 2002:a5e:890c:: with SMTP id k12-v6mr18546653ioj.182.1533662463188;
        Tue, 07 Aug 2018 10:21:03 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id h71-v6sm983958ith.9.2018.08.07.10.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 10:21:02 -0700 (PDT)
Date:   Tue, 7 Aug 2018 11:21:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     jic23@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com
Subject: Re: [PATCH v3 8/9] dt-bindings: iio: tsl2772: add binding for
 avago,apds9930
Message-ID: <20180807172101.GA12095@rob-hp-laptop>
References: <20180803001900.25371-1-masneyb@onstation.org>
 <20180803001900.25371-9-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803001900.25371-9-masneyb@onstation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 08:18:59PM -0400, Brian Masney wrote:
> This patch adds avago,apds9930 to the tsl2772 bindings.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  Documentation/devicetree/bindings/iio/light/tsl2772.txt | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
