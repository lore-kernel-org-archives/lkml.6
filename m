Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB7FC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404242454F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTbPO0e3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404242454F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933928AbeGDHz1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:55:27 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42807 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933675AbeGDHyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:54:53 -0400
Received: by mail-pg0-f65.google.com with SMTP id c10-v6so2153150pgu.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 00:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vubBjxNtAgWXRdolYgdcIp4xHSZ+b2FQkqJfVaMCJqw=;
        b=pTbPO0e3DD8exFMEaqJ/mh1Hq6Q3MMjM5V4Dsb1ugafN2+Y0fryv4gIbtXxx/FwLji
         ImDcM7tDANpxgsE5rcDzRu7MVWd2LtjTvotS+2qt7v7R9eX4t8MeNndceMxfkPu81yhh
         pt5zh3ESPkyQN9c5DEwFI9MVdreBhYfssOdjn/50F6/+GZqV3doXPuXdqSwpBRBRNSbZ
         L3xp/FMqW4mEnSAMg9kqZmIy4e2/t1PUvAYqm7o9H5hdBFG9cNQ7SCoehz31QyXdQTtL
         7uMt13os2Oc2djyDIqgUR+j1ulsJAu2R/vG+tUdQvu30/bdb0u863ZAZzCsaL58Qy4Nq
         R/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vubBjxNtAgWXRdolYgdcIp4xHSZ+b2FQkqJfVaMCJqw=;
        b=eALDMzJqG57baBJ1QtK+yXki1+IukGgidzaujmoBcU2BDHN44NnxNiRFJuMUcT9aP9
         NGjJiri/JwhluK45TJr4Ezx3AwJO3frEulkg6e8hIw7XFqIE5k27U7HnhAJ171Zs+VFl
         DfDm7Lx5uScKW041ZHgDi1puHnruwOKV3gnHLd8r69/SRj26frYYiIXLAfsMXOlJiCy2
         OnNxGsS5HRTMA9/35hFYURq3xZYg1zhXeGjCQVRNud/ks3o+dIfNLHInuZXjfZm/qDO/
         nZIorp4Ub37cBu0pxGfSC7Ej0IV1cmGSBvddYeni2UW7XUDqVZrdPD5fUEJ8QM6IlO/V
         /lVw==
X-Gm-Message-State: APt69E13h73ij3kv0Vfytv6+JFsPIqhWJyzDFg/wcqpvRAjlbKdbt33P
        Ti8BbOjVimZdPRKX1o4mgeA=
X-Google-Smtp-Source: AAOMgpfKCRWtHuP2kyGZ46ZDPa6TDLuVLCEosTIrA2u4tFC509GWqGZ5dmDYjUcQ4ReHwf/EC0Y9lg==
X-Received: by 2002:a63:ac57:: with SMTP id z23-v6mr923210pgn.74.1530690893359;
        Wed, 04 Jul 2018 00:54:53 -0700 (PDT)
Received: from localhost ([175.223.14.150])
        by smtp.gmail.com with ESMTPSA id g4-v6sm5559108pgc.8.2018.07.04.00.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 00:54:52 -0700 (PDT)
Date:   Wed, 4 Jul 2018 16:54:49 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/memblock: replace u64 with phys_addr_t where
 appropriate
Message-ID: <20180704075449.GB458@jagdpanzerIV>
References: <1530637506-1256-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180703125722.6fd0f02b27c01f5684877354@linux-foundation.org>
 <063c785caa11b8e1c421c656b2a030d45d6eb68f.camel@perches.com>
 <20180704070305.GB4352@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704070305.GB4352@rapoport-lnx>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/04/18 10:03), Mike Rapoport wrote:
>  arch/alpha/kernel/pci_iommu.c             | 20 ++++++++++----------
>  arch/arm/mm/alignment.c                   |  2 +-
>  arch/arm/nwfpe/fpmodule.c                 |  2 +-
>  arch/microblaze/mm/pgtable.c              |  2 +-
>  arch/sparc/kernel/ds.c                    |  2 +-
>  arch/um/kernel/sysrq.c                    |  2 +-
>  arch/x86/include/asm/trace/exceptions.h   |  2 +-
>  arch/x86/kernel/irq_64.c                  |  2 +-
>  arch/x86/mm/extable.c                     |  4 ++--
>  arch/x86/xen/multicalls.c                 |  2 +-

Isn't it "funny" that parisc, ia64, powerpc don't use pf/pF in arch code,
but x86, arm, etc. do use pf/pF in arch code?

Surely, I do understand why we have pf/pF in mm, drivers and all over the
place. But still, I'm surprised.

	-ss
