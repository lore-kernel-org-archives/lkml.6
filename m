Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2A5C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786C62184B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dCs2TV6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbfBEXLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:11:23 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41610 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfBEXLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:11:22 -0500
Received: by mail-ua1-f66.google.com with SMTP id z24so1695470ual.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 15:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j5HkeUNThkthwBCR68NpvhUFgzSA/PWSkaEL6oAA0so=;
        b=dCs2TV6EswhYsGkHxXzoSizgamWNzyDPKTFsrF49nST+zEYbx0JwJuzXLVJUYEZwvr
         7lVHaP1Lg7vK7yuvorPST5mQnpxnP+llLDllFTvTPx8hEcj3yR4tEZ8DF91McZPJgyZo
         KVVaFiAHY3uI/piyeDdrK77bf9cvuloW7CAHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j5HkeUNThkthwBCR68NpvhUFgzSA/PWSkaEL6oAA0so=;
        b=LoKcQGdOtnquinQzvmce8r5/kmO8011Bn3+DsN+SiFx0QFoiaHJNOy/M/o5xHjZ+oF
         NI+fg/9B/U6wcp5LH7Ym3Ps3XMl5CwhHzBB0eEmJLGvz77M6aoGrkYFfpKLUdnP+IXpl
         kouQIch88xRR2R5Uu4krEwB/IgS97pMMRAW8ZWJgQOiatSK7MsRsaLJjoldckuFcsPSx
         Qzx3387eLzxqEpaX+AAzR2YRJo0ZJfD56SRYgsR+rhoNSDW3V5TLUP4WlmCEd7XFw3fH
         0kRPrwKx+ussQtyLU9mIMZ8l8YwMbhehqcq5ixVr1RLUfFFWOZFPk91GMgeuJxYYh3WJ
         pq/Q==
X-Gm-Message-State: AHQUAuZh2brY0tvEzQKqUpUF+wTyKizEgpNKS+LDKuUzYn9/efQfCNZn
        1hCmpTqvuhZ6Dko6M0HMIlh4iTcRqvk=
X-Google-Smtp-Source: AHgI3IajYk0PbjKmoPw+hj1uKY2zPC3keu+db8ypB8RYHovr+usuyW0q3tGSZTGSWeL7/Ohq6XDJnQ==
X-Received: by 2002:a9f:35f1:: with SMTP id u46mr2869936uad.136.1549408280554;
        Tue, 05 Feb 2019 15:11:20 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id n206sm23499791vkn.36.2019.02.05.15.11.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 15:11:19 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id z3so3293778vsf.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 15:11:18 -0800 (PST)
X-Received: by 2002:a67:e15e:: with SMTP id o30mr3333598vsl.66.1549408278541;
 Tue, 05 Feb 2019 15:11:18 -0800 (PST)
MIME-Version: 1.0
References: <154899811208.3165233.17623209031065121886.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154899811738.3165233.12325692939590944259.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190205140415.544ae2876ee44e6edb8ca743@linux-foundation.org>
In-Reply-To: <20190205140415.544ae2876ee44e6edb8ca743@linux-foundation.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 5 Feb 2019 23:11:06 +0000
X-Gmail-Original-Message-ID: <CAGXu5jJJQq358_H=xAcf=17WixnFx-P6HqTuv8uQn2zGgNg3Fw@mail.gmail.com>
Message-ID: <CAGXu5jJJQq358_H=xAcf=17WixnFx-P6HqTuv8uQn2zGgNg3Fw@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] mm: Shuffle initial free memory to improve
 memory-side-cache utilization
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 10:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 31 Jan 2019 21:15:17 -0800 Dan Williams <dan.j.williams@intel.com> wrote:
>
> > +config SHUFFLE_PAGE_ALLOCATOR
> > +     bool "Page allocator randomization"
> > +     default SLAB_FREELIST_RANDOM && ACPI_NUMA
> > +     help
>
> SLAB_FREELIST_RANDOM is default n, so this patchset won't get much
> runtime testing.
>
> How about you cook up a (-mm only) patch which makes the kernel default
> to SLAB_FREELIST_RANDOM=y, SHUFFLE_PAGE_ALLOCATOR=y (or whatever) to
> ensure we get a decent amount of runtime testing?  Then I can hold that
> in -mm (and -next) until we get bored of it?

I love this plan. :)

FWIW, distros have enabled it by default for a while. Here's Ubuntu,
for example:

$ grep SLAB_FREELIST /boot/config-4.1*
/boot/config-4.15.0-45-generic:CONFIG_SLAB_FREELIST_RANDOM=y
/boot/config-4.15.0-45-generic:CONFIG_SLAB_FREELIST_HARDENED=y
/boot/config-4.18.0-13-generic:CONFIG_SLAB_FREELIST_RANDOM=y
/boot/config-4.18.0-13-generic:CONFIG_SLAB_FREELIST_HARDENED=y
/boot/config-4.18.0-14-generic:CONFIG_SLAB_FREELIST_RANDOM=y
/boot/config-4.18.0-14-generic:CONFIG_SLAB_FREELIST_HARDENED=y

and Fedora too:

$ curl -s 'https://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/fedora.git/patch/fedora/configs/kernel-4.16.12-x86_64.config?h=f26'
| grep SLAB_FREELIST
+CONFIG_SLAB_FREELIST_RANDOM=y
+CONFIG_SLAB_FREELIST_HARDENED=y

-- 
Kees Cook
