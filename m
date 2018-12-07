Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897B9C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DB02082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mxXiZnLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DB02082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbeLGSpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:45:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38613 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeLGSpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:45:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so2212338plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 10:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=NNDKygG0WX9igZsqFZ4iPyF5LpJxmo5sA54/xkrjpjI=;
        b=mxXiZnLitdrHnq22Nq8YRSCL++2I+yp2I1Wp+rhZAC2Ll/kMbtW3xGbqrbwv3rmxRx
         bp8qlisSxMY0S+lMrHpl2XZ7eCj+vUXoABRIcvVbFULRxPUX5m3sV8hTfeGE/JhYJozc
         /yV2VXYQT4kO/lTvWz5eYyzx2boKoO9jo4KKoUukpTzcbNng1cD5qPMd0MnM+LTJD7kL
         dmumrdrYTOEf/KHoCXuRvqIkURR/1xxZ0kqUKSd3jQorfVB+0kiCAfcEZXBDXtZv0s2m
         0Gr3CRmQ1azvjYXTninXQTbih0ghtLT4w3VvE3sGvaidFNLYEdCuiDbFfJfHGPoSM1cX
         Xz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=NNDKygG0WX9igZsqFZ4iPyF5LpJxmo5sA54/xkrjpjI=;
        b=UpUUU0pS21ewF+UhHKF5pEJjRoAaDhvun9/wrplJqmZ7OUcvAWL7Pawnm7jBlhV1QK
         qaBiD8QMJk+lT9WMbNWN4TgcTmw6MWVCs0XO2BlWTGl4YpHUNYiEZi52eaeGg1RVCI2s
         5SA/YIVSt8888O2FxPt9iKPJOP4SdPtNzmbcQWHjqyH3rT4/Po1idEv3t1/cjAdt+9Fp
         Zt+CuaSH1N0RP2E6CmZAU3dBGMyT5BOhLObxAX8kg/5LSMmuffNdVvkwBWJKi4EJTn6a
         /C1vqazC2cPn86xjoCEOAoM5si1BFtSHA4WULyFT6NDa3sa7/EvFSr0xNpb1QHtdVysX
         oEDA==
X-Gm-Message-State: AA+aEWZ08DLXHS5gv/LELNLmU3K9rB0omJ9uEkLLLXjoqYbCdtr4p53h
        M+ZI0m95W+WoqqjC9SYfiOeKiQ==
X-Google-Smtp-Source: AFSGD/WCcCsZa5P1415ERxz/08fdE7JNfiI8/LYm5k/Mg2iZ/ywuZ2XvHuADtSp9XAy7PaCZ2is06Q==
X-Received: by 2002:a17:902:720c:: with SMTP id ba12mr3193243plb.79.1544208311926;
        Fri, 07 Dec 2018 10:45:11 -0800 (PST)
Received: from localhost ([216.3.10.7])
        by smtp.gmail.com with ESMTPSA id 125sm8970983pfd.124.2018.12.07.10.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 10:45:11 -0800 (PST)
Date:   Fri, 07 Dec 2018 10:45:11 -0800 (PST)
X-Google-Original-Date: Fri, 07 Dec 2018 10:42:13 PST (-0800)
Subject:     Re: [PATCH 1/3] tty/serial: Add RISC-V SBI earlycon support
In-Reply-To: <20181205095846.GA9847@kroah.com>
CC:     anup@brainfault.org, jslaby@suse.com, aou@eecs.berkeley.edu,
        atish.patra@wdc.com, Christoph Hellwig <hch@infradead.org>,
        robh@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Message-ID: <mhng-114b47e6-1722-4cae-9132-5998c74eef66@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Dec 2018 01:58:46 PST (-0800), Greg KH wrote:
> On Tue, Dec 04, 2018 at 07:25:05PM +0530, Anup Patel wrote:
>> In RISC-V, the M-mode runtime firmware provide SBI calls for
>> debug prints. This patch adds earlycon support using RISC-V
>> SBI console calls. To enable it, just pass "earlycon=sbi" in
>> kernel parameters.
>>
>> Signed-off-by: Anup Patel <anup@brainfault.org>
>
> This makes more sense to take through the riscv tree, so feel free to
> add:
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> to it and take it that way.

It should be in my for-next now.

Thanks!
