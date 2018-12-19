Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB82C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAA820989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="D5iR2auQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbeLTAAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 19:00:00 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:35610 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbeLTAAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 19:00:00 -0500
Received: by mail-ot1-f47.google.com with SMTP id 81so20809265otj.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 15:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkdIVWdTDcU1xAlF1lj1kMy0qu2e2ktPr6qOzABEZZw=;
        b=D5iR2auQeAkJcy2RIlJWyV8hJCi4rX31aDvHWJ/XrqpY5RBdVQQ4j/kIJk9P4kNB6V
         PkR17sh6hsn6irY3+twmGUkato5wBOs2NgWJ49aMg9ymbVgTdkGqZC9FrwbJaV3SGyfd
         7m3J09NCuzVIE98ONiaSrDRipHbxQobyhy7H//LRpLreNqOyAXzWNHnCA3Vix2FetM4G
         R2fKvIO8mMi9UDkOQ03xXGFSzHbNKvwP3u6TooTO5lFki8VQCmzZnfhd9GiIYPWxsDL7
         CtDJP7DSBWOjDwpvYm1aqcapckRNecVEO1ikUPxSZlR+w/1218z+iLkmZv7Aov7GxZ6c
         PCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkdIVWdTDcU1xAlF1lj1kMy0qu2e2ktPr6qOzABEZZw=;
        b=O+fJAeXaxD0j6T7a9bTj+FVsDxeYTDJf32OhOuSCKRIbdG98KgMlBb328pG0N74pRt
         0nfFJzWQUARX8sXP404EEb5wpuJ7U5bmJTosboZvJqxQ3D7YFUGR110t3ighnHxHHiQO
         4rd55zbdSMbZNhKHBNtwy7EGtF3OJUf9DqOMeuaSrEO44Lqu0xxy6ZQQbpUtD8+xWsyY
         9gxduTzT6x0yQUCXXR+mbZavxtrVXyQ1PNjVLNtWZEiCAkJZpCwQC3GNrwXqs8joxtTh
         1VS1q6c6DYsD0XzoZB8nR17Ka0Zz4jTOXbQvPzjHs2nkmIKrprGVmX9bz98HeHtCxIOB
         5p8A==
X-Gm-Message-State: AA+aEWZ9TiHpRVzB0t5KdNamh9enKpur+77Ukuq+M3f3XL83Iyr1kzk9
        TbJgyMUSkoxbMNbI4G3IhWG4AcVlgO7RX+hvBIOLRw==
X-Google-Smtp-Source: AFSGD/WS2KHJsqM1TylmXy7Ud7FMrXRTnO3MHsUGwRSwAxy4LESXXP49Yf/c1JAx51qEtdobE6hSJXSWEa/nisGqGeM=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr16558015oti.367.1545263999229;
 Wed, 19 Dec 2018 15:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20181211010310.8551-1-keith.busch@intel.com> <20181211010310.8551-2-keith.busch@intel.com>
 <CAJZ5v0iqC2CwR2nM7eF6pDcJe2Me-_fFekX=s16-1TGZ6f6gcA@mail.gmail.com> <CF6A88132359CE47947DB4C6E1709ED53C557D62@ORSMSX122.amr.corp.intel.com>
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C557D62@ORSMSX122.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 Dec 2018 15:59:48 -0800
Message-ID: <CAPcyv4jmGH0FS8iBP9=A-nicNfgHAmU+nBHsGgxyS3RNZ9tV5Q@mail.gmail.com>
Subject: Re: [PATCHv2 01/12] acpi: Create subtable parsing infrastructure
To:     "Schmauss, Erik" <erik.schmauss@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 3:19 PM Schmauss, Erik <erik.schmauss@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > Sent: Tuesday, December 11, 2018 1:45 AM
> > To: Busch, Keith <keith.busch@intel.com>
> > Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; ACPI Devel
> > Maling List <linux-acpi@vger.kernel.org>; Linux Memory Management List
> > <linux-mm@kvack.org>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; Rafael J. Wysocki <rafael@kernel.org>;
> > Hansen, Dave <dave.hansen@intel.com>; Williams, Dan J
> > <dan.j.williams@intel.com>
> > Subject: Re: [PATCHv2 01/12] acpi: Create subtable parsing infrastructure
> >
> > On Tue, Dec 11, 2018 at 2:05 AM Keith Busch <keith.busch@intel.com>
> > wrote:
> > >
>
> Hi Rafael and Bob,
>
> > > Parsing entries in an ACPI table had assumed a generic header
> > > structure that is most common. There is no standard ACPI header,
> > > though, so less common types would need custom parsers if they want go
> > > through their sub-table entry list.
> >
> > It looks like the problem at hand is that acpi_hmat_structure is incompatible
> > with acpi_subtable_header because of the different layout and field sizes.
>
> Just out of curiosity, why don't we use ACPICA code to parse static ACPI tables
> in Linux?
>
> We have a disassembler for static tables that parses all supported tables. This
> seems like a duplication of code/effort...

Oh, I thought acpi_table_parse_entries() was the common code. What's
the ACPICA duplicate?
