Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2321C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5383A2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="s0YyaMn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5383A2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeJEAI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:08:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43969 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeJEAI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:08:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id s69-v6so8099061oie.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 10:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hkxKZDx2XaCUl22nZKcEHGCukcljJfLhaxcpqlpD/w=;
        b=s0YyaMn1GP9aA3A3znsLf9PzVhUcqXNN4Od8TjoBFHhjJVVJkVA0E8KhHSQC9ZlX5g
         v/cLUQgif3vPMQpkPB/pxeawFRyb2J3TqaqhXeNwFeK/HLKYF0Su/PpzM/aJtD5YpxKA
         KMLt+I3SfHPQY3k0nZLpXI99aKZ6ymkYopzw5oNd8fdYLFts+B8XrII+rWDCAu/5YbD6
         5h5CjiWN/YT1CUZkGrOR+VPYkfhdzbhA91WwEsw1yMNoxPBJ2B2o46J5R4degELFtJh7
         DXIjl3dkEMWJj4DyNpkzG5ZbsibfnpLutAxqChJZQf9FV90n2tyExGKwVYMZHJHBR0Vp
         +xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hkxKZDx2XaCUl22nZKcEHGCukcljJfLhaxcpqlpD/w=;
        b=obXjcLrFXThHFAgdv1MyDgU6BVQnrWSv8RemaEjcFA6oH2BKBdRXadjvUColdnlSjN
         TFxZjJR5LhDz3hw7N3QbWy4VawiGUcDv2fPxf7YbIKzQbXO+oa/u+rHraEKAJkR8FoI4
         7M1QpjH62J8JdKPgGN5M9waTIQ1FAYWaCZ7xAQBkAIgaIX+4zxkYIAjGwEbpPOLIC7UY
         H+ACREzxMONUsIwXmdoVxgey0aHEb5iPAJ5fBvU5JaYf6TN38K/Ioe3qSVilJhQMoQ95
         pssr8+Vb8XEaXPhrgo9LWSWFcOqYe17j58SKH6VXD7qa1iizjaD/fKEhYPWtczmtX8MB
         IlRQ==
X-Gm-Message-State: ABuFfoiWlhjO4BpeKkv1kJJjA7lYeqSUQjmdg0LLNJNCweCqI/93ZTwA
        02vmkaD5rpn4qoZ/JCiZaiuTUfeGS8xFYQ0ic0Ye5w==
X-Google-Smtp-Source: ACcGV627Xrwlxl8d5A711uNHDCSslFSo9cFO49lsqq2hYK5xsggDYcw8IEWoOIZ00EPdzca1FA/QMPxiYkvYJg8O7Rs=
X-Received: by 2002:aca:4792:: with SMTP id u140-v6mr3750482oia.215.1538671908198;
 Thu, 04 Oct 2018 09:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <153861931865.2863953.11185006931458762795.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153861932401.2863953.11364943845583542894.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181004074838.GE22173@dhcp22.suse.cz>
In-Reply-To: <20181004074838.GE22173@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 4 Oct 2018 09:51:37 -0700
Message-ID: <CAPcyv4jO_K8g3XRzuYOQPeGT--aPtucwZsqkywxOFO4Zny5Xrg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm: Shuffle initial free memory
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 12:48 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 03-10-18 19:15:24, Dan Williams wrote:
> > Some data exfiltration and return-oriented-programming attacks rely on
> > the ability to infer the location of sensitive data objects. The kernel
> > page allocator, especially early in system boot, has predictable
> > first-in-first out behavior for physical pages. Pages are freed in
> > physical address order when first onlined.
> >
> > Introduce shuffle_free_memory(), and its helper shuffle_zone(), to
> > perform a Fisher-Yates shuffle of the page allocator 'free_area' lists
> > when they are initially populated with free memory at boot and at
> > hotplug time.
> >
> > Quoting Kees:
> >     "While we already have a base-address randomization
> >      (CONFIG_RANDOMIZE_MEMORY), attacks against the same hardware and
> >      memory layouts would certainly be using the predictability of
> >      allocation ordering (i.e. for attacks where the base address isn't
> >      important: only the relative positions between allocated memory).
> >      This is common in lots of heap-style attacks. They try to gain
> >      control over ordering by spraying allocations, etc.
> >
> >      I'd really like to see this because it gives us something similar
> >      to CONFIG_SLAB_FREELIST_RANDOM but for the page allocator."
> >
> > Another motivation for this change is performance in the presence of a
> > memory-side cache. In the future, memory-side-cache technology will be
> > available on generally available server platforms. The proposed
> > randomization approach has been measured to improve the cache conflict
> > rate by a factor of 2.5X on a well-known Java benchmark. It avoids
> > performance peaks and valleys to provide more predictable performance.
> >
> > While SLAB_FREELIST_RANDOM reduces the predictability of some local slab
> > caches it leaves vast bulk of memory to be predictably in order
> > allocated. That ordering can be detected by a memory side-cache.
> >
> > The shuffling is done in terms of 'shuffle_page_order' sized free pages
> > where the default shuffle_page_order is MAX_ORDER-1 i.e. 10, 4MB this
> > trades off randomization granularity for time spent shuffling.
> > MAX_ORDER-1 was chosen to be minimally invasive to the page allocator
> > while still showing memory-side cache behavior improvements.
> >
> > The performance impact of the shuffling appears to be in the noise
> > compared to other memory initialization work. Also the bulk of the work
> > is done in the background as a part of deferred_init_memmap().
>
> This is the biggest portion of the series and I am wondering why do we
> need it at all. Why it isn't sufficient to rely on the patch 3 here?

In fact we started with only patch3 and it had no measurable impact on
the cache conflict rate.

> Pages freed from the bootmem allocator go via the same path so they
> might be shuffled at that time. Or is there any problem with that?
> Not enough entropy at the time when this is called or the final result
> is not randomized enough (some numbers would be helpful).

So the reason front-back randomization is not enough is due to the
in-order initial freeing of pages. At the start of that process
putting page1 in front or behind page0 still keeps them close
together, page2 is still near page1 and has a high chance of being
adjacent. As more pages are added ordering diversity improves, but
there is still high page locality for the low address pages and this
leads to no significant impact to the cache conflict rate. Patch3 is
enough to keep the entropy sustained over time, but it's not enough
initially.
