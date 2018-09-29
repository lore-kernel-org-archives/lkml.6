Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BA4C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7461A2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFQx7tyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7461A2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbeI2VZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 17:25:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34761 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbeI2VZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 17:25:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id q19-v6so10572615edr.1;
        Sat, 29 Sep 2018 07:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ub/mM+HvsJC8IZMKwdr38D2apLS+gF4J1xW0WDw9mWM=;
        b=DFQx7tyDe8A9B0Uw7kMOw/6p2BitdUnRST91VlRjHnQTljZVc1b3p0HbxoW8TbNhND
         xQVTVHsbMuGzUfwxc4Ra4LwXSiWzsunEbsY5rC3pOSsrWaHjLKxxuapJJglJflWLNTA2
         18re1e5Cv9HLa+Owx3F4YbIRN7qsaHcyzEQ4inc5zLwLQcYs4DxrcZUV8NdHW8PNShje
         vSoCL+my8tPqJQogjgxU1Rsg2dD0nrlRdrOBc7mAisGwOwiTgj8xFUyQS7j3fEvks2Fg
         VawA1/XCi1m7xI5+YhFrcfZ4BTyHHj5qMWBhXnZ/Cs4fmk49ypu/hvgPWTEVoYetBlKx
         UqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ub/mM+HvsJC8IZMKwdr38D2apLS+gF4J1xW0WDw9mWM=;
        b=pI5nyWPyQEOGUkyczxKAQDTs84PjCusDdoq4nXXaKD09CGx7uf0CG/jIzfY3anyJlo
         vlZw/ZXdUIwAdl61WpF0qNzcKyJ+XrXa84bLNXeclP6g5iLcDE2oEAzrmMSHhSWVYTsg
         3iMqckpXKwaNUaO6YF+QZPHVXwC5Knl2flYr69N09bp3/4dLQfKRCdwe2+cO6eOI8b2P
         c0AffM1Pj1lC9d9w//AJkB4lDrbpheBR54pu+lXqjV2VgsrIOJWF5rtqQiibzMayWKZG
         5uu7g70ygMPA+Ou5BxoxEYzPlabEeAp9mEsTlViQqrgNJbpikFKYr629CyrWgiII2Brd
         OSnA==
X-Gm-Message-State: ABuFfohas59Osg9NlXsPjO9OuRzuVpt3gl+b0cqOksr9aDvbdxsivnu4
        TlIY9BqFgOhrhBv+3F54Gk/9WC80
X-Google-Smtp-Source: ACcGV61pzA6D+9AT68C5ceYTnjtJTm46RohGKSAet4We+o16CtKe2pKoOgP7arawvj3neoZ9hvsGWQ==
X-Received: by 2002:aa7:d707:: with SMTP id t7-v6mr8937857edq.250.1538232978957;
        Sat, 29 Sep 2018 07:56:18 -0700 (PDT)
Received: from localhost (87-49-45-169-mobile.dk.customer.tdc.net. [87.49.45.169])
        by smtp.gmail.com with ESMTPSA id m14-v6sm1966735edr.19.2018.09.29.07.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 07:56:18 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com
Subject: Re: [PATCH 2/2] spi: spi-fsl-dspi: Fix support for XSPI transport mode
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180921070628.35153-2-chuanhua.han@nxp.com>
Date:   Sat, 29 Sep 2018 16:56:17 +0200
In-Reply-To: <20180921070628.35153-2-chuanhua.han@nxp.com> (Chuanhua Han's
        message of "Fri, 21 Sep 2018 15:06:27 +0800")
Message-ID: <87y3bkcpym.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chuanhua Han <chuanhua.han@nxp.com> writes:

> This patch fixes the problem that the XSPI mode of the dspi controller
> cannot transfer data properly.
> In XSPI mode, cmd_fifo is written before tx_fifo, which transforms the
> byte order of sending and receiving data.

Did you find documentation on proper ordering of writes to related
TX FIFO and CMD FIFO entries?

I have failed to find such information, and thus opted for what I
believed would be the safe approach, writing to TX FIFO first, so that
when CMD FIFO is written, it will already have data in place.  And it
seems to work.

But, I now see that SPIx_SR[TFIWF] hints that it should be done the
other way around.

    Tranmit FIFO Invalid Write Flag - Indicates Data Write on TX FIFO
    while CMD FIFO is empty. Without a Command, the Data entries present
    in TXFIFO are invalid.

But I fail to see how that should be related to byte ordering.

So I believe this patch is doing two things.

1. Changing write ordering of TX FIFO and CMD FIFO.
2. Handling byte ordering based on SPIx_CTARn[LSBFE] flag.

It would be nice if we could get clarification from NXP on
what is the right way to do the TX FIFO and CMD FIFO write ordering.

But as for the byte ordering changes, I don't think it looks write.  The
meaning of SPIx_CTARn[LSBFE] is according to the documentaiton the bit
ordering on the wire, and should not be related to register byte
ordering.

You should probably split this patch in two, so they can be reviewed and
merged independently.

/Esben
