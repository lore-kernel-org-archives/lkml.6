Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857FEC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522C521726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548176100;
	bh=My3dZ9/2oHNnBsx9uxWxM2iUi6CN09pg2wApri8QfyU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oh8PlIq/qqx38EIUepm6lvh2qZJYQIfwfQLP2IrsWybfvJqqtO5rdGt8eAkiHaZ+x
	 yuTPxPH/LJ+oldfryV+6lkKjw2jPb93R0se/soSg2eR+q6wiLX5TFnLKUj8jsmQDOr
	 +S7mlDid05d2VtNkhnOZa+EqlwMMZbR5QnSxi6NM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfAVQy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:54:58 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:35169 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbfAVQy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:54:57 -0500
Received: by mail-ot1-f53.google.com with SMTP id 81so24296408otj.2;
        Tue, 22 Jan 2019 08:54:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10akT0bp1NHa/2U4y1Gem6h2yLdRu35gxbi/m3mvu2Q=;
        b=kYf2rpWwRce+9PSj/8yX9xKCEAERxJKq3fv7jLtV6F9TtbKPkE5pnfgLoOrSoG5N2V
         73ESffpPnRKyzH5q0oHOjg9HmMExeL602CRGnY8om5JT4RdDYC2aU/y8N8NoM9WCvbPx
         Pw30D4dAtzr4EUHfMh6l5bieUpujX7vUDxldKyhljfJzOoroeZLpeyqiwsbSrX4BumUu
         wjUFnUxbtlAldN0+Vh7smfdyPGSHwawP9KKknX9/RchqKc6YLBVBb8Bv0UCFcZvo/W0T
         fB5iw/qxOaapohb//cOc766FDzCAj1qsqNC05my8I0SFD4brxv0y7/gsuV0yyi/CYDIw
         mN7A==
X-Gm-Message-State: AJcUukdcT0n206MfAmStEEyPX+zViSnjGNcraWlvQnQ2x0s/Rib322Ki
        zvVYwplzEA0sfME3TVnlhexQe41nslAUefYRQEqmOHiy
X-Google-Smtp-Source: ALg8bN7/pj42bfI8MW2bGnxgQF7xVHkxCJOb9VEFnDvIEb8DKD9g0HZa8+FBZ9rVqFp0rnIb5zJLxmr2py7CtonYb70=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr23381958otg.139.1548176096957;
 Tue, 22 Jan 2019 08:54:56 -0800 (PST)
MIME-Version: 1.0
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-6-keith.busch@intel.com>
 <CAJZ5v0jmkyrNBHzqHsOuWjLXF34tq83VnEhdBWrdFqxyiXC=cw@mail.gmail.com>
 <CAPcyv4gH0_e_NFJNOFH4XXarSs7+TOj4nT0r-D33ZGNCfqBdxg@mail.gmail.com>
 <20190119090129.GC10836@kroah.com> <CAJZ5v0jxuLPUvwr-hYstgC-7BKDwqkJpep94rnnUFvFhKG4W3g@mail.gmail.com>
 <20190122163650.GD1477@localhost.localdomain> <CAJZ5v0ggO9DePeYJkEoZ-ymB5VQywBgTnsGBo4WPHD5_JrjKRA@mail.gmail.com>
In-Reply-To: <CAJZ5v0ggO9DePeYJkEoZ-ymB5VQywBgTnsGBo4WPHD5_JrjKRA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jan 2019 17:54:45 +0100
Message-ID: <CAJZ5v0h1Q_dtJu7eXvs-7-bFRBBhLC158H1FKv96nE87rHv40A@mail.gmail.com>
Subject: Re: [PATCHv4 05/13] Documentation/ABI: Add new node sysfs attributes
To:     Keith Busch <keith.busch@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 5:51 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jan 22, 2019 at 5:37 PM Keith Busch <keith.busch@intel.com> wrote:
> >
> > On Sun, Jan 20, 2019 at 05:16:05PM +0100, Rafael J. Wysocki wrote:
> > > On Sat, Jan 19, 2019 at 10:01 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > If you do a subdirectory "correctly" (i.e. a name for an attribute
> > > > group), that's fine.
> > >
> > > Yes, that's what I was thinking about: along the lines of the "power"
> > > group under device kobjects.
> >
> > We can't append symlinks to an attribute group, though.
>
> That's right, unfortunately.

Scratch this.

You can add them using sysfs_add_link_to_group().  For example, see
what acpi_power_expose_list() does.
