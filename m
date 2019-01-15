Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A30C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B0720657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547577378;
	bh=6whWxQj1PvY5/IZ0ONf2GRXd2Bc5qbpQtwcWDSqd98E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Y1MlfwDkRUNE4Zr0IVZr1rajB5G5LEYU+pSrcRHWLcQ4rPfZ9LGjvKJM0e4EJW8E3
	 qDKzoPUBUFw1IV+ZZM5knr6dGenWMP/B+oQBQ+c0Ve5hM6FvMrk9hta39f2R7vI+Ml
	 sRGdIfeO/Vqapru1dyNJKCCUtCQC8VzTkmvO7Qao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388754AbfAOSgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:36:16 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:45655 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfAOSgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:36:15 -0500
Received: by mail-ot1-f43.google.com with SMTP id 32so3395448ota.12;
        Tue, 15 Jan 2019 10:36:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6whWxQj1PvY5/IZ0ONf2GRXd2Bc5qbpQtwcWDSqd98E=;
        b=EIXwDf5UTGX7jyY2Wr2zdwt7a9lpojl9zIrDHxnezGDigdL+drfftIrVogLlYzek1L
         d0hs+Pq2fzZKjupQUoDdGwsZbB8oseja2k7F/Xl6fIN6EWDvJIIc+CdYSzkx1GX+rfpi
         u5P/X9WtG75oDRf077Hv0GuoXdRaX9YHTH55FEWVF6ZPAwKv2zClYPIoBiPXm+ey50PG
         FhFTRCqb3xzWCruB2gjUIHZMMJOQowTsnGphX0uRVJ1mYjFxpaMLu8HxLtSbWXUdg4R2
         fYUCJZE+2mKHSI0aColmJmmfoOS/07d1XFLlXwweK2tixBO7LDSYDFM6OsTOXUYraJK2
         poEg==
X-Gm-Message-State: AJcUukeyiyZwBubdfHEiKh7OPP2rj63yhLTEBoveXFVEyRuYkCYKR7p2
        Tyx6iaaePsf0XcMJkJjhoWvqHxhwXX7Hd7GYPGk=
X-Google-Smtp-Source: ALg8bN7DseTTxUHUENdb528u6E1TBRIwSxqG5pbAKxMPUMw2+g6sVORGUH2S/S3Y5FxtVxtpmEw/tPK3vzccvQVv4Bg=
X-Received: by 2002:a9d:7f0d:: with SMTP id j13mr2996913otq.119.1547577374860;
 Tue, 15 Jan 2019 10:36:14 -0800 (PST)
MIME-Version: 1.0
References: <20190109174341.19818-1-keith.busch@intel.com> <20190109174341.19818-4-keith.busch@intel.com>
 <CAJZ5v0jk7ML21zxGwf9GaGNK8tP1LAs6Rd9NTK5O9HbzYeyPLA@mail.gmail.com> <20190115170741.GB27730@localhost.localdomain>
In-Reply-To: <20190115170741.GB27730@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Jan 2019 19:36:03 +0100
Message-ID: <CAJZ5v0iZ_i9vOPJgn69T=f8KE=fFm1vQt2AuEaNDGpn3E_cL3g@mail.gmail.com>
Subject: Re: [PATCHv3 03/13] acpi/hmat: Parse and report heterogeneous memory
To:     Keith Busch <keith.busch@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 6:09 PM Keith Busch <keith.busch@intel.com> wrote:
>
> On Thu, Jan 10, 2019 at 07:42:46AM -0800, Rafael J. Wysocki wrote:
> > On Wed, Jan 9, 2019 at 6:47 PM Keith Busch <keith.busch@intel.com> wrote:
> > >
> > > Systems may provide different memory types and export this information
> > > in the ACPI Heterogeneous Memory Attribute Table (HMAT). Parse these
> > > tables provided by the platform and report the memory access and caching
> > > attributes.
> > >
> > > Signed-off-by: Keith Busch <keith.busch@intel.com>
> >
> > While this is generally fine by me, it's another piece of code going
> > under drivers/acpi/ just because it happens to use ACPI to extract
> > some information from the platform firmware.
> >
> > Isn't there any better place for it?
>
> I've tried to abstract the user visible parts outside any particular
> firmware implementation, but HMAT parsing is an ACPI specific feature,
> so I thought ACPI was a good home for this part. I'm open to suggestions
> if there's a better place. Either under in another existing subsystem,
> or create a new one under drivers/hmat/?

Well, there is drivers/acpi/nfit for the NVDIMM-related things, so
maybe there could be drivers/acpi/mm/ containing nfit/ and hmat.c (and
maybe some other mm-related things)?
