Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C38C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC9B26753
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="u7CDCViz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC9B26753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752917AbeFZV2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:28:10 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:40570 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752561AbeFZV2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:28:05 -0400
Received: by mail-ot0-f195.google.com with SMTP id f17-v6so4085184otl.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 14:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SjG2t5fFj3/2jMsHDH9KZr4v3krCbRdUQsdC1/IlxcU=;
        b=u7CDCVizyTEWb98O17a3Jk8wgmF2Q5fnnlKi28NHMSRvtZ2LRuXX0qitImshWwAiLg
         4PQtOUSaOSnr8rr1DBoO6KCu2iWb64cz0CKd8YpCi05oErOkgFOQonHQMg76OQkrIByb
         pwBYudEUmUofJNXjzeokl5162inkmJrAR0cYcJ6gRwSkziwhf+XN7TBh5zq42EKbHiGh
         9DZdown9WupL/AUwzw80Qw1Im00L0usq2HcEQIwJcvb4dHJI2jkP7Q4ZrokoR7H/eZeJ
         4AhFAcZmKFIBm9V2PGo6g2QUezg/dQsBgtDVVS/HdSznM9UB8RplSnjCIukPWGOq7Qo3
         Xk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SjG2t5fFj3/2jMsHDH9KZr4v3krCbRdUQsdC1/IlxcU=;
        b=AzQsI7a5aaifNFouiLe0qcFj3OVzttoJTBUaUykkJ17XeEjq8AARh4gvd+pgxs6/Pg
         2d6DhafUTnt+VIOkPWVRcba56ZIzevg6a4Z6ZUs6w4U/DbB6t1Pmu5sZ2+pEANApFlsT
         TxK7w/82+JoYifcTksb9KUa7ido7p62IUTif2XArRKVOKW82+M5pAlYD6cBOweA+g5Xk
         ZP62boR+Ajms47v0tZBhY0I0qHke4chPYsDBE9JlGDfFcTcglSXIgtsTbbpxm+5pDntl
         s50p4WcMbStewNcIGTvhFx72QlwL9X79oJZWZFOpY87wJZ6yUMB/7c22EDWCivStgikq
         GuLQ==
X-Gm-Message-State: APt69E1zP9t8uoEecembqVM7MmZFLIi2KW3ApBEh1eUNXdDt9NEoKdE1
        tdWiPJvNOp+/spVcdOJbCaz/drCzN3Z3qnRwoX6CfQ==
X-Google-Smtp-Source: AAOMgpf0wpQps2EaWSX4RWkKNt3lANJO8jKgkUOxPK0vKcBmRr94EhAHzt9LiNw0yfo9nIJjSeq6JHVm9RB2AHW8/us=
X-Received: by 2002:a9d:32ca:: with SMTP id u68-v6mr2001393otb.117.1530048485208;
 Tue, 26 Jun 2018 14:28:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:38eb:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 14:28:04
 -0700 (PDT)
In-Reply-To: <1530048093.14039.286.camel@hpe.com>
References: <20180626175932.8899-1-ross.zwisler@linux.intel.com>
 <20180626175932.8899-2-ross.zwisler@linux.intel.com> <CAPcyv4iWgPnHmBKhUvhManC6UL9CkLqN_d8vBo6KmcPJdPzuUw@mail.gmail.com>
 <20180626185830.GA7171@redhat.com> <CAPcyv4h6HO6fs6k7QMD77jkz2djCeWCtWomCdNb0-1Q4VKanqw@mail.gmail.com>
 <20180626191346.GA7233@redhat.com> <1530046327.14039.273.camel@hpe.com>
 <CAPcyv4hP_Y3xdyCa-UkYCMJ5OtnjnkwPZDS2Z2Ge8+5ymBONwQ@mail.gmail.com> <1530048093.14039.286.camel@hpe.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 26 Jun 2018 14:28:04 -0700
Message-ID: <CAPcyv4gXAC7imJs5qfsDNLeN545Rqyd2b1M9s5kr4f9y48LXgQ@mail.gmail.com>
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

On Tue, Jun 26, 2018 at 2:23 PM, Kani, Toshi <toshi.kani@hpe.com> wrote:
> On Tue, 2018-06-26 at 14:02 -0700, Dan Williams wrote:
>> On Tue, Jun 26, 2018 at 1:54 PM, Kani, Toshi <toshi.kani@hpe.com> wrote:
[..]
>> > When this dm change was made, the pmem driver supported DAX for both raw
>> > and memory modes (note: sector mode does not use the pmem driver).  I
>> > think the issue was introduced when we dropped DAX support from raw
>> > mode.
>>
>> Still DAX with raw mode never really worked any way. It was also
>> something that was broken from day one. So what happens to someone who
>> happened to avoid all the problems with page-less DAX and enabled
>> device-mapper on top? That failure mode detail needs to be added to
>> this changelog if we want to propose this for -stable.
>
> My point is that the behavior should be consistent between pmem and
> device-mapper.  When -o dax succeeds on a pmem, then it should succeed
> on a device-mapper on top of that pmem.
>
> Has the drop of dax support from raw mode made to -stable back to the
> baseline accepted 545ed20e6df6?  It will introduce inconsistency,
> otherwise.

That commit, 569d0365f571 "dax: require 'struct page' by default for
filesystem dax", has not been tagged for -stable.
