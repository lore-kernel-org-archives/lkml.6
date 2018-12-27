Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315B8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41732148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545944996;
	bh=oZqznBXMaiZnqAqQGyMlvK6Q621EYR+qs40m6c8fOzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jMf+jmUXFZrhEmaXU19sZ/CJZtZOaFQSeNKhZt+VsCfKikwm0A9DTP2J+yKL7KlMN
	 cSBp6fzh4JYt9Nka5IMy4H50Su+QoBpau/yMTeLqWe+GN1xMbT8nsQIO9yd7xmPz7M
	 /l68lS5WKvB+QFXt3nAzugAk0B1VU0Dup2tXHjxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbeL0VJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:09:55 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40280 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbeL0VJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:09:54 -0500
Received: by mail-io1-f65.google.com with SMTP id a2so3058071iok.7;
        Thu, 27 Dec 2018 13:09:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i3w/R5gR+TdjmOUjmdVKVXjH3rS0dZDOdRUKMIU0C5I=;
        b=nVoLn1TTh1UjN3loMLWmzNftLA7SaUdxSTdWMOlIp3d4K1DktvCJBaGdZTBKkBA1Eg
         ztXwrY5A+54FLz6DMzThSz6WtY4fTojJH4xKk762NX7XY/Yo3B821Z8jT9RvrfVU55NC
         +6K62DdJQC/01evmA9G9bssqUf/XOGtmFe3X2u3NfaigV8vX0ken9yj+PCAA0vlS+aY2
         5QpKN0kEUkS5tXoEL3J9WWzOzSW2CBUSl+nzdI8nlTB+wqIqEigJ3f7sF88BdUo2AVLI
         9JFt9J4JF6NNpJOV/JhgHxGPUbNmfchtXUz2gq+GKypNJcrhc8dIR43wXK8xs8JlDK4e
         Aidw==
X-Gm-Message-State: AJcUukdCFFbMKCEz7iS1t80RIFk67UQwkdlRZ/DUl6+OKw1KFwSMN5If
        4poOumqMZtdwdkK9DTpuiA==
X-Google-Smtp-Source: ALg8bN6uxLNlL1SLxOd7h8Pw3C2ra6M6k6X40yXAXjKSMhjwoxv27WAOCn7jg8WfGYzvOkcZyslZcQ==
X-Received: by 2002:a6b:7844:: with SMTP id h4mr2137221iop.216.1545944993830;
        Thu, 27 Dec 2018 13:09:53 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id m186sm12985893ita.2.2018.12.27.13.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 13:09:53 -0800 (PST)
Date:   Thu, 27 Dec 2018 15:09:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     cezary.gapinski@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
Subject: Re: [PATCH v2 14/14] spi: stm32: add description about STM32F4
 bindings
Message-ID: <20181227210952.GA26671@bogus>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
 <1545688840-23992-15-git-send-email-cezary.gapinski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545688840-23992-15-git-send-email-cezary.gapinski@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Dec 2018 23:00:40 +0100, cezary.gapinski@gmail.com wrote:
> From: Cezary Gapinski <cezary.gapinski@gmail.com>
> 
> Add description that STM32F4 can be used in compatible property.
> Master Inter-Data Idleness optional property cannot be used in STM32F4.
> 
> Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-stm32.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
