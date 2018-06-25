Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C0EC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FB326100
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FB326100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965177AbeFYUr1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 16:47:27 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:38220 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934686AbeFYUrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 16:47:24 -0400
Received: by mail-yw0-f193.google.com with SMTP id w13-v6so5267577ywa.5;
        Mon, 25 Jun 2018 13:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jeWTqVj4m4ojDqRKMZLWbd6m7K0jmtk+s/i6thpFnh4=;
        b=Sdrmw4I3euOAlA/eg9qsLHwVlIEbvShlGL57l79LDVNb9WcOQKYRnBbrXbUjRdgKck
         lhwJoC1qq3RSUG8t2K5V960s2FLZc0AXPfOhBk9AoiuNwq0Z7Dv3y9W2tKPTvmCLOrSJ
         B3h8H2p+zY8xEeZYAw3MsgTtxWQ5w/ymug8Ul360rG9jqVqIjb+P6p3c33xfcvy8K7aK
         YqDoSYPKWm7a6MErk80ZqfIcC2sC1+RSSUBHR1FxHBtnAMVR2Pra6jda9cllll8pMz/U
         nJP9CNn7LNhCmIdtaMkuG01Xz3doM81orwflTwySU+VskNVy6FzsIyTRbUB2UX/Xw2RF
         hsPQ==
X-Gm-Message-State: APt69E0mKdqzpeXpq0g3QOEQAq0WCpz8eip6k34Iu3CcffTEcdvNQD+0
        3ojLazFe0xonQKbd8oxd/w==
X-Google-Smtp-Source: ADUXVKJvUzjPloryaH/ZT3bplLO6X+2fL4lYaPwHbDlQiR864tazVab2v/ekQ0jcd57daAUALMfgGg==
X-Received: by 2002:a81:902:: with SMTP id 2-v6mr6620378ywj.373.1529959643990;
        Mon, 25 Jun 2018 13:47:23 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id q7-v6sm4970262ywa.57.2018.06.25.13.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 13:47:22 -0700 (PDT)
Date:   Mon, 25 Jun 2018 14:47:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michel Pollet <michel.pollet@bp.renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>, phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] dt-bindings: Add the r9a06g032-pinctrl.h file
Message-ID: <20180625204721.GA20131@rob-hp-laptop>
References: <1528974029-29617-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528974029-29617-2-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528974029-29617-2-git-send-email-michel.pollet@bp.renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 12:00:17PM +0100, Michel Pollet wrote:
> This adds the constants necessary to use the renesas,r9a06g032-pinctrl
> node.
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  include/dt-bindings/pinctrl/r9a06g032-pinctrl.h | 191 ++++++++++++++++++++++++
>  1 file changed, 191 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/r9a06g032-pinctrl.h

This can be combined with patch 2.
