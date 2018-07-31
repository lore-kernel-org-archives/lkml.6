Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88925C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAD0208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/PGLeV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAD0208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbeGaPGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:06:07 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:42069 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732168AbeGaPGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:06:07 -0400
Received: by mail-qk0-f175.google.com with SMTP id 26-v6so10175813qks.9;
        Tue, 31 Jul 2018 06:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LDmodxtoHaC2KV5DG0oWr0czTx8kllyzlZYkNVyq3h0=;
        b=o/PGLeV19FgyPp/XLATLCqVlAsPS1FE9Q/MEmVG0cWGbNzItu36dbEXb/ku1Q04yXn
         b/FE5IHhN4f2bkmGSyyMAzWftqhiePlXv8JhwOuZsVOwFUtUD1gmU8SJRikq18TG9oBX
         qvd64ZfV7WWfxoHc4s0v6HVa0AhxPaIuBz5HKdAZmM8aSzEksOcdrHxQgOywwbE/Fd+8
         5+ZblMP/n8Cyr8R+13PaD1lnhH362hnGu+jls6wR3+L/ZtY1+yZx6odGmcw4wshxg5YQ
         Ihck8gullPHxU+m8N0Q6I4PdZS0xJeRrzrOZ1V9CiQUrvBw6yqpHQXX4FQr3UxVIt6b4
         YOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LDmodxtoHaC2KV5DG0oWr0czTx8kllyzlZYkNVyq3h0=;
        b=h+nWdcmF6VaoyM45hkJOSKezOH42yEZNoEVB/dfn+5JvF6jSHuKEqkjkio2qB91+sg
         y3TlS68Bpc5PeRE2MrPYR57U6wxnVVZUe5X1m/gtdV0UXsLjRaBZQOopTzgUfvwutpqq
         PmsZdXMIMkQlZrk9HvS/LeHoMBsUCD1Jx5XNE6C7nyCrcqW1+QyzkcnPcAXSwTvFbR45
         Ea9wxot3MJJPSJrOVkwhYKWzNzbczR9/kcX5HY4eZK9huMiX8UI+NIhWeDu++PX+aIgK
         TWz2IbsNke25V9drx9vn/oYgUcgu/e056qcpeMTjfelz9VTDooUFL6g76dUxb7AFf9tT
         RfWA==
X-Gm-Message-State: AOUpUlGhYABF0X63dWGr1556YOpvUz9L6N9km/c6GZk5nElsUr6o7/vq
        3WGIUBasZaS9rSMgSyBZE2G0eFXu/FBSdLjhzS0=
X-Google-Smtp-Source: AAOMgpf9w+EhuifZzPUWfgeuCsY2db0FZ0g209D/3+MA5pxaT1fG3Vq8LjlPy3TiIj1sMflMpVkK0gyZlWXK+yp/7IY=
X-Received: by 2002:a37:7946:: with SMTP id u67-v6mr19202913qkc.283.1533043547149;
 Tue, 31 Jul 2018 06:25:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 06:25:46
 -0700 (PDT)
In-Reply-To: <20180730090648.GA18361@lst.de>
References: <20180724120147.15096-1-hch@lst.de> <20180724202115.GA4685@lst.de>
 <18df6608-61c1-963d-bb1a-d46320232f40@landley.net> <20180730090648.GA18361@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 31 Jul 2018 15:25:46 +0200
X-Google-Sender-Auth: jIBdO3PgMX2_Kk8vmO3HC3-8eS0
Message-ID: <CAK8P3a0ZsU=qKhA2ux0X1Zqo0aD6d9T8wnwc5Kr9T6wbsGp2fw@mail.gmail.com>
Subject: Re: use the generic dma-noncoherent code for sh V2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rob Landley <rob@landley.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:06 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Fri, Jul 27, 2018 at 11:20:21AM -0500, Rob Landley wrote:
>> Speaking of DMA:
>
> Which really has nothing to do with the dma mapping code, which
> also means I can't help you much unfortunately.
>
> That being said sh is the last pending of the initial dma-noncoherent
> conversion, I'd greatly appreciate if we could get this reviewed and
> merge for the 4.19 merge window..

I've spent 30 minutes looking through your submission to find something
wrong with it now, but it all looks fine, the only criticism would be that
some of the changelogs could provide a little more background.

The original implementation seems odd in some places, but your
new version resolves the few concerns I had (like mixing up
phys and dma addresses), and I didn't see anything that should
change behavior.

I hope that helps.

      Arnd
