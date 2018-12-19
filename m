Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1756BC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D137C2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545245735;
	bh=hNLNctRUGV6DWK8yI8Df6Q3pz6d+a7qTPKjiJq4xlzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m7fI3Di64H8WWPok4mqsyeBtT03cG9Y2Zrua3Drl6qtJ0rUYXhHaEChGmRhtsfkmX
	 nVoYsSl26tnbY8VjqM2AAyILBtavRO/O38ij6YBj8xdPDewLwiA0AhyZaXok7OVgGX
	 GhctDNLaCUb/wRLQm6genhfZGUDVa8+ms9xI7UtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbeLSSzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:55:35 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37771 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbeLSSze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:55:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id 40so20093736oth.4;
        Wed, 19 Dec 2018 10:55:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7HUiX94SswtmPoBx8ulvQvKbQnVaVrrXa2kPGfNaJmA=;
        b=ASbvRwc40EocBsJJ88qiwFmXZ+Og39Rd/1KtLRSskwFsB5Lq4roCPvYQ18kwRlMefM
         YWYwRyiJW81JYUHZVFBYcd8omM8juRxcoLP1apDAOBjYOyDOt+mLa4Aykn7WdrchOGVQ
         JFSiP6rUNHucen7WYT/zVe1wY0VARxWeTy3qje1hLeBDmZ/1jeL+bRWGEDS6c/mL0xL8
         ESiEF/59X6fYwrLLablY/hA60mGoSGFwl477drfP/wRVG9q7XtyPyDgiSYLysVwvmsuP
         KO7/9fsruyj5mANRULyyBRfxdCBBqe4NOX3fUx73AX7yxN5A0A0OdRshD3h/K/UwkQS7
         PWtg==
X-Gm-Message-State: AA+aEWbrYAleYGMUodnGjSj5DUNfFNAG+XuEX5sKRtPecKAwJQRfci8Q
        yaPvL9gpjxuAf6KNnzrYIw==
X-Google-Smtp-Source: AFSGD/VA3IeSpI4dOqWG8JdMkU6bNwBHLzrT0RuSxICdlpmpsZ16HctWXin0Pkg413rmy4udhGa0eQ==
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr16508683oti.258.1545245733637;
        Wed, 19 Dec 2018 10:55:33 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m129sm9265078oif.50.2018.12.19.10.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 10:55:33 -0800 (PST)
Date:   Wed, 19 Dec 2018 12:55:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: clk: meson: add ao slow clock path ids
Message-ID: <20181219185532.GA23002@bogus>
References: <20181204165310.20806-1-jbrunet@baylibre.com>
 <20181204165310.20806-2-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204165310.20806-2-jbrunet@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  4 Dec 2018 17:53:06 +0100, Jerome Brunet wrote:
> Add the CLKIDs for the slow clock generation path
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  include/dt-bindings/clock/axg-aoclkc.h  | 7 ++++++-
>  include/dt-bindings/clock/gxbb-aoclkc.h | 7 +++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
