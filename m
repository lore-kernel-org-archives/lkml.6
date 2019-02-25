Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75057C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC9D20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551110597;
	bh=t3Vcb+IBXKkSfy+AZ0kPHtUy9+/NCegVtIswR5hbZvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cm74NWg4VyYz1RkA2fWD/UYCj488ygOtqnn4Q19hEGxbMN1yd107ptgNjYITbSEb/
	 GtCzUp5nhpDhTMdh7Woh4lVYxx/jC+8A3YzIbo6C9ZyXZ26c82UIg+OWoWKt0pZ/CE
	 2DZb4K6igDQOPzYey3xVAvsrRrCOuJOJmY2zUDSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfBYQDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:03:15 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34530 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfBYQDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:03:15 -0500
Received: by mail-oi1-f196.google.com with SMTP id g16so7683829oib.1;
        Mon, 25 Feb 2019 08:03:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IujadDX2hF7f9HNLL7DzRWQPwH7CfDha+opQqkLdPAc=;
        b=Jv/MLXDNWgA/uZ2bHcyLO7hqrZpvInuQAj5ChW+eR6AeVbrVqXtxuT3PjHkrigs8Q2
         yNIsnjN6HMumWAs76oMd+Xyyp1GoPQo3Vyyj6oh/Py07j1KyrAiuZxH6Bwq8NZZVVHRY
         eJv2g+Y00Nv107moD44zAsdV/fAVt3Qn7RwYH6QiHVSN11OQL6PSPoPVAbUhHZf75V49
         uRxL1u0a8PdI6m96Zy6WNNdTyZai8Xi1Ycu4upf56kneeTUG+KbZ40JQztb9XcK8zPAq
         uU/1L7WD+JCDEF4AqgAyGH08FqrVdvMVOsq7Mucc69JMvqN1D1vjX9RTLmPMa16SUsRF
         PiFQ==
X-Gm-Message-State: AHQUAuYS+SWVy0JpqFmqQ9fpH5PuNzWJSKmvYbfubAVXJw57UZlHy/ii
        JhYWqjK9I1wAEfIkWmMYuA==
X-Google-Smtp-Source: AHgI3IYPiSgnm1Ub3cRYaKNgR2GGGuHos+fCTz3fcyuyNE+daJ4Hc7p5pHsSFMmZxHOB/Hu3xuaLqA==
X-Received: by 2002:aca:6043:: with SMTP id u64mr10983757oib.32.1551110594611;
        Mon, 25 Feb 2019 08:03:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z6sm4121916otq.68.2019.02.25.08.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 08:03:14 -0800 (PST)
Date:   Mon, 25 Feb 2019 10:03:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH 3/6] regulator: Add document for MT6358 regulator
Message-ID: <20190225160313.GA29745@bogus>
References: <1548839891-20932-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1548839891-20932-4-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548839891-20932-4-git-send-email-hsin-hsiung.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 17:18:08 +0800, Hsin-Hsiung Wang wrote:
> add dt-binding document for MediaTek MT6358 PMIC
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  .../bindings/regulator/mt6358-regulator.txt        | 318 +++++++++++++++++++++
>  1 file changed, 318 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
