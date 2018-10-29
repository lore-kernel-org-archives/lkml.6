Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14B9C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F09E2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F09E2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbeJ2RhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:37:18 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43078 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbeJ2RhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:37:17 -0400
Received: by mail-qt1-f195.google.com with SMTP id q41-v6so8254875qtq.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 01:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HttdNTd1jhKbq8SfoIPuvYZigOvj5l86pPRsLMOgT0g=;
        b=GWHQzaOmEbts2j30l+LmLBQdrXvk0VA6bPvF4ouTgVyDto79CIemcA0x6SgLPp0e06
         iyU6BDqd60gMgaBV21c9eFDWQFDEh6m4Zes32YSUoD0xWvzU5AfpxAsBA0VljB5aDIXT
         9HaBvNK54svopG7AL7adQf7yeHEDh3HfF/ck98jlopoPqW3Abnldvb5sM3aQ9xkG39F7
         v1f+GUjzoq0cFkFy8vzzL+gkSwAtm2HfCJ/4Rxs3rAWQ33ffpx37doEnV1qJZNrN5iWz
         0lELam9rRxc3M6bKbCTYqF5alpYm4/8wwVKLGlqZlF4F3maTtXxt2qfB89VGfuuZ8/5i
         kwMg==
X-Gm-Message-State: AGRZ1gK2BSYTjv/8SfEmBSLyZv+DKjOldWqe31aMhDAkVeh9826sD1FC
        /oXFyzLf4wh5KLj6W4GUKMCwvEppXiUhTL/dZ2AzFw==
X-Google-Smtp-Source: AJdET5dRmlx+ucsVkMi/VCuYfY9EhpOfWe0TShA4BdA528F7oGgmyzd59gtKqmjsw/srrod4Ve8fdBYbDd4KnOGe9pE=
X-Received: by 2002:ac8:1a3b:: with SMTP id v56-v6mr11643924qtj.362.1540802977007;
 Mon, 29 Oct 2018 01:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com>
 <c6b7e5b26883c53db35454e9b0ffb44898517228.camel@perches.com>
 <CAHk-=wgTMd_orbgEmjtKdpPJdnFcho_-66_R3PBr7joxFOxqsw@mail.gmail.com> <nycvar.YFH.7.76.1810272338590.23511@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1810272338590.23511@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 29 Oct 2018 09:49:25 +0100
Message-ID: <CAO-hwJJjP1SJjcfGkr84yyPqYpCx-_6LSk5uDP2Twg2ouy_3+w@mail.gmail.com>
Subject: Re: Another HID problem this merge window..
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, joe@perches.com,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Oct 27, 2018 at 11:45 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Sat, 27 Oct 2018, Linus Torvalds wrote:
>
> > I wonder if there is some truly old historical legacy there, ie the old
> > PC keyboard support would have been configurable out only for expert
> > users to avoid errors, and maybe the HID Kconfig file started getting
> > ideas from that...
>
> This really goes waaay back to times when we extracted all the quirks from
> the generic driver (which became unmaintainable exactly because quirks
> being sprinkled left and right) into specialized drivers, but didn't want
> to cause too many user surprises that all of a sudden their configuration
> regressed when it comes to hardware support.
>
> We've had exactly this discussion multiple times before, see for example
>
>         https://lkml.org/lkml/2010/5/20/227
>
> So I guess there is no need for replaying it, I think we're in complete
> agreement.

On the things I have on my plate, I'll try to remove all of the tiny
HID drivers that does nothing but some small remapping. This will
probably need help from userspace ("firmware" or bpf loading), and I
have not settled my plans yet.
I also think we should probably clean up the Kconfig now that
hid-generic can unbind itself if there is a special driver coming in.
And that means that we should probably start removing the blacklist of
devices that have special modules, to let them be taken by hid-generic
on boot until their driver is loaded.

>
> That being said, benff Kconfig setting definitely escaped attention. That
> should never ever have been set to default y, I take blame for not
> noticing that while applying the patch.

Not sure I have actually reviewed this one (I don't think so), but
I'll keep this in my head for next drivers.

Cheers,
Benjamin

>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
