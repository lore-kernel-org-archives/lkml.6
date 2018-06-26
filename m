Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA23C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BC626C7D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="tpdMTLOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71BC626C7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752382AbeFZTHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:07:44 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33471 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbeFZTHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:07:41 -0400
Received: by mail-oi0-f67.google.com with SMTP id c6-v6so17055863oiy.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 12:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eEsHDdswKhCSMi1Tdxb4k2zoEdhvWEcSc2Zw4zeSY6A=;
        b=tpdMTLOIz7nEV00ncye3t/dYb3fMBcMikBBbzrOJzCuDAZETQY3kmt1PT55re9YCua
         PLsllawKFi7azx+oAoOshwDcl/HdlIoBDDjzCTO70w5gyqg96+Y+VCfdhSKICi/LB2Ik
         PGQb7mTRNnhKZBS6H82PKHnwDVclt1mEdMrnSRgsrDllv1b8h5TjBTOutGvpHTtQjitR
         5mFZMq+rQtM7EZ4M90kW2hNtJUtAH/SFSfJRGmXdyCSZerHnWbsmH8zSAeHTTgJzzmTS
         qiaPi3+8vtnbCuXghWeg2nK3H6V4gQ7zn92BagZqycwar+Ytwfw8QDvMxrQQEzBPPGzx
         gv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eEsHDdswKhCSMi1Tdxb4k2zoEdhvWEcSc2Zw4zeSY6A=;
        b=nLd4bPOU+qNCPrPhItonh8V6mfqeO36D2b5mJzl96OFon+1BFpUVSmXHHlhjLMmG/U
         r8PUxG/F15SMIrxy6PQLnlzD4R5PEgIascu7Mb2BNaGXmgbqaFjTOL1fljkQ/+awcEjQ
         SqQAUesMkC+1J6LitVRHd4E3L1e8dx44mKXvl7172wTxCUpFlHesCJdNOLG9lgzxK2od
         Q9psyUQJbqe83gdNvhSgWsAd375P6sOssgji93rwHN4XTNjgrCV9w1uFBEdZ1LYvIp5z
         T0KZIsg7leTEhwqFtEV1v/n1pFpf5qYe7EpSZVl2hcuDqbA6A4f0WSyHca1SDpce6nnC
         PozA==
X-Gm-Message-State: APt69E1kSpUVMtJkCH2apbgWOvR5yexTkgJJciAx4S6ZJiIb/6DnCTYO
        4EwFdDROdSGpObt3j2Dgu8LJs/36iDSFUVvHdS/0sw==
X-Google-Smtp-Source: AAOMgpd1vCZb00PYjf96RHpobARMkH8xSh1QRtmuOUdEDIjaJDor8LwYBHvqdFFULrVZ43QgJdq1JxLJtD8ym6c3G28=
X-Received: by 2002:aca:3d43:: with SMTP id k64-v6mr1480216oia.166.1530040061126;
 Tue, 26 Jun 2018 12:07:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:38c2:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 12:07:40
 -0700 (PDT)
In-Reply-To: <20180626185830.GA7171@redhat.com>
References: <20180626175932.8899-1-ross.zwisler@linux.intel.com>
 <20180626175932.8899-2-ross.zwisler@linux.intel.com> <CAPcyv4iWgPnHmBKhUvhManC6UL9CkLqN_d8vBo6KmcPJdPzuUw@mail.gmail.com>
 <20180626185830.GA7171@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 26 Jun 2018 12:07:40 -0700
Message-ID: <CAPcyv4h6HO6fs6k7QMD77jkz2djCeWCtWomCdNb0-1Q4VKanqw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] pmem: only set QUEUE_FLAG_DAX for fsdax mode
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Ross Zwisler <ross.zwisler@linux.intel.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 11:58 AM, Mike Snitzer <snitzer@redhat.com> wrote:
> On Tue, Jun 26 2018 at  2:52pm -0400,
> Dan Williams <dan.j.williams@intel.com> wrote:
>
>> On Tue, Jun 26, 2018 at 10:59 AM, Ross Zwisler
>> <ross.zwisler@linux.intel.com> wrote:
>> > QUEUE_FLAG_DAX is an indication that a given block device supports
>> > filesystem DAX and should not be set for PMEM namespaces which are in "raw"
>> > or "sector" modes.  These namespaces lack struct page and are prevented
>> > from participating in filesystem DAX.
>> >
>> > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
>> > Suggested-by: Mike Snitzer <snitzer@redhat.com>
>> > Cc: stable@vger.kernel.org
>>
>> Why is this cc: stable? What is the user visible impact of this change
>> especially given the requirement to validate QUEUE_FLAG_DAX with
>> bdev_dax_supported()? Patch looks good, but it's just a cosmetic fixup
>> afaics.
>
> This isn't cosmetic when you consider that stacking up a DM device is
> looking at this flag to determine whether a table does or does _not_
> support DAX.
>
> So this patch, in conjunction with the other changes in the series, is
> certainly something I'd consider appropriate for stable.

I think this classifies as something that never worked correctly and
is not a regression. It does not identify which commit it is repairing
or the user visible failure mode.
