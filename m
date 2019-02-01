Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C85C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF39620863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 04:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtaCWsxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfBAEKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 23:10:31 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42120 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfBAEKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 23:10:31 -0500
Received: by mail-yb1-f194.google.com with SMTP id l20so2147575ybl.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 20:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gwP9pWApQ96SNbTh1zx8qjARByA4CgCXaf/6XW1DafI=;
        b=TtaCWsxdZeFmWsQoGt5cDPuwuCWMfDCoSJbwcCEH7tppauYBBsuefir1tlxM6tY2ft
         XCMvy8OFpXMmWEcIEm7xzJOoOjsdEAvzowFHiKsOYjCzL2v6n7+PH0ZcGNgWGSkbxKi3
         QbJhufxpVWeiFh5xw3cA+TvWrrns0DFURA/5nWv0R9wV0cMH64ZEbt4MG4g8F0atxDTT
         2Jjj1ov9G6M7NJSTOOxgVLIcqhW5MH8RZesZDm9PDxRDF/VfSqgNoNMWLFASGYTLxbQL
         0XpmT1U/474y3FTeNkF/QvdpxjMliWdXvylcoPKtQ74lFreGKQbMRpQSTuwBYhTsdt+Q
         7SEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gwP9pWApQ96SNbTh1zx8qjARByA4CgCXaf/6XW1DafI=;
        b=SLKwK+9Tv1CB/mWW+wLTHpvKuSc5S7mn4DMptkCqLaYAaeqQnvIQGW+UD6mI+Zum31
         h1d45IRJaEAcyra1M/LUQGXkwMeWoI9f6KliO9NxKhzKxPLCHNWNwQfroFvbbgNnfiXK
         ttDKRymaZXvV1YQ0QBARKIAhWHhXIT14zxogHxH1a0rqQcsO492x2CiC/zevBS/YxF3k
         NkN6hdOMltkP6m1Yvet6tihvcxPzFBwVKK0eSqEjSvBdfqoRfvEtQ4JZGYUPUtIfIoeV
         gftlkAtU2tzPyfVC4f87n2s7ShXlXTDwAekbCib64zObxASv9KrnQwi2RnLaRW0K0Zpy
         eQFw==
X-Gm-Message-State: AJcUukfZ1ZQWZ/924XMe2qCaQh9Eo7tBdDQi1H587SdipRv28KfSP/6G
        QygGA6wNkCsGvxkbRZ6A3FQNcEB1
X-Google-Smtp-Source: ALg8bN7+u6ezOSj3jN1JBqWRDB3obKKueml+pH9B527JhjpfeXgcnJbLBzB0fJ8TbqCIpqJraiQIUw==
X-Received: by 2002:a25:c207:: with SMTP id s7mr35006011ybf.37.1548994229816;
        Thu, 31 Jan 2019 20:10:29 -0800 (PST)
Received: from [10.10.115.198] ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id e124sm2362913ywf.17.2019.01.31.20.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 20:10:28 -0800 (PST)
Subject: Re: [GIT PULL 1/3] bcm2835-dt-next-2019-01-29
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1548788008-4733-1-git-send-email-stefan.wahren@i2se.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <92b0b6d9-ced1-4a0a-e0d5-d72751dacfcb@gmail.com>
Date:   Thu, 31 Jan 2019 20:10:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548788008-4733-1-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/29/19 10:53 AM, Stefan Wahren wrote:
> Hi Florian,
> 
> sorry for being that late and hoping it's not too late.
> 
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> 
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> 
> are available in the git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-dt-next-2019-01-29
> 
> for you to fetch changes up to 14117e0af4a853b2b37925f526b2bfe1cfc7b285:
> 
>   ARM: dts: bcm2835-rpi-zero-w: Drop unnecessary pinctrl (2019-01-22 07:25:59 +0100)
> 
> ----------------------------------------------------------------
> This pull request adds the necessary changes for the new BCM2835 PM driver,
> support for the new Raspberry Pi 3 A+ and the missing GPIO labels for RPi 2/3.
> Additionally it contains some minor DT fixes.
> 
> ----------------------------------------------------------------

Merged into devicetree/next, thanks Stefan!
-- 
Florian
