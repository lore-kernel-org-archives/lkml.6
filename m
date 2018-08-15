Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D58AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEE9206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FEE9206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbeHOXRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:17:48 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34040 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbeHOXRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:17:48 -0400
Received: by mail-io0-f195.google.com with SMTP id l7-v6so2065272ioj.1;
        Wed, 15 Aug 2018 13:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6eb5Q/pWQGm0WGObuIuUyUhGMxE9l1RfeDgDAnbln7s=;
        b=LuOZ9VSjU6P0SI78SPHFBBQo0dozvOVkRxg8r6nH03bLy93wCOAr0v8hGNGU0zIRRo
         /aglNKyJ69bS/kjhGz3Aoc2nJ6cMBDyOFh93Tq4/EP2kcqhvvV8JK5tcBojoErVt4t2r
         6PsBYgeVnKeKtvM91d1Opc6BVlWDWa4zS302XDn4vusQ9C95+Hs36pEDQmZgE7uOOJED
         7o4VMajPX4oO1zxLFeEVCB9/TosBElTP9iFpZr9DLUypSPakH1RaM5V7MUbL9qZ/DAOS
         RxVtZjntQIeoylH4lVjAN7AP43WV5eeZWsvqb37tpM6gvHTkycm5GOrYyksgYVMkF/bu
         FuQw==
X-Gm-Message-State: AOUpUlErTtFsgFFGo+/m66VAUCGPrlJ2FFmx7O1TxBKROs+awwTnD9hz
        CjgLc5rXB7ysku3mhQN2OQ==
X-Google-Smtp-Source: AA+uWPygCRoOjqJwx2rhf0XJhQNkoXMmgI+wEY3yWVTvVq1b7S8GeTw9BYUTIhNmUWlUnwZkrApeQQ==
X-Received: by 2002:a6b:7c04:: with SMTP id m4-v6mr14462768iok.52.1534364646867;
        Wed, 15 Aug 2018 13:24:06 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id g2-v6sm8708045iop.29.2018.08.15.13.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:24:06 -0700 (PDT)
Date:   Wed, 15 Aug 2018 14:24:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: renesas_sdhi: Add r8a774a1 support
Message-ID: <20180815202405.GA13760@rob-hp-laptop>
References: <1534250074-15890-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1534250074-15890-3-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534250074-15890-3-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 01:34:34PM +0100, Fabrizio Castro wrote:
> Document RZ/G2M (R8A774A1) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Not sure why you didn't use 'dt-bindings: mmc: ' for the subject like 
the others, but anyways:

Reviewed-by: Rob Herring <robh@kernel.org>
