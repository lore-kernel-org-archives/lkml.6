Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F788C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E534208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZP1VZLau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E534208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbeGaMra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 08:47:30 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:39949 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731503AbeGaMra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 08:47:30 -0400
Received: by mail-wr1-f43.google.com with SMTP id h15-v6so16179255wrs.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 04:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8lWbHqiHOGiqhGb369tzpBgXP2BLu6gr3nc0Vfjql1I=;
        b=ZP1VZLauEG9yZbaTRYz7yqlspAvfQhKKykv7hrBF3lIbMUjWfagp0Ez+y74p9EWJ92
         fhEvgUAJskbSMbGe4VA9hH/6CcouO86y2D6++eVcERTp878o+7Pzp8JysVj+qOmayVOM
         ahU/Bc5FxhDUMLREQJJyDwePtA2sTOGxSKxZGDXkKDr0Iue8KIclIFeyAGCYRqpAPjcI
         kvc7z2eL3mCcqp9a4wwucpBzDjyUYPfwizEOPYYs6Yi+FWSWE97VDxaJQNx3e1QvaDul
         ft+hz42WcCeu7lzYt+CQllA8/InrbnQ5KV4P9gHQ6nPyN7Mfn6s4m4hs2uwR9fLkgORd
         o5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8lWbHqiHOGiqhGb369tzpBgXP2BLu6gr3nc0Vfjql1I=;
        b=ZuLm957mKfA5L04PrHHFYObU0aQWQ0Uy4c/gXjZ2869DvPWhw6utyjziOcSQI51acj
         HPXY0+K4fpmf0usB2yWKf2r06gfjrRZkAwKdqTnoXty5YMvwhAAiMxHPbMwX63ybf6rt
         oeS6LpYWockWPJaoHw5vH2/NzWpvGDvq1lDTNO6f+LN2hQwhvKUG5e2Ki76QZlxdvbMj
         h1mPd2vnVpku+kugNotDj/g8btctmBu2dGOj85SWcwGawug8HNXjzM0D1WjKx3IMQC2O
         H/jfO3ukrGrSzas3qIv6dFPVJnvpLbWFJh+VEdWHuENYO6uFxvQUuKOkutNp2vMdnJWk
         L+ow==
X-Gm-Message-State: AOUpUlFQXv+C2h2t6uJAGDd4wgvxt+LIUfJx6gTi/NEuk7RyFC2s16f6
        gCbqP76mVvYPhZa7xKx4t9AcwQuFEv13j8xzqWs=
X-Google-Smtp-Source: AAOMgpcyBHaoXrMYdE74ZHts6LjL4fV0ItX4KIu1jVdaSzyJlsp2mLzPkLeuOdCvr0YmGcm1K377b8ZBHTW9GnBcOcQ=
X-Received: by 2002:adf:83c6:: with SMTP id 64-v6mr20051253wre.5.1533035261546;
 Tue, 31 Jul 2018 04:07:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:9c8:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 04:07:40 -0700 (PDT)
In-Reply-To: <CAAJw_ZuQXrYaEu9_pXWtoDpUjR2au1gGT_FP9F1e1Y7veHSz2Q@mail.gmail.com>
References: <CAAJw_ZuQXrYaEu9_pXWtoDpUjR2au1gGT_FP9F1e1Y7veHSz2Q@mail.gmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 31 Jul 2018 19:07:40 +0800
Message-ID: <CACVXFVPpSJDqR8ki2PiDBbU36KsGFMYsOEf_9bmN6Cpo3w_YoQ@mail.gmail.com>
Subject: Re: How to secure erase PCI-E NVME SSD connected via USB3?
To:     Jeff Chua <jeff.chua.linux@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 5:09 PM, Jeff Chua <jeff.chua.linux@gmail.com> wrote:
> I'm testing the USB3-to-PCI-E NVME SSD. It's works using uas module,
> recognized it as /dev/sda.
>
> Since it's an USB device, the nvme-cli tools won't work, nor does
> hdparm, as it's a NVME SSD.
>
> So, how to secure-erase the NVME SSD connected via the JMS583 chip?

You may try 'blkdiscard --secure' and see if you are luck.

Thanks,
Ming Lei
