Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703BDECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D9820877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GM3JyhE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D9820877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeGQEly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:41:54 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45655 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeGQEly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:41:54 -0400
Received: by mail-io0-f194.google.com with SMTP id l25-v6so39934541ioh.12;
        Mon, 16 Jul 2018 21:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dhx2oV6LIxfXs6HHP2Jf2/uc5HecwZ6cyjY4v5Ttxss=;
        b=GM3JyhE7gGsbGH3sA6y6R0lDmTRH7vKJJfsQgmU13EDTeTqB3TCUzxdLuvC+dr2RA2
         UD/f5gjhZTJnY5FC+bbUNz3Soe7mCDQnqnIvzzyqZqwUwmNPE8n3YHkAatgAUfxKhArQ
         ZHBPQif3s2OGTuprsZyODCCphLGN6b+1UtadbQRluH03u0qk2DwVCDSIBO3KDtNeecgK
         THuKv4O+6A4alxXFgsuMOHuvS600LnmM6mM61LPiytDuZ9UPW1f21sBm+YbbGepw5sA3
         jFC2PHDUT9kkHOvm8yUtZTzlhuwIw9tSnFgL2D4MRP5sj5MrXNldCZfzIGJ0HwTUcYWr
         6tjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dhx2oV6LIxfXs6HHP2Jf2/uc5HecwZ6cyjY4v5Ttxss=;
        b=Heh9a2Vq1jVgrE7IHtpcZh26epEBxCoOcXe1Wk7ZJQT3jqBwXoFnwjXBZPapwvZ65v
         AYJo6TRD+83MiwnH1dPtzEgfIW5cjzYCrTxAhJkFSG9801yGmkewEq/Ath64AwXWhHeh
         WLF75+C4qk9dv46NDkOiZqKovWGqtrKPBIessTpA7zvB4Xbv4I4G6OIzzB7CPoChEs1g
         bQhTTZewwD/Wnb9hbPeTnLNBAVt1IK1loOOlROpQBKPeGeBzwyXhXtcQsu2ptAyEQoXQ
         IrjTVqzH+KN8OUJB2mMyLtqKbDUu3p0qxv8ojpNy24dqYjEK/wVTEThQSH+jX9jOXiNX
         f6xw==
X-Gm-Message-State: AOUpUlHE+7knOOkO+jFDnEPAoAPW8/xm3hfJZOaTur0V8uOtBJpCYSIa
        FOlCeEbpLSFdeu9MzIS3Z+bDLyV0qD9RwwzwWdwBwg==
X-Google-Smtp-Source: AAOMgpcTgBCZHq/IJawIcIvkVqK/h2y5wSfnECK4zOsTfeiGl3AWbHAtVqvszulR4JDmCXKqyxi6xY69EkDQQ3ZECHk=
X-Received: by 2002:a6b:bbc1:: with SMTP id l184-v6mr7107383iof.83.1531800681423;
 Mon, 16 Jul 2018 21:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180716062508.7726-1-andrew.smirnov@gmail.com> <20180716112629.GC20734@sirena.org.uk>
In-Reply-To: <20180716112629.GC20734@sirena.org.uk>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 16 Jul 2018 21:11:09 -0700
Message-ID: <CAHQ1cqHPgL0k9Av6m3gxkeT=YpaaK9+Wm4Lagp+GXo-nH+OBnw@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Fill actual_length when doing DMA transfer
To:     Mark Brown <broonie@kernel.org>
Cc:     maitysanchayan@gmail.com, Stefan Agner <stefan@agner.ch>,
        Chris Healy <cphealy@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 4:26 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, Jul 15, 2018 at 11:25:08PM -0700, Andrey Smirnov wrote:
> > Users of SPI device drivers may rely on 'actual_length', so it is
> > important that information is correctly reported. One example would be
> > spi_mem_exec_op() which will fail if 'actual_length' doesn't match
> > requested transfer length. To fix the problem, add necessary code to
> > populate 'actual_length'.
>
> This doesn't apply against current code, please check and resend.


Sorry about that. Will do in v2.

Thanks,
Andrey Smirnov
