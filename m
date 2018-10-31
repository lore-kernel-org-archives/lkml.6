Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A036C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD94B2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwuT/4uP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD94B2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbeJaOIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 10:08:13 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42911 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbeJaOIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 10:08:13 -0400
Received: by mail-qt1-f195.google.com with SMTP id z20-v6so16335345qti.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 22:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fPU1ZU+nS6xzx99eyl27bThSy1gTam7Ltx9vpoWu168=;
        b=IwuT/4uP2FTi3pzPU/N2DTAfUh7Gk2WbGfUk4VI1LaocUfv3OjfJMhMV9igykYxjA4
         NmXpnvqWabP0UT8sT/mdr0cKGhFcXZazIChSeZ5drX1HZyqNasT2Df5nM/zDkDr/A5Vj
         3KrAiCFIBYwR8KUFq6yuMQoFkGNNc4jbdQBhtaCLLxvMKk70MBHv/QOnVpwbH7AD/y3m
         mK3qeeAKa8sVx4McTrTQntpE7dcSTiRCcmSPYh2Ipt2vEgiWQ7FTxIoPuIVAxG7NUSQH
         Ga0uf0gYB+H5nrYIfmTGHs+mq6/P9TIEfSDnyJl7JSruroXBKtMOmQBq24FOwHxE01ar
         pX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPU1ZU+nS6xzx99eyl27bThSy1gTam7Ltx9vpoWu168=;
        b=ctzs9adduz2Wdqy65WUGn4oW9AhbzI8dJuzQRMaHEHLlwIZ0uF/ghPyrOtD2Iyy7aP
         fTO5Ssa7rwz0wxTWW6iV4ew0rUnJP+YaANLUGEiQeND5g7hNVRbuHP3Z5E66n6XsqpXn
         XbEW6gbzXa1Z+W35vs1qP6eD/C//RdCuctfoZZJNe+56bf2TRPtia+NLiL8aO6GmOzcH
         ktA7iygoMXgNoyLsyDMzzKWhRSoEd1OmU3mJ+2PC8cOchOARKlYSTQtZH8Ge35rDO/ki
         Bostm1AI3SPPyUBD38y0jEEjAAkfvwXLz6MVzt9glEIyIdY7he5UF3ru1VFzFI3batlZ
         PkiA==
X-Gm-Message-State: AGRZ1gI/HI4ueZWQ8dBAH/Cp2JGRQyzpQ94lRSO+iINaKsI8LBeDeKM1
        oMcP5r8BRsSVMcxseRwCbfmh3utgo2KM31UU9oA=
X-Google-Smtp-Source: AJdET5e5OEe1cuqljzz67reNEeSwuFt8kxq6lRd7W3/5jFWwyRKcEWBQ10iXtlhDMhVhnfT7Ll0l8fvbf1Oygp/IATg=
X-Received: by 2002:ac8:6892:: with SMTP id m18mr1308647qtq.157.1540962702263;
 Tue, 30 Oct 2018 22:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181022201317.8558C1D8@viggo.jf.intel.com>
In-Reply-To: <20181022201317.8558C1D8@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 30 Oct 2018 22:11:30 -0700
Message-ID: <CAHbLzkqhX-=Zs=XdR4crHYBHOdgR1zsAL+o3b8YUfe+7PB7PPw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Allow persistent memory to be used like normal RAM
To:     dave.hansen@linux.intel.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dan.j.williams@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-nvdimm@lists.01.org,
        Linux MM <linux-mm@kvack.org>,
        Huang Ying <ying.huang@intel.com>, fengguang.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 1:18 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
> Persistent memory is cool.  But, currently, you have to rewrite
> your applications to use it.  Wouldn't it be cool if you could
> just have it show up in your system like normal RAM and get to
> it like a slow blob of memory?  Well... have I got the patch
> series for you!
>
> This series adds a new "driver" to which pmem devices can be
> attached.  Once attached, the memory "owned" by the device is
> hot-added to the kernel and managed like any other memory.  On
> systems with an HMAT (a new ACPI table), each socket (roughly)
> will have a separate NUMA node for its persistent memory so
> this newly-added memory can be selected by its unique NUMA
> node.

Could you please elaborate this? I'm supposed you mean the pmem will
be a separate NUMA node, right?

I would like to try the patches on real hardware, any prerequisite is needed?

Thanks,
Yang

>
> This is highly RFC, and I really want the feedback from the
> nvdimm/pmem folks about whether this is a viable long-term
> perversion of their code and device mode.  It's insufficiently
> documented and probably not bisectable either.
>
> Todo:
> 1. The device re-binding hacks are ham-fisted at best.  We
>    need a better way of doing this, especially so the kmem
>    driver does not get in the way of normal pmem devices.
> 2. When the device has no proper node, we default it to
>    NUMA node 0.  Is that OK?
> 3. We muck with the 'struct resource' code quite a bit. It
>    definitely needs a once-over from folks more familiar
>    with it than I.
> 4. Is there a better way to do this than starting with a
>    copy of pmem.c?
>
> Here's how I set up a system to test this thing:
>
> 1. Boot qemu with lots of memory: "-m 4096", for instance
> 2. Reserve 512MB of physical memory.  Reserving a spot a 2GB
>    physical seems to work: memmap=512M!0x0000000080000000
>    This will end up looking like a pmem device at boot.
> 3. When booted, convert fsdax device to "device dax":
>         ndctl create-namespace -fe namespace0.0 -m dax
> 4. In the background, the kmem driver will probably bind to the
>    new device.
> 5. Now, online the new memory sections.  Perhaps:
>
> grep ^MemTotal /proc/meminfo
> for f in `grep -vl online /sys/devices/system/memory/*/state`; do
>         echo $f: `cat $f`
>         echo online > $f
>         grep ^MemTotal /proc/meminfo
> done
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: linux-nvdimm@lists.01.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Fengguang Wu <fengguang.wu@intel.com>
>
