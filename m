Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFADC282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A13120869
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmLpXeYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfAaVt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:49:27 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55052 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbfAaVt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 16:49:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so4046833wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 13:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/hX5KDMKgR+lXyknno+hpKg6MWnLWVX48Cnsfqsnspc=;
        b=qmLpXeYWcHEWhyE7P2gE8DF4YSUTwEzDjJtWZ4xjtWa/n+5yaJocE08bYG7MrZjmXx
         FS57NtnHJKecyUlQ7XiD//SLig7arDbjSmpEHLBDYXd1gcfi+mrT5IvggQDkAH+8w3CC
         ZTi48CKGW0Eif/QZISdovqKXS3moSa9wKG8wWsfQaD1HSM1qzTlaj4fE2oGuKd6pu51v
         ONhVNUzGg6v0dGGQa8QMQAsys5okLES0ZF9yvbGHF0UQ3QVP0mR6YQu84rDq/4BlGri6
         fMqSS4Kmka4P5eE4JNxWIqJVt26gR7kpqrp0YinaGXZgfOrMBT5ryqlv6ZIDDT9jBL6d
         F/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/hX5KDMKgR+lXyknno+hpKg6MWnLWVX48Cnsfqsnspc=;
        b=VYzKpy6Z3EQSuXzjG2MPqZyqY+RABP+iwjCLtMFKET8gW4iGv3o+gOxm/Vvea2thBK
         90p1f52i0rLcouLf6Exlpf6x0UgP/LoLzDg7V50DXME3e+0CBGL+C1xh8nTi8IG0zkjc
         i0VR9sr5MNmvFqI55AahxelwMRiwNW9kdas8uVUmRRpkPjar884EMjtBu8d/2dgtfC4Y
         3QORglukaegwIci4sMl8xW5M+eTjX6wUWsudQJyhMZHJwd8cqOWAT6YvDR2pJZ+D908y
         QYPy3oNms8W9LwZ8eqI675uBjVxPYGw4X9ttesKvmAZJe4FKlfBf25DFhVlreSzwvwOq
         9Ecw==
X-Gm-Message-State: AJcUukfiGbsxBeTJ7Pk/T5ERPcgsZrSPWEgjtMD6FUeL063zr8kgTnLh
        4VVxTih6Xw7VJs+1bu7DmDT7MkJ/R6JyK7bVy/cG
X-Google-Smtp-Source: ALg8bN5Ah3ZT1JZ+SMt+qcVsSqjJU0hrNqayrRYCOfJRbPx513PDcARp3sNYhB3qhFcAt8hqBWDgKCbjMeNJOxSlQKg=
X-Received: by 2002:a1c:4046:: with SMTP id n67mr29743285wma.123.1548971364896;
 Thu, 31 Jan 2019 13:49:24 -0800 (PST)
MIME-Version: 1.0
References: <87o97wrbef.fsf@mntmn.com>
In-Reply-To: <87o97wrbef.fsf@mntmn.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 31 Jan 2019 15:49:12 -0600
Message-ID: <CAErSpo4T91kbXXuMSCqrDk=_HD+6GZ64WVZsvhSOtW=L89Pf0g@mail.gmail.com>
Subject: Re: Linux Kernel Regression: HAPS quirk breaks PCIe on i.MX6QP
To:     "Lukas F. Hartmann" <lukas@mntmn.com>
Cc:     thinhn@synopsys.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc linux-pci, linux-kernel]

On Thu, Jan 31, 2019 at 11:21 AM Lukas F. Hartmann <lukas@mntmn.com> wrote:
>
> Hi Thinh,
>
> I'm writing you because you're the author in this commit:
> https://github.com/torvalds/linux/commit/03e6742584af8866ba014874669d0440bed3a623
>
> This quirk workaround breaks the PCIe on i.MX6QP, at least on my test
> devices. The reason is because the Synposys PCIe IP in i.MX6QP has the
> same device ID as the HAPS USB3 controller you are targeting in the
> commit: 0xabcd.
>
> Definition:
>
> https://github.com/torvalds/linux/blob/master/include/linux/pci_ids.h#L2364
>
> Here is a bit of lspci output on my i.MX6QP machine (without the problem):
>
> mntmn@reform:~/code/linux$ lspci -v
> 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00
>                                           ^^^^
> [Normal decode])
>         Flags: bus master, fast devsel, latency 0, IRQ 307
>         Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
>         Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
> ...
>
> The failure mode is that the PCIe controller shows up as a USB
> controller and my ath9k wireless PCIe card cannot be assigned the
> proper resources anymore (-ENOMEM even for very small BARs).
>
> Reverting this commit fixes the problem for me. I suggest to make the
> check more specific to the platform/chipset you are targeting.

So Synopsys apparently re-used Device ID 0xabcd?  That's a pretty bad problem.

It looks like we merged 03e6742584af ("PCI: Override Synopsys USB 3.x
HAPS device class") for v5.0, and v5.0-final hasn't been released yet,
so if we don't hear from Thinh with a resolution, we can still revert
it.

I set myself a reminder to revert this on Feb 11, but hopefully we'll
have a better resolution before then.

Bjorn
