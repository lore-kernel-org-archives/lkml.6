Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C4CC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE0B2086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5aUEDJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE0B2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJIVHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:07:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39337 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIVHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:07:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id d15-v6so1757359edq.6;
        Tue, 09 Oct 2018 06:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=lg98PekJjJNpsVcYtJkwW/OVYg6wZ+XMQna/VA2K26E=;
        b=Y5aUEDJGzLYxJRHlX75egSdDE36kmT13x8skOCDlsUvKAvC3gGkazVL52bE/N6uRS2
         64ENhkVpbSA4ZIN/M36kTiLz93VphhEQpay3qhv8BGkj8BZWhfV6WGAdhmOCBQaUTOYf
         k+jIcp6VVaxnFqsVe3khJsRbXt4yAAE0z56MrILCfnRtfpQNtP8oH1SdjOENsCNMDD4X
         IJpSA1C460RtU1HLFOy44AcfYVkEKQMDyJiA4vCrxOxcpEjxTXs5UDyKkVwNXOoY8Kw0
         jLpFKVLsoRNAX2BNXQDWoAks5O/V9xyrFviWBo/G6o6Btq07q2OU8tMtDf1l/onWXPQR
         td9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=lg98PekJjJNpsVcYtJkwW/OVYg6wZ+XMQna/VA2K26E=;
        b=LsEymclzEJgktvd9wMcK311ftklML5AeqN3Biwpa8LvaRw4R4C8N5TZicHRiliZTyo
         JguAGMoe7F0tWW67MwO/39Mj3O0fW/0YewHw6PWj+Be0hOwCGWwiGXkbVN/M8Qu+QVV2
         a4YVcF5U0gkCmQxd/MZWEO7NNOoeIU2REoSTNH54zzJAc09TW0u+tNyfVPRnBx/Q3XVp
         2GFwTRxGQNPfplA8GP9sSRQMg5ksJgoHAMzBLIG1MUh3ShlIm7QvmY7ZJl1XCEMD/Lfq
         wTgtiXwilwN5htXhAh3XeP8P2JEOM5mnu/jEyk1tOA3rX66q6M39VnpZUe12sLKL9j2g
         xzvw==
X-Gm-Message-State: ABuFfohSll6gRH+4/kdTa+iyCCnlUnCa+Qj+P98jHpvWLlZPu/g7XqHh
        BBuN2ayNHq8P1UC6JehR6vc=
X-Google-Smtp-Source: ACcGV60iv9HuzTlftjoJiS5PdWI6zvX1hwmISeYsgZ9XRxs9/vJkLEQ+NLUrDQqeStHAJ272PTqi4Q==
X-Received: by 2002:a17:906:7a4a:: with SMTP id i10-v6mr28247440ejo.234.1539093048437;
        Tue, 09 Oct 2018 06:50:48 -0700 (PDT)
Received: from localhost ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id d4-v6sm3584063ejd.1.2018.10.09.06.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 06:50:47 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Chuanhua Han <chuanhua.han@nxp.com>,
        "linux-spi\@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
In-Reply-To: <20181009103328.GA20774@sirena.org.uk> (Mark Brown's message of
        "Tue, 9 Oct 2018 11:33:28 +0100")
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180928084431.300b7bf9@bbrezillon>
        <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <20180928091833.15e95f7f@bbrezillon>
        <AM6PR04MB4357280CD4F77FCB01AB5C7097E70@AM6PR04MB4357.eurprd04.prod.outlook.com>
        <20181009120522.6b2bd15a@bbrezillon>
        <20181009103328.GA20774@sirena.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Tue, 09 Oct 2018 15:50:45 +0200
Message-ID: <87o9c32pqi.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

> On Tue, Oct 09, 2018 at 12:05:22PM +0200, Boris Brezillon wrote:
>> On Tue, 9 Oct 2018 09:52:23 +0000
>> Chuanhua Han <chuanhua.han@nxp.com> wrote:
>
>> > 1. In the dspi driver (spi controller), bits_per_word
>> > (dspi->bits_per_word = transfer->bits_per_word) passed from the upper
>> > layer (spi-mem.c) is used. In this way, I can only assign the
>> > appropriate value of transfer->bits_per_word before passing to the
>> > controller, that is, the controller driver does not know the value of
>> > bits_per_word, and it will use this value when the upper level sets
>> > what value is passed.
>
>> I think you're missing my point: ->bits_per_word is not what you're
>> looking for if what you're trying to do is use 32-bits accesses when
>> things are properly aligned.
>
> To be clear: bits_per_word affects what goes out on the SPI bus (4 byte
> words swapped to be in MSB first order), it needn't have any effect on
> on what goes on inside the SoC - many controllers fill their FIFO in 32
> bit blocks even when sending 8 bit SPI words.

Exactly.

I believe behind all the confusion here, is the fact that the current
spi-fsl-dspi.c driver does not utilize all the possible features of the
DSPI controller.

1. DMA support requires a nasty workaround before it can be enabled for
   LS1021A.
2. EOQ mode is not enabled (and not tested) for some platforms which
   might actually support it.
3. Cyclic command transfer is not implemented.

So in order to improve performance on LS1021A, I propose to do work on
above issues.  I believe the performance improvement that can be gained
is likely to be biggest for 1 (DMA support), and smallest for 3 (cyclic
command transfer).

I don't have access to any coldfire boards, so I haven't tested EOQ mode
(it is only enabled for coldfire currently), so I cannot really know if
there are some bugs hiding there.

/Esben
