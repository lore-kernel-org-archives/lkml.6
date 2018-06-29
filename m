Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7BEC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626E824310
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1e0qlYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626E824310
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754965AbeF2VW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:22:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41216 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753186AbeF2VWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:22:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id a17-v6so5220584ljd.8;
        Fri, 29 Jun 2018 14:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=quEOIa+z1Bjzkp3S45bn0pwVggHcTTyBEYvpTOCJv70=;
        b=u1e0qlYnXfbnUeYXL157XwhlSEM1H6zE+gXJvYe/p9HxdMt4XAsgvwvzK+NevbULyv
         EsQ9DAgOqDbOtudFVa/ZRnThRiEsS58nQaB7V6MpPlOTp4NC6qjnH6hLkqKke9vSXJO3
         JqJa/XWSZnxhwNuuTj0+thCg6U8Z05pQcqL1kWhEuT04U8r0FtlfNrSp9HkUfgafoiBd
         +E4dvQOA1MdyByDFH2sj+3pz71G1LYuOQWls3OtDFnXV5bdNvL50iOBk41n0NkEEXt8l
         iDGMeSjtJoSSLjGnU8Ha+ogq/DQBl4laXiCz7ncksxWZ7lW6p9CXgZ5yuy0IiHM1EF3y
         1NYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=quEOIa+z1Bjzkp3S45bn0pwVggHcTTyBEYvpTOCJv70=;
        b=jrkceG6IpckaVmLgbGy+a+yd6QPkSyzEX9AdnI52QhJfYD2UYqclpl4tL/kwjjEEVE
         ljy7ydfS5DvvANrsRCyyaFCw4iNKBmysoEQYk4KfN0OozZgDRS+itrC/Ckrq+dwsrKx8
         Eurupz1rYUI9HNMBg8o00u7pMxnks6L/7aQNwt7LEK0pThS4wbKzZQI92t4k9q0PEJLG
         AKPXNH5vtoTDIiEInBdvQ0AmwzeUK6fC1nKAcIqT83RyjdMkXny0w4G8xT9hoToO1pWy
         oDEPstRhcOcqmSonbrO3lAHwSOYMH7G6Val/6n5BySmJEpB9GJ1P+9b1zeQb0R2kFcET
         OHrw==
X-Gm-Message-State: APt69E0/aFSbo45ok2VKHB6Ca/k/FA+SCPuGN0wtoVyk8PcqFE8+JyOF
        IqZAV5EE8f7xYw3rZ2pGRp7MjfcwGZxzarkrquU=
X-Google-Smtp-Source: ADUXVKJimaED7iWsq/W/FowmLgJLF9g8JtYA359JUQpD8h1PxTVevV1/brf6mT0vu30IMySRHseYRGDZDA3wyymJpEE=
X-Received: by 2002:a2e:9a95:: with SMTP id p21-v6mr11013435lji.60.1530307343615;
 Fri, 29 Jun 2018 14:22:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41cf:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 14:22:22
 -0700 (PDT)
In-Reply-To: <20180629185107.GA37488@beast>
References: <20180629185107.GA37488@beast>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 29 Jun 2018 23:22:22 +0200
X-Google-Sender-Auth: IjQFIQRDYyYQcIu0icoXXc4l9a8
Message-ID: <CAK8P3a30Q1ezvCWfudUY=z1q3NHdrkbwRsmSDso4s7TifQAmNQ@mail.gmail.com>
Subject: Re: [PATCH] dma: ste_dma40: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 8:51 PM, Kees Cook <keescook@chromium.org> wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> switches to using a pre-allocated scratch register space, set up with
> all other other allocations.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: dmaengine@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

I looked too long at this one, in short:

- Your change looks correct to me
- It could be done better in many ways, all of which would
  involve cleaning up some of the existing code in the process
- Nobody uses this driver in practice, as the hardware platform
  was a dead end

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
