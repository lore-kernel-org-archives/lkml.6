Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C71ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40BF020647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="tbwGkpSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BF020647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388177AbeGTS0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:26:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45170 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731747AbeGTS0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:26:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id q5-v6so11757176ljh.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GnPqYKdaxaoojwORTcjduuBEz5S/KAmKjNLBd5aXpKI=;
        b=tbwGkpSp6bzhyG9apBW0m+dgt6Bi8AG3BpbFMmxCcI4X4xojh6gA8AYuXjj1Rg3+W5
         Y46z281pLTwLlj9Js6t0LzCtc4Dgt4w58rZ3Sra0Xt/ENs0sgHk88SqlSKaVaaf7ysPZ
         /TERwHuhwgU3a6o/Ir4HPFeCI/4PAAoD+S9G8WTk/VVAlWaptzMt3cYQ+S6440FteQzV
         UAlTPatNXpCvAP6H8tkYk+pj3FWrrUG2h6bbHJM4Th81h7OuMtLyvzgJWUVqtJvEUGVZ
         3iTzqn7VM6vdf1vUGpLmouLzLzs0Nfww37dxNfS73hvWuQsaUt69A0mJGhAi01NgvWUV
         TL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GnPqYKdaxaoojwORTcjduuBEz5S/KAmKjNLBd5aXpKI=;
        b=Dqi60thDpBTTSBZlunHOQnfrPpf/DXvpapWVw5fIfQczJkNj0mQ/bmQwlemvHWWY1+
         1BWCmtC6wRH/lOPJuV1bWvNIkYXATA0GXpO+PXPlQDHhenu5Wquo4Qq5PBwY04pyo5oX
         XY1Uzd2S6LutkuvrPst0Xhg66ZDjAfSeCph4e8ADOcbtbIP0wykYg7sPgW33GL3RUZv3
         3RrF3PBHBRbtZSRpzPigRXE9RsDvzULtb4xvfLNeh0yY8x03xXM8DNTc88K7vdXm7z9h
         vD49uSn+xcu4P5l02BeTdV4ebUzvjSmq4HgaMpBoB3+GKg9Z6YmCQzipQiC3qGVowkJH
         2pUQ==
X-Gm-Message-State: AOUpUlE9klcBI6P7KIlDKfliwdNNSp6EbicZvUM0iuOQwKSLUhArrwd4
        6EJtDBbFw2n70MIXfpmo2seVUD9V9igb6y6P1cLcZtFzEEM=
X-Google-Smtp-Source: AAOMgpfELQ9LdCZJ05OHnzAm5WGkh0okuRruiXbe+u9WmieWH+GJ4BJZznOuQkhA5QI90bxL5+A1NDP0DmyDDCqbk04=
X-Received: by 2002:a2e:195c:: with SMTP id p89-v6mr2204718lje.138.1532108250594;
 Fri, 20 Jul 2018 10:37:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:fc1c:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 10:37:29
 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:200::4:f46a]
In-Reply-To: <20180720121619.pqrgth4zxdj7zjym@8bytes.org>
References: <20180711205936.18614-1-olof@lixom.net> <20180720121619.pqrgth4zxdj7zjym@8bytes.org>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 20 Jul 2018 10:37:29 -0700
Message-ID: <CAOesGMiaC8VXkYkgJF7h32ounC6hHNZtZjfW_xPcbw1cGKOT5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu: Add config option to set passthrough as default
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 5:16 AM, Joerg Roedel <joro@8bytes.org> wrote:
> Hi Olof,
>
> On Wed, Jul 11, 2018 at 01:59:35PM -0700, Olof Johansson wrote:
>> +config IOMMU_DEFAULT_PASSTHROUGH
>> +     bool "IOMMU passthrough by default"
>> +     depends on IOMMU_API
>> +        help
>> +       Enable passthrough by default (removing the need to pass in
>> +       iommu.passthrough=on through command line). If this is enabled,
>> +       you can still disable with iommu.passthrough=off
>> +
>> +       If unsure, say N here.
>> +
>
> The patch is a good start, but the description above indicates that it
> affects all IOMMU driver, which it does not. Please make the Intel and
> AMD IOMMU drivers also take this option into account.

It looks like it should make the AMD driver should honor it, since it
uses the generic infrastructure for domain types? But it also shares
iommu_pass_through variable usage with Intel, so if I change it over
there it'll be covered for sure.

One unfortunate thing here is the divergence in command line options
between arm64 and x86. I'll add a 'iommu=nopt' on x86 so it can be
turned off at runtime if enabled in config, but it'd be nice to also
have it adhere to the .passthrough options. That's a larger topic than
just this specific patch though.

Posting new patch shortly.


-Olof
