Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5004EC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C8A2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C8A2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeJHPXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:23:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725973AbeJHPXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:23:53 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9889T1Z028236
        for <linux-kernel@vger.kernel.org>; Mon, 8 Oct 2018 04:13:23 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n031b9qcg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 04:13:22 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 8 Oct 2018 09:13:21 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Oct 2018 09:13:19 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w988DIRN57475130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Oct 2018 08:13:18 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC03311C054;
        Mon,  8 Oct 2018 11:12:52 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46D4711C058;
        Mon,  8 Oct 2018 11:12:52 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.161])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  8 Oct 2018 11:12:52 +0100 (BST)
Date:   Mon, 8 Oct 2018 11:13:16 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: linux-next: manual merge of the akpm tree with the jc_docs tree
References: <20181008183840.70ebfe94@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008183840.70ebfe94@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18100808-0028-0000-0000-00000303EE37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100808-0029-0000-0000-000023BE3906
Message-Id: <20181008081315.GB6772@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810080082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 06:38:40PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the akpm tree got conflicts in:
> 
>   Documentation/memory-hotplug.txt
>   Documentation/admin-guide/mm/memory-hotplug.rst
> 
> between commits:
> 
>   6bf53999a3a2 ("docs: move memory hotplug description into admin-guide/mm")
>   98cee6742c80 ("docs/vm: split memory hotplug notifier description to Documentation/core-api")
> 
> from the jc_docs tree and patch:
> 
>   "memory-hotplug.txt: add some details about locking internals"
> 
> from the akpm tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Somehow I've managed to miss the patches from David :(

I should have called the new
Documentation/core-api/memory-hotplug-notifier.rst memory-hotplug.rst and
then the details about locking would fit there just fine.

I can do the renaming and add the patch

  "memory-hotplug.txt: add some details about locking internals"

on top of the jc_docs tree.

Does it sound Ok?

> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc Documentation/admin-guide/mm/memory-hotplug.rst
> index 0b9c83effaa4,ce4faa5530fa..000000000000
> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
> @@@ -413,6 -413,128 +413,46 @@@ Need more implementation yet...
>    - Notification completion of remove works by OS to firmware.
>    - Guard from remove if not yet.
>   
>  -Memory hotplug event notifier
>  -=============================
>  -
>  -Hotplugging events are sent to a notification queue.
>  -
>  -There are six types of notification defined in include/linux/memory.h:
>  -
>  -MEM_GOING_ONLINE
>  -  Generated before new memory becomes available in order to be able to
>  -  prepare subsystems to handle memory. The page allocator is still unable
>  -  to allocate from the new memory.
>  -
>  -MEM_CANCEL_ONLINE
>  -  Generated if MEMORY_GOING_ONLINE fails.
>  -
>  -MEM_ONLINE
>  -  Generated when memory has successfully brought online. The callback may
>  -  allocate pages from the new memory.
>  -
>  -MEM_GOING_OFFLINE
>  -  Generated to begin the process of offlining memory. Allocations are no
>  -  longer possible from the memory but some of the memory to be offlined
>  -  is still in use. The callback can be used to free memory known to a
>  -  subsystem from the indicated memory block.
>  -
>  -MEM_CANCEL_OFFLINE
>  -  Generated if MEMORY_GOING_OFFLINE fails. Memory is available again from
>  -  the memory block that we attempted to offline.
>  -
>  -MEM_OFFLINE
>  -  Generated after offlining memory is complete.
>  -
>  -A callback routine can be registered by calling::
>  -
>  -  hotplug_memory_notifier(callback_func, priority)
>  -
>  -Callback functions with higher values of priority are called before callback
>  -functions with lower values.
>  -
>  -A callback function must have the following prototype::
>  -
>  -  int callback_func(
>  -    struct notifier_block *self, unsigned long action, void *arg);
>  -
>  -The first argument of the callback function (self) is a pointer to the block
>  -of the notifier chain that points to the callback function itself.
>  -The second argument (action) is one of the event types described above.
>  -The third argument (arg) passes a pointer of struct memory_notify::
>  -
>  -	struct memory_notify {
>  -		unsigned long start_pfn;
>  -		unsigned long nr_pages;
>  -		int status_change_nid_normal;
>  -		int status_change_nid_high;
>  -		int status_change_nid;
>  -	}
>  -
>  -- start_pfn is start_pfn of online/offline memory.
>  -- nr_pages is # of pages of online/offline memory.
>  -- status_change_nid_normal is set node id when N_NORMAL_MEMORY of nodemask
>  -  is (will be) set/clear, if this is -1, then nodemask status is not changed.
>  -- status_change_nid_high is set node id when N_HIGH_MEMORY of nodemask
>  -  is (will be) set/clear, if this is -1, then nodemask status is not changed.
>  -- status_change_nid is set node id when N_MEMORY of nodemask is (will be)
>  -  set/clear. It means a new(memoryless) node gets new memory by online and a
>  -  node loses all memory. If this is -1, then nodemask status is not changed.
>  -
>  -  If status_changed_nid* >= 0, callback should create/discard structures for the
>  -  node if necessary.
>  -
>  -The callback routine shall return one of the values
>  -NOTIFY_DONE, NOTIFY_OK, NOTIFY_BAD, NOTIFY_STOP
>  -defined in include/linux/notifier.h
>  -
>  -NOTIFY_DONE and NOTIFY_OK have no effect on the further processing.
>  -
>  -NOTIFY_BAD is used as response to the MEM_GOING_ONLINE, MEM_GOING_OFFLINE,
>  -MEM_ONLINE, or MEM_OFFLINE action to cancel hotplugging. It stops
>  -further processing of the notification queue.
>  -
>  -NOTIFY_STOP stops further processing of the notification queue.
>  -
> + 
> + Locking Internals
> + =================
> + 
> + When adding/removing memory that uses memory block devices (i.e. ordinary RAM),
> + the device_hotplug_lock should be held to:
> + 
> + - synchronize against online/offline requests (e.g. via sysfs). This way, memory
> +   block devices can only be accessed (.online/.state attributes) by user
> +   space once memory has been fully added. And when removing memory, we
> +   know nobody is in critical sections.
> + - synchronize against CPU hotplug and similar (e.g. relevant for ACPI and PPC)
> + 
> + Especially, there is a possible lock inversion that is avoided using
> + device_hotplug_lock when adding memory and user space tries to online that
> + memory faster than expected:
> + 
> + - device_online() will first take the device_lock(), followed by
> +   mem_hotplug_lock
> + - add_memory_resource() will first take the mem_hotplug_lock, followed by
> +   the device_lock() (while creating the devices, during bus_add_device()).
> + 
> + As the device is visible to user space before taking the device_lock(), this
> + can result in a lock inversion.
> + 
> + onlining/offlining of memory should be done via device_online()/
> + device_offline() - to make sure it is properly synchronized to actions
> + via sysfs. Holding device_hotplug_lock is advised (to e.g. protect online_type)
> + 
> + When adding/removing/onlining/offlining memory or adding/removing
> + heterogeneous/device memory, we should always hold the mem_hotplug_lock in
> + write mode to serialise memory hotplug (e.g. access to global/zone
> + variables).
> + 
> + In addition, mem_hotplug_lock (in contrast to device_hotplug_lock) in read
> + mode allows for a quite efficient get_online_mems/put_online_mems
> + implementation, so code accessing memory can protect from that memory
> + vanishing.
> + 
> + 
>   Future Work
>   ===========
>   



-- 
Sincerely yours,
Mike.

