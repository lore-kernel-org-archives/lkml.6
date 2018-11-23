Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3560DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E264B20866
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="CdhJ9Z2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E264B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440786AbeKXEBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:01:05 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42657 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732237AbeKXEBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:01:04 -0500
Received: by mail-ot1-f65.google.com with SMTP id v23so5765829otk.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 09:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/pyLSnVA1ilwj6HbR8Zqq0lbebPC6Jq/SItElT23/84=;
        b=CdhJ9Z2i1B8dCYO8IdsfOG/+ogDgLxZVXpQsQFKjkYx9sRRaDQx3z4kU073D1Wt3M8
         t9VLprcLFezqTAyG23awixeWWFCe5Q+omwggIf1eH/husLq4GzVSF908caLKtDcz6Okq
         Up+AMxJajHvJsjzfjA8cwQTCNjAGy0vubGTgJHLhRcKrzcQmEe/YJBHLrTNkxzau7W4u
         BwSzguMXNodMmRMtjzzYtUWagHELQj2jNGLD0fHhyAlBG3kq37JATXg51rgasvUMF3EB
         R0pgFDztkD0lsaDZ14zY0VoDNCzP4WHurPkH343Sd4GjY+puvS0KEDMKTYL7pFuLj6o2
         XAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/pyLSnVA1ilwj6HbR8Zqq0lbebPC6Jq/SItElT23/84=;
        b=gsQ2kNuQGzskUn5GF2V1isCqoNTM58VpUwhiQLSUCEwh9EZvl72yAFbSqNiqVOX6e2
         V+Dp30bCCPF/PYe6Dv7YYsFWbBqS+SuUThsItGYiCBNrV0QpzaUhHzJsvccSLB/9Ky7f
         c3m02XSF1dudxX5ARQ02uIrd/0/alidSDAjdsEksNx3l7Wk9ITZVmfOieVgRXX1aijOx
         KQmnxonAxxVIDzGf8FA/KibEJMcw69/pODjYmzoFMGqgu7HBVvcrMWOQhqZ4cRGmyN4r
         kues1bn2fD+kKDFGDV0arwZFYTolPrAVemWhEQk0i49eBf/w41no3lkfpAtcyoKPLQR1
         cJbg==
X-Gm-Message-State: AA+aEWbEvN+ZbiICHInKQaxfELh5SOq4dzMFHMc5L1qp7MX2f3VHiWkR
        uUXgyfOxtKwdawJK81KINT+XJ9T97iSVz+YH1tuChg==
X-Google-Smtp-Source: AFSGD/W3x+Af8VEoNaGidaG1BWbhTp7Y6NxkyUjYpJJGA6SJmK9C40wCJueLjBjt4bpIzsT6HdXBD0I8jqB0Aj/CqDM=
X-Received: by 2002:a9d:a78:: with SMTP id 111mr4969218otg.229.1542993357790;
 Fri, 23 Nov 2018 09:15:57 -0800 (PST)
MIME-Version: 1.0
References: <20181114224902.12082-1-keith.busch@intel.com> <1ed406b2-b85f-8e02-1df0-7c39aa21eca9@arm.com>
 <4ea6e80f-80ba-6992-8aa0-5c2d88996af7@intel.com> <b79804b0-32ee-03f9-fa62-a89684d46be6@arm.com>
 <c6abb754-0d82-8739-fe08-24e9402bae75@intel.com> <aae34dde-fa70-870a-9b74-fff9e385bfc9@arm.com>
 <CAPcyv4hj61o+TDTSGxYSMMXMn7YiOGP0fj6R-cquPodN4VeT9A@mail.gmail.com> <0194f47c-d1d8-108e-a57f-0316adb9112b@arm.com>
In-Reply-To: <0194f47c-d1d8-108e-a57f-0316adb9112b@arm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 23 Nov 2018 09:15:45 -0800
Message-ID: <CAPcyv4iP_+BhVD9NqYG_m8thXARbOfPMDpvg4hfxRATWom_MRQ@mail.gmail.com>
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

On Thu, Nov 22, 2018 at 11:11 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 11/22/2018 11:38 PM, Dan Williams wrote:
> > On Thu, Nov 22, 2018 at 3:52 AM Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> >>
> >>
> >>
> >> On 11/19/2018 11:07 PM, Dave Hansen wrote:
> >>> On 11/18/18 9:44 PM, Anshuman Khandual wrote:
> >>>> IIUC NUMA re-work in principle involves these functional changes
> >>>>
> >>>> 1. Enumerating compute and memory nodes in heterogeneous environment (short/medium term)
> >>>
> >>> This patch set _does_ that, though.
> >>>
> >>>> 2. Enumerating memory node attributes as seen from the compute nodes (short/medium term)
> >>>
> >>> It does that as well (a subset at least).
> >>>
> >>> It sounds like the subset that's being exposed is insufficient for yo
> >>> We did that because we think doing anything but a subset in sysfs will
> >>> just blow up sysfs:  MAX_NUMNODES is as high as 1024, so if we have 4
> >>> attributes, that's at _least_ 1024*1024*4 files if we expose *all*
> >>> combinations.
> >> Each permutation need not be a separate file inside all possible NODE X
> >> (/sys/devices/system/node/nodeX) directories. It can be a top level file
> >> enumerating various attribute values for a given (X, Y) node pair based
> >> on an offset something like /proc/pid/pagemap.
> >>
> >>>
> >>> Do we agree that sysfs is unsuitable for exposing attributes in this manner?
> >>>
> >>
> >> Yes, for individual files. But this can be worked around with an offset
> >> based access from a top level global attributes file as mentioned above.
> >> Is there any particular advantage of using individual files for each
> >> given attribute ? I was wondering that a single unsigned long (u64) will
> >> be able to pack 8 different attributes where each individual attribute
> >> values can be abstracted out in 8 bits.
> >
> > sysfs has a 4K limit, and in general I don't think there is much
> > incremental value to go describe the entirety of the system from sysfs
> > or anywhere else in the kernel for that matter. It's simply too much> information to reasonably consume. Instead the kernel can describe the
>
> I agree that it may be some amount of information to parse but is crucial
> for any task on a heterogeneous system to evaluate (probably re-evaluate
> if the task moves around) its memory and CPU binding at runtime to make
> sure it has got the right one.

Can you provide some more evidence for this statement? It seems that
not many applications even care about basic numa let alone specific
memory targeting, at least according to libnumactl users.

     dnf repoquery --whatrequires numactl-libs

The kernel is the arbiter of memory, something is broken if
applications *need* to take on this responsibility. Yes, there will be
applications that want to tune and override the default kernel
behavior, but this is the exception, not the rule. The applications
that tend to care about specific memories also tend to be purpose
built for a given platform, and that lessens their reliance on the
kernel to enumerate all properties.

> > coarse boundaries and some semblance of "best" access initiator for a
> > given target. That should cover the "80%" case of what applications
>
> The current proposal just assumes that the best one is the nearest one.
> This may be true for bandwidth and latency but may not be true for some
> other properties. This assumptions should not be there while defining
> new ABI.

In fact, I tend to agree with you, but in my opinion that's an
argument to expose even less, not more. If we start with something
minimal that can be extended over time we lessen the risk of over
exposing details that don't matter in practice.

We're in the middle of a bit of a disaster with the VmFlags export in
/proc/$pid/smaps precisely because the implementation was too
comprehensive and applications started depending on details that the
kernel does not want to guarantee going forward. So there is a real
risk of being too descriptive in an interface design.

> > want to discover, for the other "20%" we likely need some userspace
> > library that can go parse these platform specific information sources
> > and supplement the kernel view. I also think a simpler kernel starting
> > point gives us room to go pull in more commonly used attributes if it
> > turns out they are useful, and avoid going down the path of exporting
> > attributes that have questionable value in practice.
> >
>
> Applications can just query platform information right now and just use
> them for mbind() without requiring this new interface.

No, they can't today, at least not for the topology details that HMAT
is describing. The platform-firmware to numa-node translation is
currently not complete. At a minimum we need a listing of initiator
ids and target ids. For an ACPI platform that is the proximity-domain
to numa-node-id translation information. Once that translation is in
place then a userspace library can consult the platform-specific
information sources to translate the platform-firmware view to the
Linux handles for those memories. Am I missing the library that does
this today?

> We are not even
> changing any core MM yet. So if it's just about identifying the node's
> memory properties it can be scanned from platform itself. But I agree
> we would like the kernel to start adding interfaces for multi attribute
> memory but all I am saying is that it has to be comprehensive. Some of
> the attributes have more usefulness now and some have less but the new
> ABI interface has to accommodate exporting all of these.

I get the sense we are talking past each other, can you give the next
level of detail on that "has to be comprehensive" statement?
