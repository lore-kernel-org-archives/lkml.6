Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C75C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D81214DE
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D81214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeK3Iu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:50:28 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40270 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbeK3Iu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:50:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id s5so3232444oth.7;
        Thu, 29 Nov 2018 13:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBbUYKlInnIiQ496CvzNakK4TWVzZ3u9XRNgWv9gGf0=;
        b=SjFtYxmpWGB7w5D60cGSA9dOivtGIugyTHQXNdruGp79vhxt6u1k5zjKURLRO03yq+
         EkC9Es1/56+A/n8rhwBPnRfVItmSqQVvB8NSF9zdOVdGsA9Vnxwa29nHaK8U85ySceRn
         1rupfN/W5W2VPmss7HQJAqYZHMTWlZm1mm1iVU5cDw7RMK8ixJdvmw78YqDDHV7cG7rc
         0O8DTmIOppJOnPKALfYidXr8J6COOz7IjFZfpkmP+ZyUR4rXEYASkr35rOSVwWgudgeM
         a2rHyr67C/mOgEocYIxdwjgMm8ECK1c8bEHru2PCP7wcQYnvJc6b90gk4I6cQFQb0QSd
         u6TA==
X-Gm-Message-State: AA+aEWYt/01+gEI+3OXe9q/YVePDqkZR80ZDwz9E7HoysWGyK9eo3Pv0
        kyjD0ntloVP1zTmhlGZu+eaY6ijUfwX7kBM8vGeKeg==
X-Google-Smtp-Source: AFSGD/Wg3ZuvFHUP7hn/ZdZSSXPOOj8AvSSZDRU5+4PZ776RVrvkZ8LUxfloAjMeHrpOLIw2dJ4vmF+aU9N+t0EJoYw=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr2068748otg.139.1543527816623;
 Thu, 29 Nov 2018 13:43:36 -0800 (PST)
MIME-Version: 1.0
References: <2021920.OpoCz8F1eI@aspire.rjw.lan> <20181129144022.0908ddb2@lwn.net>
In-Reply-To: <20181129144022.0908ddb2@lwn.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Nov 2018 22:43:24 +0100
Message-ID: <CAJZ5v0j4ANP30U8Vzt857aeFatJ0i453oRc2RL2mYatP4+TY6g@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation: admin-guide: PM: Add cpuidle document
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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

On Thu, Nov 29, 2018 at 10:40 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Thu, 29 Nov 2018 22:22:04 +0100
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>
> > Important information is missing from user/admin cpuidle documentation
> > available today, so add a new user/admin document for cpuidle containing
> > current and comprehensive information to admin-guide and drop the old
> > .txt documents it is replacing.
>
> I've not had a chance to read through it in depth, but a first scan looks
> good.

Thanks!

>  I assume this is going up via your tree?

Yes, I would like to take it as there may be new patches on top of it.

Cheers,
Rafael
