Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4920FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF7620847
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF7620847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeH2Qm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:42:59 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42141 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbeH2Qm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:42:58 -0400
Received: by mail-oi0-f68.google.com with SMTP id k81-v6so2728927oib.9;
        Wed, 29 Aug 2018 05:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DIiH0rwjb0a1ucn2Il+rvq0bhmf/EDcGV+ncl5j1HmE=;
        b=kAfDwbmUd/cMva/qPLV2W4aFt2NHFp2oZWiRtGSzgJm9vVJmCv8+8fsImFrM1w7aFs
         WI1OTSz4OgIS4oFw/MrnUk7zBzDuD++jCcajvCGM+pABr2uFv8eJOiGU5DXYTX3Q3V4p
         VoyG8ue+wbYamXaLKCbOkaPpbWZObObI9Wbn9EX2FuGBfVtd39YfD2B2asem0SPUK16P
         c3dlG3+hXRUyYGLLia/Cp2g7cV8sn1t3M3m7zDX7otyRFfcuq1GRn8rphqpyy+8+kzbz
         uaS5DIt62bZ5OzW5KI4iQfrfzbpQjpDwn4xXWvIl7w012FMZKBWmwE+dzqy0VZiJO8uB
         /3rg==
X-Gm-Message-State: APzg51A84vo/EVuT0MrBBEETyhLK7EqesV4eVcpd5W8ZGw4K+OLZ2nyl
        Ovf61lR8jaB1ZgKWEeyW8Q==
X-Google-Smtp-Source: ANB0VdZqhNelJFKMfkqcHFTyvaUMtrd32UswzLxzw+cs9nwZzwKx26uJu1YJMHUn3M15vLjNY0x44A==
X-Received: by 2002:aca:cc90:: with SMTP id c138-v6mr2707009oig.282.1535546771654;
        Wed, 29 Aug 2018 05:46:11 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s133-v6sm4480464oie.4.2018.08.29.05.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 05:46:10 -0700 (PDT)
Date:   Wed, 29 Aug 2018 07:46:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jan Tuerk <jan.tuerk@emtrion.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 2/4] dt-bindings: arm: Document emtrion emCON-MX6
 bindings
Message-ID: <20180829124610.GA6123@bogus>
References: <20180824132617.43975-1-jan.tuerk@emtrion.com>
 <20180829100811.55836-1-jan.tuerk@emtrion.com>
 <20180829100811.55836-2-jan.tuerk@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829100811.55836-2-jan.tuerk@emtrion.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 12:07:58PM +0200, Jan Tuerk wrote:
> Document the compatible strings for emtrion emCON-MX6 SoM's.
> 
> Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
> ---
>  Documentation/devicetree/bindings/arm/emtrion.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/emtrion.txt
> 
> Unchanged since v6 (rebased)

Please add acks/reviewed-bys when posting new versions.
