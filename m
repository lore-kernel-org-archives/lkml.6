Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A46C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 06:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4D12070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 06:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbfACGM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 01:12:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:24655 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfACGM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 01:12:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 22:12:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,433,1539673200"; 
   d="scan'208";a="288468476"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by orsmga005.jf.intel.com with ESMTP; 02 Jan 2019 22:12:56 -0800
Message-ID: <5C2DA92E.9090503@intel.com>
Date:   Thu, 03 Jan 2019 14:18:22 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        mst@redhat.com, cohuck@redhat.com
CC:     pbonzini@redhat.com, dgilbert@redhat.com,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v1 0/2] Virtio: fix some vq allocation issues
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com> <c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
In-Reply-To: <c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/2018 03:57 PM, Christian Borntraeger wrote:
>
> On 28.12.2018 03:26, Wei Wang wrote:
>> Some vqs don't need to be allocated when the related feature bits are
>> disabled. Callers notice the vq allocation layer by setting the related
>> names[i] to be NULL.
>>
>> This patch series fixes the find_vqs implementations to handle this case.
> So the random crashes during boot are gone.
> What still does not work is actually using the balloon.
>
> So in the qemu monitor using lets say "balloon 1000"  will hang the guest.
> Seems to be a deadlock in the virtio-ccw code.  We seem to call the
> config code in the interrupt handler.

Please try with applying both this series and the "virtio-balloon: tweak 
config_changed"
series that I just sent.
This series fixes the ccw booting issue and that series tries to fix the 
ccw deadlock issue.

Best,
Wei
