Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B315AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974E9206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974E9206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeHOXPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:15:44 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33877 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbeHOXPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:15:44 -0400
Received: by mail-it0-f65.google.com with SMTP id d70-v6so18328637ith.1;
        Wed, 15 Aug 2018 13:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JPQO6rsc72XEZ/7VSh4wB4wC7fZK0qO7rHgBw3/ws4w=;
        b=rvm9Xe2gP+1adbeW+PeUrEjE7pNuDHiWib7aEG1yzIV53CRv5jJvH2bQHCnVO2bYg4
         zWUG+jOWkt820nY4WaIxmIHRdJqaxrXKRcnHS7KMoo9FY/VKZ6InSR8ufqcyBJicXJZ5
         YJRWxSI+bBCTG083UTIEGXKTEy6th4HYWdG+2+yzPqdOOBKwNikyi8SNir/HSbr1WxkL
         hUrPBVn3LuOCUN96q/ToKcJ2v/KaX0bL2WwJ5zy2q8hjVEMdRF1VDI9CS3XogC8yAZjz
         Bpd8sQwd2Y81StNulTVHpnQAJ0CoTABtqSN8r2vstH8AXufpWQH+C2766ti9m+TaUQgg
         htdA==
X-Gm-Message-State: AOUpUlFAPcEkwlwC2t7Bya11hJw+D3cjVXiuSgTkWdKWUNT+fRCizC61
        lI9dcmAKEycgsJdBO6adzA==
X-Google-Smtp-Source: AA+uWPyyGdO3QFoO1LtQ8r2xClNfyohz+NTMw8OP/pET39LRXpJFTmZFXBcykytUGZUhRSf8OovTmQ==
X-Received: by 2002:a02:879a:: with SMTP id t26-v6mr23533046jai.67.1534364523589;
        Wed, 15 Aug 2018 13:22:03 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id a79-v6sm1405773itc.33.2018.08.15.13.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:22:02 -0700 (PDT)
Date:   Wed, 15 Aug 2018 14:22:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] serial: sh-sci: Document r8a774a1 bindings
Message-ID: <20180815202202.GA12472@rob-hp-laptop>
References: <1534250042-15815-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534250042-15815-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 13:34:02 +0100, Fabrizio Castro wrote:
> RZ/G2M (R8A774A1) SoC also has the R-Car Gen3 compatible SCIF and
> HSCIF ports, so document the SoC specific bindings. While at it,
> update the RZ/G1 and RZ/G2 family specific strings description as
> outdated.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  .../devicetree/bindings/serial/renesas,sci-serial.txt      | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
