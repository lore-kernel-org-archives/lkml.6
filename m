Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F914C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAAE214C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ks1JZ3jK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAAE214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeJIDWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:22:11 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:52019 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIDWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:22:11 -0400
Received: by mail-wm1-f50.google.com with SMTP id 143-v6so9248228wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 13:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=02BobGl2NubJwR7sYXPC0Sv+CHJnX0j0cpnGfuOoTdU=;
        b=Ks1JZ3jK26QNhn1nXaZdlisHYyZlNspIhzRUZTzw2Hm5qelzeKbOV5U46ixLaRq/bf
         WoWK7h3nJdbqCyqc0iL3Tjwmw9c5SgJiG2IhjUH+6URqjsuzgOxrnkh3wBgsRwKZ5fvF
         Cd7rhkLAdNrXRi54yYHmcP/XWw5cQjCwN1IIVPziaNTgKYod1s4+X7bmi/9ltcOrNOh3
         d3nyZ4ugeYQtYiTEBxlznoNBOj4gmRof2s/EVNuxWrQ9O4SePdaYRCMvvcxRPQYUQvNZ
         wrbK4h14Gsa31jJiYr9BiV8l5FOvKrH1sVQusY9nFq9d57MTgTJhcC7d9HgfTwwXYMll
         Y2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02BobGl2NubJwR7sYXPC0Sv+CHJnX0j0cpnGfuOoTdU=;
        b=dREFsGZABF4eNbihq6vHRYbGZLgFQsSnzgy8NpATKnGFJVIgG2aF+gw0pE0wm+X6Te
         LdEOaFQC1xCTAcEU0Sjat8oqZfwFBhZLFzxhqWzXywTS6/sIMSv90XcfpLieuHhtTmp0
         8NX/juEDATLT9HKslrZh4sa2D8SeJ4EtsPtM6dkr2Kqcgen5BfQrAuPlvqdocXFHWPAh
         Te1w4EOSlX7XdfhGgrQyvqj+rIA2oeHwOeFNkcW7gXVj2faeqfPs2nJVnIXQxjAVfOr1
         furvMnLo6K27FIUwAGrnUO4tnjsTd2yDBATWB2Wjp/p39Syg3KPese1GQtsyPRxYUAic
         llKQ==
X-Gm-Message-State: ABuFfogu/YTqKb9cveeQaSiNeFEP588SPfSwxuvF2/WisPQtBjRZHFf1
        zS6qtkK/imMXbkdpPwS0P8bvRouw5OfiTZyMg/Af
X-Google-Smtp-Source: ACcGV6376ehOHuH8nNRi00X5LArlgWj1op8IsVu9/x/TQ62lhJm5SfNrrpmL/+DU1PXnkQYLXaZHmvXkPgI/PJA4P58=
X-Received: by 2002:a1c:88cd:: with SMTP id k196-v6mr15732774wmd.17.1539029322145;
 Mon, 08 Oct 2018 13:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <e75fa739-4bcc-dc30-2606-25d2539d2653@molgen.mpg.de>
 <alpine.DEB.2.21.1809191004580.1468@nanos.tec.linutronix.de>
 <0922cc1b-ed51-06e9-df81-57fd5aa8e7de@molgen.mpg.de> <alpine.DEB.2.21.1809210045220.1434@nanos.tec.linutronix.de>
 <c8da5778-3957-2fab-69ea-42f872a5e396@molgen.mpg.de> <alpine.DEB.2.21.1809281653270.2004@nanos.tec.linutronix.de>
 <20181003212255.GB28361@zn.tnic> <20181004080321.GA3630@8bytes.org>
 <alpine.DEB.2.21.1810051124320.3960@nanos.tec.linutronix.de>
 <74dededa-3754-058b-2291-a349b9f3673e@molgen.mpg.de> <alpine.DEB.2.21.1810082108570.2455@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1810082108570.2455@nanos.tec.linutronix.de>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 8 Oct 2018 15:08:30 -0500
Message-ID: <CAErSpo5dSd7=BZFoROowLACmkKHHD0gbbRQWN3VCga3M3GepgQ@mail.gmail.com>
Subject: Re: x86/mm: Found insecure W+X mapping at address (ptrval)/0xc00a0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     pmenzel@molgen.mpg.de, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@alien8.de>, linux-mm@kvack.org,
        x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 2:37 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Paul,
>
> On Fri, 5 Oct 2018, Paul Menzel wrote:
> > On 10/05/18 11:27, Thomas Gleixner wrote:
> > > If pcibios is enabled and used, need to look at the gory details of that
> > > first, then the W+X check has to exclude that region. We can't do much
> > > about that.
> >
> > That would also explain, why it only happens with the SeaBIOS payload,
> > which sets up legacy BIOS calls. Using GRUB directly as payload, no BIOS
> > calls are set up.
> >
> > Reading the Kconfig description of the PCI access mode, the BIOS should
> > only be used last.
>
> Correct. And looking at the dmesg you provided it is initialized:
>
> [    0.441062] PCI: PCI BIOS area is rw and x. Use pci=nobios if you want it NX.
> [    0.441062] PCI: PCI BIOS revision 2.10 entry at 0xffa40, last bus=3
>
> Though I assume it's not really required, but this PCI BIOS thing is not
> really well documented and there are some obsure usage sites involved.
>
> Bjorn, do you have any insight or did you flush those memories long ago?

No, I don't.  I was never really involved with PCIBIOS.
