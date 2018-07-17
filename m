Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA76ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754742083C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="dl35cb6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754742083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbeGQNCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:02:50 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36168 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbeGQNCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:02:50 -0400
Received: by mail-oi0-f65.google.com with SMTP id r16-v6so1652269oie.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 05:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=71p09tZXws5UcS3rBK/NA0XemmgP3tpFKFPjOLpSviw=;
        b=dl35cb6grXfRtBWv3Q6tAr4sUzc81FvX2HLZ/UV4hExQtA8OS0mZzz/agjP39E+sTd
         uuGqikPe9AcpuxxSgmoeUK+P6OtSTcK2hgCmmpbhW+Zv7GhvF7RKEngAnqVBXKnhd4yo
         +ecLWXozvMtKZzFWu2Jv67d8xyR73FoVeH+T2O4FvI6HBNlIvTi0pJMg1fEaAu+oQLbj
         rt1XEd06doPK6JmqB1x+G3gYWbMNCmjLBUzv21xWb94XMR19yJZiyiXWPJBD/dbZdXUa
         JhnsUr3ZHV+zLg3yAqvQdTEI+gpMMmkp6sZ9hpbgRKxkh9AX8o3+SoQUPfmrXAu6iXig
         o3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=71p09tZXws5UcS3rBK/NA0XemmgP3tpFKFPjOLpSviw=;
        b=dB9T0enFpsunpaMV3iKWfR41e8k3t6KDjLHzdtQTkE0lIYrT6OtDRwUa/fFA2ktyoG
         cFemgnj/fJBoYtibC+ab4WOdusmlGXoRQ40RklpgdpesUYuMmu8eIcsJTiMWtF3MVYZz
         9n9lG8/lknimbFv2SVSj26sluSR/WbtOoLrjxJGQYzBKyfWXSPf/UpRLhX+dawJRqvcd
         ZxEKZo6pdwMOAg1wVM9xiQbr/mCVOQXI1Txy3nOoYqETZoJKU7Sz0Yyoy0bXpXY2M73c
         S9vAzDpoDN/iAYgM5PLJXoZ3b3/l8p8E3JrSUPKEXpngKpXsvOgv3wms9TWxUm2v2j6w
         B2pA==
X-Gm-Message-State: AOUpUlFZ5iqbqE2IcZ/7ItIQ4yy363vLTtivi7T0qx7ZjTJaOVK4x0ic
        oMEYjpuztKNKs3hLGn8aGbcOpMYbd1gU1JabphRS7A==
X-Google-Smtp-Source: AAOMgpcUU+rcu+qI0bbELtlp27Ss4PVrAiHJnbklSpZAnI+4TRJy67ToIMxze9eYzgSl2Z8KcjFf3/zPZ6gOeO53lLs=
X-Received: by 2002:aca:51c2:: with SMTP id f185-v6mr1500969oib.188.1531830623536;
 Tue, 17 Jul 2018 05:30:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3e18:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 05:30:22
 -0700 (PDT)
In-Reply-To: <20180717005719.258905-2-djkurtz@chromium.org>
References: <20180717005719.258905-1-djkurtz@chromium.org> <20180717005719.258905-2-djkurtz@chromium.org>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 17 Jul 2018 07:30:22 -0500
Message-ID: <CAD8Lp446Zu=EhdzRE9pEoskMWeOHOovoAJ8qtrovEuZ2E7Z5VQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl/amd: use byte access to clear irq/wake status bits
To:     Daniel Kurtz <djkurtz@chromium.org>
Cc:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Ken Xue <Ken.Xue@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 7:57 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> Commit 6afb10267c1692 ("pinctrl/amd: fix masking of GPIO interrupts")
> changed to the clearing of interrupt status bits to a RMW in a critical
> section.  This works, but is a bit overkill.
>
> The relevant interrupt/wake status bits are in the Most Significant Byte
> of a 32-bit word.  These two are the only write-able bits in this byte.

I don't have the hardware to test this any more, and I also don't have
any docs to double if those are really the only writable bits, but
looking at the existing driver code it does seem to be the case.

I think you should retain the comment noting that the value of the
register may have changed since it was read just a few lines above
(and hence explaining more precisely why we make the special effort
just to modify the MSB), just in case there is further rework of this
code in future and we end up walking into the same trap. It was one of
those issues that took a frustratingly long time to figure out...

Thanks
Daniel
