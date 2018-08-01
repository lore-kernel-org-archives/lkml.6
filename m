Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A573C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CAE20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="K71vuEAF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZHhpQWIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CAE20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbeHBA0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:26:11 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:43882 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbeHBA0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:26:10 -0400
Received: by mail-yw0-f194.google.com with SMTP id l189-v6so81553ywb.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 15:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xbkJcJgly9eymOzPmiGURjcYZqWqwn35dWO+IKYIMUw=;
        b=K71vuEAF6Ul/ChDUFpprKa6DfJSfo6VfhmTd08xIpt1t4v8L100wgX5ZVfNWhQ9TBO
         qwNrds5awpFw9MHQEHxNKnmqGf3Ai39JM9XNpROHEyCaq1I9fhzBtOIkXmi2a/uYa97e
         ePOr7KxW0qCm7lKGwfOkeTxLnikHvx0jCcvgA8i6xUWFHFoO7bHXNWSWjl4M+kg3duR5
         rGCMCAJAFBi9NzB+dn+pN0FlQK4RKGeb7c4L66rNcRr/mjo3h3mJoVg8JgMX+7Cy47PV
         uN3aY9Bo3Ko7ortdNIpEGNAK4Yk8whc6dbgk8acejiM1/wv01x+7UmAl0eTSUNrNrXtT
         f2nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xbkJcJgly9eymOzPmiGURjcYZqWqwn35dWO+IKYIMUw=;
        b=ZHhpQWIPJyWVPc/dACObUhc+31MNGt/oFC3Visnxj440Np2yluWAbXQMPLx9SKib9m
         7t9GcVa5fByrShHhR4ElvWSdZ73ohVBg/HLD4IQV6r94KwDRluVeIzDalzU6i0g3xyWu
         4wgjLZfkKynMqi7v2S2ndooE0HiTSNCdw3vDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xbkJcJgly9eymOzPmiGURjcYZqWqwn35dWO+IKYIMUw=;
        b=N+Gj7ocPGKQVWvcLlVzKTbvUc5U9SLF6CqGv8wCimQ7K4GDHlrFErcQUCZCqmOSh6S
         0lZ8JGgCSyyZ+xf0u+RKN0jcDFxqieTEP4gpjwbXdeRL7QuqJUJp/e/DbPCzmb6zRpFT
         XMEkkKUSnewYmcms21DV7uGGN6shvsT1itMt+DDOvi1bV1VfFR2c/kL4suDPsc/6j0T1
         eQI2eeQ672Iix6gFWcvjAFFz93LMdDosG8uSv+ehtPKaDTAvdYlpQUS7hf4joU/BUgj7
         slVft57q5XtOqFL3M1Pixxu6JF+42ADrBQ709iyw0/z/9SF4ZWiZpNExXxUvruUnisGK
         3vtQ==
X-Gm-Message-State: AOUpUlH3MU/ZULUKBeQSnligjuUG8azTPEiTdxtAZTNmEfpKaUPs30gz
        06sPCzhu9/oWXPQvxm7uwA+st+H91pOtvKxuEbYrJw==
X-Google-Smtp-Source: AAOMgpd5I7pch1yz05pMbQIyjXljHevoJFnnlZNcAlG85mhltMCRshNJ2hWDmPkITdPCpbc/vGXQX3SC3Zl0U+GEdy8=
X-Received: by 2002:a81:b248:: with SMTP id q69-v6mr170974ywh.38.1533163088735;
 Wed, 01 Aug 2018 15:38:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 15:38:07 -0700 (PDT)
In-Reply-To: <8da60549d9c649bc6f00cd82f70464b982ecb2a0.1533122560.git.geliangtang@gmail.com>
References: <8da60549d9c649bc6f00cd82f70464b982ecb2a0.1533122560.git.geliangtang@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 1 Aug 2018 15:38:07 -0700
X-Google-Sender-Auth: wTu1aK7XaoHpps5adyX4YW2JpV0
Message-ID: <CAGXu5jKhP6FFYF0O=Vy6aMqJxD9Ubt80nX9Mh=guU8wgUzvzQw@mail.gmail.com>
Subject: Re: [PATCH] pstore: add zstd compression support
To:     Geliang Tang <geliangtang@gmail.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 4:23 AM, Geliang Tang <geliangtang@gmail.com> wrote:
> This patch added the 6th compression algorithm support for pstore: zstd.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Thanks! I've applied this to my tree and it should be visible in -next soon.

> +#if IS_ENABLED(CONFIG_PSTORE_ZSTD_COMPRESS)
> +static int zbufsize_zstd(size_t size)
> +{
> +       return ZSTD_compressBound(size);
> +}
> +#endif

One thing I've been pondering is if there might be a way to extend the
crypto compression API to provide the "buffer output size" interface
directly. If that happened, pstore wouldn't need per-compression-algo
entries like it still has.

-Kees

-- 
Kees Cook
Pixel Security
