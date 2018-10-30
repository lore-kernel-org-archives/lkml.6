Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAE8C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D41B2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D41B2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbeJaE01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:26:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34577 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbeJaE01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:26:27 -0400
Received: by mail-ot1-f67.google.com with SMTP id e9so10780874oti.1;
        Tue, 30 Oct 2018 12:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZZM621CZPzz2GnWMDWWUaciFfFWkdQNNvMIMgqInc6A=;
        b=Rw0mSLZxJeJo+jFIhZePWuvdgK8w+mgYxyiayAokfKkfJMJ9Uz/0Bfr5YJ9e416o8e
         VgKT3RY/RiJ96C82sF7vkbVaHt3g+H6VTvax1l+7HbU1FqqHEidOS4FTlQCgatqD3Bct
         oWGmVmg6d1d/NL0A6ct7Ggjfz1OPuQgLT59Y/NSDKuut/CzQMDUekSCeyMcLaIi7Biqi
         I2Vz3lwuwsQUWmlfn54JYPnIGtJC+rGuMKRlw72ycHYwVDh6pAyMcdzW2nQICP4UzFBk
         eRJ5+V3Nc33vXpeY2TMTYMq1Aw0Ek7fYwumclaZa8mssSY9l8cw6Kc+OMSFbb8BGjq3Q
         2PSQ==
X-Gm-Message-State: AGRZ1gIS+eMryX5lcVd3J7ETbBjVWHHtWCH5Kuludi9HG/fq3O09Uam7
        qc7hBjVY5b1rujuPQG+X6A==
X-Google-Smtp-Source: AJdET5ecUwTLxMew6E+dgys5y+ywr/Mk/ndSsbUlRflGvrY72xv8eituDIuH35ZQpttKCduCT4Qlsg==
X-Received: by 2002:a9d:4704:: with SMTP id a4mr3947otf.325.1540927899478;
        Tue, 30 Oct 2018 12:31:39 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d8sm10438618otd.69.2018.10.30.12.31.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 12:31:38 -0700 (PDT)
Date:   Tue, 30 Oct 2018 14:31:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linux@armlinux.org.uk, u.kleine-koenig@pengutronix.de,
        jlu@pengutronix.de, bp@alien8.de,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/8] ARM: l2x0: add marvell,ecc-enable property for
 aurora
Message-ID: <20181030193137.GA28258@bogus>
References: <20181029072535.31667-1-chris.packham@alliedtelesis.co.nz>
 <20181029072535.31667-6-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029072535.31667-6-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2018 20:25:32 +1300, Chris Packham wrote:
> The aurora cache on the Marvell Armada-XP SoC supports ECC protection
> for the L2 data arrays. Add a "marvell,ecc-enable" device tree property
> which can be used to enable this.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> [jlu@pengutronix.de: use aurora specific define AURORA_ACR_ECC_EN]
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/l2c2x0.txt | 2 ++
>  arch/arm/mm/cache-l2x0.c                         | 7 +++++++
>  2 files changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
