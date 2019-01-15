Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05D4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD4320651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 02:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfAOCKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:10:06 -0500
Received: from mga01.intel.com ([192.55.52.88]:62911 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbfAOCKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 21:10:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 18:10:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,480,1539673200"; 
   d="scan'208";a="310445141"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jan 2019 18:10:05 -0800
Message-ID: <5C3D424B.70400@intel.com>
Date:   Tue, 15 Jan 2019 10:15:39 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Cornelia Huck <cohuck@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
CC:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/2] virtio: fix virtio_config_ops description
References: <20190103160804.21438-1-cohuck@redhat.com>  <20190103160804.21438-2-cohuck@redhat.com> <20190114150958.39a4a56a.cohuck@redhat.com>
In-Reply-To: <20190114150958.39a4a56a.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/14/2019 10:09 PM, Cornelia Huck wrote:
> On Thu,  3 Jan 2019 17:08:03 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> - get_features has returned 64 bits since commit d025477368792
>>    ("virtio: add support for 64 bit features.")
>> - properly mark all optional callbacks
>>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>   include/linux/virtio_config.h | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
>> index 32baf8e26735..7087ef946ba7 100644
>> --- a/include/linux/virtio_config.h
>> +++ b/include/linux/virtio_config.h
>> @@ -22,7 +22,7 @@ struct irq_affinity;
>>    *	offset: the offset of the configuration field
>>    *	buf: the buffer to read the field value from.
>>    *	len: the length of the buffer
>> - * @generation: config generation counter
>> + * @generation: config generation counter (optional)
>>    *	vdev: the virtio_device
>>    *	Returns the config generation counter
>>    * @get_status: read the status byte
>> @@ -48,17 +48,17 @@ struct irq_affinity;
>>    * @del_vqs: free virtqueues found by find_vqs().
>>    * @get_features: get the array of feature bits for this device.
>>    *	vdev: the virtio_device
>> - *	Returns the first 32 feature bits (all we currently need).
>> + *	Returns the first 64 feature bits (all we currently need).
>>    * @finalize_features: confirm what device features we'll be using.
>>    *	vdev: the virtio_device
>>    *	This gives the final feature bits for the device: it can change
>>    *	the dev->feature bits if it wants.
>>    *	Returns 0 on success or error status
>> - * @bus_name: return the bus name associated with the device
>> + * @bus_name: return the bus name associated with the device (optional)
>>    *	vdev: the virtio_device
>>    *      This returns a pointer to the bus name a la pci_name from which
>>    *      the caller can then copy.
>> - * @set_vq_affinity: set the affinity for a virtqueue.
>> + * @set_vq_affinity: set the affinity for a virtqueue (optional).
>>    * @get_vq_affinity: get the affinity for a virtqueue (optional).
>>    */
>>   typedef void vq_callback_t(struct virtqueue *);
> Ping. Any feedback on that patch?

Reviewed-by: Wei Wang <wei.w.wang@intel.com>

Best,
Wei

