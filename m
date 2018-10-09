Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA98C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A41B2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWz2I0o8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A41B2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeJISKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:10:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37044 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeJISKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:10:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id c22-v6so1256147edc.4;
        Tue, 09 Oct 2018 03:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7hu+9I3df9yDB49L5W9dRz6K+Zh3RHIGg0xYk//E5lM=;
        b=bWz2I0o8eQHYFEOlliZuzBRf1Ifdutsf2uphDcuTxM/xYZg+3/4EznUsegFbFg1m0Z
         cB/3rSXPDTzYkbnqzvgXo/mCtsWyIvOWgmYremBDpukPw9sP/Pnu7WbGGQ/Ra5vLLigO
         pPTapl1/h7hMAyR56QaPYY0aj5CRs2HlU5k+3MuX202DKRMzmEDeM0bOFIxzgd/eZ1zH
         Agz271NZeFgd3ZLTrmcbZ8PEop4itJ62MuDI8KXm5tjWMzFTrUqdmg0NxDhdeGOlLwF7
         P00L51gnX6fHQeGgPqBP3M2J7XJG0CYgSmPTgbJmxAWUyjk11lUE94O6EM1TSCwHtpzM
         Hm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7hu+9I3df9yDB49L5W9dRz6K+Zh3RHIGg0xYk//E5lM=;
        b=o1pUNKM1guhJpAuDqGKwsMjOQW+t8/fxR/oTWQeTQ0GQ7yAxVbs/FtdcNhwJ6wfKLQ
         sYEsBqWq0tnoWC7AyI24h8VrjeoNw60R3vDsOIdIHuJVw5AnSEhkZAGom3sbybGaxUD6
         kq8pSof3HzhDJzo5JMNXeYhTsl6cUqMHGeDPNHDUscYDnP2ILR7LC/cUWvvr4BpujJRM
         x02hdSyJRb0MCLkdcvFu/DjPP2NMly4wXNGeRxorgocMh6LlJqqYfqCuFJio5cBSVHmH
         g84SODpwGnxBGuVOgqVP3OdGNnF+kLFSolSVgT0dyIRqXMhFQlzw92iFcz+IYP/iKMnu
         qbmQ==
X-Gm-Message-State: ABuFfohgfs1tKKYEXkPWqDHpD/E3eukPB4ksjEM7jtd/DNuPjFZAXfZt
        myO8jjb/1MupRVQpB0DPaXw=
X-Google-Smtp-Source: ACcGV626sapfTi3DtNt0axvUjtcNYgCKt1uvkD/Wef2Y4LuQGP+3sdB7o/1N86qpbDYcTvzJSs4iSQ==
X-Received: by 2002:a17:906:5512:: with SMTP id r18-v6mr27162720ejp.15.1539082425085;
        Tue, 09 Oct 2018 03:53:45 -0700 (PDT)
Received: from localhost ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id v11-v6sm3564133ejj.19.2018.10.09.03.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 03:53:44 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        "broonie\@kernel.org" <broonie@kernel.org>,
        "linux-spi\@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180928084431.300b7bf9@bbrezillon>
        <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <20180928091833.15e95f7f@bbrezillon>
        <AM6PR04MB4357280CD4F77FCB01AB5C7097E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
Date:   Tue, 09 Oct 2018 12:53:42 +0200
In-Reply-To: <AM6PR04MB4357280CD4F77FCB01AB5C7097E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
        (Chuanhua Han's message of "Tue, 9 Oct 2018 09:52:23 +0000")
Message-ID: <87y3b72xxl.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chuanhua Han <chuanhua.han@nxp.com> writes:

> 1. In the dspi driver (spi controller), bits_per_word (dspi->bits_per_word =
> transfer->bits_per_word) passed from the upper layer (spi-mem.c) is used.
> In this way, I can only assign the appropriate value of
> transfer->bits_per_word before passing to the controller, that is, the
> controller driver does not
> know the value of bits_per_word, and it will use this value when the upper
> level sets what value is passed.

Yes, the upper layer (spi-mem.c) should set ->bits_per_word according to
how the SPI data is to be transfered on the wire.  In this case (I
haven't looked at spi-mem.c myself), it sounds like the desired value is
8.  So it is set to 8, and that should definitely not be changed by dspi
driver.

> 2. As I understand, bits_per_word does not exist for non-byte alignment, but
> for the need to reserve non-byte transmission mode that meets the
> controller.

Where did you get that understanding from?  The bits_per_word value
defines the word size in bits for all transfers.

> 3. In addition, now the XSPI of dspi cannot transfer data normally, so this
> problem needs to be solved. As for the DMA transfer mode, some colleagues will
> study it.

What do you mean that "XSPI of dspi cannot tranffer data normally"?
What specific problems do you see (with unpatched mainline kernel)?

/Esben
