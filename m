Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9679BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD4F20818
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="xjUSj6oU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD4F20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeKHFaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:30:04 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:46446 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbeKHFaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:30:04 -0500
Received: by mail-oi1-f170.google.com with SMTP id k64-v6so14871541oia.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 11:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u25Hl9nttXsOv9mUmKr2AbGA4/VesCfN1ie9f8ee/nc=;
        b=xjUSj6oUJ/tXzIfUxeDC2g9JF6xPqKSZlEwIRb+RK08PotmqGdEEkebmeTfQ/V331W
         8XFYIfN5GPPJLJkb3fepCM3uLn6gyIdg1cKJSmxvSvZ6iqn5rxJNnglcTSiXR1juwQk9
         eeIL5K0zcpxd+KrFRRKjVPLcnmzCUm7Kug2Ap47RDLfAQ+nLj7AJZJ7FA6Ib1OMh0jc0
         sgWjMqCqN4XtkJdt/VDaVlr6VlE9Ato01EXVKLiFF02LLyuOCQRlskIksY0qzZDq4FhE
         7jC34n/ykJsKlqAQQKB8YAl/CKpTd6XeGR7Qa3+HS0rajo7VVyrIGy2lxlPVxYhdPOfg
         EWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u25Hl9nttXsOv9mUmKr2AbGA4/VesCfN1ie9f8ee/nc=;
        b=WCXz5IKoqUkn6wKdqFEYVxhHdbiQoK/nXgwswQu5eRueVRe36aAE6XdBPkU0KdOetf
         gJEvoX8v/gcYm62rPrfglj/RA+ySQz6IXjpb9O3p1HdghcjYm//WimaFHjQcwAGu0343
         9AmDpsD3Szzx2hD+U/GqeNEysyyYQdyuQujOdCDOMHHIfc5lKwX8q1PE4nV5BeBPl5u8
         3CQ5WwPHUrpz49QNNyA3U7ZIUtQ8M7dkPp0yMRQZGGBWT36twAtCv+LIZpJsoN3hewz2
         zTDWLvScRPXNBYbJQ0I0cuHtfA4JyeaPx+II807FLoWu86Vaq86Acb2gYnPGwnkrD+qz
         Q4Xg==
X-Gm-Message-State: AGRZ1gLegFBojc5Kb48lq33g9fGPe+LbPxUr9QdLIM1MSHYmKjI7VESS
        /R4qAXjIINyXZsc5UuSkOlpEi/TD95J6D6fA9l7j6zSY
X-Google-Smtp-Source: AJdET5cxQAtvrCSvsMwq913Bs1m28aK8H/8JiH/Z33+rViM8T0lwkv2OU7+HtIc6oU1tCxQPeUBlkUw1Aduk2SIspY4=
X-Received: by 2002:aca:e691:: with SMTP id d139-v6mr942880oih.232.1541620691838;
 Wed, 07 Nov 2018 11:58:11 -0800 (PST)
MIME-Version: 1.0
References: <20181107171010.421878737@linutronix.de> <20181107124855.328133e7@lwn.net>
In-Reply-To: <20181107124855.328133e7@lwn.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 7 Nov 2018 11:58:00 -0800
Message-ID: <CAPcyv4goT+7t1foOhEYgGTz2kRV2Oou8QOs38D13rdC-TpfX+Q@mail.gmail.com>
Subject: Re: [patch 0/2] Documentation/process: Add subsystem/tree handbook
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        john.stultz@linaro.org, acme@redhat.com, frederic@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>, daniel.lezcano@linaro.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 11:49 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Wed, 07 Nov 2018 18:10:10 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
> > Mark recently suggested in one of the ksummit discussions to add subsystem
> > or tree specific maintainer handbooks to document subsystem/tree specific
> > development process information.
> >
> > The following series adds the general section and the tip tree specific
> > handbook.
>
> So this is an idea that has gone around for a while; developers often get
> into trouble when wandering into an unfamiliar part of the kernel, so
> documenting the quaint local customs might help.  Assuming people actually
> read the documentation, of course.
>
> What's here seems generally good, but I do have an overall worry that we
> may want to consider:
>
>   - How much do we want to support and document subsystem-specific quirks
>     vs. promoting reasonable and consistent rules kernel-wide?
>
> There is a *lot* of stuff in the new tip manual.  Much of it, regarding
> coding style and the writing of changelogs, really seems like it should be
> global; if we need better documentation of that stuff, I'd really rather
> see that advice folded into the central documents.  Having two (or more)
> extensive coding-style documents doesn't seem like it's going to help us.
>
> The stuff that is truly specific to tip seems fairly minimal:
>
>   - what goes into tip
>   - the reverse fir tree thing
>   - tail comments, or the distaste thereabouts
>   - subject-line prefixes
>
> Having a tip-specific document that contains only those (plus whatever
> else I forgot to list) would, IMO, make it much more likely that readers
> would actually notice (and follow) the stuff that's specific to tip.
>
> See what I'm getting at here?  Am I totally out to lunch on this?

Not at all, and this is one of the thrusts of my talk next week at
Plumbers. I *do* want to propose that sub-systems document all their
local quirks. Then we can refactor the common ones into a global
document, have some discussion fodder if some sub-system specific
rules can be unified, and otherwise leave the freedom for individual
sub-systems to be different as long as it's documented.
