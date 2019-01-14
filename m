Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A442C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388BD206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="i5CYrJ5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfANQsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:48:02 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40741 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfANQsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:48:01 -0500
Received: by mail-oi1-f195.google.com with SMTP id t204so18384464oie.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FcB/VpFkFjmPCsHlU5bJd9NSzPUiF9AwSBgA8CBKzGs=;
        b=i5CYrJ5RSrWk9LqKndF0DW6j6SBwv9X6ZeJbeSfiLBD2Q4k9135mWmklJ0Z6W4HJ4R
         3tkNjFUcZFWowZOGsNlFguDK/Wwb52BDfVRH/wPWGuxrLQwCXITtYKkQsxxwmFXP1XCX
         XDtjuwfpsA0p/rfSbZVoHpW0B8bJBmvSOlKiom0WN0dJ/YT6Zk1JpAG06l+JcifzsvrQ
         J9MCjf9/iJ+owk1AZxNlYIPhIdr2yRZzXtL7lg0h08kXuVSNheEgi1NjBaepQWzjvQ57
         dwnTbaUhQVtJ76QNxP+Ms9hAhyPzqZuuwd5JXvBKiEFY0qbxaXfc34ZAImQGoaTqVXSU
         B9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FcB/VpFkFjmPCsHlU5bJd9NSzPUiF9AwSBgA8CBKzGs=;
        b=c8zeEkHPmrwvKvUwuZ876dqyvMsgNqYsNkNsLfcUZK8Vn7ZP98wgvMjGEwRppZI7LW
         Cl/lysJC7mUvNRDPymobGCsnJVRP91VpUF79nQh1wJv5aUhVbpCt3Kat4QX6TNpAEEyF
         U/7MJlkPzb1KRklGxjykOc3sjkiJICKnsFpZac8h2jgZD7CVHESZsA0RD8Lhz/mbdsjE
         WtXoH/SiHM9PQYHBqu+WaywkCRAtnnTTSnAf0kxESP4UgVZ2A1zmOcdfnPMyPIlyzRUU
         us8ilO6Y0LjnLpEckxq+0K350BaDJysrzHtPLu27NLKr/emhK0VVDHFj+lU0AvZCk75V
         CfPQ==
X-Gm-Message-State: AJcUukdgLobwUzJNTBlekwpTSzppPscpS2XBxJMOmkPEUV0fHRHhOnbr
        yYeTjBOYkK8Xum3DWxp+T/Mx0xVhnBkIJz6Rg5kTdA==
X-Google-Smtp-Source: ALg8bN5zfBGbK66qUDEl/ucwy4qDOiZJnLWNZbe+UvWBLNP+A19xctcidqZs7untOW9coRNnzQCDQjo+7680jNhqJ0s=
X-Received: by 2002:aca:b804:: with SMTP id i4mr15855789oif.280.1547484481013;
 Mon, 14 Jan 2019 08:48:01 -0800 (PST)
MIME-Version: 1.0
References: <154725096972.1367907.12968253382302127133.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49sgxvclmu.fsf@redhat.com> <CAPcyv4hLGB-=UcHykgAO5X3Oakp_erw_62_gpUD2cqXLXKpJVQ@mail.gmail.com>
In-Reply-To: <CAPcyv4hLGB-=UcHykgAO5X3Oakp_erw_62_gpUD2cqXLXKpJVQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 14 Jan 2019 08:47:49 -0800
Message-ID: <CAPcyv4hANufJYNnu+tc5yaun3xG8Ht6MirobG4Fj_CaafXE+7g@mail.gmail.com>
Subject: Re: [PATCH] acpi/nfit: Fix command-supported detection
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Sujith Pandel <sujith_pandel@dell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 8:43 AM Dan Williams <dan.j.williams@intel.com> wrote:
> On Mon, Jan 14, 2019 at 7:19 AM Jeff Moyer <jmoyer@redhat.com> wrote:
[..]
> > > +
> > > +     if (cmd == ND_CMD_CALL) {
> > > +             int i;
> > > +
> > > +             if (call_pkg && nfit_mem->family != call_pkg->nd_family)
> > > +                     return -ENOTTY;
> > > +
> > > +             for (i = 0; i < ARRAY_SIZE(call_pkg->nd_reserved2); i++)
> > > +                     if (call_pkg->nd_reserved2[i])
> > > +                             return -EINVAL;
> > > +             return call_pkg->nd_command;
> > > +     }
> > > +
> > > +     /* Linux ND commands == NVDIMM_FAMILY_INTEL function numbers */
> > > +     if (nfit_mem->family == NVDIMM_FAMILY_INTEL)
> > > +             return cmd;
> > > +     return 0;
> >
> > Function zero?  Is that really the right thing to return here?
>
> Yes, function zero is never set in n

...whoops fumble fingered "send"

Function zero should never be set in nfit_mem->dsm_mask, although the
NVDIMM_FAMILY_MSFT mask violates this assumption. I'll fix that up.
