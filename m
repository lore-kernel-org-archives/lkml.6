Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3C6C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491712089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmHc2qzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491712089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeIZN2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:28:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55296 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeIZN2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:28:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id 206-v6so1032690wmb.5;
        Wed, 26 Sep 2018 00:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJfPRyG+f6RWvk5UC5Fmv6yOHZd6T+TtUFlkK3TIFOI=;
        b=UmHc2qzPTpktoz+hbal3OLGvWG3aOf64LkfJZ3pCHHp1CvxR0BL37m/SwEogkd/3CX
         1m8q+o8M0QL8Ec/e/7nV646R9KXnJ7by4S+u8ueaDRkciotuAraoWrgxjvb1I8K7BzeL
         NksVNgdYVBcc71JLMv2Ld+rUrFnSaK0rwScle2kH559s+JWRzw4CZXprvU1wgSmUYcYK
         b3lekqa/zRTU1NrjarRmODB6zewOUhf+AZfHmg8hWcbdf/bZoPte3lvgB3ytXELW6Den
         Z/m4ytnJQ9w4Wi5c/ozzlqT8h8nkRuc7vWbtpbAqG54qA8bCJv+7AbB0g8QscOkWh8JG
         CSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJfPRyG+f6RWvk5UC5Fmv6yOHZd6T+TtUFlkK3TIFOI=;
        b=HiyMrq8pi60vvGihht8K05JP1p14grpMjJ/LuhMEc+UOT7c2zJ0IqFJRrhScaKqtbh
         pBicScJBp0gVZNcD5ZTcnKsIuPoD5aA3ohFD51nr7P6V+ujHr0AJnrixW1bXNEIxvJEE
         ypa2BlFEOj+8QQD5nO81Id17LCnyX8xioUSsPFpbUFRz8PV/51bwFka2B2qn9itlz0ZS
         KBnLINBf+5CNuUOSGChdNiK180pdG7OkgGreh+EBQfEdACM56Rhjuobld1w0YTre4WWu
         onSx0CUTIqJug8xmzWM7fbqVSTEHh1uAQDujhqU7Fd92M4U+mmd8gd2P/WRisW3N4zkx
         bnBg==
X-Gm-Message-State: ABuFfog+cOVvD1VPqzEaRCjE5moCjg4o2AsfdUqxq6DGC1kHcqrrhIrl
        P8VkFB5q8v6XCaXY0QCHrA3ZJk3WGgJ/6gweT30=
X-Google-Smtp-Source: ACcGV63ixqitNSDIGQw7qiHw7W7aspz5/S36lA/4AJb0aSZf6oDIYhAoWDp7GoZk1+GUCj9ZN+n+EXE+CkoTl5bG0Ws=
X-Received: by 2002:a1c:889:: with SMTP id 131-v6mr3151162wmi.142.1537946229960;
 Wed, 26 Sep 2018 00:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537936397.git.helen.koike@collabora.com>
In-Reply-To: <cover.1537936397.git.helen.koike@collabora.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 26 Sep 2018 09:16:57 +0200
Message-ID: <CAFLxGvzCDOTR4stPmp1TTLkQ39x3e8MQuL=AR754abKc5skhpA@mail.gmail.com>
Subject: Re: [PATCH 0/2] boot to a mapped device
To:     helen.koike@collabora.com
Cc:     device-mapper development <dm-devel@redhat.com>, agk@redhat.com,
        snitzer@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        enric.balletbo@collabora.com, Will Drewry <wad@chromium.org>,
        linux-doc@vger.kernel.org, linux-lvm@redhat.com,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helen,

On Wed, Sep 26, 2018 at 7:01 AM Helen Koike <helen.koike@collabora.com> wrote:
>
> This series is reviving an old patchwork.
> Booting from a mapped device requires an initramfs. This series is
> allows for device-mapper targets to be configured at boot time for
> use early in the boot process (as the root device or otherwise).

What is the reason for this patch series?
Setting up non-trivial root filesystems/storage always requires an
initramfs, there is nothing
wrong about this.

> Example, the following could be added in the boot parameters.
> dm="lroot,,,rw, 0 4096 linear 98:16 0, 4096 4096 linear 98:32 0" root=/dev/dm-0

Hmmm, the new dm= parameter is anything but easy to get right.

-- 
Thanks,
//richard
