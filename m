Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048FCC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C227A222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="LSoGx5Om"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733234AbfBMGnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:43:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55352 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfBMGnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:43:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id r17so1113435wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 22:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8dmR0NFGNyhmtovA2tdJzy6bkO95KBp/gI439HNKvIY=;
        b=LSoGx5OmmNj09LZqF4KwNJ5BxWG5Xt6c1MYKq1Bt9KlBgOEOVnfJK9fpL6FxiXTbFe
         4caOr7tl+aFd4CEmI4eyHb6WzBEw2gofvawEUIdDRLEetnTPOx8LfKcyLDfqxQQ8/t3V
         b/i+ZnsYKsaZa5/5yJO51i5s36UfI0QBK/hp42Z5+shyjTU9dld0m3EUxZ5iIFmv4RGn
         FMkrvQruRA3JMWO7m3kYMQSu/8ADSB1Rx2QByv3FVDPVv2/WYOX3s8VNjydIq+EiE4xE
         bnJgEmR0suDrZMj0qvLzBizN/YfaSc2m0cLvSiVm5bHscTAeRMyXhmKZyJYwz0X9diaN
         IMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8dmR0NFGNyhmtovA2tdJzy6bkO95KBp/gI439HNKvIY=;
        b=FCu/IjCQrWAFAMfKq3r++BXOxb9WJ58EdW9A6+Ey3qLSLo/AGTAAnPl8z5Il8jpF7S
         smb6sRRvZx0Q/7VIWajPA6Z+Dl9Mae3g2PeaXwbR9rY3Hm3GrYughoiBTUu5ihp5SYSj
         NU1ibt+zmYApECLLuDehX9HlwxFwolwg63UsE/vuXKSunLewR8Cllzhjti3jy9VIEXQc
         +Pr+5FK+IychC3bwHLkzw6dQZWEVQfpZOh3cQVQ1F7wg9BWAjcQ7NxSE1F8EFHklm6M4
         iEf1ZfGpyj2DRBDuJjpePBJz7+vL8ly1KE1AERHvNmUeNLM5hXZ9zcFuvfrz8G5D+AY6
         W5hA==
X-Gm-Message-State: AHQUAuZ/GkkFZI+tsw6cHx+L4OGQgvMoMvJA/QuFAzMCOIxAwZBLJ7ay
        yBR5CzP0O3XUKHVtk54nApaX80LRXNqE7EfMLvJOPA==
X-Google-Smtp-Source: AHgI3IY3wh0fAJ3pkBOSWL9QIIrC56NnkSdRlyBop6m4MPvrou4wIzbSQ/cYiwvqU2LGody3UpZZrkFGNemeeLsl/s8=
X-Received: by 2002:a1c:a3c3:: with SMTP id m186mr1906321wme.16.1550040220679;
 Tue, 12 Feb 2019 22:43:40 -0800 (PST)
MIME-Version: 1.0
References: <1549969812-22502-1-git-send-email-atish.patra@wdc.com> <1549969812-22502-7-git-send-email-atish.patra@wdc.com>
In-Reply-To: <1549969812-22502-7-git-send-email-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 13 Feb 2019 12:13:29 +0530
Message-ID: <CAAhSdy3fs58TyiNTxD2NNz-MQuND6gyyg6hrKScN-iYmstXfnA@mail.gmail.com>
Subject: Re: [v4 PATCH 6/8] clocksource/drivers/riscv: Add required checks
 during clock source init
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org, Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Johan Hovold <johan@kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 4:40 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> Currently, clocksource registration happens for an invalid cpu for
> non-smp kernels. This lead to kernel panic as cpu hotplug registration
> will fail for those cpus. Moreover, riscv_hartid_to_cpuid can return
> errors now.
>
> Do not proceed if hartid or cpuid is invalid. Take this opprtunity to

s/opprtunity/opportunity

Otherwise, looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
