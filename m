Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0771CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B201520852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3XHuErD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B201520852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388417AbeGXK2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:28:47 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38008 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388236AbeGXK2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:28:47 -0400
Received: by mail-qt0-f195.google.com with SMTP id y19-v6so3419540qto.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 02:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jDWsSL4qcEGslJUGS0dWVQTKmPUr0fxHXXABEJaaqSA=;
        b=B3XHuErDLgYdxyNl29mu6N9KQ23tJT/0YehRpqE44rXsafufMKn2QKbE70Iqfre4Kz
         cbfP6kn7aIfljmLcZ7YTY2iGOxrcQAA5h1cEW4LcZDeIzQty3NLIgEZDbICA8N4vXCk2
         280o8zfOTjSBQm6ebf72iQ0YXb6sMHHZttLPag4Ma7GV7xbAoAKhAwQ6QqBvB2okUeo9
         hgV+d6XAZVV5/GOYZmVHUkksZQpiUWOOfbmnsqI+wfGazoMbilv09l6g0I1kZzzt/nMZ
         ML83MbmMYF6TsDd7NQ1O6JQSIfhPH0X42uekku+XrHCBAIJm1JHQ31GWz1Iu4ROXOGgA
         98FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jDWsSL4qcEGslJUGS0dWVQTKmPUr0fxHXXABEJaaqSA=;
        b=mmgTucAn04wMloTtrsGqFfLUK/I06kYaNPYFZXUuI/i2xdIwOW1EEWvFkyYv4T/DxC
         CbhpLzUuKusCz8WMmQW4TorRMKzhtVafgt9Zyg4pFJsOJH3whHglOB/pUN4xGnzIrlUF
         PxZ+9CdAaGB+DOId33dtg5cIDWSIYaJGsfo4ESLkqs77xry6N3ls5lBiTWcY0TLXVAl6
         PtDmXVprsuHIWH9ILtbejjZTMVN6xzG+Mwxw6d1RhKHvppqy4ffpvDoKmG7jYIHB0HK6
         xrtvtfPD5k1f4HrrGcmpkpK6RQmLNPNLFbaLQ18GZHWQkNYEvg/kle40cyRsVqWmUlQ8
         EwSw==
X-Gm-Message-State: AOUpUlFI+620Zdl2fO6U2rd2+7M40awthfMAcwXCs3xK7mTcDTA9duN3
        X/L6+X5U6jUvAUIuWqLFZxOI7zmUK0RFl8nQJy0=
X-Google-Smtp-Source: AAOMgpfQeXVYxGmLVkz9ShsWMCj8fsWBAZP2/wkLOaysEbpVLuLnW5/7rliezxLVu3PU5YYGthOeNLCCJVq3xfOPX3w=
X-Received: by 2002:ac8:30e3:: with SMTP id w32-v6mr15868571qta.280.1532424195115;
 Tue, 24 Jul 2018 02:23:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 02:23:14
 -0700 (PDT)
In-Reply-To: <58f371f95c10969bacff4d5bc393ff0f0c6102fb.1532415410.git.fthain@telegraphics.com.au>
References: <58f371f95c10969bacff4d5bc393ff0f0c6102fb.1532415410.git.fthain@telegraphics.com.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 24 Jul 2018 11:23:14 +0200
X-Google-Sender-Auth: BLlVnKbcw7KnBgP1drPrOASbEnU
Message-ID: <CAK8P3a1e-HHm9+sYYmsgOHtqLK_GD_uMxuKg9dMo_xEfHAHP5g@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Rework patch "use time64_t in RTC handling"
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 9:07 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> This addresses the issues arising from commit 324caa29cd04
> ("m68k: mac: use time64_t in RTC handling").
>
> Adopt __u32 for the union in via_read_time(), consistent with changes
> to via_write_time().
>
> Use low_32_bits() in via_write_time(), consistent with changes to
> pmu_write_time() and cuda_write_time().
>
> Have via_read_time() return a time64_t, consistent with changes to
> pmu_read_time and cuda_read_time().
>
> Drop the pointless wraparound conditional in via_read_time().
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks for fixing it up!
