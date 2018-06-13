Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7E472C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A1920891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fyxmhw3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A1920891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754554AbeFMISy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:18:54 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:38459 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754511AbeFMISw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:18:52 -0400
Received: by mail-ua0-f196.google.com with SMTP id 59-v6so1148425uas.5;
        Wed, 13 Jun 2018 01:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9SCszq8UJUre0w5/Za3KxITbdsVLRhw9OZ8TXXrBtCI=;
        b=Fyxmhw3X52wq0bWg8IG9GcDIr6RRrNC59RsPF5T2y1xmXhmp2wgP5P74+nZAUYdiDx
         YNjgS0XOz7gv7ZtU8t1ocDaCmgikqGdX9GFTBaOu/iyO5rX03njim/WRE4C+U6UrIseJ
         4NWWLVSFmaPCBjQEJ1Tm8xgCPqF/V3kWK1wCw4R5o0Ro4fn3sEKa5j3+HDAb2FGVZcB0
         6v0cbEQldqNuaNfqJ308pmf6sdE9ez7G8TSRazUXgICDzesOOCT0gY6xpeaNxnsk8rHL
         fOCp/kEJcsWleeY6LxkmfIxIGRr+ckbatUtgdVhN5t4RZ4p5u/LV5RdpoXYInCNlzwRg
         cIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9SCszq8UJUre0w5/Za3KxITbdsVLRhw9OZ8TXXrBtCI=;
        b=oHnLZ4+8l5Zv+r+PjLY4AUuYzES7CilXsyFKgdxoeSNVOdWygRLhO3K7LGj7rZPFno
         YgCrFGMEQFNvHD83Gb9uEbHEQc4gLTmXNdpm9QQjNzxis3qKm5nUteMPKGf30zO/kcNg
         fK/iQLUXr5+QtI/xzlQ8oRZfiqRjNITcSyikRLEPVNGCkGc40vf/NPh3G1trMjlv5oPF
         5F/oy2Qn3/14H55V8a1OU/HgKM0a/CCydrlUH0SclHbjMuNcIeGNvKqBdLIEKQgPUD8T
         33N9GEXsgE618Zqwq+lUXAi+wWe+1QgQGNtJlRGS1Uw8324iR9EX5PtZFOsNz/D7Gd+r
         uzOA==
X-Gm-Message-State: APt69E1uz7XABPaRi3dJhJqw46V3gj7txgNV1Y0n6i+i2Pul5R6ZPk75
        WBjRtxL5gG6shNT8vl1xKjcjvQ1ZQG1kTS4fSbwaRCc2
X-Google-Smtp-Source: ADUXVKJeSg36sqD38SA6dhzfBht3Uhi89YfLYzq+9raB18Mle9f1DY2NHEaLjoZ0UIUAnjUquJ5xDo0lK8zuUFJnAWk=
X-Received: by 2002:ab0:1a23:: with SMTP id a35-v6mr2581441uai.47.1528877932090;
 Wed, 13 Jun 2018 01:18:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 01:18:51
 -0700 (PDT)
In-Reply-To: <ddc9a616517f8c4255efe2f57d13d3b3ba81ee89.camel@kernel.crashing.org>
References: <23be2945b593a36d8fa1970bb579389c0f892a3e.camel@kernel.crashing.org>
 <CAHp75VfJNrviiiam9p49+6_oSjW+YH8vwjcZ2hn5Ux5mHgDCQw@mail.gmail.com>
 <53ef03b26a17738dc1465ce85562c9611ad415f8.camel@kernel.crashing.org>
 <CAHp75Vcdaejn=eq740YNdscSv9zX9xj3RzYp=AFs8HFprw34_Q@mail.gmail.com>
 <5d932502d9985cdfa6540480ea5ce6b0730502a1.camel@kernel.crashing.org>
 <CAHp75VfV7actoXkMUbh9KwAXR1FKR_VZ5RAuaL-pKLSynFi-3g@mail.gmail.com> <ddc9a616517f8c4255efe2f57d13d3b3ba81ee89.camel@kernel.crashing.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jun 2018 11:18:51 +0300
Message-ID: <CAHp75Vey4sVb=VHRXCB3WHDwuwBUM24gbnjt+hHTJuTmUoQgQA@mail.gmail.com>
Subject: Re: [PATCH] drivers/of: Add devm_of_iomap()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 3:18 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> But there are many other uses of things like of_iomap() which could
> benefit from switching to devm_of_iomap() and thus getting the
> automated cleanup on exit and appropriate request of the memory
> resource.

Fine, fine.

-- 
With Best Regards,
Andy Shevchenko
