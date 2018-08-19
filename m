Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ABAC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 05:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637AD215EB
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 05:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="bR07Rq9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637AD215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeHSITT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 04:19:19 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55832 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeHSITT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 04:19:19 -0400
Received: by mail-it0-f66.google.com with SMTP id d10-v6so16481550itj.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 22:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1XsHtSspreRn+8La8y2Qrz0Yl5hoZv7Msw/9Dhh58Cs=;
        b=bR07Rq9OTcQ3Mmhw9iJ2giaeMHHaUGE0YhCfcP91B2W2K09DZVUKDo0b8YmIj62zdq
         AufqqffoPr/b9eiWtUcJ8hBLCDrzmd6CXpmzP+UC4w/mCNTRWdAuFyk++mW7MN8H3AV4
         hc9robsYhkYJBT2oAHpLki9mOjzymXfoGDfjIPL6UIPhsVkt0hOeNYmmIk4PhxcTCxqH
         gilQ8QjJGOlzmvQEF8fs0/gUkcegX2h1wNJOK2sq7RmcInieGf8TR1eBB7e7zlLZVi4w
         v05G6r2r3GzqzEd/Vutte8jhZ6ssQRGKc4budiMHrUN3wI7+HRkqQhA4KLgu4h9+ob4g
         jK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1XsHtSspreRn+8La8y2Qrz0Yl5hoZv7Msw/9Dhh58Cs=;
        b=K+mrM/rbdUX5pyZF/6/HwWcuSr+ydjltsErI/X5legUGSjOkLhgPEwJ1Glm6saGjrL
         KAcB+s2w5iZWn8E7vVpJqBcZhVfJTrujtEiAIZg7rLMTu1ck/QBd9l1W2N6K2Gv4gtMD
         NndnOp+1oO0vJ0bh2JegocjpDbL7va7iKrzVUid0haXm226DMpdQVzhK/kHc2uzDc+e3
         8jOCcotlXYWgbFpPUqazEKp4WdeRJQJkO9uOgjld+w5ds5u0Q1Bkf1yAVndukZGsS6iF
         Ws+MN1dln5iol/T+Zeq3i67wXRelABmhtXDSWMkc0hoPHRU6VTQyiC2i4R//UHuzUtGk
         P4xg==
X-Gm-Message-State: AOUpUlGTtnMmlAtYia0I4xbJ1XmhoxVW7MtpmZJU3pLrNMOs5kRo2l+U
        jgkBcrN+bIVjQ7eXGZeB374/+7P6sjn9et+Dfsg=
X-Google-Smtp-Source: AA+uWPyfXsotzGI0eODsuMjCspLOIh/Q185LnreS3tdiC7eyEiqasyLPCRYHfdmK25WuUZyUf7uhbxJmQYYwraSrRt8=
X-Received: by 2002:a02:4142:: with SMTP id x63-v6mr36817321jaa.127.1534655345187;
 Sat, 18 Aug 2018 22:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <1b332ae402bfc3806b834ee2c050dbc52b7eeb01.camel@intel.com> <CA+55aFy18-r8FM614FWo8o0T2yOSy9rvv1hX50EOij84v1n1-g@mail.gmail.com>
In-Reply-To: <CA+55aFy18-r8FM614FWo8o0T2yOSy9rvv1hX50EOij84v1n1-g@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 18 Aug 2018 22:08:53 -0700
Message-ID: <CAA9_cmcGchAuDB-8kz34PjJeR10rAKPV4k=thahojiC5XNWY3Q@mail.gmail.com>
Subject: Re: [GIT PULL]: libnvdimm updates for v4.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "dave.jiang" <dave.jiang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/me peeks in from vacation and realizes he has left his coverage with a mess

On Sat, Aug 18, 2018 at 4:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Aug 17, 2018 at 9:17 AM Jiang, Dave <dave.jiang@intel.com> wrote:
> >
> > Please pull to receive libnvdimm contributions for v4.19-rc1
>
> So I don't care about the libnvdimm code itself, but when you guys add
> code to the core mm/ code, I start looking.
>
> And when I then see shit like this:
>
>         if (is_zone_device_page(p))
>                 tk->size_shift = ilog2(dev_pagemap_mapping_size(p, vma));
>
> I go "No".
>
> There's two issues with this:
>
>  - the damn thing can return 0, which would be an error for ilog2, and
> the result is undefined
>
>    You never check for errors. There's a check for tk->size_shift ==
> 0, but is that actually the guaranteed return value of ilog2(0)? No.
>
>  - there is exactly one user of dev_pagemap_mapping_size(), and the above is it.
>
>    Why the hell didn't that function just return the number of bits to
> begin with?

In an earlier version of the patch set the raw size was used, but yes,
now we only need the number of bits.

> I do not care if you screw up your own particular driver that much.
>
> But when I see a pull request with complete and utter garbage in the
> core mm part, I will not pull.
>
> This is not acceptable.
>
> Pulled, merge conflict fixed, and then immediately unpulled again.
>
> I do not want to *EVER* see these kinds of patches to core MM code.
> And I'm not going to pull these patches or anythinig that looks like
> it has any trace of this shit.
>
> I get upset, because dammit, I expect better. I don't want to go "oh,
> this changes core code, let's just skim over the patches" and
> immediately find something fundamentally broken like this.

Yes, that's my wreckage. I particularly should have known better
because I have seen your ilog2() misuse review comments on other patch
sets and was careless in this instance. I was focused on the
dax_lock_mapping_entry() implementation and did not circle back to
sanity check this when the test case started passing (not an excuse,
just thinking through how I overlooked this).

This support for turning machine checks in dax mappings into SIGBUS
unfortunately ended up touching "all the things" across mm/ and x86/
in addition to drivers/nvdimm/ and drivers/dax/. It ran out of time
for 4.18, and to help not miss 4.19 I offered to coordinate the series
in libnvdimm.git with acks from Naoya, Ingo, and Jan.

If it can still make 4.19, would you except a fixed up branch?

The justification for pushing this sooner rather than later is to
start the pipeline to the distros since enterprise in-memory-database
developers reported this gap in the kernel memory error handling
compared to the DRAM / page cache case.

I'm otherwise not in a position to help out on this with code until
I'm back in the office mid-September, so I'd have to put this on Dave
to clean up. Sorry Dave, and apologies Linus for the screw up.
