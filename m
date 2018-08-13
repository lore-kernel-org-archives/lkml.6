Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172C1C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB83F2174D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB83F2174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbeHNBqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:46:13 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34818 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbeHNBqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:46:13 -0400
Received: by mail-it0-f68.google.com with SMTP id 139-v6so16935969itf.0;
        Mon, 13 Aug 2018 16:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3pJKd+X7gfOZOoPU+QBNh+/Fg9nOBdrbPIg5tuYxHhc=;
        b=bLxpEbVMtdZCtrmt1hpxItjPFmENNb/iafazBWOgBy5D07o45e/TVHWduQQZJSODxP
         9FHwhCVlNrh+f3MkV7Pb+twY9djfqbSOv0fYQs4Ftg8qoLtgnU+0u3sN5RUtiQ2v19T+
         3ZXqk2mxNOKglg4MeBJXGAF36TNPiG/jsk1RDpuYzPaQBDZIURjHqTJYFE5EhnbQXap/
         gEC3d0B1rO/Yp3el57+9VpLDixnehvFjPqQKn9oWao7VVkIIjKABcT6lpuzR0uIOB291
         Hy/TT+wqchoKb4Jb/tpP0M9Q8RccrSx6hgrvyzjkNOALHPIWN8kWRXQX2bf7g91QjguQ
         nnAg==
X-Gm-Message-State: AOUpUlGjPST1vfrrlrnkrYFIiu/mVUbW64rukH4+Z/TdmLIetb2NfgVi
        GDNoqFa/0zGrGW2ofDiHAA==
X-Google-Smtp-Source: AA+uWPxs8qvClbfi7fQ2nbeDTCwV94yCIT4Xx80V9jIqoLvy//W0tiIb3jn6/tEWdPlBG5Wc9nKntA==
X-Received: by 2002:a24:7f94:: with SMTP id r142-v6mr12855277itc.137.1534201312894;
        Mon, 13 Aug 2018 16:01:52 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id l13-v6sm7402835itb.43.2018.08.13.16.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 16:01:52 -0700 (PDT)
Date:   Mon, 13 Aug 2018 17:01:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx7ulp: update pinfunc header file
Message-ID: <20180813230151.GA28201@rob-hp-laptop>
References: <1532988635-4726-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532988635-4726-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 06:10:35AM +0800, Anson Huang wrote:
> The i.MX7ULP B0 chip has some pin changes for USB and VIU
> module, update pinfunc header file accordingly.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx7ulp-pinfunc.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>

