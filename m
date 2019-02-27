Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6DEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4169821850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E6PrP6At"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfB0PRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:17:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45781 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729948AbfB0PRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 10:17:48 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so8087233pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 07:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ztjqP1VuN+g3iEnYapJxXdQTlGlWvjXAM/v+qMDTXuE=;
        b=E6PrP6At6RtOVPdYP8r4EqJj1VDw2BRrrfVtDGRAcZM82VlmjQXuv5vEgwPchO2BMx
         Z8DwCOkugmvOXbE27ev1lOLDGImyv4l7gf8NWLUf9bFYFifUWpF0DpcTlbtqJMicFBvk
         NnjF9aPSCmpjcoAKiIW3JmuSkSFaIzzPmFLFJLIKx4Gg5srAPi2kWi7uZrac74mquGih
         khboVw7j8SDpwaKd7bX+zhw5CbVdOMMrUYQD8eRe4SoLOWmM8qg6x9eDE+E9zw3cVVxW
         ZP5ORE2Dcx7mU05i/T1FPMn/ZxDPqYLKTuZ52uPTtP1Bf+NhNy/ojy8qEkQXttyQ+6rZ
         bcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ztjqP1VuN+g3iEnYapJxXdQTlGlWvjXAM/v+qMDTXuE=;
        b=M5jq3aG+cOGJP/+kr5fHrpK2M2+TEkZo+FzrJz9MJgjhVGlQzv4xJF34aRagYaAUgH
         NnsQNM/S5u+kZR9kxaHtwIrhvmVk9WM7x0E0V90BLgxCSKEuBe3ChPH77s3I5AvShx8U
         9AfXtcEsS+xEjzX/9gjfPgxFY7ebXKUh45cWR+NoK7GCwTghKDQuTnH4pcEH1j02r+tu
         IL6HpGG5pGl7VWR9MI51DXZcrM6jRh1sKEy9rgQwz2yG6zB6N6hy9utw5VUgp3oNfvOT
         vKloo3Sn/Pgts58RP5IKBgr52/A2A8PwpLO4JZ5ng/gLzFPXzjRWGbuJ0jVi5ZeZCjDM
         iRxw==
X-Gm-Message-State: AHQUAuaj0m/FFrUJMBASs1JoRfCQeZwJGmyVbdkzuEQitKY4aM2uqCyI
        2LGZAkLQPs9xEoUhyT55KN0wEpPEH3bMQuiyGRjDaQ==
X-Google-Smtp-Source: AHgI3IZ++yeiGkqPRdbt1kSQM/4m7ahJgVlS2Da37s6UT53YMBDpWkaRoskS1bQp56phkFSYULA7j6yAJ9eMX4z0ENQ=
X-Received: by 2002:a65:48c1:: with SMTP id o1mr3352451pgs.94.1551280666811;
 Wed, 27 Feb 2019 07:17:46 -0800 (PST)
MIME-Version: 1.0
References: <20190221222537.137331-1-venture@google.com> <9ab3a0e6-fa1e-11c7-adad-7e14bfe28059@gmail.com>
In-Reply-To: <9ab3a0e6-fa1e-11c7-adad-7e14bfe28059@gmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Wed, 27 Feb 2019 07:17:35 -0800
Message-ID: <CAO=notw6Yhi5uSfHtEzSy57JPzhFHiQyPcaZGHhBhLjtmVTaFg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers/misc: Add Aspeed P2A control driver
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 9:05 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 2/21/2019 2:25 PM, Patrick Venture wrote:
> > The ASPEED AST2400, and AST2500 in some configurations include a
> > PCI-to-AHB MMIO bridge.  This bridge allows a server to read and write
> > in the BMC's memory space.  This feature is especially useful when using
> > this bridge to send large files to the BMC.
> >
> > The host may use this to send down a firmware image by staging data at a
> > specific memory address, and in a coordinated effort with the BMC's
> > software stack and kernel, transmit the bytes.
> >
> > This driver enables the BMC to unlock the PCI bridge on demand, and
> > configure it via ioctl to allow the host to write bytes to an agreed
> > upon location.  In the primary use-case, the region to use is known
> > apriori on the BMC, and the host requests this information.  Once this
> > request is received, the BMC's software stack will enable the bridge and
> > the region and then using some software flow control (possibly via IPMI
> > packets), copy the bytes down.  Once the process is complete, the BMC
> > will disable the bridge and unset any region involved.
> >
> > The default behavior of this bridge when present is: enabled and all
> > regions marked read-write.  This driver will fix the regions to be
> > read-only and then disable the bridge entirely.
>
> A complete drive by review, so I could be completely off here (most
> likely am), but have you considered using virtio and doing some sort of
> rudimentary features (regions here) negotiation over that interface?

I have not.

>
> If I get your description right in premise maybe emulating the AHB side
> on the BMC as a PCI end-point device driver, and using it as a seemingly
> regular PCI EP from the host side with BARs and stuff might make sense
> here and be less of a security hole than it currently looks like.

In this case, what I"m trying to do is control access to regions of
BMC physical address space.  The ASPEED BMC is by default, completely
open in this regard, see CVE-2019-6260.  There are two sets of
registers that control the host's ability to read or write the
physical address space.  The host needs to be able to write to the
BMC's physical address space in some use-cases -- one of which is my
firmware staging case.  It could just as easily be used as a memory
buffer region for a virtual nic.  Part of the goal here though is that
the host should not have control of what regions are on/off without
the BMC allowing it.  It's currently a security hole, and this driver
is meant to open that hole on demand for specific purposes, whereas
the default state is completely open.

> --
> Florian
