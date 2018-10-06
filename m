Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B42EC65C30
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81A121486
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 12:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="thPM68Bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81A121486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbeJFT2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 15:28:31 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:43005 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbeJFT2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 15:28:31 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 075e77d6;
        Sat, 6 Oct 2018 12:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=mo+gwhmqNg4tzmD/7e/M+9Wuhic=; b=thPM68
        Bn305pFDpSPIUDlz5tcEwFQJXtNM1DTZAMOEWJ/Ohhyp5r4rAahcUprZO78lAcHU
        sQu3u5f2OrQOe6LZeuSHgXajYAcg7FvO1KhXxIMoxkp8M4lfIqv0XVW7ei7zeA/I
        R/NUoCOsy2NLRdLsBHWxdsUkqhcez/Q0xaBxq2gyvFmWUwlJc8iAM/bPPvRYWqQK
        kIf6VJdZkSzZ8DSiqEJ/T4Mc/Il36xrgLg/ON9Yke6SiptOIyRb4Nx5jq8olNKVa
        Q9w6h5pXWS2lhXob/I8me0WdLhhV+iRj4pnR9tmHGritpf84pN7hJ7eK2E2EZ46K
        TjNyvNMj4ZhsCu7Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4c0bd64a (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sat, 6 Oct 2018 12:24:51 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id o13-v6so15323828otl.4;
        Sat, 06 Oct 2018 05:25:23 -0700 (PDT)
X-Gm-Message-State: ABuFfoiKW7OwNXU2VrvOCjPFPgtQzqhbsxBdG38nsBUEC9QMFCHKFi5P
        mTBGpsWweVefmkT8NOyW4Rt3i4nwCv0HidLpKdA=
X-Google-Smtp-Source: ACcGV60W6bMGQU9NG2v84x+u1M8nFmI/0YWeglxOjAYLXjcAlOlM03liPPI83BUsFct4TKi2PI5mHCaz3O05/9YNzW0=
X-Received: by 2002:a9d:1723:: with SMTP id i35mr9518949ota.223.1538828722650;
 Sat, 06 Oct 2018 05:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181006025709.4019-1-Jason@zx2c4.com> <20181006025709.4019-29-Jason@zx2c4.com>
 <20181006065819.GD3061@nanopsycho.orion>
In-Reply-To: <20181006065819.GD3061@nanopsycho.orion>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 6 Oct 2018 14:25:11 +0200
X-Gmail-Original-Message-ID: <CAHmME9oJcXKEJ8SAuPmKAvQtonUsM8RoosJSiUhgKauemaquYA@mail.gmail.com>
Message-ID: <CAHmME9oJcXKEJ8SAuPmKAvQtonUsM8RoosJSiUhgKauemaquYA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 28/28] net: WireGuard secure network tunnel
To:     jiri@resnulli.us
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

Thanks for the review. Those points seem reasonable to me. I'll have
this cleaned up for v8.

Thanks,
Jason
