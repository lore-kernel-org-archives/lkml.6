Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F0FC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CF0206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHDXDAuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CF0206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeI3QuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 12:50:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38362 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbeI3QuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 12:50:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id c1-v6so2436396ede.5;
        Sun, 30 Sep 2018 03:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TMKTM+QOSqnMhXF1Oz7IrV6yFws8qtYbiQXWvBffc4E=;
        b=NHDXDAuWEKDAy8Jvv2122TYvS6YOmp6iZ4IUc7bJhjbR8p4VTLA6BRXvpw/C8KqqEV
         fd2QD4ALyGKUw7TNGZFTskVNwNsZKx9K+9mr1aAVFbkM4jxh4qRoRgMMoEsJfyAC+bcZ
         Mm/7XBwyJBDyyic9VLNd79WT0Jxs6Mu9+5l/hT4b/SwaVDrMS8O+n7nwIAJYlb1MMlZ6
         l77Rf67n8oz5BQHOm1+ssFwMeYjGyFJKqfX2IjVE5vV49vOtgN2bewm/ohgEwLRJgNOa
         Y+xRiBKOtAsRcL188bbINqIpf3APawGv9Y8X2M2chUV9JTfp9iA6r9tIglcieVfBEZG2
         2HKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TMKTM+QOSqnMhXF1Oz7IrV6yFws8qtYbiQXWvBffc4E=;
        b=h5br7bENyLaCvKJgY9vaFlLVeTIdKS1YWEL8w/0xBcGeW0ogWxDQRjMOz6dhWdU+zl
         DAqpTVqtOIAXfB6o2vVn4k03SGchN5RW4+Tu7vP6posZKPcNbG+yg1ciLGxEW1n8XKBp
         79XDo/fvsBmmjajue8gkya5oVKzf/XWvIC9hQ8qHTmsS8WjBJjRjRRWynJz1atKiMsT0
         9N0qZ47PiuIQek1Oy1LRL8VsG4PGiak+yMWB2YCunhPGE5YzL8eaHD0Vdv1XDVB+JqFN
         KJc75Nnlp85fGs+1DfgCVSmV+CtaWH5HzVlxtV1B9twb6vHqKjMzc0GFZH7rDZ1mES+r
         MABw==
X-Gm-Message-State: ABuFfoigv9VfxB1J/tc3dTL+ZwCfxgtHdU1Lgxjtnt2bn3I0iq4fEsd0
        PadowS08xtyFBkCs4cCCds4=
X-Google-Smtp-Source: ACcGV61l+6fR8X62ttWkpH5cwCFCQMqvz1rv/9BrfTjGNEd31eeoHti+oHRiWkKPhrwDhvFLbS+MPQ==
X-Received: by 2002:a17:906:2410:: with SMTP id z16-v6mr9775173eja.164.1538302656199;
        Sun, 30 Sep 2018 03:17:36 -0700 (PDT)
Received: from localhost (87-49-147-65-mobile.dk.customer.tdc.net. [87.49.147.65])
        by smtp.gmail.com with ESMTPSA id s12-v6sm3346226edr.9.2018.09.30.03.17.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 03:17:35 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Chuanhua Han <chuanhua.han@nxp.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] spi: spi-mem: Add the spi_set_xfer_bpw function
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
        <20180930120425.7715cb29@bbrezillon>
Date:   Sun, 30 Sep 2018 12:17:34 +0200
In-Reply-To: <20180930120425.7715cb29@bbrezillon> (Boris Brezillon's message
        of "Sun, 30 Sep 2018 12:04:25 +0200")
Message-ID: <87o9cf70ht.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris Brezillon <boris.brezillon@bootlin.com> writes:

> Hi Chuanhua,
>
> On Sun, 30 Sep 2018 17:25:32 +0800
> Chuanhua Han <chuanhua.han@nxp.com> wrote:
>
>> Before we add this spi_transfer to the spi_message chain table, we need
>> bits_per_word_mask based on spi_control to set the bits_per_word of
>> this spi_transfer.
>
> Let's make it clearer: this is wrong. The spi-mem protocol is just
> using bytes, not custom size words. Fix the fsl-dspi driver if needed,
> but don't try to adjust xfer->bits_per_word in spi-mem.c, because this
> is inappropriate.

I don't think there is a "fix" needed in fsl-dspi driver for this.

I am not sure, but I think that what Han is trying to achieve here is
better performance.
And wile the XSPI mode does provide better performance for sending one
32 bit word, than normal mode providees for sending 4 x 8 bit words.
But as you say, this is wrong.

To improve performance, the fsl-dspi driver should be fixed to work in
DMA mode.  Implementation of erratum A-011218 is necessary in order to
use DSPI DMA mode on LS1021A.
I was planning to work on that, but haven't had the time for it.
So if you want better performance for spi-mem on LS1021A DSPI, please
work on this.

/Esben
