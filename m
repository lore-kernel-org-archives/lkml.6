Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3936460764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932377AbeFFHpK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 03:45:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:58668 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932352AbeFFHpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 03:45:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,482,1520924400";
   d="scan'208";a="62196153"
Message-ID: <2fe122f7fa0040509dcc049b48e7934b54ee0a55.camel@linux.intel.com>
Subject: Re: [GIT PULL] Device properties framework update for v4.18-rc1
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 06 Jun 2018 10:45:05 +0300
In-Reply-To: <CA+55aFw8yUOweiQSEp-ZHzEeSAGggZ0-Ksy0e4GQgEhKvmwLog@mail.gmail.com>
References: <CAJZ5v0jq45atkapwSjJ4DkHhB1bfOA-Sh1TiA3dPXwKyFTBheA@mail.gmail.com>
         <CA+55aFyoxvrA-7X_8ZfQXd1=GfLT96ZaHAM+o5gKwOOfiy_HDA@mail.gmail.com>
         <CA+55aFw8yUOweiQSEp-ZHzEeSAGggZ0-Ksy0e4GQgEhKvmwLog@mail.gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-05 at 10:39 -0700, Linus Torvalds wrote:
> On Tue, Jun 5, 2018 at 10:30 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > 
> > Honestly, this looks questionable to me.
> > 
> > I'm not talking about the changes themselves - I can live with them.
> > But the _rationale_ is pure and utter garbage, and dangerously so.
> 
> Side note: I've merged it, and it's going through my build tests, so
> it's really not that I hate the code.

Thanks for merging.

> 
> But I really find that kind of one-sided rationale that ignores
> reality unacceptable.

Yeah, there were few reasons why I decide to make that patch (OK, it
seems I staked on not the best reason).

Like Rafael said there is no need to use it here and code initially was
without union aliasing be in place.

> And I find it dangerous, because it *sounds* so "obviously correct" to
> people who don't know any better. If you don't know that gcc
> explicitly says that you should use unions to do type punning to avoid
> aliasing issues, you might believe that union type punning is a bad
> thing from that commit message.
> 
> So it's dangerously misleading, because lots of people have a
> dangerous reverence for paper over reality.

I agree with you, because type punning via unions feels natural and
that's why I even didn't notice when made a refactoring there several
releases before.

> In programming, "Appeal to Standards" should be considered a potential
> logical fallacy. Standards have their place, but they definitely have
> their caveats too.

Yes, even outside of programming.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
