Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A76C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 23:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB552124D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 23:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AUs63dWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB552124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbeHSCYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 22:24:37 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34671 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeHSCYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 22:24:37 -0400
Received: by mail-io0-f194.google.com with SMTP id c22-v6so3652481iob.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 16:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dJJqdw5cyKuCuy7V1J2qRtnz94ZTcErO2tj9v2EYKiE=;
        b=AUs63dWoCmt14fHmSdqE6zDQjtMLJCFoBiixcjDl1kW/N5nQVYnm9HK7ddyAJsAhAr
         mPkCZmr+wwU4Es9HyL7+vhDY229m3CAxfzkqmf+IaB1PkjzznwXBgvqisgGUK+2d2rAL
         8s6EVUzbUzejYDJZ6HEzBfVEuXnbrfnp7jHV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJJqdw5cyKuCuy7V1J2qRtnz94ZTcErO2tj9v2EYKiE=;
        b=ddh7hiL2cAV+uSFNsVr2sdvUMINESDwGqqPGwlsXJe4+/yMcKg8dVyzMoQ25Tr0Hfg
         aWYm3r5wogfurvEoVsj0rY06GOVx19xGGxzvG3vYRd+H/roYRpmHTXAUhroP6hXr84xc
         aCUIVnZJ058wUGTJpfxjcJu/czISO7tpHPoR+I7bfFWm0vy9Vq+ZuJonIrGhUqqs5Rlz
         /oGxyPYwusonUN2yV6l0tsR6woo+LUKau0HknFSepeumEFO+abgHPV6p8rOZNuGtk8tA
         uTVJQVcfuTO2kTZ111CXMTTWw/LsWnMFZ+fuGqA3tB0BoFAUOVoSYb2AwZoIaly/L/KQ
         QFug==
X-Gm-Message-State: AOUpUlG7eo/Y6C6S99lkk6/aValFsg8xxR1tO9qouUoHyyRIpgtujGhG
        inFS0UuIVI65oCx4BEK9DbHek30rDPIdC3Q9GVM=
X-Google-Smtp-Source: AA+uWPyInTu6ioUpxxs2KiOygPK89FMnLF3lMIYwEf9KYEejQsYeDj8qSlHOWyOcqh3qggfW9q60Ns+KQnoESLo/j5s=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr17824600ioh.259.1534634116615;
 Sat, 18 Aug 2018 16:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <1b332ae402bfc3806b834ee2c050dbc52b7eeb01.camel@intel.com>
In-Reply-To: <1b332ae402bfc3806b834ee2c050dbc52b7eeb01.camel@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Aug 2018 16:15:05 -0700
Message-ID: <CA+55aFy18-r8FM614FWo8o0T2yOSy9rvv1hX50EOij84v1n1-g@mail.gmail.com>
Subject: Re: [GIT PULL]: libnvdimm updates for v4.19-rc1
To:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 9:17 AM Jiang, Dave <dave.jiang@intel.com> wrote:
>
> Please pull to receive libnvdimm contributions for v4.19-rc1

So I don't care about the libnvdimm code itself, but when you guys add
code to the core mm/ code, I start looking.

And when I then see shit like this:

        if (is_zone_device_page(p))
                tk->size_shift = ilog2(dev_pagemap_mapping_size(p, vma));

I go "No".

There's two issues with this:

 - the damn thing can return 0, which would be an error for ilog2, and
the result is undefined

   You never check for errors. There's a check for tk->size_shift ==
0, but is that actually the guaranteed return value of ilog2(0)? No.

 - there is exactly one user of dev_pagemap_mapping_size(), and the above is it.

   Why the hell didn't that function just return the number of bits to
begin with?

I do not care if you screw up your own particular driver that much.

But when I see a pull request with complete and utter garbage in the
core mm part, I will not pull.

This is not acceptable.

Pulled, merge conflict fixed, and then immediately unpulled again.

I do not want to *EVER* see these kinds of patches to core MM code.
And I'm not gfoing to pull these patches or anythinig that looks like
it has any trace of this shit.

I get upset, because dammit, I expect better. I don't want to go "oh,
this changes core code, let's just skim over the patches" and
immediately find something fundamentally broken like this.

               Linus
