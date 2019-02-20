Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACAEC10F07
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE81520880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550701031;
	bh=02ms/63ufns/530szRZo/TcLkPI86KtEFV1vOaOm+Gg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rG6sO3wKAbQydoD/nZDHRbQrARSCrddvpRetw/mDHPxp4gh+YjMOqGOvlwg8umcAD
	 1suSl+syGXWVhypagiFbXrFujHj7Lkog+zM4QwwRwzVNQCGBVJp6QJWUJLua3yqtNG
	 1slxSm9D2ordY+wi2ZQBGAQNsZ0iABHgZPUoMVoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfBTWRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:17:10 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33875 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfBTWRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:17:10 -0500
Received: by mail-ot1-f65.google.com with SMTP id 98so43080697oty.1;
        Wed, 20 Feb 2019 14:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aZiSJ5zHvIOHDPPsq+gJj9k0t/TVuDTgJuAZIqMAxis=;
        b=bMnodD+5dvJEL9PGg/v0ITjwbQrqBXGUHx+wpNtybercc6Arz0BxqMfsKIhMkz2UxN
         0V/ezxzv2+FsyrGdBIB7WdC6JQ3yt1Lyttd8XuFMcrx0E01tMdnemFnwg10C/LwRvkn6
         3nx26rsNgCSgZJTCeV5VMyqVXcrnY3MOewzctcuugBrpMOw7Tbstx6NJO9be4uOZorq9
         EXUVO6KMi9M6g/bpYCFOwGzqZN2Y8zwkMJ+x3WPN9CYsgu7VraX8+55W8cZ67rYVzx7C
         YOaGE/eU3gsxk6ad9e5qmJGXikLxF4As06iAbuvvyId5G7i5kUt+IDc8LaS8VfqBeOiP
         cmwg==
X-Gm-Message-State: AHQUAubIj2cN6f2F3rn1jd9x5/FMG8XeanVJtvwBmUoFzguvvt/yr2r/
        UxVhZOZDKLIW+7ymcKQFBaKVFMEpm7uR0jsXxmM=
X-Google-Smtp-Source: AHgI3IYdg4Ic4DZNMP9CEt1r6Bd1F1fVzuO3jiNBVrgeqfuxI5QgCkmTc5WdvQJDoNqBgGSLF4P7w/0AjFyNExUXr5Y=
X-Received: by 2002:aca:c141:: with SMTP id r62mr7065095oif.160.1550701029508;
 Wed, 20 Feb 2019 14:17:09 -0800 (PST)
MIME-Version: 1.0
References: <20190214171017.9362-1-keith.busch@intel.com> <20190214171017.9362-8-keith.busch@intel.com>
 <CAJZ5v0gjv0DZvYMTPBLnUmMtu8=g0zFd4x-cpP11Kzv+6XCwUw@mail.gmail.com>
 <9ab5d6ba-4cb6-a6f1-894d-d79b77c8bc21@intel.com> <CAPcyv4iP032bqAgCZ8czRXkJ_gXz0H1EVC+ypf6NhKQ65aKczg@mail.gmail.com>
In-Reply-To: <CAPcyv4iP032bqAgCZ8czRXkJ_gXz0H1EVC+ypf6NhKQ65aKczg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Feb 2019 23:16:58 +0100
Message-ID: <CAJZ5v0hwyXnsLmCKNJvzOvcG-HD1UmuWNGFvoB02=2Ks1hE0bA@mail.gmail.com>
Subject: Re: [PATCHv6 07/10] acpi/hmat: Register processor domain to its memory
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 11:14 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Feb 20, 2019 at 2:11 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 2/20/19 2:02 PM, Rafael J. Wysocki wrote:
> > >> diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/hmat/Kconfig
> > >> index c9637e2e7514..08e972ead159 100644
> > >> --- a/drivers/acpi/hmat/Kconfig
> > >> +++ b/drivers/acpi/hmat/Kconfig
> > >> @@ -2,6 +2,7 @@
> > >>  config ACPI_HMAT
> > >>         bool "ACPI Heterogeneous Memory Attribute Table Support"
> > >>         depends on ACPI_NUMA
> > >> +       select HMEM_REPORTING
> > > If you want to do this here, I'm not sure that defining HMEM_REPORTING
> > > as a user-selectable option is a good idea.  In particular, I don't
> > > really think that setting ACPI_HMAT without it makes a lot of sense.
> > > Apart from this, the patch looks reasonable to me.
> >
> > I guess the question is whether we would want to allow folks to consume
> > the HMAT inside the kernel while not reporting it out via
> > HMEM_REPORTING.  We have some in-kernel users of the HMAT lined up like
> > mitigations for memory-side caches.
> >
> > It's certainly possible that folks would want to consume those
> > mitigations without anything in sysfs.  They might not even want or need
> > NUMA support itself, for instance.
> >
> > So, what should we do?
> >
> > config HMEM_REPORTING
> >         bool # no user-visible prompt
> >         default y if ACPI_HMAT
> >
> > So folks can override in their .config, but they don't see a prompt?
>
> I would add an "&& ACPI_NUMA" to that default as well.

But ACPI_HMAT depends on ACPI_NUMA already, or am I missing anything?
