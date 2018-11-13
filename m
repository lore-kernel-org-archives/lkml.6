Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98311C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B67022419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B67022419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbeKMKRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:17:49 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41193 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbeKMKRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:17:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so4796819pgh.8;
        Mon, 12 Nov 2018 16:22:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NDYc6PLgvfYfcwHoRqJ6g9wBHDUi4uO8ls1aHLxzdgU=;
        b=KK1qeq0etyzL9iNYknDA+GHuslZ/CyMMUDTFpMlxe/HiZKLtIW0e9vW965Cpmun35j
         5qUqn2fGF4zF9Np3DaGGLEnAeQZOihYBc4bNJDtx1QqpzS1VQHf//KWjnSE6wuIa2dW4
         iXqm9K7PeHKgA27C/Ja+eIXjRTVh/FaL/pczyHYynee5Rkhn3H3tAN6iy/quDSMWpxZG
         0udEzJtcuOFXdCDtyrqlBmXeWASdwaXjfLkfib70dimf6/8P9Gsp2+vk0/EAVd66l+T/
         1lqRlqN/W4Kwwikade4MXdHNiqPLvOVInMvyYVF1l+/3hlYli1JFWUofZEIUXTRNG+hg
         +xzA==
X-Gm-Message-State: AGRZ1gKXpMAXRE3RRGvglabizteRPLX+ertAWtdxC+tzfEYXm3qtduqM
        6nzgjTSgjpJMinHblB4JRg==
X-Google-Smtp-Source: AJdET5dJ/ktORr0pyFsKehi5ZwFeK0uCwqxVjvH6pRjCe20CTz92/oZz9OdHPGOUQR+DKVGenW3olA==
X-Received: by 2002:a65:624c:: with SMTP id q12mr2730533pgv.379.1542068537459;
        Mon, 12 Nov 2018 16:22:17 -0800 (PST)
Received: from localhost ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id r4sm21683833pgn.54.2018.11.12.16.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 16:22:16 -0800 (PST)
Date:   Mon, 12 Nov 2018 18:22:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Hackmann <ghackmann@android.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, linux@armlinux.org.uk,
        green.hu@gmail.com, deanbo422@gmail.com, gxt@pku.edu.cn,
        ard.biesheuvel@linaro.org, linux-snps-arc@lists.infradead.org,
        vgupta@synopsys.com
Subject: Re: [PATCH v4 0/6] arm64: Get rid of __early_init_dt_declare_initrd()
Message-ID: <20181113002216.GA26854@bogus>
References: <20181105225431.24485-1-f.fainelli@gmail.com>
 <20181106140642.GA19280@rapoport-lnx>
 <68b32163-85ff-45f7-8887-60273da7c6e2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b32163-85ff-45f7-8887-60273da7c6e2@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 12:32:50PM -0800, Florian Fainelli wrote:
> On 11/6/18 6:06 AM, Mike Rapoport wrote:
> > On Mon, Nov 05, 2018 at 02:54:25PM -0800, Florian Fainelli wrote:
> >> Hi all,
> >>
> >> Changes in v4:
> >>
> >> - dropped initrd_below_start_ok assignment in ARM64, not necessary at
> >>   all (Ard)
> >> - replace #ifdef CONFIG_BLK_DEV_INITRD with if
> >>   (IS_ENABLED(CONFIG_BLK_DEV_INITRD) for consistency with other parts
> >>   of arm64_memblock_init() (Rob)
> >>
> >> Changes in v3:
> >>
> >> - use C conditionals in drivers/of/fdt.c
> >> - added check on phys_initrd_size in arch/arm64/mm/init.c to determine
> >>   whether initrd_start must be populated
> >> - fixed a build warning with ARC that was just missing an (unsigned
> >>   long) cast
> >>
> >> Changes in v2:
> >>
> >> - get rid of ARCH_HAS_PHYS_INITRD and instead define
> >>   phys_initrd_start/phys_initrd_size in init/do_mounts_initrd.c
> >>
> >> - make __early_init_dt_declare_initrd() account for ARM64 specific
> >>   behavior with __va() when having CONFIG_DEBUG_VM enabled
> >>
> >> - consolidate early_initrd() command line parsing into
> >>   init/do_mounts_initrd.c
> >>
> >> Because phys_initrd_start/phys_initrd_size are now compiled in
> >> ini/do_mounts_initrd.c which is only built with CONFIG_BLK_DEV_INITRD=y,
> >> we need to be a bit careful about the uses throughout architecture
> >> specific code.
> >>
> >> Previous discussions/submissions list here:
> >>
> >> v3:
> >> https://www.spinics.net/lists/arm-kernel/msg683566.html
> >> v2:
> >> https://lkml.org/lkml/2018/10/25/4
> >>
> >> Florian Fainelli (6):
> >>   nds32: Remove phys_initrd_start and phys_initrd_size
> >>   arch: Make phys_initrd_start and phys_initrd_size global variables
> >>   of/fdt: Populate phys_initrd_start/phys_initrd_size from FDT
> >>   arm64: Utilize phys_initrd_start/phys_initrd_size
> >>   of/fdt: Remove custom __early_init_dt_declare_initrd() implementation
> >>   arch: Move initrd= parsing into do_mounts_initrd.c
> > 
> > For the series:
> > 
> > Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> Thanks Mike, Rob, do you want to merge that series through the OF tree?

Sure, some arch maintainer acks would be nice.

Rob
