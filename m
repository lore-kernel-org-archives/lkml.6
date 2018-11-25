Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D806C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0EF2086B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="dHtRey9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0EF2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbeKZHwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 02:52:07 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44410 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbeKZHwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 02:52:07 -0500
Received: by mail-ot1-f65.google.com with SMTP id f18so13207845otl.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 13:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=grN8iueVCnJfFhI5vNxMNHC4YBEugxlvf468YCpBLTU=;
        b=dHtRey9Ivdbuwq3wnIMXOBEu793BOjxb+vjEv58lVsuEYQw8Xy2SuP9eCNlaPwzJR+
         Mif1Tjqsx2c/IgERM10FyEktJSU/6Byc3WrsL7QYRV0H45pNg67wwkwfCZAAkAIhKnmy
         n3tneNfpYHvHnc5NKjApUUtsLG2kzGTtUtBiqdRaBH8roX7cne2Fx6oV3LTvwg76ml6l
         GFMRlrXLy35omTbYfEJimuUFOU04kxZ4ORGPhiRJdJTX805NwwM/crG6jvuVdwGnh9Un
         5ZGg583UrY01zvrTlWtYVk7RuPp4wbnPUbe1HVzNEfPPah0LPpealOJp1ZatRFIkx8nx
         E1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=grN8iueVCnJfFhI5vNxMNHC4YBEugxlvf468YCpBLTU=;
        b=jZ5O4OZvFfwyZImZPqwbCrqG+OK/18gcu0NxaiYku3SxdtXFtRnUV2rArq1tA8NoVu
         wZb9MohkKCYxl+WfwQCPWCGbSbmOnxsd8y32R1b/Z0njY/aNhXXydgsaQGQqSeX25Hdm
         EEiPsODVY7LqIN2ZkOBwhXn28izBySYk95sohULr99VA718F40LDBAMmQsLLiFp1MYh0
         y1FICl/yiXZYtdYlOES0QRgpWt9TNUiHOkXgcZH8//ZyKjxoMkq1s8VQXfx++14WYLKm
         pmaA5pqHHOmTBAVwPGhx1X6MoH3H5WEjT3tRyhjG5QbBdlh8h28Ph4r7HxBsITuTsd5s
         qHkg==
X-Gm-Message-State: AA+aEWbeqIFzLQwvQgfvP5Vuee2nNoi5MuVApskrWGhGEjAVHOjLtZ7s
        z9TsXEsFmbFoWmatCfh+Iw9rMwypQBaxpclLBGq7jw==
X-Google-Smtp-Source: AJdET5d6Go+dHqS5tEszdo1nPigCgIfhs2WB9QUYzMOsEh/rqGCWsa7U1CiyarMSKgv8jNqsOh3kPTsFZXX9/efTfVw=
X-Received: by 2002:a9d:7dd5:: with SMTP id k21mr14287939otn.214.1543179610180;
 Sun, 25 Nov 2018 13:00:10 -0800 (PST)
MIME-Version: 1.0
References: <20181121032702.3048-1-yehs2007@zoho.com>
In-Reply-To: <20181121032702.3048-1-yehs2007@zoho.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 25 Nov 2018 12:59:59 -0800
Message-ID: <CAPcyv4hmCsNOZPEAzOLxhFCQpyaG0_9TJvJnyuytQAVEU7_wbA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] realize dax_operations for dm-snapshot
To:     Huaisheng Ye <yehs2007@zoho.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, zwisler@kernel.org,
        Jan Kara <jack@suse.cz>, Dave Jiang <dave.jiang@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NingTing Cheng <chengnt@lenovo.com>,
        Huaisheng Ye <yehs1@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 7:27 PM Huaisheng Ye <yehs2007@zoho.com> wrote:
>
> From: Huaisheng Ye <yehs1@lenovo.com>
>
> Changes
> v1->v2:
>         Add NULL funtions for origin_dax_direct_access and
>         origin_dax_copy_from/to_iter in order to avoid building
>         error when CONFIG_DAX_DRIVER has NOT been enabled.
>
> [v1]: https://lkml.org/lkml/2018/11/20/759
>
> This series patches are used to realize the dax_operations for dm-snapshot
> with persistent memory device.

How does this interact with mmap write faults if the mapping is dax
and the page needs to be cow'd?
