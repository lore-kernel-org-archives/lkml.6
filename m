Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F385DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AC12176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545296246;
	bh=GEf+k5Uk0Mg9MUszfBZKGx3K/s+PTmCHTwwdSu6EEiw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fYoDW4bGASb+Tzp3RocYP8xEvnxcjjfaz1WUgrL77KUyHQabBA1Tv+DXrHt2r1tCK
	 uvXs4ok//5bPUao3ZQsEye1pVxFqczH7lgagfEjNFXXSUF4nnKBjJLwoSkW35D5RM3
	 VxGr0RmSvg3UJEzWpepbYnOed+zoi0/f/x23likE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbeLTI50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:57:26 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40342 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeLTI5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:57:25 -0500
Received: by mail-oi1-f196.google.com with SMTP id t204so766656oie.7;
        Thu, 20 Dec 2018 00:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEf+k5Uk0Mg9MUszfBZKGx3K/s+PTmCHTwwdSu6EEiw=;
        b=s4SIsRyagOu12eOjzF80f4+h/ppUrSMXGnvhFkxoOHmSEDRG5mPfGQ1/HRjb+t+3fE
         hs8/3N1wz9umJjDAYmsQ6R70Ls+CyABC0sZjTgrlQwvtS3Al4Z7SFvPNYNLC9U6TUT6T
         rtYDLxODdfuccyeUpkERZSMsP+8HoLXh9+0vyVnXB6Xj0obFEa+l6avQRCY+PuBTB0OF
         Q0anen7vLzO6tz2HuyV5aHW8GhkqLOKV3C4t9odwrNpSJaRVfSkX86dta8QfItBlX+ei
         T8LolPNhN65QfV7AmunQzoR7aMkLW2lonGVfUG9+TaAmfKEjcvFWqRninX027RZ3YyI/
         4xdA==
X-Gm-Message-State: AA+aEWaypqmtsZtxuY+kWaJufIHgNxVSyZ+6AyoG6QAASDFmz2CppBO5
        2uNSCjE9BKo2iVBW8lOPZSCFNfPCu5Ugb3Z9Pa8=
X-Google-Smtp-Source: AFSGD/VK5FQ9u6F30dguE4o5lCq0kRVgMcnSXhynI4ll2d+ouXBYUwFl8QYUBQMA7AZcX3+JSMv0jQDxBh8LiDVoxew=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr1408656oia.95.1545296243439;
 Thu, 20 Dec 2018 00:57:23 -0800 (PST)
MIME-Version: 1.0
References: <20181211010310.8551-1-keith.busch@intel.com> <20181211010310.8551-2-keith.busch@intel.com>
 <CAJZ5v0iqC2CwR2nM7eF6pDcJe2Me-_fFekX=s16-1TGZ6f6gcA@mail.gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C557D62@ORSMSX122.amr.corp.intel.com>
 <CAPcyv4jmGH0FS8iBP9=A-nicNfgHAmU+nBHsGgxyS3RNZ9tV5Q@mail.gmail.com> <CF6A88132359CE47947DB4C6E1709ED53C557DAB@ORSMSX122.amr.corp.intel.com>
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C557DAB@ORSMSX122.amr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Dec 2018 09:57:11 +0100
Message-ID: <CAJZ5v0iMf15tC6xLwCC8G2DuDazvznPe-BGJ7F+_r384wBRCCA@mail.gmail.com>
Subject: Re: [PATCHv2 01/12] acpi: Create subtable parsing infrastructure
To:     "Schmauss, Erik" <erik.schmauss@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 2:15 AM Schmauss, Erik <erik.schmauss@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > owner@vger.kernel.org] On Behalf Of Dan Williams
> > Sent: Wednesday, December 19, 2018 4:00 PM
> > To: Schmauss, Erik <erik.schmauss@intel.com>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>; Busch, Keith
> > <keith.busch@intel.com>; Moore, Robert <robert.moore@intel.com>;
> > Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; ACPI Devel
> > Maling List <linux-acpi@vger.kernel.org>; Linux Memory Management
> > List <linux-mm@kvack.org>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; Hansen, Dave
> > <dave.hansen@intel.com>
> > Subject: Re: [PATCHv2 01/12] acpi: Create subtable parsing
> > infrastructure
> >
> > On Wed, Dec 19, 2018 at 3:19 PM Schmauss, Erik
> > <erik.schmauss@intel.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > > > owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > > > Sent: Tuesday, December 11, 2018 1:45 AM
> > > > To: Busch, Keith <keith.busch@intel.com>
> > > > Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; ACPI
> > > > Devel Maling List <linux-acpi@vger.kernel.org>; Linux Memory
> > > > Management List <linux-mm@kvack.org>; Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org>; Rafael J. Wysocki
> > <rafael@kernel.org>;
> > > > Hansen, Dave <dave.hansen@intel.com>; Williams, Dan J
> > > > <dan.j.williams@intel.com>
> > > > Subject: Re: [PATCHv2 01/12] acpi: Create subtable parsing
> > > > infrastructure
> > > >
> > > > On Tue, Dec 11, 2018 at 2:05 AM Keith Busch
> > <keith.busch@intel.com>
> > > > wrote:
> > > > >
> > >
> > > Hi Rafael and Bob,
> > >
> > > > > Parsing entries in an ACPI table had assumed a generic header
> > > > > structure that is most common. There is no standard ACPI
> > header,
> > > > > though, so less common types would need custom parsers if they
> > > > > want go through their sub-table entry list.
> > > >
> > > > It looks like the problem at hand is that acpi_hmat_structure is
> > > > incompatible with acpi_subtable_header because of the different
> > layout and field sizes.
> > >
> > > Just out of curiosity, why don't we use ACPICA code to parse static
> > > ACPI tables in Linux?
> > >
> > > We have a disassembler for static tables that parses all supported
> > > tables. This seems like a duplication of code/effort...
> >
> Hi Dan,
>
> > Oh, I thought acpi_table_parse_entries() was the common code.
> > What's the ACPICA duplicate?
>
> I was thinking AcpiDmDumpTable(). After looking at this ACPICA code,
> I realized that the this ACPICA doesn't actually build a parse tree or data structure.
> It loops over the data structure to format the input ACPI table to a file.
>
> To me, it seems like a good idea for Linux and ACPICA to share the same code when
> parsing and analyzing these structures. I know that Linux may emit warnings
> that are specific to Linux but there are structural analyses that should be the same (such as
> checking lengths of tables and subtables so that we don't have out of bounds access).

I agree.

I guess the reason why it has not been done this way was because
nobody thought about it. :-)

So a project to consolidate these things might be a good one.
