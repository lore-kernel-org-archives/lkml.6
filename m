Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFB7C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9AC26D11
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="YrJOfyPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9AC26D11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751004AbeFZVDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:03:03 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39826 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbeFZVDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:03:01 -0400
Received: by mail-oi0-f67.google.com with SMTP id 18-v6so7840831oiq.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 14:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IAJPa+OU7AIGrfjl+Oq9ZKgb4EiXMMKIS99pIQgUfxk=;
        b=YrJOfyPcOTDLoE5geFjUSGqwaJTjIVtZKhsAwZDFVywE6qLuSkaDK/aW6Y4u+nB7PB
         WCzwgThHfpo/lmvxC6qShj3RlYZMD8PzE/njZleZfIUtAGEWDMs3GP2FIAw2kqnd9Bl1
         gL2xMNNHoSXi2EhVBvEjBoVrwfvB5X55Zcph0yGY+bxuTsD1c4JNl2DIBHQvtWBRWn4A
         cuPkzUI7tIWkEU/7QVPgfJllNtyYlRhUQAgoUdJ2h1hxFt4ZTEZNzVlHfZGw8f6j220N
         i27V59YXUEkyo4rnT3UfxzTU+s/txEohWVaglwld4OVy+aRWzHJZyuHfHili6Sm8Snye
         uVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IAJPa+OU7AIGrfjl+Oq9ZKgb4EiXMMKIS99pIQgUfxk=;
        b=P5fr6cnK7GHo79NzWYQ1gJHUIzruPe9wKYJJ1A4pSNyvLpxFK6K5ZqyRrjZCg5w2uB
         EqQcweSiqeVxcmmYonU0sob9ynvRVUXvZnv3Sv+Y/HqQLfwnRvlhDfy/SM3cHeoyVVHg
         ak9P36FetDd8wErMB4khFbF2gR/QlAASa7DqbqqV/2GP/7KfMQCQb1m9LuwVO7EnvxkD
         upv+CFHAco7UR7TA7VOXH943ryY/QNg9EcZG4nYy9QVxwoN0fsFkE+g9kuaUGUmb4mi7
         NTM5WoKmSPGns+Z1Xvz8wQ8sSdM8tFNx1P4ta6+YMVT11HJiQATzP37CTVblKnbxEDSw
         OFvg==
X-Gm-Message-State: APt69E0AlQODUnS4rDTK/nveAZASe5dfDh0H2e4lGwLFTU18ETuLoVAT
        1kzY+2X8AqV/nyeXX++sqyNaRqTxuxVGFZ2CPiF0DQ==
X-Google-Smtp-Source: AAOMgpeVFXvircx25UO/55/nGSgLse586wlmVopHihNVyJ38mhvD/8Lo6L4g1zgP5AkcGcG7zk8cLgfCvrct1DuNRpc=
X-Received: by 2002:aca:745:: with SMTP id 66-v6mr1657836oih.295.1530046980739;
 Tue, 26 Jun 2018 14:03:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:38c2:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 14:02:59
 -0700 (PDT)
In-Reply-To: <1530046327.14039.273.camel@hpe.com>
References: <20180626175932.8899-1-ross.zwisler@linux.intel.com>
 <20180626175932.8899-2-ross.zwisler@linux.intel.com> <CAPcyv4iWgPnHmBKhUvhManC6UL9CkLqN_d8vBo6KmcPJdPzuUw@mail.gmail.com>
 <20180626185830.GA7171@redhat.com> <CAPcyv4h6HO6fs6k7QMD77jkz2djCeWCtWomCdNb0-1Q4VKanqw@mail.gmail.com>
 <20180626191346.GA7233@redhat.com> <1530046327.14039.273.camel@hpe.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 26 Jun 2018 14:02:59 -0700
Message-ID: <CAPcyv4hP_Y3xdyCa-UkYCMJ5OtnjnkwPZDS2Z2Ge8+5ymBONwQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] pmem: only set QUEUE_FLAG_DAX for fsdax mode
To:     "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 1:54 PM, Kani, Toshi <toshi.kani@hpe.com> wrote:
> On Tue, 2018-06-26 at 15:13 -0400, Mike Snitzer wrote:
>> On Tue, Jun 26 2018 at  3:07pm -0400,
>> Dan Williams <dan.j.williams@intel.com> wrote:
>>
>> > On Tue, Jun 26, 2018 at 11:58 AM, Mike Snitzer <snitzer@redhat.com> wrote:
>> > > On Tue, Jun 26 2018 at  2:52pm -0400,
>> > > Dan Williams <dan.j.williams@intel.com> wrote:
>> > >
>> > > > On Tue, Jun 26, 2018 at 10:59 AM, Ross Zwisler
>> > > > <ross.zwisler@linux.intel.com> wrote:
>> > > > > QUEUE_FLAG_DAX is an indication that a given block device supports
>> > > > > filesystem DAX and should not be set for PMEM namespaces which are in "raw"
>> > > > > or "sector" modes.  These namespaces lack struct page and are prevented
>> > > > > from participating in filesystem DAX.
>> > > > >
>> > > > > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
>> > > > > Suggested-by: Mike Snitzer <snitzer@redhat.com>
>> > > > > Cc: stable@vger.kernel.org
>> > > >
>> > > > Why is this cc: stable? What is the user visible impact of this change
>> > > > especially given the requirement to validate QUEUE_FLAG_DAX with
>> > > > bdev_dax_supported()? Patch looks good, but it's just a cosmetic fixup
>> > > > afaics.
>> > >
>> > > This isn't cosmetic when you consider that stacking up a DM device is
>> > > looking at this flag to determine whether a table does or does _not_
>> > > support DAX.
>> > >
>> > > So this patch, in conjunction with the other changes in the series, is
>> > > certainly something I'd consider appropriate for stable.
>> >
>> > I think this classifies as something that never worked correctly and
>> > is not a regression. It does not identify which commit it is repairing
>> > or the user visible failure mode.
>>
>> So you're taking issue with making stacked dax configs work in older
>> kernels?  That's fine.  We can drop the stable cc if you like.
>>
>> But I mean we intended for this to work.. so the Fixes commit references
>> can easily be added, e.g.: 545ed20e6df68a4d2584a29a2a28ee8b2f7e9547
>> ("dm: add infrastructure for DAX support")
>
> When this dm change was made, the pmem driver supported DAX for both raw
> and memory modes (note: sector mode does not use the pmem driver).  I
> think the issue was introduced when we dropped DAX support from raw
> mode.

Still DAX with raw mode never really worked any way. It was also
something that was broken from day one. So what happens to someone who
happened to avoid all the problems with page-less DAX and enabled
device-mapper on top? That failure mode detail needs to be added to
this changelog if we want to propose this for -stable.
