Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40782C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C012080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="FFyvgiOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C012080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbeKTKOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:14:53 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40987 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731972AbeKTKOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:14:53 -0500
Received: by mail-oi1-f195.google.com with SMTP id j21so57230oii.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 15:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wygiTZLWq10D2HnpFa23pd0KZJ6w+iznzVW5St01Fd0=;
        b=FFyvgiOevLSyLiSpUb4j4ve5g5W2vcYCIFn0z5Uw+E37uHodpiEDMPMhUs8ISHiZuz
         dZQuhKIYI/S2s+qVGo7v5DF5OxRLjhLviiobmutVsiSICaAZwZzNys8so56it6hDXMCa
         T5vY75mzk+dSsTyQ0amrFfbplNYq2ujtwjCSkX/3vO500WCd1/n7TwwxJo57IR20WmZI
         eEP+Q/gwEZ59lk7mVC3cV5RxQK2LrHYnFvu3LFiU8Fymx51vGE4NIZKbyGOHjoCVyRfR
         y6EO9NgPWqYwU2Z2UeWwgOVCzwEjLVkAgabIgy9cMWJTgiT3ovCrqNr6NOgQ4vcU4EvQ
         zbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wygiTZLWq10D2HnpFa23pd0KZJ6w+iznzVW5St01Fd0=;
        b=X7fX6bIYnLmJxe8zxSWirZ/7CN4N+izblsaXOMHSxpQqKa9TITNRtYqE8Moz8tNUV8
         eJcURy70Ky3wMIJ0T5lzqkC4mwdSs5g5uP882AV8Q8w1CJrLVFPnXSv6QWFdmQgK6AeD
         xxHg1jnZo/T8HmhZrnERVLkIen3ZQdnJTopFOLOnOxunhvM5olv9OriBZLADVuQgGQQW
         d3HRBWsYu2hypXZvlKxYz9ME0ey5svKg+MBhyVMd0n/ap/Q7AAzgyMsBDje8LS1lJmmv
         8y1CthAHdIhRYFvoLNtGDz95LxXsLq4nWqIlzvgZW0wckuXOhUZ1FSWWiTtxPcV9+ygP
         OR5A==
X-Gm-Message-State: AGRZ1gISRbUGx761IwlKHd9D5sXh23l4bgmrmErjv+qH+DbWJP2s3qu3
        kJe8sJxqpDwfU8KxixLS2fp+qhJ+dBHhX67KN3A+FA==
X-Google-Smtp-Source: AJdET5c4/EDZ9SFQ0Rk4kmk7iIwje4ZmMQtB2bnC5uE5YogY2Ufq+02Ok4TIgzXJdbhtxNhrO7nOfrojYOigXNqRfoQ=
X-Received: by 2002:aca:2dc8:: with SMTP id t191mr7990882oit.235.1542671324617;
 Mon, 19 Nov 2018 15:48:44 -0800 (PST)
MIME-Version: 1.0
References: <154266954452.2939184.974606608701109493.stgit@dwillia2-desk3.amr.corp.intel.com>
 <279dadae-9148-465c-7ec6-3f37e026c6c9@intel.com>
In-Reply-To: <279dadae-9148-465c-7ec6-3f37e026c6c9@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 19 Nov 2018 15:48:33 -0800
Message-ID: <CAPcyv4iuRMJjEKutcvRSFjpiy8N27jggUQA-uWd3q7Gopa=xFg@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Drop usage of __flush_tlb_all() in kernel_physical_mapping_init()
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        stable <stable@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 3:43 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 11/19/18 3:19 PM, Dan Williams wrote:
> > Andy wondered why a path that can sleep was using __flush_tlb_all() [1]
> > and Dave confirmed the expectation for TLB flush is for modifying /
> > invalidating existing pte entries, but not initial population [2].
>
> I _think_ this is OK.
>
> But, could we sprinkle a few WARN_ON_ONCE(p*_present()) calls in there
> to help us sleep at night?

Makes sense, I'll add those for v2.
