Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EEAC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BDB2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0GFhGlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BDB2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeI3Q7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 12:59:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40494 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeI3Q7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 12:59:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id j62-v6so11639739edd.7;
        Sun, 30 Sep 2018 03:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6rFHGB0azUBryatwbdKeDg6VV54fpJjNczrWP+p0F+U=;
        b=U0GFhGlWPoL5EV9qc4CmYjaHkESL8mfjSxHT5JO+lFiYyS+bmAXfM5sIrrzaNXjQee
         OZEoKi6sBxckMTCs6mkJvQh3xGYoz+UEeG0uzFXbVQ9GhevsVkK4x4l6QatZToh0eMQH
         mNTm1Ti7kocFh32do49CG5WYr6UAUsNy6OxHeBVZADF1yXvTw3OYU3A3ixxbZ+U4p9qi
         e/qBtFwTN1eXnfVwI2wnmd84MlKFUZGnMUtaiLqKGtIJmQoRTFxMnFgS27E/mDGk4IVz
         3TuNZ+nhLtob8cvNcRGSchGB5RSZsr/NXDQv4yLmhcDNeLsqbSzzU+Za7pEhaEugalIy
         bRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6rFHGB0azUBryatwbdKeDg6VV54fpJjNczrWP+p0F+U=;
        b=KfJAQco3Tnp45Dh8zbSptyBpuObNJhML8mCctKLlaESJRKbC8qjDQCCACfUT17TsH2
         VCky3kk8Axd+Fa5hqm3NNw1P70Thy8sFG4YMx+ZbeLszjAIL5xifX0Owb4Uh+ftyMJb3
         877N/YuVDMB4Zqa1spAkxCA9Ijo0WJVbzEIj4z0/88MQl3oa68TkgEXhmOQLSw1VbwGR
         J6UWACdJnH2zJyK2tYS8/tba8IjAjO/uPmrQvQ6Xl2zCmKObYyE/rsQiplLB9C4nyWDO
         e8SoDtQDwlqTK4RRagWhp00QAlaepy2Kmf9dTJu9scqiaJmoQZGCC4M8VbAr3RXBIlmN
         uDyg==
X-Gm-Message-State: ABuFfoii5+Ocrrm9iepKTZJHtq0ZWl1D+dIxY3s5iV6NVxcRWadfJQAv
        L1FPpLoOf03Z/3LuPEwhO5w=
X-Google-Smtp-Source: ACcGV60qVPZwp3z7UT590reJWN8J3HoKq47Na/8aKv07OrdPK5P1yKpbEs8z6K1/PqKnK0GvoB8Bbg==
X-Received: by 2002:a17:906:3792:: with SMTP id n18-v6mr8002901ejc.179.1538303246002;
        Sun, 30 Sep 2018 03:27:26 -0700 (PDT)
Received: from localhost (87-49-147-65-mobile.dk.customer.tdc.net. [87.49.147.65])
        by smtp.gmail.com with ESMTPSA id d23-v6sm3291674eds.47.2018.09.30.03.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 03:27:25 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com
Subject: Re: [PATCH v2 4/4] spi: spi-fsl-dspi: Fix adjust the byte order when sending and receiving data
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
        <20180930092535.24544-4-chuanhua.han@nxp.com>
Date:   Sun, 30 Sep 2018 12:27:24 +0200
In-Reply-To: <20180930092535.24544-4-chuanhua.han@nxp.com> (Chuanhua Han's
        message of "Sun, 30 Sep 2018 17:25:35 +0800")
Message-ID: <87k1n3701f.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chuanhua Han <chuanhua.han@nxp.com> writes:

> This patch fixes the byte order inversion problem in the XSPI mode of
> the dspi controller during data transfer.
> In XSPI mode,When I read and write data without converting the byte
> order of the data, and read and write the data directly, I tested spi
> flash connected by the dspi controller and found that the byte
> order of the data was reversed by the correct byte order.
> When I changed the byte order according to the SPIx_CTARn[LSBFE] flag,
> the correct data was obtained.

I believe this is related to patch 1/4 of this series, and your attempt
on pushing the 8-bit spi-mem data into 32-bit SPI words.  The
byte-ordering for that does not belong here, and will likely break
byte-ordering for other (proper) use of XSPI mode.

My advice is that you focus your effort on implementing/fixing DMA mode,
ie. erratum A-011218.
A proper implementation of that will be appreciated, and should give you
much better performance than XSPI mode would be able to give you.

/Esben
