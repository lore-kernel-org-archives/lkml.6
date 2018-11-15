Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AAFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CC3208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="brXzQDTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CC3208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeKOLBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 06:01:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43646 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeKOLBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 06:01:42 -0500
Received: by mail-ot1-f67.google.com with SMTP id a11so12915831otr.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 16:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AavQfhDiJCrxhdEXmK8NIMj2fhFuXrV0N/0nsHp53p8=;
        b=brXzQDTVRtsPcSj5y5ilwPPzVH3paMi4/o7O0XS7o96cCUFN0W7O9baluKuWfD+CmJ
         MGcTm58z9wc+u0GG5asodKCQzm/tJzU3X8STUw963QP4iF+XIgiUCKwK1D9Od258QVCw
         L6RJChRztjZTkmorneGx9faIptgMf9tTNUb0qf4sI8cwyK37w9fC5JzmD4iNslBLjV3b
         LVTuhQwhq3ny2V737w1fqPAAWcuT5uT3Jtcb8+VDHHpEqfmF3WPPR0aMeNkfWRN6T9k9
         WP1ts7Ywi917/EZPGOSbjTPuBQC+09v3giZMY4cNyo6K2VZXsmHl7vNYImq2l0uwEvYZ
         vUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AavQfhDiJCrxhdEXmK8NIMj2fhFuXrV0N/0nsHp53p8=;
        b=kavRv18l0rCa5VjKHn1KscHwqsESSzgJ9zQI5Gk9Wv7tdry6vDofB/6ZBKD1SX48Rd
         oVihrQHy33McEXAWBC5lHlCJT/20RZaYwackIt0LnXspEURMoDgD4iiwLxRgMSRtXwBD
         pzyrnAq17TkAk5tlUz9yuMHPnMv17qp9hS7bNNySjAPffOlwubERNTNmFcc+0DxQ7fET
         ApFdIyvoq1oXeeiEG8rRZDAe7TWSz7DBT3+3Tkrx28QMH/JxtZRqykTZ8+cMu7cyn1B3
         NhBwODOV8IlKsCy6zAgTwzCAhP/FQrQFaxdsDdOsumJkuE9MP0vhNHs6Q2uJPsMVxaQa
         kTIw==
X-Gm-Message-State: AGRZ1gKCyGNDXWrXd94LwulAb7uKqS0RYQ1v46G5j8oKhNoCJRDFFRqC
        9Ejl1lc2AEnmGjzO87wxoriZCOocn2LpN2pKqeA3T/P8ynY=
X-Google-Smtp-Source: AJdET5fHydd1KAJqnAGjKYlCZwPNYXg/wu7MpooX1FuQbRhqbZCfKlaedOYg9/Z36FNQjTzUfHd+PoKyU0FJ5TiiKS0=
X-Received: by 2002:a9d:f07:: with SMTP id 7mr2348407ott.353.1542243365810;
 Wed, 14 Nov 2018 16:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20181109203921.178363-1-brho@google.com> <20181114215155.259978-1-brho@google.com>
In-Reply-To: <20181114215155.259978-1-brho@google.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 14 Nov 2018 16:55:54 -0800
Message-ID: <CAPcyv4jga=HnsfHffWoo+JjRUBf3stD4VP3B5X5xSOZb=yh+Mw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] kvm: Use huge pages for DAX-backed files
To:     Barret Rhoden <brho@google.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        alexander.h.duyck@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Alex who is looking into removing PageReserved for DAX pages. ]
On Wed, Nov 14, 2018 at 1:53 PM Barret Rhoden <brho@google.com> wrote:
>
> This patch series depends on dax pages not being PageReserved.  Once
> that is in place, these changes will let KVM use huge pages with
> dax-backed files.  Without the PageReserved change, KVM and DAX still
> work with these patches, simply without huge pages - which is the
> current situation.
>
> RFC/discussion thread:
> https://lore.kernel.org/lkml/20181029210716.212159-1-brho@google.com/
>
> v1 -> v2:
> https://lore.kernel.org/lkml/20181109203921.178363-1-brho@google.com/
>
> - Updated Acks/Reviewed-by
> - Minor touchups
> - Added patch to remove redundant PageReserved() check
> - Rebased onto linux-next
>
>
> Barret Rhoden (3):
>   mm: make dev_pagemap_mapping_shift() externally visible
>   kvm: Use huge pages for DAX-backed files
>   kvm: remove redundant PageReserved() check
>
>  arch/x86/kvm/mmu.c  | 33 +++++++++++++++++++++++++++++++--
>  include/linux/mm.h  |  3 +++
>  mm/memory-failure.c | 38 +++-----------------------------------
>  mm/util.c           | 34 ++++++++++++++++++++++++++++++++++
>  virt/kvm/kvm_main.c |  8 ++------
>  5 files changed, 73 insertions(+), 43 deletions(-)
>
> --
> 2.19.1.1215.g8438c0b245-goog
>
