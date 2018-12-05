Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6577C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786D0206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/AZ1Dr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786D0206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeLEHMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:12:25 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:47074 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeLEHMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:12:25 -0500
Received: by mail-io1-f67.google.com with SMTP id v10so15800405ios.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 23:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IhG8Uu+pUR3spU8Zz04Y6oamwobCw2zB6E8PPeGHPYI=;
        b=P/AZ1Dr4jJPOknith1oCtIFfDwXt9ymkUFNw7PH53o2RHfxvoubzVNthCJ+E6NEzfF
         urrbDQbArkpTQeBIzMDOyLqAd5pJ1GXB57TMziDb+QsEz4mHhK7iUN7oBPCSrmajPe9h
         QWy4Qne2pVWWl0ZUXyFKU9vO6WEzYoscQOS7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IhG8Uu+pUR3spU8Zz04Y6oamwobCw2zB6E8PPeGHPYI=;
        b=FvM0LT7UDOos/n750kswwFNk+N4JLYtN4d/3E7E0pvQo+/vgLN920NGvo7pB8+hjZW
         0SjWzPHZ2zC4YEpilkkjQ6w5Eb2+66/mayNTDHk52gOZHtOVPI/TgXcLu8UBQzfnzd2E
         9dIIbQ02yV3tTmf5TnRViypUxrQeLD0RAkkVEcYjc3Qtr18yJHGiAbNw8AL7+DKxg2E7
         n+XcbjVQn0sp1Ker+VKXDxZOEhnZzIT+5RGoOgUzWi5E5Bw7GebvXZf/X1T8jEEkucde
         F8b5G9wsolbHwC+jVWqNMfPEbSIQraFp/t8uiZFfEJWXavGukSD338Ss7KF1eUgyc8Ad
         hLdw==
X-Gm-Message-State: AA+aEWZRU3UnsUbtM9Y7mWoKgKFT6zS6OR+CuyKz/dN4EC2RZuumX4ED
        NsMsNJJQF6nMherCQdCn764a8MLZXivdwgfyuyUekA==
X-Google-Smtp-Source: AFSGD/Ujh0fvsrCAzeVC4tNfbehRTlCt9Cw7MdLY1TRd/WuUa5r7m+Y6QMYtokhuujWQS1J+5J84Cu8I5dfocHv7Y6Q=
X-Received: by 2002:a6b:8f8d:: with SMTP id r135mr19980984iod.5.1543993944272;
 Tue, 04 Dec 2018 23:12:24 -0800 (PST)
MIME-Version: 1.0
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
 <CALxhOnjSEp++W5T3Sf0eX+8hPt08ER22M817M-Vhd24_96a_EQ@mail.gmail.com> <20181205063436.kzxgnvgexcgq572k@pburton-laptop>
In-Reply-To: <20181205063436.kzxgnvgexcgq572k@pburton-laptop>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Wed, 5 Dec 2018 12:42:13 +0530
Message-ID: <CALxhOnhH8WmtBsJ_=qb03G-T4d+uZrc7xoOnjy9f8JunG-A-Jg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] mips: system call table generation support
To:     Paul Burton <paul.burton@mips.com>
Cc:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, 5 Dec 2018 at 12:04, Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Firoz,
>
> On Tue, Dec 04, 2018 at 09:33:08AM +0530, Firoz Khan wrote:
> > Could you review this patch series. I would appreciate if you can
> > perform the boot test on the actual platform.
>
> This is looking pretty good to me, so I look forward to v4 with Arnd's
> comments addressed.
>
> I've verified that the sys call tables are identical for both
> 32r2el_defconfig & 64r6el_defconfig before & after this series, and that
> both still boot fine.

Great, thanks for the update. will send v4 asap.

Firoz

>
> Thanks,
>     Paul
