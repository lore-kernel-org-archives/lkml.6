Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D35C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF29A20851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544566596;
	bh=bxGMdLW9iozKcZQ5uq6UHyiDdW/t4w9dCuMbjm5XC4g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ovLmsKwCslQZ4og2qZ671yTVjsgUTHlm2HB8jaHf3mE9/A7w71pHYP5nBk8YiXH9S
	 BC40OJ6vNeTYRl/9B6NWLe0kr8goV592rE09NRH5pt2l/FGzR8dMClgpri6fuui4Nt
	 UuCbDW53V1SpS2Tq9uXYttqH1i7ek5GKJDBDyNto=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF29A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbeLKWQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:16:35 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43084 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbeLKWQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:16:34 -0500
Received: by mail-oi1-f196.google.com with SMTP id u18so13381834oie.10;
        Tue, 11 Dec 2018 14:16:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cq6WvAF7qrqngI0ZO6SgAyV0Mg+pnA2WeEZIZT6IIzA=;
        b=ZgMsvRKw6FFY3yFL4puYgQ5WwFENW6aUdQzUJHDoLXnuD2RkoyOPyxSzdRU1b15gN2
         FuCy6A/GER1yWAHdQgFhvwot1oSl1IIqWeB+LdSya3F01eEFXer1rb2iosp84e2dMxQc
         /3Op9zW7PRJlEx1AKM+EEHi8EUAK9xqVTPLpriS/93W/VwkJPRI7VmOWZpm9ErsknwdU
         4+R3I5XykHZTRP1m5anEvWNEFJeBhmbaSlvaaUnmn0JRXIPd1nX01jyDigFVMLP5KwvL
         7dQCN23WC5eIkae8LHy2AJXe0yByylXKVY+wt2uR6hoJe2L2/IoQsNkTk6bPNibsRRo/
         9w5A==
X-Gm-Message-State: AA+aEWbI6UY5Z6MiMzAgExqEkl67f0JGKUTZZ/B063h4IbHd2Dwpkh8t
        LRtRUI6Jr5LnG7g5UdyA+wmzIzDVFYD0tNnqYZyhVw==
X-Google-Smtp-Source: AFSGD/WM8sR0e9WLnTC7oDzYMmI6NtwQIdc0O+scapBJgZhy1CcJdYUmbEfiFadSqaSf6k/Ir6AHVkIU99uIQVp93zE=
X-Received: by 2002:aca:a698:: with SMTP id t24mr2390688oij.76.1544566593769;
 Tue, 11 Dec 2018 14:16:33 -0800 (PST)
MIME-Version: 1.0
References: <20181210181315.5023-1-okaya@kernel.org> <20181210181315.5023-2-okaya@kernel.org>
 <20181211170957.GA335@infradead.org> <342c5dd9-cb3d-d714-c87f-814a942cf395@kernel.org>
 <CAJZ5v0ia+eotSZgjbitt7TAT0ECSmTAz1XJhS3Auz5w5Z61SZA@mail.gmail.com> <a9c7cbe1-eef3-40ad-de62-8194df12ca20@kernel.org>
In-Reply-To: <a9c7cbe1-eef3-40ad-de62-8194df12ca20@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Dec 2018 23:16:23 +0100
Message-ID: <CAJZ5v0g5t4sx6mY=mCPWOdZLbhEAXo5Ah1TZw9jZNJQ-+cgWsw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ACPI / OSL: Allow PCI to be disabled
To:     okaya@kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:57 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 12/11/2018 4:46 PM, Rafael J. Wysocki wrote:
> > On Tue, Dec 11, 2018 at 6:37 PM Sinan Kaya <okaya@kernel.org> wrote:
> >>
> >> On 12/11/2018 12:09 PM, Christoph Hellwig wrote:
> >>> On Mon, Dec 10, 2018 at 06:13:14PM +0000, Sinan Kaya wrote:
> >>>> Getting ready to allow PCI to be disabled with ACPI enabled. Stub
> >>>> out calls that depend on PCI.
> >>>
> >>> I think you want to skip building at least all of hwpci.c if CONFIG_PCI
> >>> is disabled.  Or replace that whole stiking pile of crap with something
> >>> resembling C code..
> >>>
> >>
> >> I can give it a try but I'm under the impression that we don't touch
> >> ACPICA code in general.
> >>
> >> Feel free to correct me.
> >
> > We don't as a rule, but depending on what the patch looks like, we
> > might not follow the rule this time.
> >
>
> OK. Good to know. I'll take a stab at it.
>
> > I wonder though what we do if some AML wants to access PCI config
> > space via an opregion in there.  Have you thought about that?
> >
>
> Return an error.
>
> AFAIK, ACPI spec says that AML code running on non-existing op-regions to be
> discarded last time I checked.

I guess you mean "disregarded"?

So the spec appears to expect the OS to silently ignore the failures
in those cases, so why should an error be returned?

> I know Linux is noisy about these.
>
> I did boot QEMU without CONFIG_PCI. There was a bunch of ACPI errors reported
> during boot as expected but boot succeeded. There was no hard lockup/failure.
