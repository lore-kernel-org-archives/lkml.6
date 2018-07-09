Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBA5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57652086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XnpwkKLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57652086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbeGIWGx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:06:53 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:39420 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932554AbeGIWGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:06:51 -0400
Received: by mail-yw0-f196.google.com with SMTP id r184-v6so1741209ywg.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 15:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUiNf+V/V9XL2NJIlHWqSlv5mvsQHLyrvVGow+AZBXs=;
        b=XnpwkKLLzmFcCXl8YhrxWoiIIheXmEdGs7qNxLSQTzDQH7T/Lk+tG4+KIJW7ldB7uP
         6e8F1rAoBABuH2es0GJ3h3bOEU8RegMfGYZubYX22lqOVx61qcjvMbIZLKl4v4tyRBAq
         XFcFHeO5NwwCvUxLewyLj0kSaevcDhi4M59Tlwl921A7gIGHD5rLPFSGgZiC8Zm0rBpZ
         iWsjkmw9N+Tkuk7MhgdCeO0O2iQmPHVrzO4CUzyE85m0wBknTBx8+L4xmd38hD8oVXHq
         aCSMlQGE0vapEgtKYqkxsw8WwWGap7Zx0v445E+LzN/chDXMmhL+7DAT/gwi0pAHbvSl
         5keA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUiNf+V/V9XL2NJIlHWqSlv5mvsQHLyrvVGow+AZBXs=;
        b=QKwGvXdpmDXqQoaw2uLaciiiBRoBzpvBVsrGxEKLstDG6PnhdhYIEw7Nq60XGqg/Z4
         j6htvUjF2hgquppD64r9TGlwyEHV6e5dd9K/l2jiPu6z5Va5U6pPA9ZG26CiyjhQeU5Y
         5S3B8mFoxVBIrA4NbfgxykUwu/El4yfGcZD0x/bf8BNbW5QCBI5/bTpVwZoozH36DyI8
         yX0CCpQq1Vk9fjMenaygJsSza29T4paXYl5FBLZATz0W3H4DbwEMwnWHjjLP0pdkcixR
         lLBSNWSzcFlSJouu8XXEeOHB64lBSLf5DRme/RdAdutPZNw81RdqFTSCglRe2c524bWS
         IlDw==
X-Gm-Message-State: APt69E2gjYvJe7KbGsDzFBD8eLVE7jv0/N2EDNL+36LlweSdyjU7xOHM
        cGPssfewrWYAgMPNmAuVxutQyr4GlOYgogE3dVI+
X-Google-Smtp-Source: AAOMgpdmbftl3FSDyigz9oGO8d8A+kxPgV5LvuQqloqK065cgVplJNI48BLxF1Lczm+6XFxI1zq05rXibs7OkfZ2bHA=
X-Received: by 2002:a81:5556:: with SMTP id j83-v6mr9456586ywb.134.1531174010697;
 Mon, 09 Jul 2018 15:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <2108146.dv4EAOf6IP@aspire.rjw.lan> <CAFgQCTsGC8NH+5kXYD7vykJeUsaAzCAjgxSP-R0EqA3YvgsY0w@mail.gmail.com>
 <8816662.k3KXbdkA2e@aspire.rjw.lan> <CAErSpo4eaaieQiZjAejXAoCv82wddPOcRQXpiqD6X=fFW5XAHQ@mail.gmail.com>
 <CAJZ5v0hVDo-Y2gPTxd6yHVY=vr093hai1VhLzNzzhFkKe0LoKA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hVDo-Y2gPTxd6yHVY=vr093hai1VhLzNzzhFkKe0LoKA@mail.gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 9 Jul 2018 17:06:39 -0500
Message-ID: <CAErSpo4TOiBtdG0iwgeFpv76Lhs4s7PXAWv5_DG-VRyEoP5bOQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: Drop devices_kset_move_last() call from really_probe()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelfans@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>, dyoung@redhat.com,
        linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Kishon]

On Mon, Jul 9, 2018 at 4:35 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Jul 9, 2018 at 3:57 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > On Fri, Jul 6, 2018 at 5:01 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> The devices_kset_move_last() call in really_probe() is a mistake
> >> as it may cause parents to follow children in the devices_kset list
> >> which then causes system shutdown to fail.  Namely, if a device has
> >> children before really_probe() is called for it (which is not
> >> uncommon), that call will cause it to be reordered after the children
> >> in the devices_kset list and the ordering of that list will not
> >> reflect the correct device shutdown order.
> >>
> >> Also it causes the devices_kset list to be constantly reordered
> >> until all drivers have been probed which is totally pointless
> >> overhead in the majority of cases.
> >>
> >> For that reason, revert the really_probe() modifications made by
> >> commit 52cdbdd49853.
> >
> > I'm sure you've considered this, but I can't figure out whether this
> > patch will reintroduce the problem that was solved by 52cdbdd49853.
> > That patch updated two places: (1) really_probe(), the change you're
> > reverting here, and (2) device_move().
> >
> > device_move() is only called from 4-5 places, none of which look
> > related to the problem fixed by 52cdbdd49853, so it seems like that
> > problem was probably resolved by the hunk you're reverting.
>
> That's right, but I don't want to revert all of it.  The other parts
> of it are kind of useful as they make the handling of the devices_kset
> list be consistent with the handling of dpm_list.
>
> The hunk I'm reverting, however, is completely off.  It not only is
> incorrect (as per the above), but it also causes the devices_kset list
> and dpm_list to be handled differently.

If I understand correctly, you are saying:

  - the 52cdbdd49853 really_probe() hunk fixed a problem, but
  - that hunk was the wrong fix for it, and
  - this patch removes the wrong fix (and probably reintroduces the problem)

If devices_kset is supposed to be ordered so children follow parents,
I agree the really_probe() hunk doesn't make much sense because the
parent/child relation is determined by the circuit design, not by the
probe order.

It just seems like it's worth being clear that we're reintroducing the
problem fixed by 52cdbdd49853, so it needs to be solved a different
way.  Ideally that would be done before this patch so there's not a
regression, and this changelog could mention what's happening.

> It had attempted to fix something, but it failed miserably at that.

If you're saying that 52cdbdd49853 *tried* to fix a DRA7XX_evm reboot
problem, but in fact, it did not fix that problem, then I guess there
should be no issue with reverting that hunk.

> >> Fixes: 52cdbdd49853 (driver core: correct device's shutdown order)
> >> Link: https://lore.kernel.org/lkml/CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com/
> >> Reported-by: Pingfan Liu <kernelfans@gmail.com>
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> ---
> >>  drivers/base/dd.c |    8 --------
> >>  1 file changed, 8 deletions(-)
> >>
> >> Index: linux-pm/drivers/base/dd.c
> >> ===================================================================
> >> --- linux-pm.orig/drivers/base/dd.c
> >> +++ linux-pm/drivers/base/dd.c
> >> @@ -434,14 +434,6 @@ re_probe:
> >>                         goto probe_failed;
> >>         }
> >>
> >> -       /*
> >> -        * Ensure devices are listed in devices_kset in correct order
> >> -        * It's important to move Dev to the end of devices_kset before
> >> -        * calling .probe, because it could be recursive and parent Dev
> >> -        * should always go first
> >> -        */
> >> -       devices_kset_move_last(dev);
> >> -
> >>         if (dev->bus->probe) {
> >>                 ret = dev->bus->probe(dev);
> >>                 if (ret)
> >>
