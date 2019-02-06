Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC955C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8703218AF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Z3Z2lLvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfBFXmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 18:42:33 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:45082 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfBFXmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 18:42:32 -0500
Received: by mail-ot1-f48.google.com with SMTP id 32so15144676ota.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 15:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mXx8poVQjV9HwQ463+J8Xh3rIF5Pas5UKY3iVculMOM=;
        b=Z3Z2lLvknU+nXiktZsISNTZLCCnSxgLh9jbswTAZpFimWum7i8r4fiyXlbRXawiSFx
         ubZthob+CbYbDMN5OCG6J2F9X3wECf+LBU+tTop4TVjaWjls++ZNfLtg+1JGYnPEcN37
         EaNJwmPl89UKy8gR+WlqBXdJkRZg16QJ0BjDH4q+Sx6RPbFi1tr2TZb/EHnIeM4dOWHF
         wHzB/rU13hd17CbU1+HNk9CJoObq4xDh7x4aC/CDMcamLw4e/S1MrwMzMk7bxycUqbgS
         InxU0buRpVtfqCYuDLJanWPCzbVAjVkTWMWCnP0VW6BH5bVPjHYS4iqebcD180jVB1rC
         q3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mXx8poVQjV9HwQ463+J8Xh3rIF5Pas5UKY3iVculMOM=;
        b=JRxSIZfS4MlooJ05F9U4V8n/qI5dHrFwt2NZq9EWctpUaVgCy2ZF4jKhTFgp+d7bIa
         ay0+qmoOm/56wFETL4QTaxXf75fTKTjox3kLwHROGddt3uaH+FGIpJURPKDMREUHWDJo
         /SAiQZzA7Q89/lLNHIe02Oo7xQu0B0ufdPU/UL9yFNLA4kw364h3UXLq4RuP1ZlRc9mp
         Vk1u30UYDKY4X6/+POHcVr4FiH3o790vpVER8eSaUXzOuMFSYc+faYZM66RefeRdBgHF
         bDpRwdiSov5aCgnc9BJ+sNPyTI3g5nInySKfe9tgHv8jKs3TSyBWXPYcyZpM/CB1ZtEm
         yylA==
X-Gm-Message-State: AHQUAuZwIy15d9XIrhtAfNS27mOrBpt0SpCON2YkHwC+M7cFmoTUdSjJ
        vbeLwc/QXBQfYOE1mzJJyBsc5GBQxigaKh1QxwnfYQ==
X-Google-Smtp-Source: AHgI3IYi1lYx53OeMuuIKEyrITbFju31q2tPP/t65m35wlLVFLatHOq9dRn/sh2Fw8NEo3ekoOOLnIYan2iyNMuAnBk=
X-Received: by 2002:aca:240a:: with SMTP id n10mr956698oic.73.1549496551785;
 Wed, 06 Feb 2019 15:42:31 -0800 (PST)
MIME-Version: 1.0
References: <20190206231706.GB23860@ubuette>
In-Reply-To: <20190206231706.GB23860@ubuette>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 6 Feb 2019 15:42:17 -0800
Message-ID: <CAPcyv4jhkkUd_rZ9PhZhOZDYYgMj28siVBUjhMMT4c4HJiaAHw@mail.gmail.com>
Subject: Re: question about mmap MAP_PRIVATE on PMEM/DAX/fs files
To:     Larry Bassel <larry.bassel@oracle.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 3:17 PM Larry Bassel <larry.bassel@oracle.com> wrote:
>
> Is mmaping a PMEM/DAX/fs file MAP_PRIVATE supported?

Yes.

> Is it something
> that people are likely to want to do?

MAP_PRIVATE for file backed mappings is useful for processes to read
common data as input, but hide their writes to that data.

> If it is supported, suppose I open a file in PMEM/DAX/fs, mmap it
> MAP_PRIVATE, read from the memory mapped file (with memory accesses,
> not the read syscall) and take a page fault which the kernel satisfies.
>
> At this time do my page tables for the private mmaped page(s) point to the
> PMEM corresponding to the file and the kernel will wait until
> the page(s) is/are altered (either by me or someone else) to
> copy on write and give me a different page/mapping?

For this example let's assume the filesystem already allocated
capacity for the file at the given offset, otherwise the kernel is
free to map in a zero page to cover holes in the file.

> Or does the kernel avoid this by always mapping a copy of the
> page(s) involved in the private mmap in the first place?
>

At read-fault time the page tables point to the direct PMEM page for
the file allocation, for a write fault a "System RAM" page is mapped
in place of PMEM.

> In either case, is my private copy going to come from PMEM or is it
> an "ordinary" page, or is this "random"? Does the program have
> any choice in this (i.e. suppose I want to make sure my copied
> page is persistent)?

No, the copied page will never be persisted. From the mmap() man page:

"Updates to the mapping are not visible to other processes mapping the
same file, and are not carried through to the underlying file."
