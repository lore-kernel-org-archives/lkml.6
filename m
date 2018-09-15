Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C4FECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 23:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E96B20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 23:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SIJokFxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E96B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbeIPEfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 00:35:54 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:45673 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbeIPEfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 00:35:53 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 68fcaf2d;
        Sat, 15 Sep 2018 22:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=nA/DyP57uHbiIaiwDjHATTuM56k=; b=SIJokF
        xXj1uN0AKUgBojV9WDIYnDVBu1v5f743LJdq7yiIfCWT8SWQzQTffalu5bbezRC5
        yoXJT2WhV1+tkAhnXhra0MzwwWoI9sKPPq2zuOWQfIpkjNGLna5wisHALV9w6ALm
        H+nO0HBZXwb8N8MvoCpfy3AWw10MTnbBrAz4nasrrHoazjMqTv9fnN0djsennAm6
        Qg+EeZopSGluorcXDJsKKvEge07BqsHRCBPtsT47pa01mWI605NxbhbZz/H2T7Se
        M6f6RaXMtUw1T0XCzyFyYy2Nl8jdHvpCz81R+qoQAPoYsGDSIlb5RJIw7Z/6xly3
        HcUFRWc1B4j5PH2w==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 061d51f2 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sat, 15 Sep 2018 22:57:55 +0000 (UTC)
Received: by mail-oi0-f52.google.com with SMTP id r69-v6so15950976oie.3;
        Sat, 15 Sep 2018 16:15:08 -0700 (PDT)
X-Gm-Message-State: APzg51CAi1qrPi+BXjf8UIrWOaJS/LeeHcyMJEqlcLwEXbpBhLdHZVbX
        itDX+gMFDiEGhh953hGaRh9ooyF9kkSpSnCAyms=
X-Google-Smtp-Source: ANB0VdZTG+xDSjAxkBvgyFg4A33iydNpDGMJlEjT1Z35NzCrQszD4vDiD3B9Qyp1L98pnErgvIEHD4DcyDn4cwcjf0w=
X-Received: by 2002:aca:e6d4:: with SMTP id d203-v6mr13717556oih.311.1537053307819;
 Sat, 15 Sep 2018 16:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180914162240.7925-21-Jason@zx2c4.com> <201809160630.4PzV0pYM%fengguang.wu@intel.com>
In-Reply-To: <201809160630.4PzV0pYM%fengguang.wu@intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 16 Sep 2018 01:14:56 +0200
X-Gmail-Original-Message-ID: <CAHmME9oHC-DZqC8RQnboFyTDwL+bZX4KFX9JJkV1KiRgdeOQ8A@mail.gmail.com>
Message-ID: <CAHmME9oHC-DZqC8RQnboFyTDwL+bZX4KFX9JJkV1KiRgdeOQ8A@mail.gmail.com>
Subject: Re: [PATCH net-next v4 20/20] net: WireGuard secure network tunnel
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mr. Ro Bot,

On Sun, Sep 16, 2018 at 12:19 AM kbuild test robot <lkp@intel.com> wrote:
>    drivers/net/wireguard/send.c: In function 'packet_encrypt_worker':
> >> drivers/net/wireguard/send.c:320:1: warning: the frame size of 1136 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>     }

Thanks, fixed for v5.

Jason
