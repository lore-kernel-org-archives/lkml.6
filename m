Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3927EC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCAA820846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtb16NRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCAA820846
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933344AbeFTVWA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 17:22:00 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52768 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933092AbeFTVV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 17:21:59 -0400
Received: by mail-it0-f65.google.com with SMTP id m194-v6so1725199itg.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 14:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XG29ekBSSXhcQEmjNhRSuxxGXBbmxiwvPWXSPfxAbQE=;
        b=jtb16NRNpUaIlqFLptRivFVywuF8K8FIVbB+ZZuGJYYxFwN7M2NiVScn9w8y4qSxhG
         Rlu8Ozz+xnEGBpNubBB+8CoHEn2CeAAhHx6bixW8H25+PfkshWCSevPYDjS0UvNo532J
         Q+yB9po0wbf6TWlq739qZDCFRwXRRDsU3TU49IXnzarj2TvT6FBu52RBjAd5GxYLtbeL
         z5ojx3NXPtjWZLZMF7czKIzsiI+bbXhCM4fVfkoyPEQIgTBeyRa784moXA2mBSM0ZAuT
         mqmuX6UgYgVoOi0O70wSt+45RuNOhDhvpRLEpZOeBkdB58RZDoYeitX83YX+vUfLrIxX
         B6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XG29ekBSSXhcQEmjNhRSuxxGXBbmxiwvPWXSPfxAbQE=;
        b=kGOuDlhY0V43MtdZrVRq1mLtT4GWdxG3vL7V0u/AICyAJTxGKBvrVHrEosBALDKwMA
         R5yEgOaDaUlVlKrnjZA7yQx4YJsWC7fxQRj52BiL9x4h7t78koLPZ1L4WpPYojCgT4bt
         LpAddQqHjp31njlzNWIfe1lUI+rwQ2MRmR3PbGZp513zizP/Izny8zOGGoD+aGFrL7Mw
         QntAZB6NlDpUDpHmt0AX6duleZvo48SNiqob0qM2HtzKsxfsKn057pxbgYSepF8tHcjk
         4i3ltPd/ZkbHm7uUsExsiEmZJKU3ngluhH7SrHFtH+jM4H/SGj4DRWYfPIG9ZpxYsAZF
         XidQ==
X-Gm-Message-State: APt69E1SSjBM0YisQAiZ7JD0vdKbDsfqRrqohmSamdMXq5dzfMnnJHpy
        L1rjY/sNtX6ksHjBdnkaquRnWgZOE1VX81MfQSJ22bptLEs=
X-Google-Smtp-Source: ADUXVKJhWfmPaBsfeUf4uPxPlOV1z0M2368jDawaJxXokDW1Z3WR36jP2OE+rNJmS4hk9kh503R/5l6+6pTiG2TxDqE=
X-Received: by 2002:a24:3cd7:: with SMTP id m206-v6mr2909540ita.113.1529529718524;
 Wed, 20 Jun 2018 14:21:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:8f86:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 14:21:57
 -0700 (PDT)
In-Reply-To: <20180620043200.GA10888@joelaf.mtv.corp.google.com>
References: <20180620005735.219840-1-astrachan@google.com> <20180620005735.219840-2-astrachan@google.com>
 <20180620043200.GA10888@joelaf.mtv.corp.google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 20 Jun 2018 14:21:57 -0700
Message-ID: <CAKOZuetoYikhAz1c6NuaVjeU_E58hbH7wMsDUKCYWqb63ESPeA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] staging: android: ashmem: Fix mmap size validation
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alistair Strachan <astrachan@google.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>, devel@driverdev.osuosl.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 9:32 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Tue, Jun 19, 2018 at 05:57:35PM -0700, Alistair Strachan wrote:
> > The ashmem driver did not check that the size/offset of the vma passed
> > to its .mmap() function was not larger than the ashmem object being
> > mapped. This could cause mmap() to succeed, even though accessing parts
> > of the mapping would later fail with a segmentation fault.
> >
> > Ensure an error is returned by the ashmem_mmap() function if the vma
> > size is larger than the ashmem object size. This enables safer handling
> > of the problem in userspace.

Are we sure that this approach is a good idea? You can over-mmap
regular files. I don't like the idea of creating special mmap
semantics for files that happen to be ashmem files. Ashmem users can
detect size-changing shenanigans with ASHMEM_GET_SIZE after mmap,
since an ashmem file's size can't change after an mmap call succeeds.
