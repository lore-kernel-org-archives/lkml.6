Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754B2C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E7B276DB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 17:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="EV/ZsfE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E7B276DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967637AbeF1R7f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 13:59:35 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:45433 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967426AbeF1R7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 13:59:33 -0400
Received: by mail-ot0-f196.google.com with SMTP id k3-v6so7096427otl.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZCQN18S7Xh6hoAW617L3djy5g+UhJXoIM1d3uuYd70w=;
        b=EV/ZsfE87hgyyDz5xEvOYDHLCeRFkNPqUflBLgt15gh+eNSIFZyo1hN2a/Ssv8jYL3
         74q+EaL2iFyuZWMhpO/evd1dK1Esr6wHX829IEFKs0UCqlGPY7l/LSFxk5cPvzk2c0XS
         45Sglsfd7OaLaTay+lGxQKA3tqZkE2nQonbg7yAsTDOIhK6odpbJiobg76Sm2BTO2aFK
         sRIKvNO/L/2O+7wOViil1oMujdOt+aZeRXbmXvffhuiH4ZV5UaCDYcal9Nq+83I5+s83
         kfyd2u7AuX+yqQPQnBd+JNmNp+U+5H3ZmKLAXywa7s83XRibEtNe0FjDe4kbif6E40lt
         7EaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZCQN18S7Xh6hoAW617L3djy5g+UhJXoIM1d3uuYd70w=;
        b=eYOUDRrgvM+edZft1YILQXj3rKO5o0ia1/zciN8TfuBFgXq7d9Jkyu//ZDUyPvwE2f
         28LVd8LFpJVfR2KfPJNiaUKEAa6OZLGjpNwe6RuuMfMYA5lx0p2xd/pZO7SpmvCIHpsN
         8Y4GS1H9bRn7Pd0bGNdJS5smn6Sm10lXNYKN7co4CFhoYMuFcE7mKjNi4Qowe6Bce76S
         kGX0M4j5G1kMhF0aDrb/AH0mOUk+ZJ3Tgc2G3iH99ZxBW+sy9sBPXt0bZl1l0IM3eVZQ
         UISpiaxUsrq/T0nUbf1NyUULANGy/fPwbLeeXFOxdy2/R9qldhOKbToUkxtJJZGoz5Eg
         /VdQ==
X-Gm-Message-State: APt69E3zUUe0jdoxJbnvKXe/t14HhavFvc8ctrCidANd4YL9Kmn+hV34
        SWjL/+nIrTR+7DUmEp/fBRtdQkc7OARJ46Ftgu6jdg==
X-Google-Smtp-Source: AAOMgpcPEUm8sbzw2iL9SqKqLR/m755biSd4GzgBf/dlz+5kTs1nNhooNZzjo3PVqpoqtwxA/3DF5y6EUM/PLHQ5vnM=
X-Received: by 2002:a9d:7311:: with SMTP id e17-v6mr6326041otk.162.1530208772572;
 Thu, 28 Jun 2018 10:59:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:38c2:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 10:59:31
 -0700 (PDT)
In-Reply-To: <20180628174815.GA18768@redhat.com>
References: <CAPcyv4h6HO6fs6k7QMD77jkz2djCeWCtWomCdNb0-1Q4VKanqw@mail.gmail.com>
 <20180626191346.GA7233@redhat.com> <1530046327.14039.273.camel@hpe.com>
 <CAPcyv4hP_Y3xdyCa-UkYCMJ5OtnjnkwPZDS2Z2Ge8+5ymBONwQ@mail.gmail.com>
 <1530048093.14039.286.camel@hpe.com> <CAPcyv4gXAC7imJs5qfsDNLeN545Rqyd2b1M9s5kr4f9y48LXgQ@mail.gmail.com>
 <1530048545.14039.288.camel@hpe.com> <CAPcyv4ifHX95fCM9Xj87CugwNWzgq=y-4LxPQ5L6RdjX0jdctQ@mail.gmail.com>
 <20180626220430.GA4269@linux.intel.com> <1530207635.14039.308.camel@hpe.com> <20180628174815.GA18768@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 28 Jun 2018 10:59:31 -0700
Message-ID: <CAPcyv4grHpyihujqxvaPe4=E-43L2Yvp+dNyX6bx+B06mNwsPA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] pmem: only set QUEUE_FLAG_DAX for fsdax mode
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     "Kani, Toshi" <toshi.kani@hpe.com>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 10:48 AM, Mike Snitzer <snitzer@redhat.com> wrote:
> On Thu, Jun 28 2018 at  1:42pm -0400,
> Kani, Toshi <toshi.kani@hpe.com> wrote:
>
>> On Tue, 2018-06-26 at 16:04 -0600, Ross Zwisler wrote:
>> > On Tue, Jun 26, 2018 at 02:51:52PM -0700, Dan Williams wrote:
>> > > On Tue, Jun 26, 2018 at 2:31 PM, Kani, Toshi <toshi.kani@hpe.com> wrote:
>> > > > On Tue, 2018-06-26 at 14:28 -0700, Dan Williams wrote:
>> > > > > On Tue, Jun 26, 2018 at 2:23 PM, Kani, Toshi <toshi.kani@hpe.com> wrote:
>> > > > > > On Tue, 2018-06-26 at 14:02 -0700, Dan Williams wrote:
>> > > > > > > On Tue, Jun 26, 2018 at 1:54 PM, Kani, Toshi <toshi.kani@hpe.com> wrote:
>> > > > >
>> > > > > [..]
>> > > > > > > > When this dm change was made, the pmem driver supported DAX for both raw
>> > > > > > > > and memory modes (note: sector mode does not use the pmem driver).  I
>> > > > > > > > think the issue was introduced when we dropped DAX support from raw
>> > > > > > > > mode.
>> > > > > > >
>> > > > > > > Still DAX with raw mode never really worked any way. It was also
>> > > > > > > something that was broken from day one. So what happens to someone who
>> > > > > > > happened to avoid all the problems with page-less DAX and enabled
>> > > > > > > device-mapper on top? That failure mode detail needs to be added to
>> > > > > > > this changelog if we want to propose this for -stable.
>> > > > > >
>> > > > > > My point is that the behavior should be consistent between pmem and
>> > > > > > device-mapper.  When -o dax succeeds on a pmem, then it should succeed
>> > > > > > on a device-mapper on top of that pmem.
>> > > > > >
>> > > > > > Has the drop of dax support from raw mode made to -stable back to the
>> > > > > > baseline accepted 545ed20e6df6?  It will introduce inconsistency,
>> > > > > > otherwise.
>> > > > >
>> > > > > That commit, 569d0365f571 "dax: require 'struct page' by default for
>> > > > > filesystem dax", has not been tagged for -stable.
>> > > >
>> > > > Then, Fixes tag should be set to 569d0365f571 to keep the behavior
>> > > > consistent.
>> > >
>> > > Sure, and the failure mode is...? I'm thinking the commit log should say:
>> > >
>> > > "Starting with commit 569d0365f571 "dax: require 'struct page' by
>> > > default for filesystem dax", dax is no longer supported for page-less
>> > > configurations. However, device-mapper sees the QUEUE_FLAG_DAX still
>> > > being set and falsely assumes that DAX is enabled, this leads to
>> > > <insert user visible failure mode details here>"
>> >
>> > Dan is correct that there is no user visible change for this.  It is the right
>> > thing to do for consistency and sanity, but it doesn't actually have user
>> > visible behavior that needs to be backported to stable.
>> >
>> > Toshi is correct that this change is only for raw mode namespaces, not btt
>> > namespaces.
>> >
>> > I'll adjust the changelog and remove the stable flag for v5, and I'll add a
>> > Fixes: tag for patch 2.
>>
>> Hi Ross,
>>
>> Your patches look good.  But I am still not clear about the Fixes &
>> stable handling.  Talking about user visible behavior, I do not think we
>> had any issue until dax support was dropped from raw mode.  Until then,
>> the pmem driver supported dax for all modes, and the check for
>> direct_access worked.
>
> I've staged the changes to send to Linus shortly.
>
> The first patch has:
>
> Fixes: 569d0365f571 ("dax: require 'struct page' by default for filesystem dax")
> Cc: stable@vger.kernel.org
>
> As that is the right thing to do given the other 2 patches are marked
> for stable.  We don't want to have a stable kernel with the last 2
> patches but not the first.

Ok, I'm still grumbling about the changelog being more clear about
what the problem was, but let's just go with what you got.
