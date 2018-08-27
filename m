Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1058C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667F4208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XV4nqRIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667F4208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeH0TFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:05:30 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52812 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeH0TFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:05:30 -0400
Received: by mail-it0-f68.google.com with SMTP id h3-v6so2180790ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 08:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=HxiPezqC0bxVc9IPV1JJdiUGZv8Jk3BJ5gzoJKzjlWU=;
        b=XV4nqRIhXuchdut2h4wwObX0HCNQVHgB9mIATL27kMEATI+mdLtLUj6UrdzTi7EVwu
         YiXhokDrMyKvCabENiOunfn8piKu6IwSNm9wh8FHcSNJayUdMAPPOWTDZerfS3g21DdB
         Guqnm3Pdu7Msv/45dDjMzBxq1ycKXTyYUAH7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=HxiPezqC0bxVc9IPV1JJdiUGZv8Jk3BJ5gzoJKzjlWU=;
        b=dHGitY27wiu88+h/2sDFArTDFfKCnnAJV/WxmpXqOQq/dTrGTJAuLPaZJ6VB6Emgja
         g3XxTEBBxa1vkg9Wapve1l13Nnn9VR07sQrhntt2I22PEHTpKPP7IZsRKbGQLGjil5B+
         yjPYsHtar7YBmlhC1eLhmyGrx3HRUWr9hxfGSOjsYbjsJlyNRgE14LI4gnBEkvGX9V5Y
         Iqmz52L550LTKA+9V/9QJGZC79Ne4V2rMOPxsBgZne6dht2pQdE6Yj32LHPI4NZT3m48
         xoMLavtAEU/8aqyb5ctTpgcxfboxFCBRu8JXkIAvWcnM/GObYWs69KnZE+my8Qgl8fn+
         zozA==
X-Gm-Message-State: APzg51DmZEdHVEJsUiggKW+o5m/vSKZs9lUWyHEv/aQgRcElfiSIUTq5
        Fn4Q2UZ7Df/tlSgFynQp3KCC7axO/l6+Mu3s10qqwg==
X-Google-Smtp-Source: ANB0VdZcH1zsn3+PjNxoK3sgtcHJjuGntPUCMSjEX5DM57esqeXRDkoGIEsDlaqu14gPuW0JJAcL5dI3ZWQqxG49zCA=
X-Received: by 2002:a24:8309:: with SMTP id d9-v6mr7288787ite.123.1535383107092;
 Mon, 27 Aug 2018 08:18:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 08:18:26
 -0700 (PDT)
In-Reply-To: <20180827145352.GF2311@thunk.org>
References: <20180827110245.14812-1-ard.biesheuvel@linaro.org> <20180827145352.GF2311@thunk.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 27 Aug 2018 17:18:26 +0200
Message-ID: <CAKv+Gu_qz+HbU2HQ2ep0cN-9V5hA46sBNVoxvkyjDQ=ZGk8yfw@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm64: wire CRC32 instructions into core crc32 routines
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 August 2018 at 16:53, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Mon, Aug 27, 2018 at 01:02:41PM +0200, Ard Biesheuvel wrote:
>> While this is not known to cause performance issues, calling a table based
>> time variant implementation with a non-negligible D-cache footprint (8 KB)
>> is wasteful in any case, and now that the crc32 instructions have been made
>> mandatory in the architecture, let's wire them up into the core crc routines.
>
> Stupid question --- are there any arm64 SOC's out there which do *not*
> have the crc32 instructions?  Presumably there won't be in the future,
> because it's now mandatory --- but where there any in the past?
>

Yes, the APM Xgene for instance.
