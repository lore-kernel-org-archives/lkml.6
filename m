Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446B2C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEC220879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="vbeMMo8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CEC220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbeLMRV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:21:26 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36774 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbeLMRVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:21:24 -0500
Received: by mail-oi1-f194.google.com with SMTP id x23so2270888oix.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 09:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DLj5B2WBtgjMeAt1YunYj55Bi8buNA5sz/8p9/trqng=;
        b=vbeMMo8hd8N5zOUAUtgfjyKtm+8yGp/MC6Tf+qb4H8mHWwT3IIRCs0+FQ+GuqeA2k1
         YOKOos1FGM2uSbvzZ3SC/AB/05bs8RbnO0bDOT6xSHRIGcA0tsygbfxbb+7PPQDtOmgn
         9v56lPAqoKPzZZGTq9htLg+DmvyKYCK7UUCPvHvVUWhB25nfXsJhI8kY6ny08L1Mp2kZ
         IV+gcugi5x4JqoV0IC99t3XhR3rmqwZUMexzHVUAw6pcW+68tCktHwIVWE++iR7eFTcS
         W61+tM6jOOCpWVmoibQ2rOLYiu26ZfRVTkQTXlCT28iFgkm4lKJmeDoCdoudtx5Euz/j
         VoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DLj5B2WBtgjMeAt1YunYj55Bi8buNA5sz/8p9/trqng=;
        b=a/VUDptJHoLrB3/eUVR+REaxXc7ksfZqmerpR1osOKmw7Q6d2usCYEKZH6lhL47EUL
         HZhr54vj3jQr00PohAsGhbTtWgOKpADNqLS6xwVQt5584BJuyce6DnsnA2eNzYVcnPBj
         moTpletm6D8zum9+XCUPEcbQzwoY7trr1pMCJXGvsDUFOiXKow+cKogbq8r95KBOPcva
         ARVAdRJbXMxJ9uKdEkJzTPo6iL1nl5dBBT0KjH5Bb6JdgNTqU4RlRDZlf5CQkAcw+GzT
         Tp/7HD4F9AotKpKxPKjyTJQ2ryiYLgj9IcnC7v2WfivzEMKu9lhyaoci1s243P1zzWNU
         Fkxg==
X-Gm-Message-State: AA+aEWa0CLpkoXmfpOLZhSk8c0ZJHHsUSVKNUEtZwMSHryp30jjQIf9R
        m8g5+FikfQajZYeK5pNATdBeWm6roKPpa9RU8q4sQw==
X-Google-Smtp-Source: AFSGD/VjPlVOI7qZDRVvuS/T2xOLfS6/wPSbzbBnBRLzgDrg5bxdEzFaDN0mPtsFAIXZxeBfTzqUuNWiF/Uocbzsq/s=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr3203887oig.232.1544721683680;
 Thu, 13 Dec 2018 09:21:23 -0800 (PST)
MIME-Version: 1.0
References: <20181213171330.8489-1-jglisse@redhat.com> <20181213171330.8489-4-jglisse@redhat.com>
In-Reply-To: <20181213171330.8489-4-jglisse@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 Dec 2018 09:21:12 -0800
Message-ID: <CAPcyv4i=Vq9VQphMhyuuBpS5j9MeuaXF9URyR=a4kN+ios5Gyg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mm/mmu_notifier: contextual information for event
 triggering invalidation v2
To:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>, zwisler@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Michal Hocko <mhocko@kernel.org>,
        "Koenig, Christian" <christian.koenig@amd.com>,
        rcampbell@nvidia.com, John Hubbard <jhubbard@nvidia.com>,
        KVM list <kvm@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 9:14 AM <jglisse@redhat.com> wrote:
>
> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>
> CPU page table update can happens for many reasons, not only as a result
> of a syscall (munmap(), mprotect(), mremap(), madvise(), ...) but also
> as a result of kernel activities (memory compression, reclaim, migration,
> ...).
>
> Users of mmu notifier API track changes to the CPU page table and take
> specific action for them. While current API only provide range of virtual
> address affected by the change, not why the changes is happening.
>
> This patchset adds event information so that users of mmu notifier can
> differentiate among broad category:
>     - UNMAP: munmap() or mremap()
>     - CLEAR: page table is cleared (migration, compaction, reclaim, ...)
>     - PROTECTION_VMA: change in access protections for the range
>     - PROTECTION_PAGE: change in access protections for page in the range
>     - SOFT_DIRTY: soft dirtyness tracking
>
> Being able to identify munmap() and mremap() from other reasons why the
> page table is cleared is important to allow user of mmu notifier to
> update their own internal tracking structure accordingly (on munmap or
> mremap it is not longer needed to track range of virtual address as it
> becomes invalid).

Who consumes these new enum values? The consumer of the new
infrastructure should be included in the patchset that adds the new
functionality. So a NAK from me until the consumer is clarified /
included.
