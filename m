Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBB2C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D49204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsRKLc9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D49204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbeJBUfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:35:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42726 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbeJBUfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:35:16 -0400
Received: by mail-qt1-f195.google.com with SMTP id z8-v6so1930607qto.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 06:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tWzAXi2t51cz5Y9LEZOu4OxxvTmIahxPicMlKKfQGoo=;
        b=VsRKLc9M/lQ05Hb79HuuhBXhtT/+9YZOq+qaRgAqx5iFJeof4KorC+UNPH7gpYFvUL
         lFWpAMMCUnLwYsfsb7gqtiZtAGW6bhTY/0aeqs0a69ikgvWeRu5Xr6GjvTRvIllO9RRa
         7emM7L/f19xYt9SmOwQwKTyBjdnbnuqYY5/5agLAVkB+VwICuCMX756z3KhRsq7k/Cgt
         VCFE8M4FYcLnvYmUjlA4Mrv3a7c7DUnpqYC/UZ1LqiRgHv9r28RNXpVgikFexGEZ6THX
         kI4+bX4UFwJBig+5W2nS7KzaI5ywVMbJVVtfCngatkBjcuxvq32WqFSoyPBopm0CEbH0
         RRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tWzAXi2t51cz5Y9LEZOu4OxxvTmIahxPicMlKKfQGoo=;
        b=JrW5sa5OsxAYCNygu+zWJe1dBIZdEhZaDt8I2JYtRYkIHHxGJTUWP7mw0pu/Jk/0iB
         BJRicf07KJNZVTwE3YCbY2rs4Z7zyHGiPPfeOjhLjkAekxFC2FFZ+y2bgC1A9F69Z83Y
         KOcFZpwHl2HmnAOJuJXxZDZX4YTz7N/qu6CaYgd/Z8fbU9qAVZoggac51EKBjj6cfT4M
         6BSAIoIPiSAayBkBTin6sETpYfTz1VPsaTspncrRFzy9q34MbTYdNWZxtlWLXBGSdg2h
         4rm7HtxdUGXmV0bTliNKU1v5rid5GDt2o2g1BXcNqcuMuXacjV6tT2Knf274OCumq1Ki
         p5Ow==
X-Gm-Message-State: ABuFfojWxVKJ9l86qm2/kBZPA/X0nTCdCQ3ajJNme3eCNm4U66VHG3F/
        y4mmnH9dEIA04N5/7GoBHg==
X-Google-Smtp-Source: ACcGV62sZbMs4x6IVaGfrgCCDN/KW/Dhi4JkmLzYyXWo8j1GgxIq/YkFlTxoT6v5Y3iR/cHfe0vIGw==
X-Received: by 2002:ad4:530b:: with SMTP id y11-v6mr11544785qvr.29.1538488307969;
        Tue, 02 Oct 2018 06:51:47 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z14-v6sm7784409qti.83.2018.10.02.06.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 06:51:47 -0700 (PDT)
Date:   Tue, 2 Oct 2018 09:51:41 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-mm@kvack.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@kernel.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 1/3] Revert "x86/e820: put !E820_TYPE_RAM regions into
 memblock.reserved"
Message-ID: <20181002135141.3yqedau2nrvwpxmy@gabell>
References: <20180925153532.6206-1-msys.mizuma@gmail.com>
 <20180925153532.6206-2-msys.mizuma@gmail.com>
 <20181002093940.GA98058@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002093940.GA98058@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 11:39:40AM +0200, Ingo Molnar wrote:
> 
> * Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> 
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > 
> > commit 124049decbb1 ("x86/e820: put !E820_TYPE_RAM regions into
> > memblock.reserved") breaks movable_node kernel option because it
> > changed the memory gap range to reserved memblock. So, the node
> > is marked as Normal zone even if the SRAT has Hot plaggable affinity.
> > 
> >     =====================================================================
> >     kernel: BIOS-e820: [mem 0x0000180000000000-0x0000180fffffffff] usable
> >     kernel: BIOS-e820: [mem 0x00001c0000000000-0x00001c0fffffffff] usable
> >     ...
> >     kernel: reserved[0x12]#011[0x0000181000000000-0x00001bffffffffff], 0x000003f000000000 bytes flags: 0x0
> >     ...
> >     kernel: ACPI: SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
> >     kernel: ACPI: SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug
> >     ...
> >     kernel: Movable zone start for each node
> >     kernel:  Node 3: 0x00001c0000000000
> >     kernel: Early memory node ranges
> >     ...
> >     =====================================================================
> > 
> > Naoya's v1 patch [*] fixes the original issue and this movable_node
> > issue doesn't occur.
> > Let's revert commit 124049decbb1 ("x86/e820: put !E820_TYPE_RAM
> > regions into memblock.reserved") and apply the v1 patch.
> > 
> > [*] https://lkml.org/lkml/2018/6/13/27
> > 
> > Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> > ---
> >  arch/x86/kernel/e820.c | 15 +++------------
> >  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> Bad ordering which introduces the bug and thus breaks bisection of related issues: the fixes 
> should come first, then the revert of the unnecessary or bad fix.

Thanks. I'll change the order, then resend them.

- Masa
