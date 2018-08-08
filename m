Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34801C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8947621718
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lY+CUrhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8947621718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeHHREz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727713AbeHHREw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:04:52 -0400
Received: from mail-qt0-f173.google.com (mail-qt0-f173.google.com [209.85.216.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BD2E21718;
        Wed,  8 Aug 2018 14:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533739493;
        bh=kpU+MJt+DW8vUI+D8bsiqJJjkiQhWxEU1ek7i+ZbqUw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lY+CUrhvZ8inaOS6+EGCMyFJ8jFSnScIBOf+KSW5dToxrY19hqPMk4fjicF4rp0e/
         6OUPC/cqjYRAZ42opbNDzBT8pJ54UYgbhU/8b46QEVpYYESI44plQrZOvQ798FbFXE
         TwBqxoRLZbf9IdPA+/qk0O03+fztHz2d0O+Ey9Bo=
Received: by mail-qt0-f173.google.com with SMTP id d4-v6so2628066qtn.13;
        Wed, 08 Aug 2018 07:44:53 -0700 (PDT)
X-Gm-Message-State: AOUpUlFh5pA9GGX8+Qw8e2VhqdC6KNrgCIe43CFmdBxewqMBoc1Cvh6i
        84PsWd+JeAvHH3m6A7n6QQQALmQAnirIWvbGhg==
X-Google-Smtp-Source: AA+uWPxYugE7f0vYT7kdopqqrVO/ueYzGWXoLEaGT1Q8MjQkCGPF/BEaFUVCM0/+s1F5k+1wbGTCVULPKUMqVALOQqw=
X-Received: by 2002:ac8:71c9:: with SMTP id i9-v6mr2899056qtp.22.1533739492588;
 Wed, 08 Aug 2018 07:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180802115008.4031-1-hch@lst.de> <20180802115008.4031-2-hch@lst.de>
In-Reply-To: <20180802115008.4031-2-hch@lst.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 8 Aug 2018 08:44:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLq_JqjbnjSz7+72ssZH1deKU7iCxofn_bLhiKpCEXD=w@mail.gmail.com>
Message-ID: <CAL_JsqLq_JqjbnjSz7+72ssZH1deKU7iCxofn_bLhiKpCEXD=w@mail.gmail.com>
Subject: Re: [PATCH 01/11] dt-bindings: Correct RISC-V's timebase-frequency
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Anup Patel <anup@brainfault.org>, atish.patra@wdc.com,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 5:50 AM Christoph Hellwig <hch@lst.de> wrote:
>
> From: Palmer Dabbelt <palmer@sifive.com>
>
> Someone must have read the device tree specification incorrectly,
> because we were putting timebase-frequency in the wrong place.  This
> corrects the issue, moving it from
>
> / {
>         cpus {
>                 timebase-frequency = X;
>         }
> }
>
> to
>
> / {
>         cpus {
>                 cpu@0 {
>                         timebase-frequency = X;
>                 }
>         }
> }
>
> This is great, because the timer's frequency should really be a per-cpu
> quantity on RISC-V systems since there's a timer per CPU.  This should
> lead to some cleanups in our timer driver.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
