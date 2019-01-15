Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96953C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F60220659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfAOCN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:13:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:61858 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbfAOCN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 21:13:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 18:13:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,480,1539673200"; 
   d="scan'208";a="127756790"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by orsmga001.jf.intel.com with ESMTP; 14 Jan 2019 18:13:24 -0800
Message-ID: <5C3D4313.7090306@intel.com>
Date:   Tue, 15 Jan 2019 10:18:59 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        cohuck@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com,
        dgilbert@redhat.com, pasic@linux.ibm.com
Subject: Re: [PATCH v3 2/3] virtio-balloon: improve update_balloon_size_func
References: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com> <1546844466-38079-3-git-send-email-wei.w.wang@intel.com> <20190114195450-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190114195450-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/15/2019 09:00 AM, Michael S. Tsirkin wrote:
> On Mon, Jan 07, 2019 at 03:01:05PM +0800, Wei Wang wrote:
>> There is no need to update the balloon actual register when there is no
>> ballooning request. This patch avoids update_balloon_size when diff is 0.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> It sounds reasonable but it does have a side effect of
> not writing into actual anymore.
>
> I am not sure actual never can get out of sync as a result.
>
> So better deferred, pls send this in the next merge window.
>

No problem, it's not urgent to me.

Best,
Wei
