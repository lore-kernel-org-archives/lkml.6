Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F9E13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE0620892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE0620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeG3MXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:23:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35325 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeG3MXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:23:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10-v6so10045033ljg.2;
        Mon, 30 Jul 2018 03:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MeNm0Jm2XfcY+5ixN7yGANI0pnCg0YuVodHDrzVuqps=;
        b=bYr/oT5JBhbN7d4NYPkuNtblO2cbHeMO6uW0eGJPBTwA6hHomJ+e+OUozusgRsVmBl
         281vwQlf1m8oh1TYPXXGDYu6r/E2ziAtcw6P8VoJPrZmCJhp9rd0jGgUIO77woAMnwIk
         B9hypoWkKTuhodgDKInji6TQNlpjngP0YBt3TT+Rj5cXY7SEjn47GXLkLZJXHdAdtPq2
         EUMdNfC/Fh28qttoeEBs28Gw0BHVmTJzKxe/Vj2ZeFhiIeo3LPfZdRGJVNGPdUjZplqn
         T5bqRzm25VgfiPe3rtnP2gFVlRt4FlIMSZTH05Nob+ma4NoPUdEgsaAAtGuW2gR5mfgr
         5MUw==
X-Gm-Message-State: AOUpUlGtrcbrObla+iS7BZG8Aot4EHKwigfBDHSxrWos369HdtHtT6+v
        ChMamc6eMi7hx80VsAsCYsg=
X-Google-Smtp-Source: AAOMgpeh0PzSHz+ZqYkuQaH2X3J1wvBK1KnVNc1lAguVpW8ttAxec3y+n0cFzpx7FRi5CirpdMZ2tg==
X-Received: by 2002:a2e:44c6:: with SMTP id b67-v6mr12282477ljf.102.1532947761417;
        Mon, 30 Jul 2018 03:49:21 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y74-v6sm1536541lfi.61.2018.07.30.03.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 03:49:20 -0700 (PDT)
Date:   Mon, 30 Jul 2018 13:49:18 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        eballetbo@gmail.com, linus.walleij@linaro.org,
        mazziesaccount@gmail.com, dmitry.torokhov@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, broonie@kernel.org,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v11 2/2] mfd: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Message-ID: <20180730104918.GB8862@localhost.localdomain>
References: <cover.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
 <04328e559dcb38b8722248af5a2de028d4237224.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04328e559dcb38b8722248af5a2de028d4237224.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 01:46:37PM +0300, Matti Vaittinen wrote:
> Document devicetree bindings for ROHM BD71837 PMIC MFD.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Please note - this patch is unchanged from previous version so I 
maintained the reviewed-by and acked by statements.

Br,
	Matti Vaittinen

