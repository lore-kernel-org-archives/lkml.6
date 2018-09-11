Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38781C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 03:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D170F20645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 03:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="ivEu0Of3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D170F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbeIKIc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 04:32:28 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34839 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeIKIc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 04:32:27 -0400
Received: by mail-qk1-f195.google.com with SMTP id f62-v6so14185554qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 20:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8mzDCYQpRSL+woMoAxAIMGz4v2MoNvj7TYo/teM7H0Y=;
        b=ivEu0Of3FeXV5gFX+2sP5tttJ8Zpx+DftTBq8am1uaq5Y7MgLsKYgRi+miDUzpWY/O
         +JjRnjZcPpfAoGA/suheyNr+a5ZSFpf8oEuSvNtGYzt08eA/3lZxpTto4u52nlbgohYY
         B1ERgQ64awRReTTp30RHVgtrEHBAgqoXwhl9K4WjyOoO1xISt78y7a5WfQefW7hKYnkK
         YMeO28k30U8vjG0gqggszlj0OACeW1//cPHgT6tp5MpHdQJVZC1POA/1M07pPhjOGbTI
         cNpyMAmAYbeKWaTkricoLiEeeO2mbs5viqbgmP3qiHGvQKL7DMiS/mmYIX6y99iPiyCx
         dm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8mzDCYQpRSL+woMoAxAIMGz4v2MoNvj7TYo/teM7H0Y=;
        b=KZ8YRxy5gCdlHOyfDd0y2jm3eU/ad8TowjW/XMn0hIJcKBeEeHeFiQ3U574pmcxhSi
         S3l0iFl0dBTyGn/03xmxEpWwgzx0mxcbPf3N3Ws21xNJUnzTJbiyxhNmpl1JLXMZPCfL
         26Qsot96+0hhhLUHZ6CG606roGnGu1Ya5DsVun7G2YIhymXxt+KQF/LXSRLUlp7WTjm6
         ICoop86Gkrscus/+wirmDmKOBh6RkK+m6Jo/M7KbBZQGO8XtFZ2lBN8ujXkl/AwHDnX/
         /+kAiXs97fV3V3xDD0eq0WNRPXyR6FwRQ43Zw0w6v2gNCstTX8TMb1AZSyxAav96yIry
         zo1g==
X-Gm-Message-State: APzg51BrFnUyfdlfeS7bwHYsD5+OgjCfA0bwPKlPTAFNoWJbJ3rq20so
        GjAVnWHtZl79wiUQFi919iISh+cvMjTIpAJSjfCcnQ==
X-Google-Smtp-Source: ANB0VdZAa5JXVFwfNU0SUDj0yTxVwk4Z1VVktmQeRJmBSiKZucneHgV35TqTZ0K7UkIkGgQDTUjXeCjTTUqE2Etx4DQ=
X-Received: by 2002:a37:f71d:: with SMTP id q29-v6mr1530440qkj.254.1536636914232;
 Mon, 10 Sep 2018 20:35:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:147:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 20:35:13 -0700 (PDT)
In-Reply-To: <20180907150515.GA28739@al>
References: <20180907053614.6540-1-drake@endlessm.com> <20180907150515.GA28739@al>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 11 Sep 2018 11:35:13 +0800
Message-ID: <CAD8Lp46eDaSF3fNQgYL=3vCXJ5VpV-JkYEu-YTtuh+w4rMU-5w@mail.gmail.com>
Subject: Re: [PATCH] PCI: Reprogram bridge prefetch registers on resume
To:     Peter Wu <peter@lekensteyn.nl>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>,
        nouveau@lists.freedesktop.org, Linux PM <linux-pm@vger.kernel.org>,
        kherbst@redhat.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Thomas Martitz <kugel@rockbox.org>, davem@davemloft.net,
        hkallweit1@gmail.com, netdev@vger.kernel.org, nic_swsd@realtek.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have created https://bugzilla.kernel.org/show_bug.cgi?id=201069 to
archive the research done so far.

On Fri, Sep 7, 2018 at 11:05 PM, Peter Wu <peter@lekensteyn.nl> wrote:
> Windows 10 unconditionally rewrites these registers (BAR, I/O Base +
> Limit, Memory Base + Limit, etc. from top to bottom), see annotations:
> https://www.spinics.net/lists/linux-pci/msg75856.html
>
> Linux has a generic "restore" operation that works backwards from the
> end of the PCI config space to the beginning, see
> pci_restore_config_space. Do you have a dmesg where you see the
> "restoring config space at offset" messages?

Interesting, I had not spotted this code. The logs for the affected
bridge on Asus X542UQ:

 0000:00:1c.0: restoring config space at offset 0x3c (was 0x100,
writing 0x1001ff)
 0000:00:1c.0: restoring config space at offset 0x24 (was 0x10001,
writing 0xe1f1d001)
 0000:00:1c.0: restoring config space at offset 0x20 (was 0x0, writing
0xef00ee00)
 0000:00:1c.0: restoring config space at offset 0xc (was 0x810000,
writing 0x810010)
 0000:00:1c.0: restoring config space at offset 0x4 (was 0x100007,
writing 0x100407)

So it didn't restore 0x28 (the magic register) and also register 0x2c
(prefetch limit upper 32 bits) because their values were already 0 on
resume.

https://bugzilla.kernel.org/show_bug.cgi?id=116851#c23 has an
assertion that Intel recognises this issue and calls for all those
registers to be restored on resume.

I propose for Linux 4.19 we apply a minimally intrusive change that
"forcibly" restores dword registers 0x24, 0x28 and 0x2c for PCI
bridges (regardless of their current value), while retaining the
existing restore order (high to low) over all registers and doing the
read-then-maybe-write thing for all of the other regs (per current
behaviour).


Then we also consider swiftly applying a followup patch implementing a
more thorough approach and we give it some time in linux-next before
releasing in Linux 4.20 which does something more thorough. I think
perhaps more discussion is needed there, or at least some more input
from Bjorn. Seems like we have 3 approaches to consider:

1. Peter Wu suggests following what windows does. Windows appears to
start with low registers and works its way upwards, which means it
writes BAR addresses, I/O base, etc, before writing prefetch
registers. It skips over read-only and write-to-clear registers and
also only writes some of the registers at the very end - like the
command register.

To be thorough here we would probably also have to study and copy what
Windows does for non-bridge devices (not sure how many device classes
we would want to study here?). Also it is a bit risky in that Bjorn
has pointed out that Linux's earlier approach with a high level of
similarity here (restore registers in ascending order, regardless of
their current value) caused a laptop to hang on resume.


2. Bjorn suggested tweaking the existing code to always write the
saved value even when the hardware has that same value. The
read-maybe-write logic was introduced to avoid a laptop hang, but at
that time we were restoring registers in ascending order, now we are
descending it might be worth giving this another try.


3. Do nothing else beyond the minimal change that I propose for v4.19?
Looking a bit more into git history this seems to be a sensitive and
problematic area, more changes might mean more trouble. For example
right now pci_restore_config_space() does:
        pci_restore_config_space_range(pdev, 10, 15, 0, 0);
        /* Restore BARs before the command register. */
        pci_restore_config_space_range(pdev, 4, 9, 10, 0);
        pci_restore_config_space_range(pdev, 0, 3, 0, 0);
but pci_restore_config_space_range() already goes in descending order,
so the above is already equivalent to the code in the "else" path that
follows:
        pci_restore_config_space_range(pdev, 0, 15, 0, 0);

and if you look at the history behind this "mixup" there's stuff that
goes back to 2012 like commit a6cb9ee7cabe ("PCI: Retry BARs
restoration for Type 0 headers only") which was fixing up another
problematic commit in this area, etc.

Daniel
