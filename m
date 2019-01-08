Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8DBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B342087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfAHF3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:29:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:4340 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfAHF3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 00:29:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 21:29:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,453,1539673200"; 
   d="scan'208";a="115016314"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jan 2019 21:29:34 -0800
Message-ID: <5C343688.2060609@intel.com>
Date:   Tue, 08 Jan 2019 13:35:04 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        mst@redhat.com, cohuck@redhat.com
CC:     pbonzini@redhat.com, dgilbert@redhat.com, pasic@linux.ibm.com
Subject: Re: [PATCH v3 1/3] virtio-balloon: tweak config_changed implementation
References: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com> <1546844466-38079-2-git-send-email-wei.w.wang@intel.com> <4ea022d4-6b89-b481-5747-871e154dd21a@de.ibm.com>
In-Reply-To: <4ea022d4-6b89-b481-5747-871e154dd21a@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2019 09:49 PM, Christian Borntraeger wrote:
>
> On 07.01.2019 08:01, Wei Wang wrote:
>> virtio-ccw has deadlock issues with reading the config space inside the
>> interrupt context, so we tweak the virtballoon_changed implementation
>> by moving the config read operations into the related workqueue contexts.
>> The config_read_bitmap is used as a flag to the workqueue callbacks
>> about the related config fields that need to be read.
>>
>> The cmd_id_received is also renamed to cmd_id_received_cache, and
>> the value should be obtained via virtio_balloon_cmd_id_received.
>>
>> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Together with
>    virtio_pci: use queue idx instead of array idx to set up the vq
>    virtio: don't allocate vqs when names[i] = NULL
>
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>

OK. I don't plan to send a new version of the above patches as no 
changes needed so far.

Michael, if the above two patches look good to you, please help add the 
related tested-by
and reviewed-by tags. Thanks.

Best,
Wei
