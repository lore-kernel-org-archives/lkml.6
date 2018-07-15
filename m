Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5088DECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10362089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 22:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="fc/0dEbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10362089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeGOXOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 19:14:38 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33224 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeGOXOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 19:14:38 -0400
Received: by mail-lf0-f68.google.com with SMTP id u14-v6so30918093lfu.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 15:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EfUBWWTM6JhdnYZkBjxXy9lee3OOw5z980ga+36EJlw=;
        b=fc/0dEbFnIxNis+jS7CPhPpVGbufvpWkME6yM7Oimxya/1x3XbltNWQgu7UVcAT+8c
         EOF9iaLqf0ZpUcftv6u6SSD3NRE0BWkHbDijwEfE17hp5TO6cWgDzjggrbc4tN7PLqQt
         Asf/xIZ1w2zcw7II4Z6S/EaRcSmc7jr9GGUwIC29LKsFhKWQVcMEP5lWqccN89KZHR/X
         LVAxIKI8+f/lr2Kq4l+/VAD+SP9x7NKssFlWfGo4H3RdWcdCteb+DVpPtop8hrw3YuXq
         Ra9N1ir2+/Vxc5MaV+Fb0mKmm2nw+LSDLNVMOZfar6sFuYiT8ORSNS6OicsTNGAx0cjc
         urQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EfUBWWTM6JhdnYZkBjxXy9lee3OOw5z980ga+36EJlw=;
        b=Wf/gZy2SLfTxytlhdAolxCRHHHEt8R2JdTUKURuS3VA+1m3XKBWXusKmj6K/EK0jz9
         kh562kOV2lclb4gysamEKkcFjJi/U5ZRA+q+SIEc+q75I3naTH8jzODErrFlJssV/7bh
         ATqZ/GwgeKEu3HjkNwwWNgTFt8mbPWebahSS+pqgfo1gey7+BkX+YHQOfQUWbQmqjPR+
         /0ArpIvlB8BmLAPbLHyf+lAkdBFhiyytsi/Ib7iKKAiCbRlxccX/2s2zbguXJfL2FhqO
         bupbilE9TpTPwczS8v9L8u5xOfKc6OPG/mtsNRWjrbMNZe4ZsH9Gzn1n7USvKLXUsNSP
         +uMw==
X-Gm-Message-State: AOUpUlFWt6w7Issl4zyEFn8uiK3+KxlTAnd8/tbGUE/MuAYKX1LlBPEW
        fyWlS8h698hHJepqrH5PVe1b/a0cqSLbhAymoUeeKw==
X-Google-Smtp-Source: AAOMgpf+cQ0Bs9gEEY9XAp1S7YiVP3e0R2PcYNMVAyaJgeCvBuY0hUBjDrRMQKX47gx/PICx0sR16U7PSd7jh8PwjfI=
X-Received: by 2002:a19:4344:: with SMTP id m4-v6mr10814159lfj.111.1531695008101;
 Sun, 15 Jul 2018 15:50:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:fc1c:0:0:0:0:0 with HTTP; Sun, 15 Jul 2018 15:50:07
 -0700 (PDT)
X-Originating-IP: [99.152.116.91]
In-Reply-To: <20180716075718.4e5ef491@canb.auug.org.au>
References: <20180716075718.4e5ef491@canb.auug.org.au>
From:   Olof Johansson <olof@lixom.net>
Date:   Sun, 15 Jul 2018 15:50:07 -0700
Message-ID: <CAOesGMhVeo6Wc=nMcEnusa+FfwQBWJnxs0LY-zXm4HMau+SMhg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Eric Anholt <eric@anholt.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen, I keep saying every time you catch these that I need
to run the same script. :(

Florian, I wonder if this happened when you rebased to squash in the fix?

I'll figure out where to get this into my workflow so we catch it
before I merge from now on.


-Olof

On Sun, Jul 15, 2018 at 2:57 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Commits
>
>   b8ccf02a5014 ("ARM: dts: bcm283x: Add the PMU to the devicetree.")
>   b7dd29b401f5 ("ARM: dts: bcm283x: Add Transposer block")
>   74d1e007915f ("hwmon: Add support for RPi voltage sensor")
>   70eea1bbb556 ("firmware: raspberrypi: Register hwmon driver")
>   a1547e0bca51 ("firmware: raspberrypi: Remove VLA usage")
>
> are missing a Signed-off-by from their committer.
>
> --
> Cheers,
> Stephen Rothwell
