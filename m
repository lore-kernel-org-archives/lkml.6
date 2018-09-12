Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EACC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BF420833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZpiWAny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BF420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeILVmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:42:09 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50335 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbeILVmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:42:09 -0400
Received: by mail-it0-f68.google.com with SMTP id j81-v6so3939978ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/bJ73c+xI6X7i5kSTbLBmWNZjqAzwfkXU5+ik834+yA=;
        b=OZpiWAnyNrDhvCQ+IGb0f8aMzNpMwJztoUxP6gWGqXkG/8sYI+x2WVS/O6vnX8ak94
         ZVRoUzA8pnRYfVTfpDkFyExy1TpEO2+xxjtxjzqx7yvr2HwLUpgcgAeFFSwl7h1Qqc2h
         rJ8ZhtplpHG22MD7HdyJX9dps/JbVOFd0CKE+BWQQYdB2GqtZaupZ+N/odDFz88kLEVT
         pMLlHAUF4tWCtgidXV6enZmLWVq7g0TTEBbuylXkwGv13HNZqYIUIND7NV8/ey6Gl74K
         LtDTWRmQX+iCIzIIqmTxSVjcIA39UePejFzD38U0L/KCJ6HsB0UPYqXyBjGuqYi2bJKg
         YNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/bJ73c+xI6X7i5kSTbLBmWNZjqAzwfkXU5+ik834+yA=;
        b=Q2uuId5btA4mDCznjqKui612NG25h0U+yLn5mlfkfAewv81YzHn8lD+MAZH86ZgFTt
         pSXTGhthFy1NML/+LbmXw4hfOLIpOlp3Yclfbk5YlthDuF009z5ZuW/4WukkpouPT2Rx
         uH1cIlAcsPVtzbqIhBJYmBLdTX6hzMzLt3a8p41t/Jo/Nv1ka2BXFIti8BOHCVkuVkET
         nK+8c+O+nURaP6AnbtwpN/G71gvW5WZVxPtH0cGDHYA+0hJxrtcopYkgA6C/8Fz4o8VA
         0tNkcpfoUO5NxRepw6384nq/mQM0BNPMjQQXHKEg0YUdaw0RUzp/uncfSvwKfJzddkkc
         cJ+w==
X-Gm-Message-State: APzg51CNUPvZZprUn7IGKG5+dKG//Rrz9ZCM8FCbnXUdpAqrWXkQmiFs
        xSfVm54FaAtFsNwdQNTLGeQCL6gJtao8szfGJAM=
X-Google-Smtp-Source: ANB0VdaApQIlY3jag8Fi5cvUAbQjMJELoS9AIZdVYLxJBHmJhFY451ktt29lz8LMRM/Wm4bFOy4hLG4piWGPuPe4jYE=
X-Received: by 2002:a24:c2c2:: with SMTP id i185-v6mr2927677itg.76.1536770208874;
 Wed, 12 Sep 2018 09:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180910232615.4068.29155.stgit@localhost.localdomain>
 <20180910234341.4068.26882.stgit@localhost.localdomain> <20180912141053.GL10951@dhcp22.suse.cz>
 <CAKgT0UdvhV7U5Zniq=KskXz2QsRP8C7ctr5=ZtJwYAVpBT-RHw@mail.gmail.com> <841e8101-40db-9ff2-f688-5f175d91fc31@intel.com>
In-Reply-To: <841e8101-40db-9ff2-f688-5f175d91fc31@intel.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 12 Sep 2018 09:36:37 -0700
Message-ID: <CAKgT0UeKnaY4XebOmtGozbjEJN4k3cwyhdBLPPJLc677-QU+Sw@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Provide kernel parameter to allow disabling page
 init poisoning
To:     Dave Hansen <dave.hansen@intel.com>, mhocko@kernel.org,
        pavel.tatashin@microsoft.com, dan.j.williams@intel.com
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm@lists.01.org, dave.jiang@intel.com,
        Ingo Molnar <mingo@kernel.org>, jglisse@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>, logang@deltatee.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 8:25 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 09/12/2018 07:49 AM, Alexander Duyck wrote:
> >>> +     page_init_poison=       [KNL] Boot-time parameter changing the
> >>> +                     state of poisoning of page structures during early
> >>> +                     boot. Used to verify page metadata is not accessed
> >>> +                     prior to initialization. Available with
> >>> +                     CONFIG_DEBUG_VM=y.
> >>> +                     off: turn off poisoning
> >>> +                     on: turn on poisoning (default)
> >>> +
> >> what about the following wording or something along those lines
> >>
> >> Boot-time parameter to control struct page poisoning which is a
> >> debugging feature to catch unitialized struct page access. This option
> >> is available only for CONFIG_DEBUG_VM=y and it affects boot time
> >> (especially on large systems). If there are no poisoning bugs reported
> >> on the particular system and workload it should be safe to disable it to
> >> speed up the boot time.
> > That works for me. I will update it for the next release.
>
> FWIW, I rather liked Dan's idea of wrapping this under
> vm_debug=<something>.  We've got a zoo of boot options and it's really
> hard to _remember_ what does what.  For this case, we're creating one
> that's only available under a specific debug option and I think it makes
> total sense to name the boot option accordingly.
>
> For now, I think it makes total sense to do vm_debug=all/off.  If, in
> the future, we get more options, we can do things like slab does and do
> vm_debug=P (for Page poison) for this feature specifically.
>
>         vm_debug =      [KNL] Available with CONFIG_DEBUG_VM=y.
>                         May slow down boot speed, especially on larger-
>                         memory systems when enabled.
>                         off: turn off all runtime VM debug features
>                         all: turn on all debug features (default)

This would introduce a significant amount of code change if we do it
as a parameter that has control over everything.

I would be open to something like "vm_debug_disables=" where we could
then pass individual values like 'P' for disabling page poisoning.
However doing this as a generic interface that could disable
everything now would be messy. I could then also update the print
message so that it lists what is disabled, and what was left enabled.
Then as we need to disable things in the future we could add
additional letters for individual features. I just don't want us
preemptively adding control flags for features that may never need to
be toggled.

I would want to hear from Michal on this before I get too deep into it
as he seemed to be of the opinion that we were already doing too much
code for this and it seems like this is starting to veer off in that
direction.

- Alex
