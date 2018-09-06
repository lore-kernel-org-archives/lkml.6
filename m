Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0C9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8788A20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="dERIa/YY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8788A20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbeIFSzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:55:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33933 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbeIFSzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:55:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id g33-v6so11637083wrd.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WzQoOj9YobfeAab5PFc08NTFjLIe2hwvasBZ6Gshjtk=;
        b=dERIa/YY2wv94u42gjQ27DOa6uT7y6/RbmaVw40NWzZFVUsLPg0cEfQTg/KN7rWEdY
         1zB+Dcanx4SN7Z2uNxgdnMu8c0a0cdm5MoZmVQJ5vavT++q3DPLTxYaNR7kCvWUhqR2O
         HR9l+kxJ0oCQZEgIrHDuxBKsb1pgEyotV0k2UlFj0bj8LyQmBJRVavGC/t0xRVOf62tC
         1EKV1ZOr5hyYRkWtdwJ2G/ULy97NadpziCVF4Tcb1slrft6z8KbkFr8AB+5+lhMX61LF
         C85CBvK8rdl3pWROTxp3o3pOTbAyzB261N5cx284QLDiwd1vCr8A5z1yWj053J6s8JAO
         iK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WzQoOj9YobfeAab5PFc08NTFjLIe2hwvasBZ6Gshjtk=;
        b=WDcGLcNUTIaJ34BOcNwiJhR89AiRtn2Z48iTTTBLlEoSigtK+GSl3+3AwpqILcqL+I
         cU4aJjwdLvaXehldYpA3dDWkN70cUdfhweFealCmLNX1pxTmQy0NUi+x1BgMCBLbh9r2
         LD4B15QvTkqYPm1zUWvnZGoVolnKOYL64Y8mODc7DqVZHTyqpJho97PC1Ze1RxbnKT4L
         P/WzIJjHfKpK0OBO7eWWGtECRbpTbj/PzxQQNVixkNH5XgjNTRw6Qet8ZAWGMGg0WF21
         ntm2BTxEVdRVy2o7gWTWHGNwHhvyKNMXzt6WQc2YrVcinrgq1DBXZOnV0l+T+5tgelmg
         0lsA==
X-Gm-Message-State: APzg51BKO/F2xifXqihQnQ9UWQ4cL64HUFzbfrQJako1+CBjdVtjjgxS
        XXLGeysV8sfZIK+wnbUbvvIoJ/AVBPyFEgKWXptaNw==
X-Google-Smtp-Source: ANB0VdbvpzTGibKY9vGQu3jdj1AgTtefc2cDAmQxubkA7m/O2OBH2UL+fXOs+5m5S4SU+yo6KoyITZJcGnWbuC5nuWM=
X-Received: by 2002:adf:aa9c:: with SMTP id h28-v6mr2615151wrc.149.1536243563264;
 Thu, 06 Sep 2018 07:19:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9dcb:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 07:19:22 -0700 (PDT)
In-Reply-To: <20180906140628.GA10580@infradead.org>
References: <20180906123651.28500-1-anup@brainfault.org> <20180906123651.28500-4-anup@brainfault.org>
 <20180906140628.GA10580@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 6 Sep 2018 19:49:22 +0530
Message-ID: <CAAhSdy0Rn5q_xeWYK84qMf69w0=vgz6=Pin9kyAKpZ17Vf3x5Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] irqchip: RISC-V Local Interrupt Controller Driver
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 7:36 PM, Christoph Hellwig <hch@infradead.org> wrote:
> Just as before:  NAK to entirely pointless abstractions.  Please stop
> beating the dead horse.

That's just your opinion without any concrete reasoning.

Even after explaining in various ways, you fail to understand the
flexibility brought by this driver.

Regards,
Anup
