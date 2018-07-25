Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A71C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3368320843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3368320843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbeGYUbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:31:03 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39209 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbeGYUbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:31:02 -0400
Received: by mail-it0-f67.google.com with SMTP id g141-v6so10187332ita.4;
        Wed, 25 Jul 2018 12:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7pG4bNwgPp5HhTpf0oGnXeb2n8uE51MOsvLTsAqrY6A=;
        b=C5CLNHa2AipDOD7DNxLI+Ui2Kt70i1l8+pyWBxXTeDQbYfB0Lbnf4SdMspH21L3Awc
         QfjLU8z/r1RNGg3uKFd4ECw/4SsAiTuoQzzy8DlmeQeGZgCG15GDspUXDajK2Uva1ado
         XkiCIGjRw9hCwBSk9+VI85kPe3KE4u76vB3ymzSXXLVr33HiP8nCriyelovu40m3akcf
         7dX5ISVvTmKf3hBX13ofwERXJfoW/pYZA9C7MCLevkAX40NZKOgN1npDOdnRb/0IJ8JZ
         M5m0NgakMLdbEiW+YagQ9uHjhRdjGU5v1CILQ1cDo/QBSAgbJPKGQ7f/54bJlQRDBqLY
         P4YQ==
X-Gm-Message-State: AOUpUlGM4C1uKeRNG352C01Avb72/zO7yqLgEOhHTR4w1jC6RWXlQZML
        8kOyB9ZYx2TevaB3TO0V3A==
X-Google-Smtp-Source: AAOMgpe/2KECGg13ZeKd+hfefltJu4eW0XHzUpHKjUlpB6vacged7V6o4AWMnwe80/eJq9rtAhSUKA==
X-Received: by 2002:a02:6a2f:: with SMTP id l47-v6mr20993017jac.71.1532546280296;
        Wed, 25 Jul 2018 12:18:00 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id f20-v6sm629146iog.5.2018.07.25.12.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 12:17:59 -0700 (PDT)
Date:   Wed, 25 Jul 2018 13:17:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Keiji Hayashibara <hayashibara.keiji@socionext.com>
Cc:     broonie@kernel.org, mark.rutland@arm.com,
        yamada.masahiro@socionext.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: add DT bindings for UniPhier SPI
 controller
Message-ID: <20180725191759.GA5573@rob-hp-laptop>
References: <1531983117-9443-1-git-send-email-hayashibara.keiji@socionext.com>
 <1531983117-9443-2-git-send-email-hayashibara.keiji@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531983117-9443-2-git-send-email-hayashibara.keiji@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 03:51:56PM +0900, Keiji Hayashibara wrote:
> From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> Add DT bindings for SPI controller implemented in UniPhier SoCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> ---
>  .../devicetree/bindings/spi/spi-uniphier.txt       | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-uniphier.txt

Reviewed-by: Rob Herring <robh@kernel.org>
