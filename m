Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ECEC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F344269AC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="2EVQMI9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F344269AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753065AbeFZVv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:51:57 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:35698 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbeFZVvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:51:54 -0400
Received: by mail-ot0-f194.google.com with SMTP id a6-v6so6202179otf.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 14:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bPOY96BJG72mktrthVsC54uU6gGLvcgrnNExSO1NslU=;
        b=2EVQMI9+VRGOSYuR9di3/zipvnY/Zm1dx1jNSdSd77z7CPDZ8/79vMfnVAqQpuMmVn
         rzbU2rLOmqC+kCtpVqE0UWEDlo1Y63uOCHCXZYSC2mCLAh+mUcV5pPPm+whtZq0EA66p
         c/YQFSfTIybWtosi6ehXN6whZosOQH/OX89/S29QuUysyUaRaZjMQ5k8zahRq8FJ7vP5
         xhQjgPj55E5w/uzHE0SL90sbQDCqLJeeO6uzUeh7ZrZFaGIImdclZ58AXUTN4kzcpQeB
         6DInqlu5FTfvsIG8Hn7xiP6bvm1Y3VR0LDG0pkOJjQfhaNx4UoFN8nYyr4sSSdOTH4lE
         rs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bPOY96BJG72mktrthVsC54uU6gGLvcgrnNExSO1NslU=;
        b=H5k0LtAKHsWQD+5ZxskUvHpzazzgyTH9hGfe8ElwVpINOvbI9M9BO2dNaItEd0AkG2
         UkEbTa7+mQpOtunQVJ1gfSJCEJeq9t+fG5Bru12IAByAqinygT2I1g6lMvmBLpMCYV+d
         Cj2LiMWzcHr3T4navZXGRz1u9DnyVMy0EXvTdcKqJMrTjdcFSWrHm+2tcEp21UnxHLNf
         6xtnum4mrnXFbkNQSOCZQcyKKnRzyOaUcJYHBh2ugXFp9G9PyA4+wG6lJ+0+pe8RYx3/
         vZslmH3J7i7UBUVvcgPQla1vH8m34U+midzIUzerIOpmL7wR/HF5Nm9pPBNwDD479jxV
         rp1A==
X-Gm-Message-State: APt69E2HiY+xfFE7ei3SEFemLGDwGwtTZm++66YDbqQA7sGhBeKgHZBm
        JBTNuc9ytbNyGKSPHOO7PXfLjW5AVLvcdaXV4lGoIQ==
X-Google-Smtp-Source: AAOMgpetCjCJ/2l5dY2IFUWpBjGhLHLsnCX+GthiNp5fP3NHpHmRXxPQ8Iz0V7aEBuktf9ZPTxnN0H/gzGXnMSZhZyk=
X-Received: by 2002:a9d:7311:: with SMTP id e17-v6mr1834834otk.162.1530049913801;
 Tue, 26 Jun 2018 14:51:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:38c2:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 14:51:52
 -0700 (PDT)
In-Reply-To: <1530048545.14039.288.camel@hpe.com>
References: <20180626175932.8899-1-ross.zwisler@linux.intel.com>
 <20180626175932.8899-2-ross.zwisler@linux.intel.com> <CAPcyv4iWgPnHmBKhUvhManC6UL9CkLqN_d8vBo6KmcPJdPzuUw@mail.gmail.com>
 <20180626185830.GA7171@redhat.com> <CAPcyv4h6HO6fs6k7QMD77jkz2djCeWCtWomCdNb0-1Q4VKanqw@mail.gmail.com>
 <20180626191346.GA7233@redhat.com> <1530046327.14039.273.camel@hpe.com>
 <CAPcyv4hP_Y3xdyCa-UkYCMJ5OtnjnkwPZDS2Z2Ge8+5ymBONwQ@mail.gmail.com>
 <1530048093.14039.286.camel@hpe.com> <CAPcyv4gXAC7imJs5qfsDNLeN545Rqyd2b1M9s5kr4f9y48LXgQ@mail.gmail.com>
 <1530048545.14039.288.camel@hpe.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 26 Jun 2018 14:51:52 -0700
Message-ID: <CAPcyv4ifHX95fCM9Xj87CugwNWzgq=y-4LxPQ5L6RdjX0jdctQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] pmem: only set QUEUE_FLAG_DAX for fsdax mode
To:     "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 2:31 PM, Kani, Toshi <toshi.kani@hpe.com> wrote:
> On Tue, 2018-06-26 at 14:28 -0700, Dan Williams wrote:
>> On Tue, Jun 26, 2018 at 2:23 PM, Kani, Toshi <toshi.kani@hpe.com> wrote:
>> > On Tue, 2018-06-26 at 14:02 -0700, Dan Williams wrote:
>> > > On Tue, Jun 26, 2018 at 1:54 PM, Kani, Toshi <toshi.kani@hpe.com> wrote:
>>
>> [..]
>> > > > When this dm change was made, the pmem driver supported DAX for both raw
>> > > > and memory modes (note: sector mode does not use the pmem driver).  I
>> > > > think the issue was introduced when we dropped DAX support from raw
>> > > > mode.
>> > >
>> > > Still DAX with raw mode never really worked any way. It was also
>> > > something that was broken from day one. So what happens to someone who
>> > > happened to avoid all the problems with page-less DAX and enabled
>> > > device-mapper on top? That failure mode detail needs to be added to
>> > > this changelog if we want to propose this for -stable.
>> >
>> > My point is that the behavior should be consistent between pmem and
>> > device-mapper.  When -o dax succeeds on a pmem, then it should succeed
>> > on a device-mapper on top of that pmem.
>> >
>> > Has the drop of dax support from raw mode made to -stable back to the
>> > baseline accepted 545ed20e6df6?  It will introduce inconsistency,
>> > otherwise.
>>
>> That commit, 569d0365f571 "dax: require 'struct page' by default for
>> filesystem dax", has not been tagged for -stable.
>
> Then, Fixes tag should be set to 569d0365f571 to keep the behavior
> consistent.

Sure, and the failure mode is...? I'm thinking the commit log should say:

"Starting with commit 569d0365f571 "dax: require 'struct page' by
default for filesystem dax", dax is no longer supported for page-less
configurations. However, device-mapper sees the QUEUE_FLAG_DAX still
being set and falsely assumes that DAX is enabled, this leads to
<insert user visible failure mode details here>"
