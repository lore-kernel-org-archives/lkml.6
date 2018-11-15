Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C95C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BAD2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 07:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BAD2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbeKOSFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:05:13 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:34409 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeKOSFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:05:13 -0500
Received: by mail-vk1-f195.google.com with SMTP id y14so4276460vkd.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 23:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3whvaQXr+8IIbo75NjC+Q16kxNPFSx5splXXYPVT8mc=;
        b=uLQlyT3LAcCjGnTzx2YckNu+rF1Sbdcb0m1Eg1b7pKzjP37sI0bqb/IagdHSaehkde
         xzdTbWIZUAqmS2yzS+RTU2fDk/E5afQr4kb3g7fPo3gh3Hycs3rACpct9u43ENZzWrfa
         9n4dgs8L3aEeX7CIs4CwyhMv17v3zqO3X9G5rEEtuSyEcIHN4IqYuJBWw61VnnimTYeR
         Q15Ly6ZHSnaDTExiofv8OV/LH0DdHVnscW/MgnJMv1cZTtfSU6fX8Km4EzGzrEe1zx4E
         fd967YQh9MQAi90NupEIabu95H5dqQq9xjMhoTZTORf5+v6MjNc8WPunDJFXffyS+AP+
         9ggg==
X-Gm-Message-State: AGRZ1gKznBwSLwE9uuoEvXNsXecCHscZpu07iDLh4JIfI75zL/ip/xjQ
        cJDcHlf8hjs3QhukD1rMxjf3RBplActK9/RON8M=
X-Google-Smtp-Source: AJdET5dOiqkW9DfgDIKv77uImzWI6EYQ8AuEy89q2NHVVZp8IYyDIA/+hNskH3XRSxK6tYKBAC0uL2JAnrymgN47Z5E=
X-Received: by 2002:a1f:bfc6:: with SMTP id p189mr2214725vkf.83.1542268707642;
 Wed, 14 Nov 2018 23:58:27 -0800 (PST)
MIME-Version: 1.0
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 15 Nov 2018 08:58:15 +0100
Message-ID: <CAMuHMdV5UKwMHa1ydBiEiiSBswzcVBjqjW573fSeD08RNRnzGw@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [RFC PATCH 2/3] MAINTAINERS, Handbook:
 Subsystem Profile
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        vishal.l.verma@intel.com,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        stfrench@microsoft.com, "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Thu, Nov 15, 2018 at 6:05 AM Dan Williams <dan.j.williams@intel.com> wrote:
> As presented at the 2018 Linux Plumbers conference [1], the Subsystem
> Profile is proposed as a way to reduce friction between committers and
> maintainers and perhaps encourage conversations amongst maintainers
> about best practice policies.
>
> The profile contains short answers to some of the common policy
> questions a contributor might have, or that a maintainer might consider
> formalizing. The current list of maintenance policies is:
>
> Overview: General introduction to maintaining the subsystem
> Core: List of source files considered core
> Leaf: List of source files that consume core functionality
> Patches or Pull requests: Simple statement of expected submission format
> Last -rc for new feature submissions: Expected lead time for submissions
> Last -rc to merge features: Deadline for merge decisions
> Non-author Ack / Review Tags Required: Patch review economics
> Test Suite: Pass this suite before requesting inclusion
> Resubmit Cadence: When to ping the maintainer
> Trusted Reviewers: Help for triaging patches
> Time Zone / Office Hours: When might a maintainer be available
> Checkpatch / Style Cleanups: Policy on pure cleanup patches
> Off-list review: Request for review gates
> TODO: Potential development tasks up for grabs, or active focus areas
>
> The goal of the Subsystem Profile is to set expectations for
> contributors and interim or replacement maintainers for a subsystem.
>
> See Documentation/maintainer/subsystem-profile.rst for more details, and
> a follow-on example profile for the libnvdimm subsystem.

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/maintainer/subsystem-profile.rst

> +Last -rc to merge features
> +--------------------------
> +Indicate to contributors the point at which an as yet un-applied patch
> +set will need to wait for the NEXT+1 merge window. Of course there is no
> +obligation to ever except any given patchset, but if the review has not

s/except/accept/

> +concluded by this point the expectation the contributor should wait and

expectation is (that)

> +resubmit for the following merge window. The answer may be different for
> +'Core:' files, include a second entry prefixed with 'Core:' if so.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
