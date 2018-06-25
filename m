Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3CEC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858D0262BE
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MM3BwJK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858D0262BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755685AbeFYXhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:37:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753205AbeFYXhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:37:18 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E92C25AC3;
        Mon, 25 Jun 2018 23:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529969837;
        bh=jQtQ+57xLLVGIEWE6N8LhLqZjGfb1n2udjT98l8oMbk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=MM3BwJK1cWWyxGQSAYk/qNnDq9d5sCCKe0R9ijWXuTZhEyRISu7cmYCCnLt8B1b8m
         27/Q/8S8s249LKYZeAKe7SYR9u0l7g7W4z/NkizsbwWrjqf+dIZxt9Aq9jIo42gBxC
         S5IBD6bbrROUXKg1SFLLaxoAR5Vyp094f2HGh33Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <914341e7-ca94-054d-6127-522b745006b4@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <CABe79T6zQ_7Ycws5b=xaQ3edpVn1QPQyWd9p24eqLGpYbdtt0A@mail.gmail.com>
 <CAHp75VdSW1po7fVv+A6ATTU7CkN-4nQ1haQSCq7b_+ZR9tNXCQ@mail.gmail.com>
 <CAJZ5v0iJcTg=X_j-4nap9d_H4jq2rwOETT8Sukx6UL5UsDKjgA@mail.gmail.com>
 <152908459103.16708.4012421602830600322@swboyd.mtv.corp.google.com>
 <CAJZ5v0gA76NwwgRnuztY+dUOKXS+__-7Ghw7Azb-84h_eMRt4w@mail.gmail.com>
 <152994466823.143105.11787470853817181844@swboyd.mtv.corp.google.com>
 <914341e7-ca94-054d-6127-522b745006b4@arm.com>
Message-ID: <152996983664.143105.1441423217241075965@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: ACPI support in common clock framework
Date:   Mon, 25 Jun 2018 16:37:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sudeep Holla (2018-06-25 10:15:45)
> =

> =

> On 25/06/18 17:37, Stephen Boyd wrote:
> > Quoting Rafael J. Wysocki (2018-06-16 08:50:18)
> >> On Fri, Jun 15, 2018 at 7:43 PM, Stephen Boyd <sboyd@kernel.org> wrote:
> >>>
> >>> Is this for clk_enable/disable? What about clk_set_rate() or
> >>> clk_set_phase()? Is ACPI's AML taking care of that?
> >>
> >> That's for clk_enable/disable AFAICS.
> >>
> >> AML doesn't manage device performance states at all.
> > =

> > Alright. We may need to add a better way for device drivers to get
> > handles to clk pointers on ACPI firmware so they can change frequencies
> > or phase, etc. =

> =

> Is there any specific usecase/device needing this in the kernel ? SPI
> slaves ?

Mark Brown has been pushing x86 folks to use clk framework for audio
drivers in ASoC. I haven't seen other uses besides that really.

