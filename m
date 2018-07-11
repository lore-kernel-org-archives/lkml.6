Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1280CC468C7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE66720852
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="00eciaUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE66720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390550AbeGKVxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:53:11 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41578 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387509AbeGKVxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:53:11 -0400
Received: by mail-lf0-f66.google.com with SMTP id v22-v6so8981892lfe.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 14:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fqTF+EgZjanyU5IYIAjaOCBA52D77FN66Xy66NuvqGg=;
        b=00eciaUMPTIwqJIxgHqqL/CkrmOElsS2GIxjkYjwM83jORiiSct2IxrrTW6tz1RypC
         BFlrORk6WVS9kGeoEsJkCYcm/JpyVCm2SvVrX4kFWY/FCqiwp4abMTEPZl/dIoKsYgsi
         VkS4aX2Bmvu0LD4DCBdA7hVUi0IAr8UTa9hLv1n7cfcmuiX11pw+OofpzkcflqH7pAP+
         nNolp8xsqIuJxDsfNmCT1nbLaLqT5vaqnxocdm55QfYl28LJuPhsbh6jZEw0QA1nulhT
         IWT+2ZLDRN/0nVf593vSqC9gGCCfD3H33MlFoXmH/R4T2azsWNiRaTq7sPQCk2UI5Pof
         diPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fqTF+EgZjanyU5IYIAjaOCBA52D77FN66Xy66NuvqGg=;
        b=qvTripAbedoHHaptAbigbUyqB3sBrkWMDMPrHGDtpbQqRJU34X0tPb8Dr6fZSy3Z+4
         zB6Li00MNkf6oeupXbwoJSlRMH8+W5g5tEEgWJ/ylM6Yv9oqefesVwJKK3cMX/4QPeU4
         rzYJ1/Ox/fJgtk4fIdT4amIZBOlcSTXDxXjNwL2fEyzbkzJq8jl8H1mXPtMbAF+detvE
         QY+Ttpfomxn7GAwNBB8GEwePUTRVZKEtUU3dQrW2J1whqarLwKJRAKXm1lmv7oLUzMvz
         0Jmwd8JEu0HZUr3qWpdeWW763kaBqmmpI3ftFYTg7o+HkKFM9wwnKgPwSPAEVxMgFrlF
         f+Eg==
X-Gm-Message-State: AOUpUlEmO9DrTvScijIaXmzvpnEF5uvGd14w+/A65jyzn6nqvSaepq0d
        UbHQbOSiEEla0GKXtI5gXA93HkdQccCH7aoz65Zbhw==
X-Google-Smtp-Source: AAOMgpeUZ+5fkn8bTMFVSCyA6w5d6wapWj1tuXI8AQd2s1Kasa7P+y6k3au5EPgCnxqvzIA5SMH53PQ6et1KI0QjZRQ=
X-Received: by 2002:a19:138b:: with SMTP id 11-v6mr226069lft.74.1531345609263;
 Wed, 11 Jul 2018 14:46:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:fc1c:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 14:46:47
 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:200::7:2a56]
In-Reply-To: <20180711142649.4556-1-geert+renesas@glider.be>
References: <20180711142649.4556-1-geert+renesas@glider.be>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 11 Jul 2018 14:46:47 -0700
Message-ID: <CAOesGMgkU6yBRpAsED2fPyuAo9Tc=YprndGdkmBVrc+0783VwQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: defconfig: Set CONFIG_LOCALVERSION in multi
 v4t/v5/v7 defconfigs
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 11, 2018 at 7:26 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> This allows to derive the kernel flavor from the kernel version at
> runtime.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I prefer not to have this go in -- this is extremely likely to creep
into derivative configs and as such it would have no value (you can't
be sure it's still the same config).

/proc/config.gz is the way to keep track of exactly what config you're
running anyway, right?

-Olof
