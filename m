Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA47FECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F14320846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F14320846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388105AbeGWLXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:23:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38425 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388021AbeGWLXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:23:24 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fhXzR-0002By-KD
        for linux-kernel@vger.kernel.org; Mon, 23 Jul 2018 10:22:53 +0000
Received: by mail-pg1-f198.google.com with SMTP id m4-v6so55457pgq.19
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 03:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WkEjdJaoOzsYpF3OfEHP/5h2LjbDNgqsKSOyK1a13iY=;
        b=laYJhSNnBRWSTOtxehO5VVne4vVzbqCIUkyOMnAGJa0fIWl1xe4szhXHUgC+Bsbj6C
         gEm1FlWgvcipGj0ljrP/Lkm13kimzmZJjpiBhzgywaGKnxLMrD25SVgpLvqMk0iQGY6s
         9MVZNtFt3PUyU7r8+ktCXtE3p9aIlliKk7rlNvraixWEjL4n3B+X414R3s8kz+oNgEae
         UI/N2u5pIUOhG++o9vEcqoCOV8VT7LEyLaUwgeZaWXqZHsanKeSDABZmnY9IGF+ukQDH
         7a/IJVVIu0dAbz5pd6zVerDTEEoIxmvaqD8ZareONbIwYTvVJ5akSJl295dFAuKErFjq
         sY5g==
X-Gm-Message-State: AOUpUlGDzjV9j7W/sT0DPKV8LHou9NiOs9eOcXYYuA0eZpECxJoVo4XG
        2l03OZlJvFtWRa3Q2BWq58sqkV5otxr7ZF9Ox5zyi31f4WCqe3/O8JaYj554GGWjLrlgqv7W+Fz
        wIB7w2M7KdEUQd7HAT3Xb3xRJ1mIB5WvTZrA7tBw6aw==
X-Received: by 2002:a63:2b15:: with SMTP id r21-v6mr11810093pgr.262.1532341372326;
        Mon, 23 Jul 2018 03:22:52 -0700 (PDT)
X-Google-Smtp-Source: AAOMgpeS/4csob136hOQ5aznf4okQitQ69IAC4DV6q1CicROk28LlgxO6awy+Zqx7kIjbZSNi9YKFA==
X-Received: by 2002:a63:2b15:: with SMTP id r21-v6mr11810077pgr.262.1532341372080;
        Mon, 23 Jul 2018 03:22:52 -0700 (PDT)
Received: from [192.168.20.35] (1-161-144-158.dynamic-ip.hinet.net. [1.161.144.158])
        by smtp.gmail.com with ESMTPSA id o3-v6sm10250257pgp.3.2018.07.23.03.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 03:22:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 0/5] Keep rtsx_usb suspended when there's no card
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180723101225.14884-1-kai.heng.feng@canonical.com>
Date:   Mon, 23 Jul 2018 18:22:45 +0800
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bauer Chen <bauer.chen@realtek.com>,
        =?utf-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <D1BA0076-921C-4DF6-B907-85B8CE888BE5@canonical.com>
References: <20180723101225.14884-1-kai.heng.feng@canonical.com>
To:     arnd@arndb.de, Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 2018Jul23, at 18:12, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> Hi,
> 
> This is based on Ulf's work [1] [2].
> 
> This patch series can keep rtsx_usb suspended, to save ~0.5W on Intel
> platforms and ~1.5W on AMD platforms.
> 
> [1] https://patchwork.kernel.org/patch/10440583/
> [2] https://patchwork.kernel.org/patch/10445725/
> 
> Kai-Heng Feng (5):
>  misc: rtsx_usb: Use USB remote wakeup signaling for card insertion
>    detection
>  memstick: Prevent memstick host from getting runtime suspended during
>    card detection
>  memstick: rtsx_usb_ms: Use ms_dev() helper
>  memstick: rtsx_usb_ms: Support runtime power management
>  misc: rtsx_usb: / memstick: rtsx_usb_ms: Avoid long delay before
>    system suspend
> 
> drivers/memstick/core/memstick.c    |   4 +
> drivers/memstick/host/rtsx_usb_ms.c | 145 ++++++++++++++++------------
> drivers/misc/cardreader/rtsx_usb.c  |  14 +++
> 3 files changed, 99 insertions(+), 64 deletions(-)

Forgot to include linux-usb and LKML...

> 
> -- 
> 2.17.1
> 

