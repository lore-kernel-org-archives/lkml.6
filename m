Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BAAC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E442087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b8IQSOoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E442087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeH2Bhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:37:45 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37765 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH2Bhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:37:45 -0400
Received: by mail-it0-f68.google.com with SMTP id h20-v6so4557468itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 14:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7xvC8B9cWH5ESribMtzRbl95OH5CldN7dNuxG/OIACQ=;
        b=b8IQSOoJ0rvOgk7YUifpEjIpcVrjPu1r/lC8v4Yn19RtQeOPjBiVEeGrvgoCZjPWRQ
         AE4XKmQUDUc7xCpSg2rOrwklPYEcJjgvNwYggdikfE4lbTh4NQ1D9nm6vrWaARbOJbCM
         bj4WzXhe32oi9uBybcmcrZ6rX+VVjNpI5bmg4R64FiNcDjOMVDFOsFHiEFelPluwdVsZ
         fxvS8P7DVluyGBDHQXV0g4TXkBhENrGmeUdAeSLg8BEx/xyeK2CBuXGKdM+oo7I0pNp7
         UC4dK3XOPW2p3+t/xWyAra6HmzwQ4M1Y4FHW2IetnOd8sl4huWavwDfAZ3PO1uInOoy1
         C42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xvC8B9cWH5ESribMtzRbl95OH5CldN7dNuxG/OIACQ=;
        b=Wmch7dufE6vt378PQfWt582tJsDMI0VNsjCAYG/P2N9OG7sTgJH/KoC4ZkzsAXjH/5
         pLZ8X1EAdB6CWln0yisdfnfTBvai+95Vno61bzNDUm1WMjDOSRrW6UEYv6IUWcMY+LL/
         AZcXj74Dk8pvUtr6rxdsok71hdr9ztjlzoxapcqS3n0MJN5/eObS+7j2gb8y0I1N8Pf+
         tvoYPApFrt9v6Epawi8m/qDZm6XE0jHtdyhfVDWvDqD4Ke+dwKRKPO1T2P0e+uiCtawh
         6bayBHUm3HWG9x8KIHCAJMU66+loEaIl3/GgFeApezgSj2cysCPtOgwM+Eundxpj3ZC7
         THow==
X-Gm-Message-State: APzg51BsA2D2dzYCfMNqkL93rOAVWr4WAgSGsoNmir31tdzktmx3Yxtp
        Mo5EQLLe89vzZCnP6VPeadBSSb+aSXWFT5a3OMv4dQ==
X-Google-Smtp-Source: ANB0VdYT6JlCfvFGw/5wpFyx/carUJglkeat1hlketCg6NRgh+lwDSt+gl3lVNvCQ7YIH6+116OnBYJZgvZ5dFgdK+Q=
X-Received: by 2002:a02:6584:: with SMTP id u126-v6mr3008243jab.48.1535492648948;
 Tue, 28 Aug 2018 14:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMnawu33A5L5a6a00tZ+_9cQxyN97OwXK0sO9Q60+YvR=Yg_A@mail.gmail.com>
In-Reply-To: <CAPMnawu33A5L5a6a00tZ+_9cQxyN97OwXK0sO9Q60+YvR=Yg_A@mail.gmail.com>
From:   Alistair Strachan <astrachan@google.com>
Date:   Tue, 28 Aug 2018 14:43:57 -0700
Message-ID: <CANDihLFMz8soniUeCgJp4qPPAeOf2OM742BvMHsLfhPOfqSyDA@mail.gmail.com>
Subject: Re: [PATCH] Trivial numbering change in comments.
To:     mr.ray.clinton@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 1:08 PM Ray Clinton <mr.ray.clinton@gmail.com> wrote:
> I'm trying to get my feet wet in kernel dev and while working on a patch
> I noticed in a lengthy comment block that the number "2" was skipped
> in a description of the steps of a protocol. This patch is simply correcting
> this. This is for 4.18.0.
>
> It is a very trivial patch, but this is my first actual try at one and
> thought I
> might start out small (and I don't think you can get smaller than a single
>  character change). Any and all advice (about this patch, email, or
> anything else) is very welcome.
>
> Thanks so much!
> Ray
>
> Signed-off-by: Ray Clinton <mr.ray.clinton@gmail.com>

Acked-by: Alistair Strachan <astrachan@google.com>

> ---
>  drivers/staging/android/uapi/vsoc_shm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/android/uapi/vsoc_shm.h
> b/drivers/staging/android/uapi/vsoc_shm.h
> index 6291fb2..0301172 100644
> --- a/drivers/staging/android/uapi/vsoc_shm.h
> +++ b/drivers/staging/android/uapi/vsoc_shm.h
> @@ -92,7 +92,7 @@ struct fd_scoped_permission_arg {
>   *    The transmitter can choose any appropriate hashing algorithm, including
>   *    hash = futex_offset & ((1 << num_nodes_lg2) - 1)
>   *
> - * 3. The transmitter should atomically compare and swap futex_offset with 0
> + * 2. The transmitter should atomically compare and swap futex_offset with 0
>   *    at hash. There are 3 possible outcomes
>   *      a. The swap fails because the futex_offset is already in the table.
>   *         The transmitter should stop.
> --
> 2.7.4
