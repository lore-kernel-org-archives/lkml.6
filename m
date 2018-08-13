Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1EAC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB3A21738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB3A21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbeHNA0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:26:21 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36624 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbeHNA0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:26:21 -0400
Received: by mail-it0-f68.google.com with SMTP id p81-v6so16607015itp.1;
        Mon, 13 Aug 2018 14:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1vjM5a8/q30UZifwIsOK75fl3y6ccyYEut0PVEQUgTc=;
        b=jKWPrHe7by3GT9wddgZf1VO6wjLC2I1dbTRBnhWcXzHAAmoQkzM5RdB9AS7VDYvzzr
         IrLa1lSaEOuRuMY+l0Pribf9ocGom+1BiNbfvNJA9bC80mbwxE8BuqG1WzN4QfYmT/5j
         MdeAe8jU0gYTX9c2ICTcYnqQaG/ROIt1bOxpPNRwrH4zCbCo1Kof9fFajlL0rf4XLGon
         USzzHHfk+gsKosK89SW+C0xjYWvkUxsUeIwu5VZca3S5hvYz+nJO1VApE6hnkfEPbzoq
         ho0XhfcrB8ewG4Z+P879sT+31RuCz8pJslqMOHpeQZgFm/OXRVa3fSqIIeoBpicV4ML8
         mCrQ==
X-Gm-Message-State: AOUpUlGffEjSsT36serQ57/xnGAcxv6XSrnK/Rv3DF1cDI7UfVuvt++j
        yeIbNE6dIa+s0nzWze3+Tg==
X-Google-Smtp-Source: AA+uWPwtaGlVQp2VyDhidQbdX238YZ1o7j9OMW0ikzptH5GIR+YSjrYT9Irm6OoFi9cOCuOts0nsqg==
X-Received: by 2002:a02:8cd6:: with SMTP id n22-v6mr17146382jal.106.1534196538878;
        Mon, 13 Aug 2018 14:42:18 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id t187-v6sm5996918ita.28.2018.08.13.14.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 14:42:18 -0700 (PDT)
Date:   Mon, 13 Aug 2018 15:42:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Jian Hu <jian.hu@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: amlogic: Add Meson G12A binding
Message-ID: <20180813214217.GA16738@rob-hp-laptop>
References: <1534160901-22889-1-git-send-email-jianxin.pan@amlogic.com>
 <1534160901-22889-2-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534160901-22889-2-git-send-email-jianxin.pan@amlogic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 07:48:19PM +0800, Jianxin Pan wrote:
> Introduce new bindings for the Meson G12A SoC
> 
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
