Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C5CC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BBB20645
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BBB20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbeLMMYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:24:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728888AbeLMMYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:24:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E6A43002307;
        Thu, 13 Dec 2018 12:24:37 +0000 (UTC)
Received: from [10.36.116.43] (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B400D5D6A9;
        Thu, 13 Dec 2018 12:24:32 +0000 (UTC)
Subject: Re: [PATCH 18/52] virtio-fs: Map cache using the values from the
 capabilities
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        miklos@szeredi.hu, stefanha@redhat.com, sweil@redhat.com,
        swhiteho@redhat.com
References: <20181210171318.16998-1-vgoyal@redhat.com>
 <20181210171318.16998-19-vgoyal@redhat.com>
 <de46a955-813b-355d-49f2-4d866603a8fa@redhat.com>
 <20181213091320.GA2313@work-vm>
 <d8c093db-9dda-1342-41c2-d08083cc150b@redhat.com>
 <20181213100058.GC2313@work-vm>
 <96d9ea85-ddf3-3331-77ce-124475b26da4@redhat.com>
 <20181213121548.GN2313@work-vm>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <0f1b43f6-57e3-c6d2-7ffe-cf783e125a7b@redhat.com>
Date:   Thu, 13 Dec 2018 13:24:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181213121548.GN2313@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 13 Dec 2018 12:24:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.12.18 13:15, Dr. David Alan Gilbert wrote:
> * David Hildenbrand (david@redhat.com) wrote:
>> On 13.12.18 11:00, Dr. David Alan Gilbert wrote:
>>> * David Hildenbrand (david@redhat.com) wrote:
>>>> On 13.12.18 10:13, Dr. David Alan Gilbert wrote:
>>>>> * David Hildenbrand (david@redhat.com) wrote:
>>>>>> On 10.12.18 18:12, Vivek Goyal wrote:
>>>>>>> Instead of assuming we had the fixed bar for the cache, use the
>>>>>>> value from the capabilities.
>>>>>>>
>>>>>>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>>>>> ---
>>>>>>>  fs/fuse/virtio_fs.c | 32 +++++++++++++++++---------------
>>>>>>>  1 file changed, 17 insertions(+), 15 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
>>>>>>> index 60d496c16841..55bac1465536 100644
>>>>>>> --- a/fs/fuse/virtio_fs.c
>>>>>>> +++ b/fs/fuse/virtio_fs.c
>>>>>>> @@ -14,11 +14,6 @@
>>>>>>>  #include <uapi/linux/virtio_pci.h>
>>>>>>>  #include "fuse_i.h"
>>>>>>>  
>>>>>>> -enum {
>>>>>>> -	/* PCI BAR number of the virtio-fs DAX window */
>>>>>>> -	VIRTIO_FS_WINDOW_BAR = 2,
>>>>>>> -};
>>>>>>> -
>>>>>>>  /* List of virtio-fs device instances and a lock for the list */
>>>>>>>  static DEFINE_MUTEX(virtio_fs_mutex);
>>>>>>>  static LIST_HEAD(virtio_fs_instances);
>>>>>>> @@ -518,7 +513,7 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
>>>>>>>  	struct dev_pagemap *pgmap;
>>>>>>>  	struct pci_dev *pci_dev;
>>>>>>>  	phys_addr_t phys_addr;
>>>>>>> -	size_t len;
>>>>>>> +	size_t bar_len;
>>>>>>>  	int ret;
>>>>>>>  	u8 have_cache, cache_bar;
>>>>>>>  	u64 cache_offset, cache_len;
>>>>>>> @@ -551,17 +546,13 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
>>>>>>>          }
>>>>>>>  
>>>>>>>  	/* TODO handle case where device doesn't expose BAR? */
>>>>>>
>>>>>> For virtio-pmem we decided to not go via BARs as this would effectively
>>>>>> make it only usable for virtio-pci implementers. Instead, we are going
>>>>>> to export the applicable physical device region directly (e.g.
>>>>>> phys_start, phys_size in virtio config), so it is decoupled from PCI
>>>>>> details. Doing the same for virtio-fs would allow e.g. also virtio-ccw
>>>>>> to make eventually use of this.
>>>>>
>>>>> That makes it a very odd looking PCI device;  I can see that with
>>>>> virtio-pmem it makes some sense, given that it's job is to expose
>>>>> arbitrary chunks of memory.
>>>>>
>>>>> Dave
>>>>
>>>> Well, the fact that your are
>>>>
>>>> - including <uapi/linux/virtio_pci.h>
>>>> - adding pci related code
>>>>
>>>> in/to fs/fuse/virtio_fs.c
>>>>
>>>> tells me that these properties might be better communicated on the
>>>> virtio layer, not on the PCI layer.
>>>>
>>>> Or do you really want to glue virtio-fs to virtio-pci for all eternity?
>>>
>>> No, these need cleaning up; and the split within the bar
>>> is probably going to change to be communicated via virtio layer
>>> rather than pci capabilities.  However, I don't want to make our PCI
>>> device look odd, just to make portability to non-PCI devices - so it's
>>> right to make the split appropriately, but still to use PCI bars
>>> for what they were designed for.
>>>
>>> Dave
>>
>> Let's discuss after the cleanup. In general I am not convinced this is
>> the right thing to do. Using virtio-pci for anything else than pure
>> transport smells like bad design to me (well, I am no virtio expert
>> after all ;) ). No matter what PCI bars were designed for. If we can't
>> get the same running with e.g. virtio-ccw or virtio-whatever, it is
>> broken by design (or an addon that is tightly glued to virtio-pci, if
>> that is the general idea).
> 
> I'm sure we can find alternatives for virtio-*, so I wouldn't expect
> it to be glued to virtio-pci.
> 
> Dave

As s390x does not have the concept of memory mapped io (RAM is RAM,
nothing else), this is not architectured. vitio-ccw can therefore not
define anything similar like that. However, in virtual environments we
can do whatever we want on top of the pure transport (e.g. on the virtio
layer).

Conny can correct me if I am wrong.

-- 

Thanks,

David / dhildenb
