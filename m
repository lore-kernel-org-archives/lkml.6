Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97705C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B07A20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gguNK8L1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B07A20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJBQWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:22:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40282 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeJBQWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:22:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id z204-v6so651068wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wz4zqbhuF7x0PHSfwD1x5xnncNEJYOJ+KJtr+RIT5zY=;
        b=gguNK8L1b/kJ/GiyYaieqU7Cn8Q0cgdK0Lcv+10kUyv+YbBGyrt9kHhi13Q7QSMeDP
         36VbYU7PZUEcmDbuAVUF7PCyS+1/CB6E6SCjAvUl/NvvzIaNsZCgzZQxO3G0TFHo25Iv
         Ez6fCNIimEBYDR++AYhOO+lOJlnCBTTb/FCrlHXM3Nw95evYzaZcl04KPN2t/7A2q2ys
         PDJ/eGly3fAtjfge8WbdFn+QLFztgoyzq8to1tz9Y5vOn0mdXDT0atVgNWxRByLx+p16
         1ZjjyoY6shLGAtX9IN9/Stc348H/vmRZ+UlDIgHsbZEw8jL6sFhRirDxHGCqss5qwtMn
         zjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wz4zqbhuF7x0PHSfwD1x5xnncNEJYOJ+KJtr+RIT5zY=;
        b=qo0P+miKJ3OGKwPXiEwtaajzSSLP4oeWCx5Vy6Qh3RM8oz9DWgb8OuWE86Qhbxl3J/
         bnpHgDH62AoHqDzerxvJ1OHwQWmw/ZmKZrqYKL60AP3QCW8pA4B9Il13s8srozUnsu3e
         V4UmCwiDttA/OjSvLDe/xT/Pl4QJqZahOrVM7BUbzVPpz9yd48oPDc3cJrONRbFG9G/A
         1/FrE2wYs8EpfyTdKNcWcohtP7F9/IL47U/MAkaw+VUTcmWIXUwiadrfC6JSthN7S+kZ
         bUiFjynNyQ/lLc1ssY4Ean6PMu0KPmb0x+sjjfJ/TlDnsSpB+6FYb7Hh/NV9jtQCdUua
         JHdA==
X-Gm-Message-State: ABuFfojgU/U6P96P6F+lnKOzgZBtS26TF7GDj5kouj4DE4T9NCZffbYo
        VAUJZA1OV3N21UEKrqCxZV4=
X-Google-Smtp-Source: ACcGV631+YMMuP4LTbXmhpNBs7U1M6zyrqWZbdR5gykNzawiTiAlinFHgIKWc1pHmoR+bjLqGDn6Zw==
X-Received: by 2002:a1c:5d8c:: with SMTP id r134-v6mr918580wmb.147.1538473183663;
        Tue, 02 Oct 2018 02:39:43 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 130-v6sm1602335wmn.7.2018.10.02.02.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 02:39:43 -0700 (PDT)
Date:   Tue, 2 Oct 2018 11:39:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     linux-mm@kvack.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Michal Hocko <mhocko@kernel.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 1/3] Revert "x86/e820: put !E820_TYPE_RAM regions into
 memblock.reserved"
Message-ID: <20181002093940.GA98058@gmail.com>
References: <20180925153532.6206-1-msys.mizuma@gmail.com>
 <20180925153532.6206-2-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925153532.6206-2-msys.mizuma@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:

> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> commit 124049decbb1 ("x86/e820: put !E820_TYPE_RAM regions into
> memblock.reserved") breaks movable_node kernel option because it
> changed the memory gap range to reserved memblock. So, the node
> is marked as Normal zone even if the SRAT has Hot plaggable affinity.
> 
>     =====================================================================
>     kernel: BIOS-e820: [mem 0x0000180000000000-0x0000180fffffffff] usable
>     kernel: BIOS-e820: [mem 0x00001c0000000000-0x00001c0fffffffff] usable
>     ...
>     kernel: reserved[0x12]#011[0x0000181000000000-0x00001bffffffffff], 0x000003f000000000 bytes flags: 0x0
>     ...
>     kernel: ACPI: SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
>     kernel: ACPI: SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug
>     ...
>     kernel: Movable zone start for each node
>     kernel:  Node 3: 0x00001c0000000000
>     kernel: Early memory node ranges
>     ...
>     =====================================================================
> 
> Naoya's v1 patch [*] fixes the original issue and this movable_node
> issue doesn't occur.
> Let's revert commit 124049decbb1 ("x86/e820: put !E820_TYPE_RAM
> regions into memblock.reserved") and apply the v1 patch.
> 
> [*] https://lkml.org/lkml/2018/6/13/27
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> ---
>  arch/x86/kernel/e820.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)

Bad ordering which introduces the bug and thus breaks bisection of related issues: the fixes 
should come first, then the revert of the unnecessary or bad fix.

Thanks,

	Ingo
