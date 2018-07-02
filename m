Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EF3C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD7C2087A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="j1QN8elU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD7C2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753034AbeGBRSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:18:37 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37504 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbeGBRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:18:35 -0400
Received: by mail-lf0-f68.google.com with SMTP id j8-v6so3001592lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 10:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jDylPXCR3Yu/DKi/NkTYx8zWzp7/lGc5ROU2E3K/jrs=;
        b=j1QN8elU2W0ZBjeMO9AIogdDMLkLieC1bfxVS8Oy7n3uKOkj9ulYksez6ehpb1Iehx
         nOp8hdbC+LWFPuksWyxWnyoHWe1vuv1a1uY56lMd3pXODIPaquXg2uQ7EchxjCUX1cbv
         luQygMTPsymtm9aGZDQhyyTyTYmhwn00ev26EuN7ICJWQBEfrV+ImsjTJoeClwyE1mgd
         bht4bQ9TfDX3c4aG8Le79KUTm6WPgrbkKQrz7O4sQvdiroz2HibndfGybW6HcsR608WC
         j3YTK9fbWN3T8fG73cPwgS02pIltz7bTe/XsIDjojZHInrH+ImtTpgfsojCMB70Zy0xQ
         TFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jDylPXCR3Yu/DKi/NkTYx8zWzp7/lGc5ROU2E3K/jrs=;
        b=Y6bnZfLWizDcpnN7qUK1/nAZ9l1wwB8oHEXWr+R2cbfyYTQKcmk+y/9+Y2B25SbL4M
         88aBvKezV7NfwaPlfrwTWmwo0Nh/Tvz4lTGvwQbp+Fbkw0s+hRR6rDScqgzf2bm7bjzW
         jpWC8us61ih7w+YvzH/NT2mKUnsnRoqfoSKqlFeFgjmk0iObk6L8o40H+n/CrVJcsl40
         vzHAGTL4wYzbqz0s4NHWE3oYFQ3NhNgYYrwvITraqPXeuo07bd4Um69pyTYh99Jku0pC
         fw42tnsUfa6ywHON95shnfQ2etmZzp0N1w8nLzOVuDS14yQSlvIFaKqr9pYLn/zJmBQ2
         gyFw==
X-Gm-Message-State: APt69E3ydE29bBDEJLbN32o3pQoNU5PilgfWTU/lWHoRXcumBJar1uu3
        SNIeeBw1RIKyJ70K2Wmm+Mp3NPYXkeFRBjxT32ujiQ==
X-Google-Smtp-Source: AAOMgpdscwZGnkhcLqrs4vm7IoA58z+NnUN+08DCx0K/CP0UNrPAnb9DGv3hrnkEgj901Iv4z4lIDxoyUyJjxoVOr7U=
X-Received: by 2002:a19:1f4b:: with SMTP id f72-v6mr10022774lff.42.1530551914329;
 Mon, 02 Jul 2018 10:18:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:fc1c:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 10:18:33 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:200::6:4265]
In-Reply-To: <20180702121013.GA17791@jax.urgonet>
References: <20180702121013.GA17791@jax.urgonet>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 2 Jul 2018 10:18:33 -0700
Message-ID: <CAOesGMj=OG0j_3rOY8XmJiY5c8bhJL6boxcBUm2B2yyKQTTRog@mail.gmail.com>
Subject: Re: [GIT PULL] tee driver for v4.18
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,


On Mon, Jul 2, 2018 at 5:10 AM, Jens Wiklander
<jens.wiklander@linaro.org> wrote:
> Hello arm-soc maintainers,
>
> Please pull these small tee driver enhancements. There's a new config
> option for the OP-TEE driver, OPTEE_SHM_NUM_PRIV_PAGES. Also the OP-TEE
> driver reads current time with ktime_get_real_ts64() from now on.
>
> Thanks,
> Jens
>
> The following changes since commit 29dcea88779c856c7dc92040a0c01233263101d4:
>
>   Linux 4.17 (2018-06-03 14:15:21 -0700)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-drv-for-4.18
>
> for you to fetch changes up to 3249527f19d660c5adfb2b6f4ffd4ca0506b8755:
>
>   tee: optee: making OPTEE_SHM_NUM_PRIV_PAGES configurable via Kconfig (2018-06-20 11:20:36 +0200)
>
> ----------------------------------------------------------------
> Misc enhancement for tee driver subsystem
>
> * Replaces getnstimeofday64() with ktime_get_real_ts64()
> * Adds OPTEE_SHM_NUM_PRIV_PAGES to configure how many pages should be
>   statically reserved for driver private allocations
>
> ----------------------------------------------------------------
> Arnd Bergmann (1):
>       tee: replace getnstimeofday64() with ktime_get_real_ts64()
>
> Sahil Malhotra (1):
>       tee: optee: making OPTEE_SHM_NUM_PRIV_PAGES configurable via Kconfig

This doesn't seem to be bugfixes (and not regression fixes in
particular), so I took the liberty of queuing these for 4.19 (in
next/drivers) instead of fixes for v4.18.

Let me know if this was an inaccurate assessment and I can move them over.


Thanks!

-Olof
