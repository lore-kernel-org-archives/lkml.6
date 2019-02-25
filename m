Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2288C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF01217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551133835;
	bh=MWHZhDbvOzZgahYvGFBaXWuuk9di7ESy6NlyOUcjHpg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W6PArmnQ+VWoazkXewtP16QfvC7n2uVbWL7pAZbGheytoeRib2nSnA9xD4JCOk8fq
	 bG3hazasA9uIT+i6UwuIhGMgSXE1UIIUvWfWKAUH09F79e7Wkx3UFY5ZRC3PKk682Y
	 wG4tDzf88TkNM09x3RI0eiLqds/MZJya5kq1XIVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfBYWae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 17:30:34 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38813 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfBYWae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 17:30:34 -0500
Received: by mail-oi1-f194.google.com with SMTP id q81so8703664oic.5;
        Mon, 25 Feb 2019 14:30:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0H1UNo5cnBzQ6xk3pF443nacMcRPoc4sMQBqMlH67WM=;
        b=bCJz8VfJKRZ2s82rhwsGlm3UDR7dT+t67WzXKbKwNUpM0aOC6i4S6bj/sKuDhjhlLd
         d9Lht5ZTqdvLGKMUqfNcQYEHYC8YtPcuY/2PrcoHlS3BYvyLICXCP4Xbc3xZ9lde+w+5
         oq46dQrfzCbZD75whPNKOqz+OmwpFmh6iFxprsdJQRYVvOmnph4Px0ocm7iyRmXrbpms
         Pb0ZLBY/o2RSsQGz1xiJi8oisqn0XjsDzcrR31bY2ycE2q48lLwzaLfhyvNJQk9iqHd4
         i2o2wIN0WpkZoYqKQ725lxeC/NUmYOk3FMSqqDF4UuhuJqYQvjBE/3sjK5Ir0sVNVp5A
         gZTQ==
X-Gm-Message-State: AHQUAubtWtG7A/tSItDZh507whYpO3MKjuOfN5OIiEYtLNHzh1rNCMGS
        G3Wa7QocBBFLaognoBgNijMyC5wUp6uN9nhLfKEo5R39
X-Google-Smtp-Source: AHgI3IbbcCEZzvJNaOzogXR16NVmv5uNIGRgl8l0BB8IKzI8Q5XCD2ZvRD4WoTmvZkcOZvwPt7crMexu8ico2zzKXQc=
X-Received: by 2002:aca:f4d3:: with SMTP id s202mr401553oih.178.1551133832532;
 Mon, 25 Feb 2019 14:30:32 -0800 (PST)
MIME-Version: 1.0
References: <20190214171017.9362-1-keith.busch@intel.com> <20190214171017.9362-8-keith.busch@intel.com>
 <CAJZ5v0gjv0DZvYMTPBLnUmMtu8=g0zFd4x-cpP11Kzv+6XCwUw@mail.gmail.com>
 <20190222184831.GF10237@localhost.localdomain> <CAJZ5v0hfQ5HWT0kfaOxSbpJvdqotsMWVBCZ6wiL4Tnuy+O5O7Q@mail.gmail.com>
 <20190225165118.GK10237@localhost.localdomain>
In-Reply-To: <20190225165118.GK10237@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Feb 2019 23:30:21 +0100
Message-ID: <CAJZ5v0h+YN=QYReLoeYMqM82Z1eaEk2kEy6jZ94JVe=-By8gTg@mail.gmail.com>
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

On Mon, Feb 25, 2019 at 5:51 PM Keith Busch <keith.busch@intel.com> wrote:
>
> On Sun, Feb 24, 2019 at 08:59:45PM +0100, Rafael J. Wysocki wrote:
> > On Fri, Feb 22, 2019 at 7:48 PM Keith Busch <keith.busch@intel.com> wrote:
> > > If I do it the other way around, that's going to make HMEM_REPORTING
> > > complicated if a non-ACPI implementation wants to report HMEM
> > > properties.
> >
> > But the mitigations that Dave was talking about get in the way, don't they?
> >
> > Say there is another Kconfig option,CACHE_MITIGATIONS, to enable them.
> > Then you want ACPI_HMAT to be set when that it set and you also want
> > ACPI_HMAT to be set when HMEM_REPORTING and ACPI_NUMA are both set.
> >
> > OTOH, you may not want HMEM_REPORTING to be set when CACHE_MITIGATIONS
> > is set, but that causes ACPI_HMAT to be set and which means that
> > ACPI_HMAT alone will not be sufficient to determine the
> > HMEM_REPORTING value.
>
> I can't think of when we'd want to suppress reporting these attributes
> to user space, but I can split HMAT enabling so it doesn't depend on
> HMEM_REPORTING just in case there really is an in-kernel user that
> definitely does not want the same attributes exported.

I'd rather simplify HMAT enabling than make it more complicated, so
splitting it would be worse than what you have already IMO.

> > Now, if you prompt for HMEM_REPORTING and make it depend on ACPI_NUMA,
> > then ACPI_HMAT can be selected by that (regardless of the
> > CACHE_MITIGATIONS value).
> >
> > And if someone wants to use HMEM_REPORTING without ACPI_NUMA, it can
> > be made depend on whatever new option is there for that non-ACPI
> > mechanism.
> >
> > There might be a problem if someone wanted to enable the alternative
> > way of HMEM_REPORTING if ACPI_NUMA was set (in which case HMAT would
> > have to be ignored even if it was present), but in that case there
> > would need to be an explicit way to choose between HMAT and non-HMAT
> > anyway.
> >
> > In any case, I prefer providers to be selected by consumers and not
> > the other way around, in case there are multiple consumers for one
> > provider.
>
> Well, the HMEM_REPORTING fundamentally has no dependency on any of these
> things and I've put some effort into making this part provider agnostic.

Which I agree with.

> I will change it if this concern is gating acceptance, but I don't
> think it's as intuitive for generic interfaces to be the selector for
> implementation specific providers.

That is sort of a chicken-and-egg issue about what is more fundamental
that could be discussed forever. :-)

My original point was that if you regard ACPI_HMAT as the more
fundamental thing, then you should prompt for it and select
HMEM_REPORTING automatically from there.  Or the other way around if
you regard HMEM_REPORTING as more fundamental.  Prompting for both of
them may lead to issues.

As long as that is taken into account, I'm basically fine with any of
the two choices.
