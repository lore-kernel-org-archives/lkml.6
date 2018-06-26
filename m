Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883EFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 22:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097162246D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 22:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="U06RQSCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097162246D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754807AbeFZWhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 18:37:54 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36356 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbeFZWhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 18:37:52 -0400
Received: by mail-ot0-f193.google.com with SMTP id c15-v6so70990otl.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 15:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tfrgKetEq90QY/D0gvCuyWtoPa78sDefz3xL8wqeVeo=;
        b=U06RQSCK9WBuwa5P+WJ9Cq7Fa4P0bUodkF6Kdj0oaqjxch+ciJQcC/LIfJ7l066+uy
         WdYy6QVmVI+2rawyPcbEPmobUe4aLW7u8PorAKpPnzvaPR2Fb5vI4hKw4iZyt3B/+t8c
         PC/hWI8MQ3+C1kAnv+aWhsEICIJKzssMNgLInwu4is+d+EffpHZYHmFGze2REjlM0wh2
         MC5ZEPHpyceTaEEOrm0kryPuAnz3FLsL+9ScIky4gUjIN2e4u7p2DRem+cy9a5s8Hzuf
         lgbNmTnh/dwV58akPlwWgu45zRYqQb9gh8a9lSSYsA+NbGVINyvqbSZrCKqQonRfpMI+
         G3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tfrgKetEq90QY/D0gvCuyWtoPa78sDefz3xL8wqeVeo=;
        b=lMUIU7S9oZFLsKZ3EXCdX1CIl42lmomBzu6/L452pMcz6ILrh14XwlBP7Mg9jiTQ9d
         L6RZb2yMBaXO+iMJlbglcr9ZpZYRU1zL/RikWAvE5DX41oEeLXjNEOWyCGZzZ6MZyIqp
         A3ib896AQ285eHqhpcdA2z8zkO10lIXDN8wR9b5dz7auxnuyezuGj7yAEyMtkAKaf4Nu
         hCLvNZ4JZLK7sFvnvZ7UxlgHCKeG0cb5/qtgJwt4kckMtJm07+Zx5c28Pt0eOUd5zUtK
         2STNV50CCgpQye+410+/wX39xW/0yPrJxo9EiO95+VbirzEbRQDVDwe4Cy2U+iCM804H
         rGUA==
X-Gm-Message-State: APt69E16q3Y4iIbZfg+VqgFylaOsdQRvSIK2BHSae+ynzPzgbHCWTP8+
        AqlSahZd9DQ0KRV7d6/+JYfnWUTimkjttYnyAUwMMA==
X-Google-Smtp-Source: AAOMgpewWUS8vKpphDa3FYsB91hH1l7n7yBDYUp8VDULMkyEUQqLBui3iUuI1KDTLQ1feBWjPlreBgKNRRbhV+sFT5I=
X-Received: by 2002:a9d:446c:: with SMTP id f41-v6mr1502323otj.194.1530052671770;
 Tue, 26 Jun 2018 15:37:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:38c2:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 15:37:51
 -0700 (PDT)
In-Reply-To: <20180626223041.15653-1-ross.zwisler@linux.intel.com>
References: <20180626223041.15653-1-ross.zwisler@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 26 Jun 2018 15:37:51 -0700
Message-ID: <CAPcyv4hm=fiupZWwX=o1aFf8uSWnAwr8dKpUGHVFs6HEwmtn2A@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Fix DM DAX handling
To:     Ross Zwisler <ross.zwisler@linux.intel.com>
Cc:     Toshi Kani <toshi.kani@hpe.com>, Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 3:30 PM, Ross Zwisler
<ross.zwisler@linux.intel.com> wrote:
> This series fixes a few issues that I found with DM's handling of DAX
> devices.  Here are some of the issues I found:
>
>  * We can create a dm-stripe or dm-linear device which is made up of an
>    fsdax PMEM namespace and a raw PMEM namespace but which can hold a
>    filesystem mounted with the -o dax mount option.  DAX operations to
>    the raw PMEM namespace part lack struct page and can fail in
>    interesting/unexpected ways when doing things like fork(), examining
>    memory with gdb, etc.
>
>  * We can create a dm-stripe or dm-linear device which is made up of an
>    fsdax PMEM namespace and a BRD ramdisk which can hold a filesystem
>    mounted with the -o dax mount option.  All I/O to this filesystem
>    will fail.
>

For the series:

Acked-by: Dan Williams <dan.j.williams@intel.com>
