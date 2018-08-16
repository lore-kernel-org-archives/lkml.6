Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C82C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A399214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A399214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390975AbeHPNOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 09:14:17 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38431 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbeHPNOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 09:14:16 -0400
Received: by mail-oi0-f68.google.com with SMTP id v8-v6so7077454oie.5;
        Thu, 16 Aug 2018 03:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d8rX1D1JCpgTbTlhJHiWemSS48qdfT6A4WReLk0O04M=;
        b=k9+Saa2LPan4TjOPWo1WiM6YsdPvtq2r6RyPRKs3WAjgXXkV5A6tPE/PQjns4KQJvd
         RjEg1lb7OcxchkdKQBQ11kzLFFRZMCLxdnebJIxhovKC3tkTVbN1Rx+5JzgtntcWW+1d
         oIDmjlIj6sFcG2tLbGbtDos+OJPjKYyPB8v8P/oicUVWgZBI1zHlgZSd3huVF/go8sGD
         oLTu/2mqpyt3YVC0JZRdkInMHynRR71C6DmY0bpQOgWVbErYS6L19zJGHfkipDorn+BF
         aFZpkUpEAYYmuN7WxV/qjTeEh74QrsBB3GqM16e6cMxKhn2THqzysFJkgc1Y9nC8L0PS
         r0pQ==
X-Gm-Message-State: AOUpUlFmSKRuJcfUMwkcfUR4xqqnvHyMPrlGdqAVAW9kPB0KWbj1ZHjv
        1rnMp+s1e/6k/Vf04MoBQMJ6yAbRl7coU9Wubmk=
X-Google-Smtp-Source: AA+uWPzLNGuHvlvKD+GVoVjqthml4wDr9kAg6TCSItZsUKyOgwmdzEo0OuQIERvXLDViOw5wQnTjqH3wg5k98d0qxc0=
X-Received: by 2002:aca:2dd1:: with SMTP id t200-v6mr32344754oit.152.1534414603861;
 Thu, 16 Aug 2018 03:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAB4CAwfms8_zJ=xB5wJ0Sgr6gu9-mFnqwEz2cUR-sOHdEV5zqQ@mail.gmail.com>
 <CAJZ5v0gKfyB7=5ZGj9uXejoBjkuf2snsKwYJM2Ar1_Vg8A8SCg@mail.gmail.com>
 <CAB4CAwfdwU6FQVEWWO2dLw-RJHTpqWeuk_BiH04ssE=iCOrJ+A@mail.gmail.com>
 <CAJZ5v0i6PXg1rTjBTZy3tGVihmb84qZpqzmHrwSdACWZ+SOgYg@mail.gmail.com> <CAB4CAweumP0qZEJGsNNeEEH3-g13E1dGQD9+zsh1fKysA9MsuQ@mail.gmail.com>
In-Reply-To: <CAB4CAweumP0qZEJGsNNeEEH3-g13E1dGQD9+zsh1fKysA9MsuQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Aug 2018 12:16:32 +0200
Message-ID: <CAJZ5v0gsCLScuvPnAGdOMJFx77m=+25wQNX_S7LBwvsm08NpRw@mail.gmail.com>
Subject: Re: Keyboard lost after exit s2idle on ASUS UX433FN
To:     Chris Chiu <chiu@endlessm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 12:05 PM Chris Chiu <chiu@endlessm.com> wrote:
>
> On Thu, Aug 16, 2018 at 4:54 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Thu, Aug 16, 2018 at 10:18 AM Chris Chiu <chiu@endlessm.com> wrote:
> >>
> >> On Thu, Aug 16, 2018 at 3:26 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >> > On Thu, Aug 16, 2018 at 4:45 AM Chris Chiu <chiu@endlessm.com> wrote:
> >> >>
> >> >> Hi,
> >> >>     We recently hit a weird problem on the ASUS laptop UX433FN with
> >> >> latest Intel Core i7-8565U CPU on kernel 4.18. The keyboard stops
> >> >> functioning after exit s2idle. It stops firing interrupts after resume
> >> >> on any keypress. We thought it should be something wrong with i8042
> >> >> driver or even atkbd driver, so we tried to skip the suspend/resume
> >> >> path of i8042 and input devices but no luck.
> >> >>
> >> >>     Then we tried to hack the s2idle code to fail right before it goes
> >> >> into the idle state to find out which code really cause the keyboard
> >> >> broken. It comes with an interesting finding that if it aborts s2idle
> >> >> before cpuidle_resume() in s2idle_enter(), the keyboard is fine. If it
> >> >> aborts after cpuidle_resume, then the keyboard down. At least it
> >> >> proves that even with dpm_noirq_begin() and
> >> >> dpm_noirq_suspend_devices() executed, the keyboard is still alive.
> >> >> There should be something wrong with the cpuidle.
> >> >>
> >> >>     Going deeper into intel_idle_s2idle() which is invoked by
> >> >> cpuidle_enter_s2idle(), we found that the keyboard interrupt will no
> >> >> longer function after mwait_idle_with_hints() which just simply
> >> >> executing intel monitor and mwait instructions. So I don't know what
> >> >> should be the next step I can take. Can anyone give some pieces of
> >> >> advice?
> >> >
> >> > It may indicate that the deepest C-states used by s2idle simply don't
> >> > work correctly on the affected system.
> >> >
> >> > To verify this, you can try to disable the deepest C-states via sysfs
> >> > using the "disable" attribute under
> >> > /sys/devices/system/cpu/cpuX/cpuidle/stateX/
> >> >
> >> Thanks for the great help. I can have the keyboard work after s2idle with
> >> the following command
> >>
> >> echo 1 > /sys/devices/system/cpu/cpuX/cpuidle/state8/disable
> >>
> >> cpuX, X can be 0 to 7 on this CPU.
> >> And only state8 disable would work, it fails on state 0~7 disabled.
> >
> > Well, if you disable one of states 0-7 alone, it will still attempt to
> > use state8. :-)
> >
> > It generally uses the deepest one enabled.
> >
> >> There're 9 (0-8) states on the cpuidle of this machine. However, I have another
> >> laptop with the same CPU Intel Core i7-8565U which only have 4(0-3) states
> >> under the same '/sys/devices/system/cpu/cpuX/cpuidle/' entry. Sorry that I
> >> don't have enough background knowledge about cpuidle. I thought the #C
> >> state should be depend on CPU, but why the same i7-8565 has different
> >> number of C-states?
> >
> > What is there in /sys/devices/system/cpu/cpuidle/current_driver on
> > each of these systems?
> >
> >>  And for this case, should I just disable C-8 state or there
> >> should be a generic fix with it?
> >
> > No, it just doesn't work specifically on your system, unfortunately,
> > so you need to disable state8 manually, at least for the time being.
> > If all UX433FNs turn out to be affected, we may consider adding a
> > quirk for them, but for now we just don't know.
> >
> > Do the "name" and "desc" sysfs files of state8 on the affected system
> > contain "C10" and "MWAIT 0x60", respectively?
> >
> > To make a more persistent record of this issue, you can file a bug at
> > bugzilla.kernel.org against cpuidle and put all of the relevant
> > information into it.  It is possible that some special magic is needed
> > to make the deepest idle state safe on this system and it may be hard
> > to find out, but at least it is good to know that this happens.
> >
>
> Thanks. I've reported on https://bugzilla.kernel.org/show_bug.cgi?id=200829.
> Also, include information you request. Please let me know if anything missing.

OK, responded in the BZ entry.  Let's continue the discussion in there.

Thanks!
