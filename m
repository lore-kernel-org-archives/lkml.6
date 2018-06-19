Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E93AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BD8208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8ZFoMHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15BD8208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756518AbeFSIO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:14:29 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36609 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756457AbeFSIO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:14:27 -0400
Received: by mail-lf0-f68.google.com with SMTP id n24-v6so12996285lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 01:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ivQtpnE29ubjUNif5WqiqnjWQEXMfJvVFC5wYWOBuQY=;
        b=S8ZFoMHdFvnNQsVubhxGgK6FwEJJUQmyK9xR34mnE/IrR0K8SVTdH8WIPAcfpQtr7p
         L0c+G2KQGhnaqqMGL5huh5Rh7f8epwv3YT6nskGqT7od3FwmzXCRWxN4VhtaR/ZTPRVT
         kmO3RJahSnGJj3hu/1DeYZSDZ22wq/Hed/U8yjMCT5PcpDFBzqw0o4q1LhWHNnK7B0ns
         +FBhKPJq+Cu1Jx3R6UUgq7gN6pYci+4h+KonOGWMcJFE3kZ9/khq8v1hgLw1XBU088Y7
         nVzJQmecYXYIpw0cuOlm8gIk5H9JSpOIy7QsLIpMok6Age/5mofKJJOFASJUjtq6n2CZ
         FlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ivQtpnE29ubjUNif5WqiqnjWQEXMfJvVFC5wYWOBuQY=;
        b=KHSbFJolHcPXcCJDX1kSaKHxRPceMJDngOV38OuhxLJIM9QiGJPSKLmtDF2DY2DLDw
         yE5rbVcRcK9EO7GMgHRQ7+E6mG/Sg/oIhvjkaWu8+oagJqijRZPFufkiPiPs7kF17Dcy
         QGy39ZcRFIGp/UHpWvWtK4krfxG1ND5qoMJBMFZTHWS8wwD8h09cq7oe7QM+6hMfhqaS
         URz0fwUSKiCvjD2+hYOWgl5zseDT1FMh77KYrgPqRqg9WMcNh/1Nn9lw4cWb9DRggM27
         Ku0zRYk4TIiupO3/92hnACUIKIzmgVWBtgMI6I/B5yPW/P3Y94B4UBypGBd3ER1u2y+C
         rQAA==
X-Gm-Message-State: APt69E0N8yi3jk0baPABkX0NMIdDZI6fa8Neeu4r12WqVyL+uK2y/lMI
        1a1wEuw8pjayth662ehMykmXm5mDIyEdlzSYb9w=
X-Google-Smtp-Source: ADUXVKJJFm4HXFJCV6AokDlSYz6lZAA+FwQKDErW2xAy/aB8Xq8wQA6zq3M3BfuG0LPWaCOB8AfkE2oWieI4xutgfOg=
X-Received: by 2002:a19:f03:: with SMTP id e3-v6mr7145270lfi.83.1529396066042;
 Tue, 19 Jun 2018 01:14:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 01:14:25
 -0700 (PDT)
In-Reply-To: <20180618201100.2238-1-ivid.suvarna@gmail.com>
References: <20180618201100.2238-1-ivid.suvarna@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jun 2018 10:14:25 +0200
X-Google-Sender-Auth: 4XLLcRAxbNDmp0iQHs5VFq4aT6k
Message-ID: <CAK8P3a00=z2wt1ZHoEBaVpXuYxwANwkbt2oykzU5PP=8TTU3mA@mail.gmail.com>
Subject: Re: [PATCH] posix-timers: use ktime_get_raw_ts64() instead of getrawmonotonic64()
To:     Ivid Suvarna <ivid.suvarna@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 10:11 PM, Ivid Suvarna <ivid.suvarna@gmail.com> wrote:
> getrawmonotonic64() is deprecated. This follows Arnd Bergmann's patch[1]
> for replacing deprecated functions.
>
> [1] https://patchwork.kernel.org/patch/10472141/
>
> Signed-off-by: Ivid Suvarna <ivid.suvarna@gmail.com>

This looks correct, but is the same change that I already sent in a slightly
larger patch, see https://patchwork.kernel.org/patch/10471729/

I think I have covered almost all the uses of the deprecated interfaces now,
sent out the first 50 patches (arch, drivers, core) yesterday and should
be able send another 50 (addressing most file systems) today.

        Arnd
