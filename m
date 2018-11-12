Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017F3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE62224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/IL+ACq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE62224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeKMF2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:28:03 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41124 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeKMF2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:28:03 -0500
Received: by mail-yb1-f194.google.com with SMTP id t13-v6so4374884ybb.8;
        Mon, 12 Nov 2018 11:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRN3Z2HJK1Lb65X0+iBDkBVeiNuopX1zxETdxyDgGg8=;
        b=S/IL+ACq/A5jXcK+wzkPFIlv7t8jUqxOa7CAm7zHTUuZg6mQSFwou+0YcYvxiW38ab
         8GDXZ8NZ56ncNStOWiR/7O5CrZRoX4vEF3HPOkw8XFSW0t9078okaVxmMwgVauBxltpn
         S6nQWM6/2KDHUKr5nL+urmVJ1y0c+tG1fTzeRLDvxlpvw5j0d2aNMgx6TRCHQcdVck5C
         2k1cs5Az3Y/30XAH6T/nkvB8VyUkr2jSKsrH//p49DwdtSxUwQQ6KdRPb9DVZPtPooe8
         +SizqNsKClPakggfH/wJuCK2jzH0c2N+NMn+0OsDmBcMZxcaF3t6tFU3Io5FxmkrX0c8
         lO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRN3Z2HJK1Lb65X0+iBDkBVeiNuopX1zxETdxyDgGg8=;
        b=fykMg+Ef0jhleyLkiZ2z2OYvbH/TJRFxWhlSqAbrt7ozfxYB1ARW+Y+Dum8Fiynzmx
         v2mDZXRK+kA4NiCCLhEpIngXCjzu79uTHGt9SnChBR9EZECg79jKB8+bn1j87Wk90doZ
         oa1VJxmR44jaYoiO24puWf4XSRdnuYMmyiVcE7A5oTPjSD37uUdCrMqMbgih/4Ttj0uq
         bX/FfYfb0p6KANQvyceKj1+MQHQUVkhpZUoYsiVzDQ130SCOG8f5ASKhG4BNsX5TBBbb
         jY45NuO2LxKm7qfjc/qmptmsBWdpImJ7zDKW1FI7c8aNMKfvPptgKJCKqSrGL63cQ3C4
         q4Bw==
X-Gm-Message-State: AGRZ1gKGahV9TdG1SxG7UWTSU/Xz/i21h/F1ofhQlZXvw7R+FpT7QC0Q
        EGR0Hn1xxlxfhc2AqCvR9nXT4IuzrqX/BjEzfcI=
X-Google-Smtp-Source: AJdET5ffjsdfX83WZJFd4wa1BZpcPCeUTllHNk4y165DDfIxrsxMRkih+/m/iS00ONxsbtuCOvxMmE/Aoycg0JLUCHw=
X-Received: by 2002:a25:9347:: with SMTP id g7-v6mr2198494ybo.37.1542051204493;
 Mon, 12 Nov 2018 11:33:24 -0800 (PST)
MIME-Version: 1.0
References: <20181112192252.3911-1-diego.viola@gmail.com> <ce81ea56-cdcb-c739-42b9-1d48188c86da@kernel.dk>
In-Reply-To: <ce81ea56-cdcb-c739-42b9-1d48188c86da@kernel.dk>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Mon, 12 Nov 2018 17:33:12 -0200
Message-ID: <CA+ToGPGGtxjocNs3H=PtKfSniw3bQM56RYrNi2fB6y9LSTMFBQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] Blacklist SAMSUNG MZ7TD256HAFV-000L9 SSD
To:     axboe@kernel.dk
Cc:     hdegoede@redhat.com, tj@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 5:30 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/12/18 12:22 PM, Diego Viola wrote:
> > med_power_with_dipm still causes freezes after updating the firmware to
> > the latest version (DXT04L5Q).
> >
> > Set model_rev to NULL and blacklist the device.
>
> Thanks, applied.
>
> --
> Jens Axboe
>

Thanks.
