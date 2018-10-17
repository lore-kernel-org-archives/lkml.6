Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56459ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187FA2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="xr1YQCTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187FA2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeJRA1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:27:39 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43620 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeJRA1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:27:38 -0400
Received: by mail-oi1-f196.google.com with SMTP id s69-v6so21555331oie.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 09:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6OJQa0b0+5Rqnwd0TW3Zw2yzTH2CaznLfLuu3nTkEI=;
        b=xr1YQCTZh9774kzqSNu0Zqtkfz43bxu0otbfO6Jp/7oOX24K1TCHnN9jGB2Gys2kiF
         SSy6fGz/LA/4+jIXg46JhaMl3bjdXyP8hFvUQFQq2WtwTxiRiFTzCr8jO0XXwCvZoo7D
         HEjI/9oruv/4BnbBO8bcvf5TdMLNZ8O8+jknqrYUtJmYcJHjw0McI9gHnYlU6Go+QTqI
         vA4zvksWdA3YiJkqpVZutZ8Yx+CXX52eken1h6dh0DzHz8Nrs2Ul6iB2Fo92h7CTShcR
         FC75ESuZmLkzM7tDOnycjzwPm+U1F/2fLvEqN9t99dhFxDvYeiQPGTD10cEnHg2WX6Ap
         ctfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6OJQa0b0+5Rqnwd0TW3Zw2yzTH2CaznLfLuu3nTkEI=;
        b=LBOxwToIkiplrzC5MtTVBoIXQ4dcrL7vs8uzLAqkQURJuE0W0o1PDwSbqAR7mUA8aD
         DxOSQTTMp0/zpZf8bTCm9DUeejbdZGv/+JRp4uzvGkkPWxUQOx2CT99s837tbpmS8cJa
         V5jZy0rx0+Zu7lB71oc08bjdj9Nk0opE1shdFAjpkOdw64b/x5q06RWzzOfcmkgWbfm+
         v4erX8tx+XkgD9LdpVy0l4lYLCnqTYrdClMdZac5Xbbk8ThwY/XJPfmyMWCBtsBWvF3s
         Ave8XLtbPIzqSBEHoLJ2uovH3dlTI8DmK17k3PTtBGqh0SIf7qH+yjs/9oTafcdLEx1g
         DDSA==
X-Gm-Message-State: ABuFfojfOyg3s0igyBHb18ber14qRpJ1g1lbWkzfonizF6ZTfaQ5VLdP
        JTvHkVe0vjAMx9VKaMQbk2wyZIsyCWmAbS4Rok8r3w==
X-Google-Smtp-Source: ACcGV62MgGY08JiN0RDvo1M/wirvopR7NBsdu8OyeGsCHIbYFlgUCSxa1TwEitZf3zbd5k56PmL46u0i/70OyrBAWhE=
X-Received: by 2002:a54:4516:: with SMTP id l22-v6mr14893537oil.0.1539793869815;
 Wed, 17 Oct 2018 09:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <153936657159.1198040.4489957977352276272.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153936657702.1198040.119388737535638846.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181017081753.GG18839@dhcp22.suse.cz>
In-Reply-To: <20181017081753.GG18839@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 17 Oct 2018 09:30:58 -0700
Message-ID: <CAPcyv4hMFQYekvZWMzKYckuVLSGd3GizRtoDudFBQj5bfxD3Mw@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] mm, devm_memremap_pages: Mark devm_memremap_pages()
 EXPORT_SYMBOL_GPL
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 1:18 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 12-10-18 10:49:37, Dan Williams wrote:
> > devm_memremap_pages() is a facility that can create struct page entries
> > for any arbitrary range and give drivers the ability to subvert core
> > aspects of page management.
> >
> > Specifically the facility is tightly integrated with the kernel's memory
> > hotplug functionality. It injects an altmap argument deep into the
> > architecture specific vmemmap implementation to allow allocating from
> > specific reserved pages, and it has Linux specific assumptions about
> > page structure reference counting relative to get_user_pages() and
> > get_user_pages_fast(). It was an oversight and a mistake that this was
> > not marked EXPORT_SYMBOL_GPL from the outset.
>
> One thing is still not clear to me. Both devm_memremap_* and
> hmm_devmem_add essentially do the same thing AFAICS. They both allow to
> hotplug a device memory. Both rely on the hotplug code (namely
> add_pages) which itself is not exported to modules. One is GPL only
> while the later is a general export. Is this mismatch desirable?

That is resolved by the last patch in this series.

> API exported by the core hotplug is ad-hoc to say the least. Symbols
> that we actually export are GPL mostly (only try_offline_node is
> EXPORT_SYMBOL without any explanation whatsoever). So I would call it a
> general mess tweaked for specific usecases.
>
> I personally do not care about EXPORT_SYMBOL vs. EXPORT_SYMBOL_GPL
> much to be honest. I understand an argument that we do not care about
> out-of-tree modules a wee bit. I would just be worried those will find a
> way around and my experience tells me that it would be much uglier than
> what the core kernel can provide. But this seems more political than
> technical discussion.

I'm not worried about people finding a way around, I'm sure
cringe-worthy workarounds of core kernel details happen on a regular
basis in out-of-tree code. EXPORT_SYMBOL_GPL in this instance is not a
political statement, it is a statement of the rate of evolution and
depth of the api.

>
> > Again, devm_memremap_pagex() exposes and relies upon core kernel
> > internal assumptions and will continue to evolve along with 'struct
> > page', memory hotplug, and support for new memory types / topologies.
> > Only an in-kernel GPL-only driver is expected to keep up with this
> > ongoing evolution. This interface, and functionality derived from this
> > interface, is not suitable for kernel-external drivers.
>
> I do not follow this line of argumentation though. We generally do not
> care about out-of-tree modules and breaking them if the interface has to
> be updated.

Exactly right. The EXPORT_SYMBOL_GPL is there to say that this api has
deep enough ties into the core kernel to lower the confidence that the
API will stay stable from one kernel revision to the next. It's also
an api that is attracting widening and varied reuse and the long term
health of the implementation depends on being able to peer deeply into
its users and refactor the interface and the core kernel as a result.

> Also what about GPL out of tree modules?

These are precisely the modules we want upstream.

> That being said, I do not mind this patch. You and Christoph are the
> authors and therefore it is you to decide. I just find the current
> situation confusing to say the least.

Hopefully I clarified, let me know if not.
