Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD1EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81977208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/0mXnLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81977208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966181AbeFORnQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936408AbeFORnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:43:12 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2BC1208AF;
        Fri, 15 Jun 2018 17:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529084591;
        bh=fdLh8bar6RFdcHJwPlu/8O5wBEgmrCz2ZpqPw9zctkA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=l/0mXnLoSvjcD7e3yYiKSCmaxPb9ISvbLmrRdWELjix3cwbKvLrQv4R2X74Gne/ce
         lIv/KaEiAfg+Kz0aNf9/LWBvyIDVF1mkIiNncitmfa3s1X5n5Dq1hk0s2LolYYM4Hd
         LqJxstH0TAgHy6whMiInypvWMZGJd141hFlR/UJ0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAJZ5v0iJcTg=X_j-4nap9d_H4jq2rwOETT8Sukx6UL5UsDKjgA@mail.gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <CABe79T6zQ_7Ycws5b=xaQ3edpVn1QPQyWd9p24eqLGpYbdtt0A@mail.gmail.com>
 <CAHp75VdSW1po7fVv+A6ATTU7CkN-4nQ1haQSCq7b_+ZR9tNXCQ@mail.gmail.com>
 <CAJZ5v0iJcTg=X_j-4nap9d_H4jq2rwOETT8Sukx6UL5UsDKjgA@mail.gmail.com>
Message-ID: <152908459103.16708.4012421602830600322@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: ACPI support in common clock framework
Date:   Fri, 15 Jun 2018 10:43:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rafael J. Wysocki (2018-06-13 01:27:39)
> On Wed, Jun 13, 2018 at 10:13 AM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > +Cc: Rafael, ACPI ML
> >
> > On Wed, Jun 13, 2018 at 7:14 AM, Srinath Mannam
> > <srinath.mannam@broadcom.com> wrote:
> >> Hi Michael, Stephen,
> >>
> >> We are adding ACPI support in our Linux based platform.
> >> At present our clock hierarchy using common clock framework through DT=
S.
> >> Now we required ACPI support in common clock framework to upgrade our =
platform.
> >>
> >> For example, clk_get API called in many drivers to get clock device is
> >> tightly coupled with DT framework.
> >>
> >> Please let us know, if anybody in Open Source community have plans to
> >> add ACPI support for common clock framework.
> =

> There are no plans for doing that AFAICS.
> =

> Moreover, it generally would not be consistent with ACPI power
> management defined by the specification.

This matches my understanding.

> =

> >> If not please suggest us alternative method to use common clock
> >> framework in ACPI use case.
> =

> The problem with using the clock framework on systems with ACPI is
> that, in general, the clock manipulation is expected to be carried out
> by ACPI power management and therefore it is "owned" by AML.
> Currently, there are no defined methods for synchronizing the AML's
> use of clocks for power management with what the OS may do with them
> directly.
> =

> In theory, that can be worked around to some extent by representing
> clocks as power resources in ASL (even though the provider information
> would be missing then) and manipulating those power resources directly
> from the OS.  I'm not aware of anyone doing that successfully,
> however.
> =

> For simple power management it should be sufficient to let drivers
> rely on the ACPI PM domain which should happen automatically in the
> majority of cases anyway.
> =


Is this for clk_enable/disable? What about clk_set_rate() or
clk_set_phase()? Is ACPI's AML taking care of that?

