Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23706C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6002054F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551038405;
	bh=R2lh5avj5JycPCEm/P0MSqgEmiuOdklRxaP5x9/4jzw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NWIg/gjdKvQksOk5UPEfMlY8mpk1EM+VD1R0hYYE+SL5vnkws9PWTG6uLk174Vi9l
	 ma9Rybg/90/Iu0UBuU5Hj8dIlfZzWuyLAGcbgHdeOS3Lwy2b0XAfULMqZ+ZIa38t5K
	 2wyQsipFnJ9DYSWf4rADzi+eMzWNmKevaKyZh0ZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfBXUAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 15:00:03 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37108 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfBXUAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 15:00:01 -0500
Received: by mail-oi1-f193.google.com with SMTP id w66so5653350oia.4;
        Sun, 24 Feb 2019 12:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfmUSwBalOdjcvnqS+eLnkmWA+LNz1+spq3jB7NTkvA=;
        b=HABPl9MPFMlFo59VQrJ6Ko0UP4/ozXlb6y2auWNx1GOF3qL521Z7q8z7goowO6Kb0o
         N5UzrvQBS+e3tbcBLj62YbrIqT1GD67iLou0cnXXDFf4bVYcMo4v9wvUlgloTZr/JwKf
         QrmNqOHcL7WzmY7MuN7ufXqJxVF2GsLaECN7E1vPC1mBTw9/Rq6BOzfuGF8dRrpK5n0U
         RPCL978L8CC12a0Oyq4ru/oXtWLzigRi+yX4F6GoYqVz0tiFL+KhRhfK94roYrOdfhWA
         LjD1Mz1AVuKNwXCk5JL1K1HvNbRx1V83AVCUALdAWGF+12YXqH72x1PJk45IoXJVT1nu
         Dmeg==
X-Gm-Message-State: AHQUAuaidOvX5o6RWcKbuJPz1jxFXjOpDWGizxyqCTbYS37L8GfGGkMg
        Lc3jPAyYElR+6HCDptdnW8UdgJlDPZg3LqIz13U=
X-Google-Smtp-Source: AHgI3IajckkE8zgs0EwI+0F1B+CSm/jwmndJErK8z8W0UaJ1/0fcfqbWZT7nvhPg+1vQsEYlYetS/ppMMl631GzTYqU=
X-Received: by 2002:aca:c141:: with SMTP id r62mr8543843oif.160.1551038400097;
 Sun, 24 Feb 2019 12:00:00 -0800 (PST)
MIME-Version: 1.0
References: <20190214171017.9362-1-keith.busch@intel.com> <20190214171017.9362-8-keith.busch@intel.com>
 <CAJZ5v0gjv0DZvYMTPBLnUmMtu8=g0zFd4x-cpP11Kzv+6XCwUw@mail.gmail.com> <20190222184831.GF10237@localhost.localdomain>
In-Reply-To: <20190222184831.GF10237@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 24 Feb 2019 20:59:45 +0100
Message-ID: <CAJZ5v0hfQ5HWT0kfaOxSbpJvdqotsMWVBCZ6wiL4Tnuy+O5O7Q@mail.gmail.com>
Subject: Re: [PATCHv6 07/10] acpi/hmat: Register processor domain to its memory
To:     Keith Busch <keith.busch@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 7:48 PM Keith Busch <keith.busch@intel.com> wrote:
>
> On Wed, Feb 20, 2019 at 11:02:01PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Feb 14, 2019 at 6:10 PM Keith Busch <keith.busch@intel.com> wrote:
> > >  config ACPI_HMAT
> > >         bool "ACPI Heterogeneous Memory Attribute Table Support"
> > >         depends on ACPI_NUMA
> > > +       select HMEM_REPORTING
> >
> > If you want to do this here, I'm not sure that defining HMEM_REPORTING
> > as a user-selectable option is a good idea.  In particular, I don't
> > really think that setting ACPI_HMAT without it makes a lot of sense.
> > Apart from this, the patch looks reasonable to me.
>
> I'm trying to implement based on the feedback, but I'm a little confused.
>
> As I have it at the moment, HMEM_REPORTING is not user-prompted, so
> another option needs to turn it on. I have ACPI_HMAT do that here.
>
> So when you say it's a bad idea to make HMEM_REPORTING user selectable,
> isn't it already not user selectable?

I thought that HMEM_REPORTING was user-prompted initially, by bad if it wasn't.

> If I do it the other way around, that's going to make HMEM_REPORTING
> complicated if a non-ACPI implementation wants to report HMEM
> properties.

But the mitigations that Dave was talking about get in the way, don't they?

Say there is another Kconfig option,CACHE_MITIGATIONS, to enable them.
Then you want ACPI_HMAT to be set when that it set and you also want
ACPI_HMAT to be set when HMEM_REPORTING and ACPI_NUMA are both set.

OTOH, you may not want HMEM_REPORTING to be set when CACHE_MITIGATIONS
is set, but that causes ACPI_HMAT to be set and which means that
ACPI_HMAT alone will not be sufficient to determine the
HMEM_REPORTING value.

Now, if you prompt for HMEM_REPORTING and make it depend on ACPI_NUMA,
then ACPI_HMAT can be selected by that (regardless of the
CACHE_MITIGATIONS value).

And if someone wants to use HMEM_REPORTING without ACPI_NUMA, it can
be made depend on whatever new option is there for that non-ACPI
mechanism.

There might be a problem if someone wanted to enable the alternative
way of HMEM_REPORTING if ACPI_NUMA was set (in which case HMAT would
have to be ignored even if it was present), but in that case there
would need to be an explicit way to choose between HMAT and non-HMAT
anyway.

In any case, I prefer providers to be selected by consumers and not
the other way around, in case there are multiple consumers for one
provider.
