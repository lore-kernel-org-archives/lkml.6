Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36213ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F4B21526
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/HMv4PL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F4B21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732589AbeISVVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:21:51 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41374 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732294AbeISVVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:21:51 -0400
Received: by mail-qt0-f195.google.com with SMTP id t39-v6so5501953qtc.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 08:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VGWw9HuZ8iPcfWRq4OOcD5x0N4s4FQYplacHpVzd58U=;
        b=p/HMv4PLv2313a4WuGzZcCwffTmu9cV4Y4PvJ0qHeL4qyBEEeJxKscqxzN7WPUWRdu
         GdNFzuBzqDCgNNOFEJr3LbarvdkpJ6+572TFRQKl4MW3N9SX+BRNHUp2McisOBUOx9pJ
         UXVDWeinLHDktYGJ0skAW0F2DWZymHLgiEmXvx4/kgjFD7LUc7VQ0vER/bPgwNkF+VA1
         uZ/iV9tOqamUPqpRgFFhSBMn5eOG3d8ulTu3xxT3Le7UGEZMna0xgSZ8PsQMDAxN9UUS
         rdsDCuCaW+hoS9nOk2U/7/cpPoAiYF49Dz9RNbo/q5i+yvvLC8Jp4uY8VHWnc0AxAtch
         WHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VGWw9HuZ8iPcfWRq4OOcD5x0N4s4FQYplacHpVzd58U=;
        b=oznlZBspFMyDDbZg8yPcbJYpEpA2A7yop78XOOK/ISqEFs18N32jrOdBj5h9bZ6COa
         Pzom6Nl3ofQBaGyVWHRahP+N+nTFhf0Oq/hAyPVkFxAjpuCK+UmbI9H/9gUwQILxz8Gt
         +Qc3sjC2G1GMT5PDb/6dA1unY1loGdEKrR/UIentVu8hYvBVXE3zey3y4rZsCO5R/V9r
         dwGBahIbagXiRqZRoWnceA62qjxRwndD2DjMlqTGVdFgjF9sc3v81fc0MtFWZT2fdmDz
         0748PBlRF7phBDMZfNBQPJqT+CTyWt+ovagQbDH9NYQjqphEX/6NuuWS06s8Rlk/L7Ny
         bENw==
X-Gm-Message-State: APzg51Dd/NuCVgKHSjBeA/9jCbblXv8DbaBdrbSppaqJH1NNts+AdRww
        hkbDKFWuPzJ6mK9sK2uUOVI3vtmJa/37M8MbDZjq
X-Google-Smtp-Source: ANB0VdajjuquHm4q3O9dN2UiuEM0rg/UP0BNMH69c6fa39TB0n+FBwxwg1itw31RoExDdGhuuKZg+HSln/9JShufWP8=
X-Received: by 2002:aed:26e7:: with SMTP id q94-v6mr25426949qtd.37.1537371799009;
 Wed, 19 Sep 2018 08:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180820212556.GC2230@char.us.oracle.com> <CA+55aFxZCyVZc4ZpRyZ3uDyakRSOG_=2XvnwMo4oejpsieF9=A@mail.gmail.com>
 <1534801939.10027.24.camel@amazon.co.uk> <20180919010337.GC8537@350D>
In-Reply-To: <20180919010337.GC8537@350D>
From:   Jonathan Adams <jwadams@google.com>
Date:   Wed, 19 Sep 2018 08:43:07 -0700
Message-ID: <CA+VK+GM6CaPnGKcPjEn7U=4ubtC-JWZ9k98BTxzRH_TthaFXDw@mail.gmail.com>
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
To:     bsingharora@gmail.com
Cc:     dwmw@amazon.co.uk, torvalds@linux-foundation.org,
        konrad.wilk@oracle.com, deepa.srinivasan@oracle.com,
        Jim Mattson <jmattson@google.com>, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        linux-mm@kvack.org, tglx@linutronix.de, joao.m.martins@oracle.com,
        pradeep.vincent@oracle.com, ak@linux.intel.com,
        khalid.aziz@oracle.com, kanth.ghatraju@oracle.com,
        liran.alon@oracle.com, keescook@google.com,
        jsteckli@os.inf.tu-dresden.de, kernel-hardening@lists.openwall.com,
        chris.hyser@oracle.com, tyhicks@canonical.com,
        john.haxby@oracle.com, jcm@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(apologies again; resending due to formatting issues)
On Tue, Sep 18, 2018 at 6:03 PM Balbir Singh <bsingharora@gmail.com> wrote:
>
> On Mon, Aug 20, 2018 at 09:52:19PM +0000, Woodhouse, David wrote:
> > On Mon, 2018-08-20 at 14:48 -0700, Linus Torvalds wrote:
> > >
> > > Of course, after the long (and entirely unrelated) discussion about
> > > the TLB flushing bug we had, I'm starting to worry about my own
> > > competence, and maybe I'm missing something really fundamental, and
> > > the XPFO patches do something else than what I think they do, or my
> > > "hey, let's use our Meltdown code" idea has some fundamental weakness
> > > that I'm missing.
> >
> > The interesting part is taking the user (and other) pages out of the
> > kernel's 1:1 physmap.
> >
> > It's the *kernel* we don't want being able to access those pages,
> > because of the multitude of unfixable cache load gadgets.
>
> I am missing why we need this since the kernel can't access
> (SMAP) unless we go through to the copy/to/from interface
> or execute any of the user pages. Is it because of the dependency
> on the availability of those features?
>
SMAP protects against kernel accesses to non-PRIV (i.e. userspace)
mappings, but that isn't relevant to what's being discussed here.

Davis is talking about the kernel Direct Map, which is a PRIV (i.e.
kernel) mapping of all physical memory on the system, at
  VA = (base + PA).
Since this mapping exists for all physical addresses, speculative
load gadgets (and the processor's prefetch mechanism, etc.) can
load arbitrary data even if it is only otherwise mapped into user
space.

XPFO fixes this by unmapping the Direct Map translations when the
page is allocated as a user page. The mapping is only restored:
   1. temporarily if the kernel needs direct access to the page
      (i.e. to zero it, access it from a device driver, etc),
   2. when the page is freed

And in so doing, significantly reduces the amount of non-kernel data
vulnerable to speculative execution attacks against the kernel.
(and reduces what data can be loaded into the L1 data cache while
in kernel mode, to be peeked at by the recent L1 Terminal Fault
vulnerability).

Does that make sense?

Cheers,
- jonathan
