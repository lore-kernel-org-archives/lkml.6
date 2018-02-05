Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3587241-1517868120-5-16641195979315411074
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517868120; b=LKYjnQ/ZHC+MoZi41D0ILchp0xTTLWOhQIy/7kvRU8C9hDb
    040Ci/rDAvdit6psVMnEMuwP68uEceOb5A2JzH5Gnw9m2b4o9a5HotobGsiGcTuB
    i/FuzpABYN+T9fEDsLEeqaPZMEeASaHNDrwL1ikL/8yv3IIRg+NfZFdDH0zdy0Fw
    4MfyXy0QjF3vLitYc8ji7lnA5zPrKSm/FeStANVR+TQ4e3+9XujGFzW3riJYYoqW
    GegaN4wiYeTu3iPPDEAPu0aTmqdgY/Wf3znOGJVS/Z4s7UTZIJxeqgVUASJkHpa4
    BbxH5Ko0tJIdgo1sCb2GquYCVgppw5262bdPjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517868120; bh=CtKBGNW1bv6ZT9aH9OcUwZf3vvRVsbly0fR3kl
    cF3Gg=; b=EI/LlPMiUJ2xhUaTeReA1WQxtLdVOtcB+GbJwgMDylYU1s519eZObd
    QEK9sKoFzl6v5YEoCFVilitKmh8s2E1j2IQq5jq7e4x/ia/Ml4LOw1ub8hwHZ5dg
    9+Ycz0Jd2AkWsBcu8cgjUlYV9JLC1MydGzL4TZFcNQK6bG8U0SL2QKwwacLgJL4A
    JNzQIGlBB2bzRbzOvm76QhTvuPSufyjwJQTNxmbiBqAmnPFstoH0IKMSUe+JY5nE
    hKVQ4b6a2mFL4tUNvGxYC5RQgqC6mSTEnjwBEjpts+hzJpc9NhKEOan1Y3lRBwxW
    DVjhA6DiCKVhl/YbnkTqR0SjZfEIr5yw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=PoOV/FY/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aXE0VzPc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=PoOV/FY/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aXE0VzPc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbeBEWB4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 17:01:56 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:45265 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeBEWBz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 17:01:55 -0500
X-Google-Smtp-Source: AH8x227CfCSLvQTh34EbuakTVskDOOysRHTJS/j+P866cz7vEEgayyxxLeq6QzNBZOX1BmPM4xGECIe9d+z8FeKDg3s=
MIME-Version: 1.0
In-Reply-To: <20180205144422.1ca67ab5@w520.home>
References: <151778551496.7139.17808629759104553625.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151778553083.7139.6601964812589807125.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180205144422.1ca67ab5@w520.home>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 5 Feb 2018 14:01:53 -0800
Message-ID: <CAPcyv4g+uC3HAnRpu-tfNdsBhon1dbXpte9P5DqWDBowoU08tw@mail.gmail.com>
Subject: Re: [PATCH 3/3] vfio: disable filesystem-dax page pinning
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Haozhong Zhang <haozhong.zhang@intel.com>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        KVM list <kvm@vger.kernel.org>, linux-nvdimm@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, aik@ozlabs.ru
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 5, 2018 at 1:44 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Sun, 04 Feb 2018 15:05:30 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
>> Filesystem-DAX is incompatible with 'longterm' page pinning. Without
>> page cache indirection a DAX mapping maps filesystem blocks directly.
>> This means that the filesystem must not modify a file's block map while
>> any page in a mapping is pinned. In order to prevent the situation of
>> userspace holding of filesystem operations indefinitely, disallow
>> 'longterm' Filesystem-DAX mappings.
>>
>> RDMA has the same conflict and the plan there is to add a 'with lease'
>> mechanism to allow the kernel to notify userspace that the mapping is
>> being torn down for block-map maintenance. Perhaps something similar can
>> be put in place for vfio.
>>
>> Note that xfs and ext4 still report:
>>
>>    "DAX enabled. Warning: EXPERIMENTAL, use at your own risk"
>>
>> ...at mount time, and resolving the dax-dma-vs-truncate problem is one
>> of the last hurdles to remove that designation.
>>
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: kvm@vger.kernel.org
>> Cc: <stable@vger.kernel.org>
>> Reported-by: Haozhong Zhang <haozhong.zhang@intel.com>
>> Fixes: d475c6346a38 ("dax,ext2: replace XIP read and write with DAX I/O")
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  drivers/vfio/vfio_iommu_type1.c |   18 +++++++++++++++---
>>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> This isn't without some expense, a vfio mapping and un-mapping unit
> test incurs ~1.5% increase in system time losing access to gup_fast().
> Also, I think tce_iommu_use_page() is going to have the same problem, it
> provides the same sort of functionality for a different vfio IOMMU
> backend.  Please take this through your tree and I'll add a todo list
> item to see how we might improve this.
>
> Acked-by: Alex Williamson <alex.williamson@redhat.com>

Thanks Alex.
