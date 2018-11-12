Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCE9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7B522506
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="v0/tyzzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7B522506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vanguardiasur.com.ar
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbeKMG7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:59:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42004 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMG7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:59:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so412698pfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 13:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=41H+lAG5eJZVfIC2g3mWh9vIj8/xyUsXAyPBoAu6Ldw=;
        b=v0/tyzzn+qeUo/qOi9HTQqS/TSFr5zNe4NN9vJyob+UNqqE7pIHWD4AY4eAs2pI4xL
         zuJxtziIWCASHgnTxfp7Y8HFwSQ4JBrmit05BjYg21VVc070Gu2lFfDJfx2Uxa2HHkqm
         xeqLE3KoUoFpiAZPi9qxyvVDu6OfRKjix2tSrIj1c0A5G063y4Ms8cKfiBx72CK1/Ys2
         T/qyqcpES3puWUaDWgnh3SFDHN//gVLGVvXfgraisBzkRtil8Wucr7CbYKbjYqrHIKMW
         Tsi9Zngt71LjK8w/zbRIGJI7RfND6WRNK5Ozw0lc6GNWvEI2RCts2bQ4rfA+O6onSxGG
         MivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=41H+lAG5eJZVfIC2g3mWh9vIj8/xyUsXAyPBoAu6Ldw=;
        b=CJ2oLN24iGpKmz6MXfbANxOCLdIqYZG6LDTh8yAPWIhX0AqlIY4U3hgo3GmE0xwyYl
         5rZ6ol7SwwhsX+05sLl8tNgpqIPWYe7hcUMpelIgpdLS6krUCpH9IVzCYG6EE6gNc3+y
         PDZfeZdLdSIhvwi5aoS03kMg/rXg5Y+oubnb6lSQuCKh5qMIXaFQmSMFmKyVg04KwT/G
         +1DYj7JVwM5jDFHO1lz20ewXU8mPjnaYcpwpsKFms42ZTsvj3ok7irz2yLLSp9Q5spvX
         PnSfnGw8ybiFcYFupciX7N6KViT4k2bONQTeqpAw8eqODVKB29dnf8RtWoiR0a7MpeyP
         /Zng==
X-Gm-Message-State: AGRZ1gJDQwSIEGN6iSMlJ4O8zg/sVRXW1YXirNXblkfq8RShhowyxI1X
        +R2LrFRvau4NvMQH4N/ps2NLD9JX5NZLBSCoKK1HLA==
X-Google-Smtp-Source: AJdET5ct4Jz2ImvnSes6xT6/sdhtS3+MlJSzM34b6UsbqVLwwDxURFepreo7jts1H4FlA0Lagtg65/dNK5mlgRNY4BQ=
X-Received: by 2002:a62:8647:: with SMTP id x68-v6mr2497641pfd.252.1542056658275;
 Mon, 12 Nov 2018 13:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20181014170431.GK3461@darkstar.musicnaut.iki.fi>
 <CA+7wUszkduiKMVx5Et3Q2-2tz72CXUKE1_kndC6V1d45uEY2Aw@mail.gmail.com> <20181017195050.GA20347@darkstar.musicnaut.iki.fi>
In-Reply-To: <20181017195050.GA20347@darkstar.musicnaut.iki.fi>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Mon, 12 Nov 2018 18:04:06 -0300
Message-ID: <CAAEAJfBUEj+4RnHmK9RvOv7cghQNr0xNqr5GdVTG+V88+Kzi8Q@mail.gmail.com>
Subject: Re: Bug report: MIPS CI20/jz4740-mmc DMA and PREEMPT_NONE
To:     aaro.koskinen@iki.fi
Cc:     Mathieu Malaterre <malat@debian.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 at 16:50, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>
> Hi,
>
> On Wed, Oct 17, 2018 at 03:38:07PM +0200, Mathieu Malaterre wrote:
> > Since CONFIG_PREEMPT has been 'y' since at least commit 0752f92934292
> > could you confirm that the original mmc driver (kernel from imgtech
> > people) did work ok with PREEMPT_NONE (sorry I did not do my homework)
> > ?
>
> Sorry, cannot confirm or test that. I have only used the mainline kernel
> on this board, since v4.5 or so with my own custom config which has
> been PREEMPT_NONE until now.
>

Aaro,

I spent some time today investigating this issue. I think this driver
has a broken pre-request/post-request implementation.

Will post some patches soon.

Thanks for the report,
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
