Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160ABC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C280821A67
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oicWiDE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C280821A67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733178AbeHFV4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:56:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36788 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732955AbeHFV4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:56:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so13484968wro.3;
        Mon, 06 Aug 2018 12:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8jC9CVq3/CMImMRc8OfmG4DzxaCgtqfCGucDHNj05Wg=;
        b=oicWiDE5phhYw1GZlblGcnWQA4fVTKMF1AlK/TkhZhNciE+4DSDVuAXBYr+o1h6hE8
         7UrZH9uOgMqWSrwvsUswfeYnfilC97ZROTBadkAlSDwefYssyekswgLWWCdP1wgGKyhC
         6QOVsVOlleWEA1ZDJ+8I0aBfBskOdbxwf/mneZtbS4QBj6Vbk7NXsueEXxHjHBr5ygSd
         Bkq703TC56Ag0kVCJAh2uUI26VWeAlQmLvobmD24xUGaVxmFqVTOHcV/75308lZl775P
         xcWLwGJKvBxe8I2Sf7VH/QuNoOWWQzAFqsH8Y+Co6ZMz4GcSCC17fqQNE2NEE6LU32wY
         mdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8jC9CVq3/CMImMRc8OfmG4DzxaCgtqfCGucDHNj05Wg=;
        b=gSJu5arQKrqMZMZ+bv1i1Pini+gJMwYO38bD6fwHRj0tbl7njeo02+Dr7fpjJYLrV6
         Fj/zdP7H6DraDlR6oxHiyPc0w87l9jf7zO0xD5chhAVpP/ahhpvFNve5nn3GKNahs6Dg
         3mgJnsk98Tvr2aJOFoLh/0GEFsd7VZIyESHFfMN5uf2uQ/2NYwKCZRQ2HtsnQeTEN+DM
         Z9Jk/PRBewy72CTSGg9zMhWqSLUkXOEo+suOZrztMI1PnH4kOwbcK+8EZOMwT3MqiOTU
         9Op9MzTWfYa+xZsqsxM6EfnqvXx8CvlyBTObRx0QC5mSXy+3rTYV8G+gEOFFEh0N3vDm
         8O9g==
X-Gm-Message-State: AOUpUlFALiw+ojNu5fCHa9doMjBZ2rhLbayMKgH/Fjy0b+1287LOJenc
        0QciVLyG1r+d5I1pkCzu0Lk51SnVMywrSFGnStM=
X-Google-Smtp-Source: AAOMgpfxCZyiftWgm11eWs33wUQ9cKGXLEqzt2WJBtO7ol0bt71mH1vRjDHGS9WKFpYetMpQifyx8/2CwIDU1GvsoOA=
X-Received: by 2002:adf:afd3:: with SMTP id y19-v6mr11634659wrd.176.1533584756683;
 Mon, 06 Aug 2018 12:45:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:979e:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 12:45:56 -0700 (PDT)
In-Reply-To: <20180806193457.GA7028@wunner.de>
References: <20180731003954.19962-1-lyude@redhat.com> <20180731003954.19962-4-lyude@redhat.com>
 <20180806084322.GK3008@phenom.ffwll.local> <4e72a10062166d646ebd3eb28b6c186d4c00a63f.camel@redhat.com>
 <20180806193457.GA7028@wunner.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 6 Aug 2018 15:45:56 -0400
Message-ID: <CADnq5_PJHjOrcB3WtJjg7XFSQMBRaAOrPX17M4dcm7r_7_+gqg@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] drm/fb_helper: Introduce hotplug_suspend/resume()
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "for 3.8" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 3:34 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Mon, Aug 06, 2018 at 03:15:31PM -0400, Lyude Paul wrote:
>> You did mention in the review of one of my other patches that we should avoid
>> disabling polling during runtime suspend, and you're definitely right. I feel
>> a bit silly for not remembering that since I was the one who made it so that
>> i915 does polling in runtime suspend for chips without RPM HPD detection in
>> the first place because it was causing people's displays not to come up on
>> vlv...
>> Anyway: I think if we just leave output polling enabled during runtime suspend
>> that might actually fix all of the fb_helper locking issues since we won't
>> need to wait on any of the output poll workers to finish, at least I think it
>> should: I'll confirm this when I get into the office
>
> Quoth Imre Deak:
>
>    "In i915 polling is on during runtime suspend only if there are outputs
>     without hotplug interrupt support. A special case is when an output has
>     working HPD interrupts when in D0, but no interrupts when runtime
>     suspended. For these we start polling (from a scheduled work) in the
>     runtime suspend hook and stop it in the runtime resume hook (again from
>     a scheduled work)."
>     https://lkml.org/lkml/2018/2/12/330
>
> nouveau only uses runtime PM on discrete GPUs in dual GPU laptops.
> Resuming the GPU from D3cold to D0 every few seconds to poll the
> outputs would waste too much power on such machines.
>
> The question is, why is polling running at all, since all modern
> laptops have HPD-capable ports such as DP?
>

At least on AMD GPUs, the GPU has to be powered up for HPD interrupts
to work.  On hybrid graphics laptops, depending on the OEM
configuration, the hotplug events are caught by the ACPI controller on
the motherboard when the GPU is powered down and an ACPI event is
generated which the driver can listen for and then tell userspace.
I'm not sure how nvidia handles this.  Also, some display connections
(e.g., analog DACs) don't support hotplug interrupts in the first
place so the only way to go is polling.

Alex
