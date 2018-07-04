Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFFCC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6289023D3D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uE+RBHND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6289023D3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932999AbeGDKjC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:39:02 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:32998 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932399AbeGDKjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:39:00 -0400
Received: by mail-vk0-f66.google.com with SMTP id y70-v6so505978vkc.0;
        Wed, 04 Jul 2018 03:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2FWu0aD8dQ+zrl7Pi3fqSaepG3+2JgxYVFbzmTqNsSM=;
        b=uE+RBHNDDKGCktYTV6JQ1TTDhGyVdp1wMJUHazTEJSiAiSL4AmsUE4kAQQ1VnA0d4l
         kfanJut2FidCd/V18p2YsUSVPCmoVB0EYDT/mmWiQXa28c1DazNqk+5HKQwqWWbVJWCb
         N75mD+BR/hZXtgT3IxHaANA/Z8+LRQegi/d69jZmPsOQDVnTNdC+ZqkXnn8O4+S3mARb
         Coq6G9fO/sz6Tw9BC7yVtdye6LFviDnRGWL7Sq+NSvaogIvJFqN6hZ662EG+vrsF0S3F
         a0cSvpiFzxJhkugtB0t9qinVbnEapiDOkg5CZUl6IZQGP32ZmRKa1YQXPGvaWneTiT4b
         TDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2FWu0aD8dQ+zrl7Pi3fqSaepG3+2JgxYVFbzmTqNsSM=;
        b=t4tmWUH7OEUagZ9163VqcMmo0lG8j7ydsX0fzdOvobrwD7ohzjGmxD+XzSf6/N61+Q
         /MkiPWzc1RZ1hhbXro/W769M5+ZBQn8GZmQ2TetAv1nUEZLTBhmIASiwirauUICVE42l
         UQAK60fC5KmEni/Uu7zyvKR0FJLH5F9uV9DYIeHZOfLKGiFIjRVhZ+DDl9xqXjGA1uJY
         Dtg49iaEWT5VZzvIud/9imRFlpJ/P2bQ5xgb9wuBcj92MfU6BflkHdwsPA5jC1vjnEVP
         6RpS2k0seB1jORAjbMngIARp8rP2zhw4Nw5twAr3PcbUDqDgQSGw2KsDu/pZccgg2IIY
         fGDw==
X-Gm-Message-State: APt69E28g7zSGt+66QaJ8reVWGjFJzfm6J4LeecLPtaFuXQqSIOYRCNJ
        1i9NeNSGx+4JQkLZBEtmtgI7jN9fotVVsknnpsw=
X-Google-Smtp-Source: AAOMgpd1vAqQ9/4MYrToCyVZ+6WrDGMLE0y95mO73hvaVQdxyVeGFi0rEPYbeDCxACApLs729qsvd5F7/+ZQew+HwUc=
X-Received: by 2002:a1f:50c:: with SMTP id 12-v6mr744400vkf.26.1530700739246;
 Wed, 04 Jul 2018 03:38:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 03:38:58 -0700 (PDT)
In-Reply-To: <20180704070033.GA22377@vkoul-mobl>
References: <CGME20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65@eucas1p2.samsung.com>
 <20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65~9jzNWZMqQ1216712167eucas1p27@eucas1p2.samsung.com>
 <20180704070033.GA22377@vkoul-mobl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 13:38:58 +0300
Message-ID: <CAHp75Vfy8=i3dSYoQ5Uto-RtmU6E8BVWU1dmG8BihN=Wtkr+_A@mail.gmail.com>
Subject: Re: [PATCH] dma: add support for reporting pause and resume separately
To:     Vinod <vkoul@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        dmaengine <dmaengine@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 10:00 AM, Vinod <vkoul@kernel.org> wrote:
> Hi Marek,
>
> On 02-07-18, 15:08, Marek Szyprowski wrote:
>> 'cmd_pause' DMA channel capability means that respective DMA engine
>> supports both pausing and resuming given DMA channel. However, in some
>> cases it is important to know if DMA channel can be paused without the
>> need to resume it. This is a typical requirement for proper residue
>> reading on transfer timeout in UART drivers. There are also some DMA
>> engines with limited hardware, which doesn't really support resuming.
>
> Am curious given that your hardware does not support resume, what was motivation
> for adding pause?
>
>> Reporting pause and resume capabilities separately allows UART drivers to
>> properly check for the really required capabilities and operate in DMA
>> mode also in systems with limited DMA hardware. On the other hand drivers,
>> which rely on full channel suspend/resume support, should now check for
>> both 'pause' and 'resume' features.
>>
>> Existing clients of dma_get_slave_caps() have been checked and the only
>> driver which rely on proper channel resuming is soc-generic-dmaengine-pcm
>> driver, which has been updated to check the newly added capability.
>> Existing 'cmd_pause' now only indicates that DMA engine support pausing
>> given DMA channel.
>
> The change looks fine to me. I was hoping that serial would also check
> this..

AFAIU serial does not need to resume.

-- 
With Best Regards,
Andy Shevchenko
