Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C1AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412132081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412132081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbeK1VCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:02:39 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36083 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbeK1VCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:02:39 -0500
Received: by mail-oi1-f196.google.com with SMTP id x23so22055075oix.3;
        Wed, 28 Nov 2018 02:01:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7z4lz5FKsGxdutW1NvyE9528FnmlLwU2jJcxSsKMJZA=;
        b=TdSQmw82DAWvH+HlFUOpaqmUV+ly9NqvY5erp8LAk2gdEgnn0yxKDnhprGEJ4kdSU+
         7cT/IQQmHtuJvh04UQv7wawCpiaMY7A9QK37hdXZE5s8wt2ctde1lVcLaYEHst65mB+3
         7BHvdJpQ0zzRlxXAVZKAmEfddUqY7RHsgCoilFmSqYSLFpqW9OLO30RD4PZDFOeGMEyq
         AmDO6FgycWimtS8uVt754vWiaWCeAfh12GS5a2HK6iZ3WaoIC7PGCNuUXhCkgtzYwRxm
         oPb7sIZflaIAqq3OgunygGtXO5qHeD3CJgLRE3dANcr48vduvqGWTHPxZU6GDakEgHOH
         K0/Q==
X-Gm-Message-State: AGRZ1gLiKL9LX3tBNzpUUSwcSvSBDzq0x08fLGBDpD01N0wBov1uhZ7p
        rU69RsF+tcsf9LZ+w0CaSlfFeqO1UMtISFPVRm0=
X-Google-Smtp-Source: AJdET5es4DhPCmstc+NtR/iVyavuZC1uiEuUvHumFiscoY4r6hrP50aam3tHgSz719N88P3WSAk6Qtc+W6cbOrynoOE=
X-Received: by 2002:aca:195:: with SMTP id 143mr18738085oib.322.1543399292249;
 Wed, 28 Nov 2018 02:01:32 -0800 (PST)
MIME-Version: 1.0
References: <4064391.AYvOMBeiDo@aspire.rjw.lan> <20181128054835.gnhistcfxy25rmwf@vireshk-i7>
 <CAJZ5v0hnX512AheTwhpj09+eyiyv6txsgGQcT2afWiB2JjjCzw@mail.gmail.com> <20181128093137.a5d4kwgfdthlsolw@vireshk-i7>
In-Reply-To: <20181128093137.a5d4kwgfdthlsolw@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Nov 2018 11:01:20 +0100
Message-ID: <CAJZ5v0j4B6ODKzJ+XWvMS_dc6BpQcYkK6=L-zg8wcWXQxMcFhQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: admin-guide: PM: Add cpuidle document
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Wed, Nov 28, 2018 at 10:31 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 28-11-18, 10:11, Rafael J. Wysocki wrote:
> > On Wed, Nov 28, 2018 at 6:48 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 26-11-18, 14:11, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Important information is missing from user/admin cpuidle documentation
> > > > available today, so add a new user/admin document for cpuidle containing
> > > > current and comprehensive information to admin-guide and drop the old
> > > > .txt documents it is replacing.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  Documentation/admin-guide/pm/cpuidle.rst       |  603 +++++++++++++++++++++++++
> > > >  Documentation/admin-guide/pm/working-state.rst |    1
> > > >  Documentation/cpuidle/core.txt                 |   23
> > > >  Documentation/cpuidle/sysfs.txt                |   98 ----
> > > >  4 files changed, 604 insertions(+), 121 deletions(-)
> > >
> > > Nice work Rafael. Minor nits below..
> >
> > Thanks for the typo fixes.  The spellchecker I have here evidently doesn't work.
>
> I have this in my .vimrc and I am shown these spelling mistakes somewhat
> forcefully :)
>
> set spell spelllang=en_us

Interestingly enough, it appears to work when I turn the automatic
spellchecking, which I don't do for code as a rule, because it
distracts me.  I will need to do that for docs going forward it seems,
though.

BTW, I didn't respond to the remark about the ladder governor.  I have
no plans to describe it at this time and that can be done at any time
later easily enough if anyone wants to do it.

Thanks,
Rafael
