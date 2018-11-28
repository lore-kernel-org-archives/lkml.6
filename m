Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D56C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11CE213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11CE213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeK1UMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:12:24 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43262 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbeK1UMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:12:24 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so21934923oie.10;
        Wed, 28 Nov 2018 01:11:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dd7RkrKz2XhvNFPp03jfKPgxByZ0cKyPBb5yohGZmCE=;
        b=gYn4LGSqPA6RJ/MUiZLaRBqR/5NBmw35cHTjTCXBa/HIRLAbfp9TdPvsPBEyx2DfQG
         Ee97DH1qrvm4bd6HAp/NqdGwwY+NAGODxjamILxe5w3/qwlz8nTmIeFM1AJseFSCWV5K
         MYll3bW8PH5gJMov8t/ULGSxgd/t5WlYD1ksRgyyhx1d7lkwEX3SvDm9a9TF96FsPU6d
         sax5AkJP5T13a1zStTLynZUR7GSO3Gx48xI14EYpwPs6CrlO86DSzKQfg0gL1j5gPdNL
         g1Cd601tW86XblVgb86NpRnD6h9LpT1avC1ivVALC1p1lO+boH1ShU+CprZxvdqrOb8y
         CKQg==
X-Gm-Message-State: AGRZ1gKvYwQyqzV9K8TGREN7BAXigCSAuze/sffvdDyNabHIgtxkFwlh
        CmOD6VBJe0J4tjXhy1GGu4IP8bwMtWBZwpXCgKE=
X-Google-Smtp-Source: AJdET5dWKkhWFOw9yXarSdKfL+A8j3e36LBoEGIJERqbhBXfxsdEgMEiB+7PGnARSt+uwA2noTRgdYXoy6oo+yzLryk=
X-Received: by 2002:aca:d7c6:: with SMTP id o189-v6mr20518972oig.33.1543396288504;
 Wed, 28 Nov 2018 01:11:28 -0800 (PST)
MIME-Version: 1.0
References: <4064391.AYvOMBeiDo@aspire.rjw.lan> <20181128054835.gnhistcfxy25rmwf@vireshk-i7>
In-Reply-To: <20181128054835.gnhistcfxy25rmwf@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Nov 2018 10:11:16 +0100
Message-ID: <CAJZ5v0hnX512AheTwhpj09+eyiyv6txsgGQcT2afWiB2JjjCzw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: admin-guide: PM: Add cpuidle document
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 6:48 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 26-11-18, 14:11, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Important information is missing from user/admin cpuidle documentation
> > available today, so add a new user/admin document for cpuidle containing
> > current and comprehensive information to admin-guide and drop the old
> > .txt documents it is replacing.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  Documentation/admin-guide/pm/cpuidle.rst       |  603 +++++++++++++++++++++++++
> >  Documentation/admin-guide/pm/working-state.rst |    1
> >  Documentation/cpuidle/core.txt                 |   23
> >  Documentation/cpuidle/sysfs.txt                |   98 ----
> >  4 files changed, 604 insertions(+), 121 deletions(-)
>
> Nice work Rafael. Minor nits below..

Thanks for the typo fixes.  The spellchecker I have here evidently doesn't work.

[cut]

> Maybe I missed, but I couldn't find any text that says what state 0, 1, ... N
> mean.

There is a paragraph on that above.

> Like which is the deepest idle state and which one is the shallowest.

But this part is missing, good catch!

Thanks,
Rafael
