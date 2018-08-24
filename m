Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172F5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B073E2082B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FtYn4IS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B073E2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeHXVOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 17:14:15 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36150 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHXVOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 17:14:14 -0400
Received: by mail-it0-f65.google.com with SMTP id p16-v6so2929186itp.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 10:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iwbWMBkCso+qLTd2UCAKLGBi2iYoAU0GFGbvtER/g9g=;
        b=FtYn4IS8X1CaLjybliZa+ZXgNQPW9nAawlCV3s//F4fE3x1rKBA9jvo/oXf93ty/tN
         RseuFtoQtMQH4LdJSeHurfQ/HMyOxCWgPF9A4GNQ7wwdOq5tW52s/TFiHzDINEh5W+EB
         xWTSg1H9VLwVLcjHH2rD8obVQ47PD7qTo7s38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iwbWMBkCso+qLTd2UCAKLGBi2iYoAU0GFGbvtER/g9g=;
        b=EoUbRdu3iGbKleofuX2fk8VIX4MSBF6ijP0AH3LMaSTlAxzGBlZ+d1X1r+50uvvrNh
         jb/MBhK7aZyWjNKFcZFaOlhWZq8Mirmk7Au99Crzf9KY2mSo+t39J2Se2VjUEuWtXHfM
         tq+DIoyU2gbtsSVxgzH0p6ZfPd3NxNJ7mNbNj/H6pbNguiwUWaJaW8i/regOe/O0R1Zb
         bP7ftvkoDQAjxv7mvbt7Qo0yIVZWSZIxF/+PuSHYH/IVFbeC+28CbALOh3LX7aY4ApQr
         nrQ7CwC15dkFAgA429jLNM1iKpduJk+dRimj9HcdUvBtoPguji4vGyuVW1+gq3Gnez09
         DJ5w==
X-Gm-Message-State: APzg51DJsrCKg/EWoeBSZarQtnRH0YUKcQUDNenh2KeOl0LQ0ug1boCh
        /yosqXYUczsQHHiYyNb7oKYcD1aM8wTJ2wKocpizlg==
X-Google-Smtp-Source: ANB0Vda9ryT0OjUdi7046i3BDdMIWymkSNNd69s1UAxYkIx9OMppSilGidvwQtIfrbjeip37KTgtjWvUIpiCe7jwYuI=
X-Received: by 2002:a24:8309:: with SMTP id d9-v6mr2157496ite.123.1535132317619;
 Fri, 24 Aug 2018 10:38:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Fri, 24 Aug 2018 10:38:36
 -0700 (PDT)
In-Reply-To: <yq1a7pb9196.fsf@oracle.com>
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
 <yq1in4gq5jf.fsf@oracle.com> <yq1lg8zb2lp.fsf@oracle.com> <20180822062016.GA10356@infradead.org>
 <SN1PR04MB18241CBDC8E4CA5275EE4424EA360@SN1PR04MB1824.namprd04.prod.outlook.com>
 <CAKv+Gu-RwCrdgW69NVpyRLwGPGPCZx+ksTBM7NZk7v0-dzczGg@mail.gmail.com> <yq1a7pb9196.fsf@oracle.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 24 Aug 2018 18:38:36 +0100
Message-ID: <CAKv+Gu8Y7YmyB5rmxaj-SGB7q03in7ijv2cOifwYnhP5CNastw@mail.gmail.com>
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jeffrey Lien <Jeff.Lien@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        David Darrington <david.darrington@wdc.com>,
        Jeff Furlong <jeff.furlong@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 August 2018 at 17:29, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> Ard,
>
>> Would it be possible to allocate the crypto transform upon first use
>> instead of from an initcall? If crc_t10dif() is mostly called from
>> non-process context, that would not really work, but otherwise, we
>> could simply defer it (and occasional calls from non-process context
>> that do occur would use the generic code until the point where another
>> call from process context allocates the transform)
>
> The function is always called from user context. However, postponing the
> crypto transform registration doesn't solve the common scenario of the
> user booting off of a Fibre Channel/SAS/NVMe device with the desired
> crct10dif-pclmul.ko module located on the boot drive.
>
> If there is no good way to teach crypto to update existing registrations
> when a higher priority transformation becomes available, then we
> probably need to explore tweaking dracut to unconditionally load
> crct10dif-pclmul (and your ARM equivalent). Looks like there are already
> hacks in place in dracut to preload crc32c for btrfs and XFS.
>

I'd prefer to handle this without help from userland.

It shouldn't be too difficult to register a module notifier that only
sets a flag (or the static key, even?), and to free and re-allocate
the crc_t10dif transform if the flag is set.


> Anyway. Just seems like the kernel is violating the principle of least
> surprise here. The kernel should always pick the best available tool for
> the job...
>
> --
> Martin K. Petersen      Oracle Linux Engineering
