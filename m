Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4148CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBC02083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFK8eMti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBC02083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937470AbeFSI2p (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:28:45 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35917 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937267AbeFSI2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:28:43 -0400
Received: by mail-oi0-f54.google.com with SMTP id 14-v6so17392121oie.3;
        Tue, 19 Jun 2018 01:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=15MdgXgZEpFd6D251bPSy80u+Neo1zIKATyviaPmXa4=;
        b=YFK8eMtiMBudJ+TsEYnXZcVwMtxW6J/KVKPpTNHefEWKnqiBSDf5n/FkNf5bOSjhG7
         h1pOJnx2Z0Oa4rR1y12fblXel24n/hCPyqc88yzScw7+zdwPPiDZLYqlBTyKhTpvYBnK
         0iQ7coQ3nJ5EfkFzueROT+PmPIHZ6oy98iTMA/o5X0xGZF+0WIplwVRzvuPQh470UiEZ
         ubIVccoufOZOL9YiGehmPUQ+5tmZc9DUM0SHRwI3kf9S0cM5Ya0XvkOcdjCZkbvBl6ro
         2hnyzWbJG9W2NKiuyzpfiwSsUrXjW/LLZvqf1s2DXgWU6AhlTmCXzAd3qhLcHgWPiALj
         g3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=15MdgXgZEpFd6D251bPSy80u+Neo1zIKATyviaPmXa4=;
        b=nzLZTKeVjgDsejluy6wWEeu6lZlJqlNJyBkiLknLRKm9fNljm4DnNO5OblhDcRYxDM
         l3rDO/ZzxVBdkz8uDiaG4AedwfbHs2+sJrr/MAt16DPKLRSiTTlsxVOYqfAD/3zS6bqU
         hFTjWGDyKVx4E01n181L11+AY1KK+Tk5WjYdD0UCabCL1YnUSINkJvtAn5UiZvy6OREU
         xooSZyaGRi0R1hXXYffSOXvxapyv2ADC14aKKgpWc1Pn5g59GlzdgxEHpuGEb6joasHz
         8RcKz0P8qoO1UTFOfeVVd1EtMALnxCuKHGLQh0HFW7BfsiZAQkm+O7E1tgj0NbDOL3le
         dL+Q==
X-Gm-Message-State: APt69E35nuIe9Z6qmFYDGUwttSHEV2zgyM+YWSNvbIh0zh5D9JLqboHx
        WLq2YuzEJRsDQcpOewUOzndiyeS9Pwn4x3t7wgE=
X-Google-Smtp-Source: ADUXVKLWFi/9CDWdlU6bx0OfFbbsF675AD+F+VWGtx/sh7KBWN618lg6ncAeiCoj4mUuhQCvoWLNKT8oFqy+YPza7lo=
X-Received: by 2002:aca:6914:: with SMTP id e20-v6mr8412771oic.358.1529396922698;
 Tue, 19 Jun 2018 01:28:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 01:28:42
 -0700 (PDT)
In-Reply-To: <s5h8t7bfgnq.wl-tiwai@suse.de>
References: <s5h8t7bfgnq.wl-tiwai@suse.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Jun 2018 10:28:42 +0200
X-Google-Sender-Auth: OLJ1BCln5JV49qDBoveoGNt1r3M
Message-ID: <CAJZ5v0hidPav5kvTW05e0k5mouFyiUiyUW50=fDqVphbEBjQaA@mail.gmail.com>
Subject: Re: [REGRESSION] 4.17 failed to probe ACPI PnP
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Noah Davis <noahadvs@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 8:12 AM, Takashi Iwai <tiwai@suse.de> wrote:
> Hi,
>
> there seems a regression regarding the probe of ACPI PnP devices.
> The detailed logs are found in openSUSE bugzilla:
>   https://bugzilla.opensuse.org/show_bug.cgi?id=1098074

But that's on this particular machine, not in general, right?

At least I don't see this on any of the systems in my office.

> In short, since 4.17, the laptop keyboard is lost on ASUS K501UW.
> Comparing the kernel messages and other logs indicates that the
> complete lost of ACPI PnP devices:
>
> On 4.16:
> [    0.390244] pnp: PnP ACPI: found 9 devices
>
> On 4.17:
> [    0.263266] pnp: PnP ACPI: found 0 devices
>
> ... and this leads to the failure of PS/2 keyboard detection due to
> the missing PNP030b entry as a result.
>
> Any hints for debugging this are appreciated.

It looks like this may be related to the ACPICA changes that went in
during the 4.17 cycle.

I would try 4.18-rc1 as there is an ACPICA fix in it that may be
related to this in theory.  If that doesn't help, I'd focus on the
ACPICA changes.

Thanks,
Rafael
