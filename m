Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4645CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7B820865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Bq4lwPW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7B820865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438216AbeKWEsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:48:42 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41712 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406546AbeKWEsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:48:42 -0500
Received: by mail-oi1-f193.google.com with SMTP id j21so8075389oii.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 10:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gVjy3aJbCQo9yde6c5YZxEFpJx7Xqg8PvcbSbvskKHg=;
        b=Bq4lwPW42iQ7LJvKlvAavsKDKo4HuGKXedSOa9gcqHdQcLNWuhmXwgqEKIpRpMrSOK
         xYy6NBj3HJvSJpZS8MtMUhcc37x0MCeBsSjANEor9KF/Iyq+dfcIbMuAd6vGL8I2HHSZ
         q6d7SDrYnUSyVinBWwJNMnzOFyJduQTMb9N98uq2lRThATJ6HShCtlQVCwAev0d6iUtX
         zzvCurmKW5hxd7Mzd43ozzCWO1gw5Q9ZBzmysW1Fj+5CUoMVsfAcli+bHd9v3r/HXx/z
         udEJF48oGFACqtirQDnyWuI4k1tq3sFid+uKNw+YyrkwwqbiUx5JuPawnIvZG9McK02u
         4uNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gVjy3aJbCQo9yde6c5YZxEFpJx7Xqg8PvcbSbvskKHg=;
        b=ioLrvF9dH3Csp8hM4hhfuFM1FLPhJjtQJsQg75Bmyr3AelGVh1+stVzXT3blnY7B16
         +uRnnrwCDmaBvWI2uWBvYNDgQXXMnfjAuknOsSUC1SSAliWUfW05X4O6tZHnYKTde8BV
         OPJSlbIBtYzQoYyHvwdtmtt77+A2qpu+67MM8EBl/wSXsaav9NLPkn3ZgHkXAnfgHgUu
         Sgm35lkpXc2NV/AHi7T13ZMFJQH9hxKV0uWlHF0fXSN4iya+CIJbAiVXqPeVDc8Wduyc
         odEQd7E+2cXjPuOUVwzbjQJljIFl78fOAEluUDTTMhLetXRmM0FEzCbPqTkuEeMTGEQ+
         b6iQ==
X-Gm-Message-State: AGRZ1gIlBuCv6b5GkSgGGP1UHhxOmazrTrYVmTx505BlFVhcTtdJq4Lb
        2eHamVyIaRL84HZQ9WbqdwwOH/bVr1rNLg3IVqaRFw==
X-Google-Smtp-Source: AJdET5dH1fFFp/xwZenSPEFabRBBb2wKGLmjBQtnnP/dkAmQbn7Q9Jon3MLUSdhDe8KBqcgJpn0Jj6iBrtl/Ucekq9k=
X-Received: by 2002:aca:f4c2:: with SMTP id s185mr6964032oih.244.1542910092489;
 Thu, 22 Nov 2018 10:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20181114224902.12082-1-keith.busch@intel.com> <1ed406b2-b85f-8e02-1df0-7c39aa21eca9@arm.com>
 <4ea6e80f-80ba-6992-8aa0-5c2d88996af7@intel.com> <b79804b0-32ee-03f9-fa62-a89684d46be6@arm.com>
 <c6abb754-0d82-8739-fe08-24e9402bae75@intel.com> <aae34dde-fa70-870a-9b74-fff9e385bfc9@arm.com>
In-Reply-To: <aae34dde-fa70-870a-9b74-fff9e385bfc9@arm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 22 Nov 2018 10:08:01 -0800
Message-ID: <CAPcyv4hj61o+TDTSGxYSMMXMn7YiOGP0fj6R-cquPodN4VeT9A@mail.gmail.com>
Subject: Re: [PATCH 0/7] ACPI HMAT memory sysfs representation
To:     anshuman.khandual@arm.com
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 3:52 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 11/19/2018 11:07 PM, Dave Hansen wrote:
> > On 11/18/18 9:44 PM, Anshuman Khandual wrote:
> >> IIUC NUMA re-work in principle involves these functional changes
> >>
> >> 1. Enumerating compute and memory nodes in heterogeneous environment (short/medium term)
> >
> > This patch set _does_ that, though.
> >
> >> 2. Enumerating memory node attributes as seen from the compute nodes (short/medium term)
> >
> > It does that as well (a subset at least).
> >
> > It sounds like the subset that's being exposed is insufficient for yo
> > We did that because we think doing anything but a subset in sysfs will
> > just blow up sysfs:  MAX_NUMNODES is as high as 1024, so if we have 4
> > attributes, that's at _least_ 1024*1024*4 files if we expose *all*
> > combinations.
> Each permutation need not be a separate file inside all possible NODE X
> (/sys/devices/system/node/nodeX) directories. It can be a top level file
> enumerating various attribute values for a given (X, Y) node pair based
> on an offset something like /proc/pid/pagemap.
>
> >
> > Do we agree that sysfs is unsuitable for exposing attributes in this manner?
> >
>
> Yes, for individual files. But this can be worked around with an offset
> based access from a top level global attributes file as mentioned above.
> Is there any particular advantage of using individual files for each
> given attribute ? I was wondering that a single unsigned long (u64) will
> be able to pack 8 different attributes where each individual attribute
> values can be abstracted out in 8 bits.

sysfs has a 4K limit, and in general I don't think there is much
incremental value to go describe the entirety of the system from sysfs
or anywhere else in the kernel for that matter. It's simply too much
information to reasonably consume. Instead the kernel can describe the
coarse boundaries and some semblance of "best" access initiator for a
given target. That should cover the "80%" case of what applications
want to discover, for the other "20%" we likely need some userspace
library that can go parse these platform specific information sources
and supplement the kernel view. I also think a simpler kernel starting
point gives us room to go pull in more commonly used attributes if it
turns out they are useful, and avoid going down the path of exporting
attributes that have questionable value in practice.
