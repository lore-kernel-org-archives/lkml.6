Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9509C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527992089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WztqLpLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527992089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933256AbeGJK3O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:29:14 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33433 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751194AbeGJK3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:29:12 -0400
Received: by mail-oi0-f67.google.com with SMTP id c6-v6so41662650oiy.0;
        Tue, 10 Jul 2018 03:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lvZd0kPxFYmK4L8LDsmZK+efXW+/zyokMeM4Uo3edNg=;
        b=WztqLpLW+JyF/43Tmcr+ZN/9ExFvG6fZnnk8gvCPtUaNerOR/3nLa3Bx83LEAGpxNR
         8O4QE09Uk2AnHtzaF7J861XSHMd40tZ5ftkJnZpu/glVBG05OBh0VeNiZn1ZHaQKX1OL
         CC8+6J5cZab5Lg/zM4IKywMXSRhJezTjhRh8allfDEnuqcpooeDvgJOUvs8hRm2wIcc9
         UCadHtVBgMFSI46pUTsfkyE3KkmQmqzu5vVKF8WztF1WZ4v6eVmZsR2FE+wOgy+asfFI
         rqasH8S0lZWiwRNuMrxuHJtB2eEZRvHRO+zzSR49dbLPYGKHw5FSaOimF6A1NgPGJymU
         7Ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=lvZd0kPxFYmK4L8LDsmZK+efXW+/zyokMeM4Uo3edNg=;
        b=rnD02d7mEJvKF+/2CZpXfFk7OW8Jap+tA6aY9syuFdR0l3eignbasswSYK4TTuNVqR
         8TYcTkd8HiSf6C42MXrYD48e9GTVJbqfQBYibnyrQKacY4shBYzWtrT7rKgg/cwEd+v7
         RBm/mVjTe3aCh4fxSGvqNqkTyOVpgYEGhvQRe2SfIezMLZdCvuSXRLY8LmdI0WgjwGFg
         IRyfCIlrPBlR//v3ycYIaQ85TP8YTS5p2wR09/mxQRi/TCk9XvJJBvo6dMIE6Q9vNS0S
         Z1TG6lPwq6pCtEPBbqDsimNvAlhwKuISzvY5Kztki4rwshR+PR2heYj8Nz5QE7zXJpUu
         D5Cw==
X-Gm-Message-State: APt69E2d2NgkJqPSiGrRVJpZ4GZ88R6OWMemrb2MZH85TX2/AVOACFeg
        ph2hW4x33/NZWIbEsA/GFaZiub6CmfN4KvjPFL4=
X-Google-Smtp-Source: AAOMgpdecSVZMISh3qtQOMS8rg74MYuUBsChZxlhKpa72NTwv0p59SyzuQ3Q0DR2YQzIvuiW8qsauzgPlnij4OZfm+I=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr24718343oia.154.1531218551577;
 Tue, 10 Jul 2018 03:29:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 03:29:11
 -0700 (PDT)
In-Reply-To: <CAErSpo4TOiBtdG0iwgeFpv76Lhs4s7PXAWv5_DG-VRyEoP5bOQ@mail.gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <2108146.dv4EAOf6IP@aspire.rjw.lan> <CAFgQCTsGC8NH+5kXYD7vykJeUsaAzCAjgxSP-R0EqA3YvgsY0w@mail.gmail.com>
 <8816662.k3KXbdkA2e@aspire.rjw.lan> <CAErSpo4eaaieQiZjAejXAoCv82wddPOcRQXpiqD6X=fFW5XAHQ@mail.gmail.com>
 <CAJZ5v0hVDo-Y2gPTxd6yHVY=vr093hai1VhLzNzzhFkKe0LoKA@mail.gmail.com> <CAErSpo4TOiBtdG0iwgeFpv76Lhs4s7PXAWv5_DG-VRyEoP5bOQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Jul 2018 12:29:11 +0200
X-Google-Sender-Auth: xjgnZYadckYYO6eZ_meK7bjfJ4w
Message-ID: <CAJZ5v0jz4wfrACU6WwUfuyzoxXqQsWVhvFf1B3K5z7FjngjOYQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: Drop devices_kset_move_last() call from really_probe()
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 12:06 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Kishon]
>
> On Mon, Jul 9, 2018 at 4:35 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Mon, Jul 9, 2018 at 3:57 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> > On Fri, Jul 6, 2018 at 5:01 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> >>
>> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >>
>> >> The devices_kset_move_last() call in really_probe() is a mistake
>> >> as it may cause parents to follow children in the devices_kset list
>> >> which then causes system shutdown to fail.  Namely, if a device has
>> >> children before really_probe() is called for it (which is not
>> >> uncommon), that call will cause it to be reordered after the children
>> >> in the devices_kset list and the ordering of that list will not
>> >> reflect the correct device shutdown order.
>> >>
>> >> Also it causes the devices_kset list to be constantly reordered
>> >> until all drivers have been probed which is totally pointless
>> >> overhead in the majority of cases.
>> >>
>> >> For that reason, revert the really_probe() modifications made by
>> >> commit 52cdbdd49853.
>> >
>> > I'm sure you've considered this, but I can't figure out whether this
>> > patch will reintroduce the problem that was solved by 52cdbdd49853.
>> > That patch updated two places: (1) really_probe(), the change you're
>> > reverting here, and (2) device_move().
>> >
>> > device_move() is only called from 4-5 places, none of which look
>> > related to the problem fixed by 52cdbdd49853, so it seems like that
>> > problem was probably resolved by the hunk you're reverting.
>>
>> That's right, but I don't want to revert all of it.  The other parts
>> of it are kind of useful as they make the handling of the devices_kset
>> list be consistent with the handling of dpm_list.
>>
>> The hunk I'm reverting, however, is completely off.  It not only is
>> incorrect (as per the above), but it also causes the devices_kset list
>> and dpm_list to be handled differently.
>
> If I understand correctly, you are saying:
>
>   - the 52cdbdd49853 really_probe() hunk fixed a problem, but

It papered over a shutdown failure.  Calling it a "fix" is an overstatement IMO.

>   - that hunk was the wrong fix for it, and
>   - this patch removes the wrong fix (and probably reintroduces the problem)
>
> If devices_kset is supposed to be ordered so children follow parents,
> I agree the really_probe() hunk doesn't make much sense because the
> parent/child relation is determined by the circuit design, not by the
> probe order.

Exactly.

> It just seems like it's worth being clear that we're reintroducing the
> problem fixed by 52cdbdd49853, so it needs to be solved a different
> way.

OK

> Ideally that would be done before this patch so there's not a
> regression, and this changelog could mention what's happening.

Well, commit 52cdbdd49853 introduced a regression by itself, but that
regression has only been reported recently.

I don't really want to go into a discussion on which of the two
regressions is more painful, but then IMO going back to the state from
before commit 52cdbdd49853 is fair enough.  Hence the patch.

>> It had attempted to fix something, but it failed miserably at that.
>
> If you're saying that 52cdbdd49853 *tried* to fix a DRA7XX_evm reboot
> problem, but in fact, it did not fix that problem, then I guess there
> should be no issue with reverting that hunk.

Again, it hid the reboot problem by changing the core in a way that
led to a shutdown regression elsewhere.

Also it looks like the platform(s) having that reboot issue do(es)n't
really do system-wide suspend/resume, because that "fix" obviously
doesn't help there.

>> >> Fixes: 52cdbdd49853 (driver core: correct device's shutdown order)
>> >> Link: https://lore.kernel.org/lkml/CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com/
>> >> Reported-by: Pingfan Liu <kernelfans@gmail.com>
>> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >> ---
>> >>  drivers/base/dd.c |    8 --------
>> >>  1 file changed, 8 deletions(-)
>> >>
>> >> Index: linux-pm/drivers/base/dd.c
>> >> ===================================================================
>> >> --- linux-pm.orig/drivers/base/dd.c
>> >> +++ linux-pm/drivers/base/dd.c
>> >> @@ -434,14 +434,6 @@ re_probe:
>> >>                         goto probe_failed;
>> >>         }
>> >>
>> >> -       /*
>> >> -        * Ensure devices are listed in devices_kset in correct order
>> >> -        * It's important to move Dev to the end of devices_kset before
>> >> -        * calling .probe, because it could be recursive and parent Dev
>> >> -        * should always go first
>> >> -        */
>> >> -       devices_kset_move_last(dev);
>> >> -
>> >>         if (dev->bus->probe) {
>> >>                 ret = dev->bus->probe(dev);
>> >>                 if (ret)
>> >>
