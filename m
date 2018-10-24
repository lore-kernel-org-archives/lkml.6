Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC6BC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034822082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wESs8kVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034822082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeJYA2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:28:30 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:53424 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeJYA2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 20:28:30 -0400
Received: by mail-it1-f193.google.com with SMTP id q70-v6so6807402itb.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkOD/tgaIRCmfNzSeuIvsxupgqvG6w6hzAPVZ07SxNU=;
        b=wESs8kVD9hLE5VddBF1BFnN3qv2+P9JgD/YkVOpajkmJ5Tek7XKoAPrLqoIhs00b2V
         k/u6iBpHIFJNfHT8bXj2m/ocOL0Nv4VexVotK6eiJde4XO+WRnScoD8CX3HO/gZasHFA
         jV9YnVON/s9WjHPYCT55T+k3Mh77H7e3hw/GJlv+n0YXBBUYAPH1Mu6ZFVZmmbK8vjoY
         AL/XRJDNkC/Jc76Yi/CypQCr6wxgupLGqZb+IjirXHYdAiWo8J0bydHHyahYOiDi5zzD
         0TdbVuRecSzEPdbjjWrfyAXQnvMM1teEQ0ORNNaLfx/8WbtoWBGn2aH4EKeqKWSNsvKU
         1yBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkOD/tgaIRCmfNzSeuIvsxupgqvG6w6hzAPVZ07SxNU=;
        b=q+Wn9Df+FweWAsjaNp3b2PjTLDGvXnYNItijvCmKtamDwvkP088IYIvIiEZpuZeGOl
         MHeu51iUGBAG/IzTIBhKXw+yD6S67UMphVFGaVXoZBf8PVaOwbgT35S3w+/3UiXBNGpF
         9e8q/to9sbQOQ7ERx+/Mtwsc8/mGVyX9zUyK+GoM4IbC/CqnLelaA/phl/OfFZ4SvyBw
         IZiFjcHfU64xD22S5WONHq1JrEBr7+W7HXdhDXfm8JKKP83fHsiXKpgXwV0an2afjj68
         x/6uE/rb4KUaVS5AiCFdbywOg1EW/r9O7b+EM6opQ50mbFnQlzrj/apqKwCw+tiw6jQo
         6r7A==
X-Gm-Message-State: AGRZ1gL9kMoVSGpqh9maWMwEo0vk7dfjcmEeIsRo63j3SHuBCmBn71ZS
        wAmOs2O4ANGOBmqKMIb5YJHvt94kBnK5OJW+xplaFw==
X-Google-Smtp-Source: AJdET5d6JbnR+EJB5XKVHwQpAvsS5jYdJyhpMvsdwu8a1fWD7ACRrWNxdjFI1BbcK86RQxMCWs53qoeSVhLkTcov3ag=
X-Received: by 2002:a24:74d4:: with SMTP id o203-v6mr1954916itc.81.1540396790956;
 Wed, 24 Oct 2018 08:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181024154729.5312-1-wanghaifine@gmail.com>
In-Reply-To: <20181024154729.5312-1-wanghaifine@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 24 Oct 2018 08:59:39 -0700
Message-ID: <CANn89iJ__4gXH-6ns5fiun6G29ppYWLRE_G=4s0vTus+ccGXcQ@mail.gmail.com>
Subject: Re: [PATCH] Change judgment len position
To:     wanghaifine@gmail.com
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 8:47 AM Wang Hai <wanghaifine@gmail.com> wrote:
>
> To determine whether len is less than zero, it should be put before
> the function min_t, because the return value of min_t is not likely
> to be less than zero.

????

I really wonder if you actually tested this patch.

Thanks.
