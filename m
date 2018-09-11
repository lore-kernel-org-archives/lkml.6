Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA23C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A258D20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jiYx/lrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A258D20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbeILDUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:20:08 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:42087 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbeILDUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:20:07 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id fff8fa1a;
        Tue, 11 Sep 2018 22:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=Hle2PBnjCSOOplPBQvmfYtEM/N8=; b=jiYx/l
        rDBTw0+gJQZ2W47B5wFaAVOw2SSrIv8fV3cg1Dr4q9xDODKArboSiOgPYA7+A99G
        yS3sBL9KPEA80VddCqunulMAymGmT0JYuYuu2BrEUr/ZQ4ZrmprdoY3IkvMzUAcF
        MX13wCxTFdeFOtZVJgDjYRGQr7h1twuORhs9+eErB5MacNR2SMQVJfvpUAAsMPRT
        ugPnQ6jkF18yF4UXwLgngwE0O3oP3K9osgsBNhvN7dtvhexPhYJfOc8IR86s7NNI
        K+CFMm/Jl7awMVAxS99vW3Lnr5Ol1bv8+p3h3X80Qz6FVE7ndBl03ZStGccrLEoG
        yQNsdi1i120Wky1Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2194eace (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 11 Sep 2018 22:01:57 +0000 (UTC)
Received: by mail-oi0-f52.google.com with SMTP id t68-v6so50317663oie.12;
        Tue, 11 Sep 2018 15:18:39 -0700 (PDT)
X-Gm-Message-State: APzg51BJE9jtA08Bo3K0MCPvJDrTjAp/p+wEitO9nnXJhQMKfUCvTHMQ
        gw7t4f4gkaYAuRxbQ/PYlFV5atVnMyTP32X8oWk=
X-Google-Smtp-Source: ANB0VdZOt+LfCXbgeKgVZkWY2yYKNW2+/yDE56o4903s+Z2SALle1bLsM9DKjYZAeRdqmVZvBabOrgmlDVXLy2Z8hbg=
X-Received: by 2002:aca:e6d4:: with SMTP id d203-v6mr29530242oih.311.1536704319076;
 Tue, 11 Sep 2018 15:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <20180911145624.GA21635@kroah.com> <20180911214737.GA81235@gmail.com> <49BAF465-B3DC-4155-BFF9-DB6C386C1878@amacapital.net>
In-Reply-To: <49BAF465-B3DC-4155-BFF9-DB6C386C1878@amacapital.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 11 Sep 2018 16:18:27 -0600
X-Gmail-Original-Message-ID: <CAHmME9q+mqT+vtM1FdBvf8=nAFu=u+wN48sOxqLcFthxYVn7NQ@mail.gmail.com>
Message-ID: <CAHmME9q+mqT+vtM1FdBvf8=nAFu=u+wN48sOxqLcFthxYVn7NQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 4:16 PM Andy Lutomirski <luto@amacapital.net> wrote:
> Jason, can you do one of these conversions as an example?

My preference is really to leave that to a different patch series. But
if you think I *must*, then I shall.

Jason
