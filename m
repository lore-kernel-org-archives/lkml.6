Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2FFC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B047A2183F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="dAdlCps/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfAGP54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:57:56 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46154 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfAGP5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:57:55 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so1320560edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 07:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TidIADdjCwnRgzsBcRP1UeEULkHESer3HI9ddcF9f7E=;
        b=dAdlCps/T+ADFgpLeqFaZkFbLtkaZSl77ci7PFBLnpcctqWVA1hUlBYdLTPGu6h8Uv
         qIf+AD1ymqWBz4tfClmtiqvXEbyEn42ujEj/CC59OhUkBZATSZc8wN6lhU6jw6+M9Fyb
         X0GeFlsExAqqR78NDs6maLaLU9EaESqce2dm4zGziZqxqa153d12wo8TvnfaQqrXNlNC
         sHO9dHv8a/H0QipmP+/X55K82PtDfQl1kgmV9ebAiY+fqFkeOFSXfNEOC9ABVUBfRARm
         IVwc3ck5vbpvQocTd3xjI4YQoUh6vV88efNcbHn+egTQSD0faVXP4/yKBQTMwn9VDcTo
         Lh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TidIADdjCwnRgzsBcRP1UeEULkHESer3HI9ddcF9f7E=;
        b=jQ3FkgSV9oVxfgcmOP2R9A4q2z7uVR4o+mgKixNAnOT0INWQUk7A0aQCs+ZcWUy/gz
         MdWznRCCgUhwo7k3HeMeXsPrGjeSY6yHGSCKXJXj6zp9Cm+59FPOrkbWAJtrwiwUmmqe
         ZcTW25SV/PHPs/GSctOWv2Dh4EAjGX3jgqVwIt5rUAiC937XZ20wMmKK6/vbawHoLQ0B
         GrPNxHFY66fJYM/aGDJCURzOcBtKAJkImrbu6ealUoQTNiUH1g9vEfQyz2MaCAGJD8+e
         KY9nm5YJMIxujvf8mmjb2XsJ/Hv8f+MV+fwX8FrSSDuks+xtLEfmzB7vbYOnfWMsio2n
         ChrQ==
X-Gm-Message-State: AA+aEWYB3jjMb6jpOykzxKNGQO6/f6CLYceiqJrgXxnOczA861yEX6iN
        A1kSiJ5wn5eOQLMuqgJ+LXboxw==
X-Google-Smtp-Source: AFSGD/XTsSqXkH96GBcf8qSMZKRzMt9amwasVuewYzhmC543lD9Fg3P0vcPuCGItCTgdBeU7GU0Dww==
X-Received: by 2002:a17:906:2615:: with SMTP id h21-v6mr48067669ejc.21.1546876673828;
        Mon, 07 Jan 2019 07:57:53 -0800 (PST)
Received: from localhost (0547277e.skybroadband.com. [5.71.39.126])
        by smtp.gmail.com with ESMTPSA id j8sm29619888ede.55.2019.01.07.07.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 07:57:53 -0800 (PST)
Date:   Mon, 7 Jan 2019 15:57:52 +0000
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "bhsharma@redhat.com" <bhsharma@redhat.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "joe@perches.com" <joe@perches.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sedat.dilek@gmail.com" <sedat.dilek@gmail.com>,
        "zhuyifei1999@gmail.com" <zhuyifei1999@gmail.com>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
Subject: Re: [tip:efi/core] x86/efi: Unmap EFI boot services code/data
 regions from efi_pgd
Message-ID: <20190107155356.GA7578@codeblueprint.co.uk>
References: <FFF73D592F13FD46B8700F0A279B802F48604575@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu_vTHFxpKRu_CxKP-GdNdgdFKr7fi87VkNur0sqGQNVDw@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F486045CA@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu9iJinkP-buhmzRyB91_HcJ-tDwT3YHeHGFo4Bsiv7O_Q@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F486046A9@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu99VdPero0yrXiaByURyp1idYE948Qi4j1eqY0ENCrF5A@mail.gmail.com>
 <20181221171308.GJ1325@zn.tnic>
 <CAKv+Gu91YsuK2QmWStPe84v8L7XD9x4cduTYgUjj3TPRfQckfw@mail.gmail.com>
 <20181221192928.GM1325@zn.tnic>
 <CAKv+Gu-v+nBh2yK0uXbuwwnpEnpG8bk4ufSMXygMOdOd2XSTYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-v+nBh2yK0uXbuwwnpEnpG8bk4ufSMXygMOdOd2XSTYw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec, at 12:07:48PM, Ard Biesheuvel wrote:
> On Fri, 21 Dec 2018 at 20:29, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Dec 21, 2018 at 06:26:23PM +0100, Ard Biesheuvel wrote:
> > > On Fri, 21 Dec 2018 at 18:13, Borislav Petkov <bp@alien8.de> wrote:
> > > >
> > > > On Fri, Dec 21, 2018 at 06:02:29PM +0100, Ard Biesheuvel wrote:
> > > > > As far as I can tell, the SGI x86 UV platforms still rely on this, so
> > > > > we're stuck with it for the foreseeable future.
> > > >
> > > > What happened with the old apple laptops which couldn't handle high
> > > > virtual mappings and needed 1:1? We don't care anymore?
> > > >
> > >
> > > If that is the case (I wouldn't know) then yes, there is a second
> > > reason why we need to keep this code.
> >
> > Fleming knows details and he's on CC, lemme "pull" him up into To: :-)
> >
> 
> IIUC the 1:1 mapping and the 'old' mapping are two different things,
> and the new mapping also contains a 1:1 mapping of the boot services
> regions, at least until SetVirtualAddressMap() returns.

Yep, they're different. And yes the 1:1 mapping should stick around
with the new scheme IIRC (it's been a while).
