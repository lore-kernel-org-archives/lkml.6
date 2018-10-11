Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19B8C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726FB2087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726FB2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeJKPJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:09:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbeJKPJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:09:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 27A973001FD2;
        Thu, 11 Oct 2018 07:43:22 +0000 (UTC)
Received: from [10.36.117.105] (ovpn-117-105.ams2.redhat.com [10.36.117.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22543105706D;
        Thu, 11 Oct 2018 07:43:19 +0000 (UTC)
Subject: Re: [PATCH 1/2] docs/core-api: rename memory-hotplug-notifier to
 memory-hotplug
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <1539233897-10207-1-git-send-email-rppt@linux.ibm.com>
 <1539233897-10207-2-git-send-email-rppt@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwX4EEwECACgFAljj9eoCGwMFCQlmAYAGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEE3eEPcA/4Na5IIP/3T/FIQMxIfNzZshIq687qgG
 8UbspuE/YSUDdv7r5szYTK6KPTlqN8NAcSfheywbuYD9A4ZeSBWD3/NAVUdrCaRP2IvFyELj
 xoMvfJccbq45BxzgEspg/bVahNbyuBpLBVjVWwRtFCUEXkyazksSv8pdTMAs9IucChvFmmq3
 jJ2vlaz9lYt/lxN246fIVceckPMiUveimngvXZw21VOAhfQ+/sofXF8JCFv2mFcBDoa7eYob
 s0FLpmqFaeNRHAlzMWgSsP80qx5nWWEvRLdKWi533N2vC/EyunN3HcBwVrXH4hxRBMco3jvM
 m8VKLKao9wKj82qSivUnkPIwsAGNPdFoPbgghCQiBjBe6A75Z2xHFrzo7t1jg7nQfIyNC7ez
 MZBJ59sqA9EDMEJPlLNIeJmqslXPjmMFnE7Mby/+335WJYDulsRybN+W5rLT5aMvhC6x6POK
 z55fMNKrMASCzBJum2Fwjf/VnuGRYkhKCqqZ8gJ3OvmR50tInDV2jZ1DQgc3i550T5JDpToh
 dPBxZocIhzg+MBSRDXcJmHOx/7nQm3iQ6iLuwmXsRC6f5FbFefk9EjuTKcLMvBsEx+2DEx0E
 UnmJ4hVg7u1PQ+2Oy+Lh/opK/BDiqlQ8Pz2jiXv5xkECvr/3Sv59hlOCZMOaiLTTjtOIU7Tq
 7ut6OL64oAq+zsFNBFXLn5EBEADn1959INH2cwYJv0tsxf5MUCghCj/CA/lc/LMthqQ773ga
 uB9mN+F1rE9cyyXb6jyOGn+GUjMbnq1o121Vm0+neKHUCBtHyseBfDXHA6m4B3mUTWo13nid
 0e4AM71r0DS8+KYh6zvweLX/LL5kQS9GQeT+QNroXcC1NzWbitts6TZ+IrPOwT1hfB4WNC+X
 2n4AzDqp3+ILiVST2DT4VBc11Gz6jijpC/KI5Al8ZDhRwG47LUiuQmt3yqrmN63V9wzaPhC+
 xbwIsNZlLUvuRnmBPkTJwwrFRZvwu5GPHNndBjVpAfaSTOfppyKBTccu2AXJXWAE1Xjh6GOC
 8mlFjZwLxWFqdPHR1n2aPVgoiTLk34LR/bXO+e0GpzFXT7enwyvFFFyAS0Nk1q/7EChPcbRb
 hJqEBpRNZemxmg55zC3GLvgLKd5A09MOM2BrMea+l0FUR+PuTenh2YmnmLRTro6eZ/qYwWkC
 u8FFIw4pT0OUDMyLgi+GI1aMpVogTZJ70FgV0pUAlpmrzk/bLbRkF3TwgucpyPtcpmQtTkWS
 gDS50QG9DR/1As3LLLcNkwJBZzBG6PWbvcOyrwMQUF1nl4SSPV0LLH63+BrrHasfJzxKXzqg
 rW28CTAE2x8qi7e/6M/+XXhrsMYG+uaViM7n2je3qKe7ofum3s4vq7oFCPsOgwARAQABwsFl
 BBgBAgAPBQJVy5+RAhsMBQkJZgGAAAoJEE3eEPcA/4NagOsP/jPoIBb/iXVbM+fmSHOjEshl
 KMwEl/m5iLj3iHnHPVLBUWrXPdS7iQijJA/VLxjnFknhaS60hkUNWexDMxVVP/6lbOrs4bDZ
 NEWDMktAeqJaFtxackPszlcpRVkAs6Msn9tu8hlvB517pyUgvuD7ZS9gGOMmYwFQDyytpepo
 YApVV00P0u3AaE0Cj/o71STqGJKZxcVhPaZ+LR+UCBZOyKfEyq+ZN311VpOJZ1IvTExf+S/5
 lqnciDtbO3I4Wq0ArLX1gs1q1XlXLaVaA3yVqeC8E7kOchDNinD3hJS4OX0e1gdsx/e6COvy
 qNg5aL5n0Kl4fcVqM0LdIhsubVs4eiNCa5XMSYpXmVi3HAuFyg9dN+x8thSwI836FoMASwOl
 C7tHsTjnSGufB+D7F7ZBT61BffNBBIm1KdMxcxqLUVXpBQHHlGkbwI+3Ye+nE6HmZH7IwLwV
 W+Ajl7oYF+jeKaH4DZFtgLYGLtZ1LDwKPjX7VAsa4Yx7S5+EBAaZGxK510MjIx6SGrZWBrrV
 TEvdV00F2MnQoeXKzD7O4WFbL55hhyGgfWTHwZ457iN9SgYi1JLPqWkZB0JRXIEtjd4JEQcx
 +8Umfre0Xt4713VxMygW0PnQt5aSQdMD58jHFxTk092mU+yIHj5LeYgvwSgZN4airXk5yRXl
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <0db601d3-319f-09d9-e659-b9116c404a6a@redhat.com>
Date:   Thu, 11 Oct 2018 09:43:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1539233897-10207-2-git-send-email-rppt@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 11 Oct 2018 07:43:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2018 06:58, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.vnet.ibm.com>
> 
> to allow additions of new documentation about memory hotplug under the same
> roof.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
>  Documentation/core-api/index.rst                   |  2 +-
>  Documentation/core-api/memory-hotplug-notifier.rst | 84 ---------------------
>  Documentation/core-api/memory-hotplug.rst          | 87 ++++++++++++++++++++++
>  3 files changed, 88 insertions(+), 85 deletions(-)
>  delete mode 100644 Documentation/core-api/memory-hotplug-notifier.rst
>  create mode 100644 Documentation/core-api/memory-hotplug.rst
> 
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index 4f8a426..29c790f 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -32,7 +32,7 @@ Core utilities
>     gfp_mask-from-fs-io
>     timekeeping
>     boot-time-mm
> -   memory-hotplug-notifier
> +   memory-hotplug
>  
>  
>  Interfaces for kernel debugging
> diff --git a/Documentation/core-api/memory-hotplug-notifier.rst b/Documentation/core-api/memory-hotplug-notifier.rst
> deleted file mode 100644
> index 35347cc..0000000
> --- a/Documentation/core-api/memory-hotplug-notifier.rst
> +++ /dev/null
> @@ -1,84 +0,0 @@
> -.. _memory_hotplug_notifier:
> -
> -=============================
> -Memory hotplug event notifier
> -=============================
> -
> -Hotplugging events are sent to a notification queue.
> -
> -There are six types of notification defined in ``include/linux/memory.h``:
> -
> -MEM_GOING_ONLINE
> -  Generated before new memory becomes available in order to be able to
> -  prepare subsystems to handle memory. The page allocator is still unable
> -  to allocate from the new memory.
> -
> -MEM_CANCEL_ONLINE
> -  Generated if MEM_GOING_ONLINE fails.
> -
> -MEM_ONLINE
> -  Generated when memory has successfully brought online. The callback may
> -  allocate pages from the new memory.
> -
> -MEM_GOING_OFFLINE
> -  Generated to begin the process of offlining memory. Allocations are no
> -  longer possible from the memory but some of the memory to be offlined
> -  is still in use. The callback can be used to free memory known to a
> -  subsystem from the indicated memory block.
> -
> -MEM_CANCEL_OFFLINE
> -  Generated if MEM_GOING_OFFLINE fails. Memory is available again from
> -  the memory block that we attempted to offline.
> -
> -MEM_OFFLINE
> -  Generated after offlining memory is complete.
> -
> -A callback routine can be registered by calling::
> -
> -  hotplug_memory_notifier(callback_func, priority)
> -
> -Callback functions with higher values of priority are called before callback
> -functions with lower values.
> -
> -A callback function must have the following prototype::
> -
> -  int callback_func(
> -    struct notifier_block *self, unsigned long action, void *arg);
> -
> -The first argument of the callback function (self) is a pointer to the block
> -of the notifier chain that points to the callback function itself.
> -The second argument (action) is one of the event types described above.
> -The third argument (arg) passes a pointer of struct memory_notify::
> -
> -	struct memory_notify {
> -		unsigned long start_pfn;
> -		unsigned long nr_pages;
> -		int status_change_nid_normal;
> -		int status_change_nid_high;
> -		int status_change_nid;
> -	}
> -
> -- start_pfn is start_pfn of online/offline memory.
> -- nr_pages is # of pages of online/offline memory.
> -- status_change_nid_normal is set node id when N_NORMAL_MEMORY of nodemask
> -  is (will be) set/clear, if this is -1, then nodemask status is not changed.
> -- status_change_nid_high is set node id when N_HIGH_MEMORY of nodemask
> -  is (will be) set/clear, if this is -1, then nodemask status is not changed.
> -- status_change_nid is set node id when N_MEMORY of nodemask is (will be)
> -  set/clear. It means a new(memoryless) node gets new memory by online and a
> -  node loses all memory. If this is -1, then nodemask status is not changed.
> -
> -  If status_changed_nid* >= 0, callback should create/discard structures for the
> -  node if necessary.
> -
> -The callback routine shall return one of the values
> -NOTIFY_DONE, NOTIFY_OK, NOTIFY_BAD, NOTIFY_STOP
> -defined in ``include/linux/notifier.h``
> -
> -NOTIFY_DONE and NOTIFY_OK have no effect on the further processing.
> -
> -NOTIFY_BAD is used as response to the MEM_GOING_ONLINE, MEM_GOING_OFFLINE,
> -MEM_ONLINE, or MEM_OFFLINE action to cancel hotplugging. It stops
> -further processing of the notification queue.
> -
> -NOTIFY_STOP stops further processing of the notification queue.
> diff --git a/Documentation/core-api/memory-hotplug.rst b/Documentation/core-api/memory-hotplug.rst
> new file mode 100644
> index 0000000..a99f2f2
> --- /dev/null
> +++ b/Documentation/core-api/memory-hotplug.rst
> @@ -0,0 +1,87 @@
> +.. _memory_hotplug:
> +
> +==============
> +Memory hotplug
> +==============
> +
> +Memory hotplug event notifier
> +=============================
> +
> +Hotplugging events are sent to a notification queue.
> +
> +There are six types of notification defined in ``include/linux/memory.h``:
> +
> +MEM_GOING_ONLINE
> +  Generated before new memory becomes available in order to be able to
> +  prepare subsystems to handle memory. The page allocator is still unable
> +  to allocate from the new memory.
> +
> +MEM_CANCEL_ONLINE
> +  Generated if MEM_GOING_ONLINE fails.
> +
> +MEM_ONLINE
> +  Generated when memory has successfully brought online. The callback may
> +  allocate pages from the new memory.
> +
> +MEM_GOING_OFFLINE
> +  Generated to begin the process of offlining memory. Allocations are no
> +  longer possible from the memory but some of the memory to be offlined
> +  is still in use. The callback can be used to free memory known to a
> +  subsystem from the indicated memory block.
> +
> +MEM_CANCEL_OFFLINE
> +  Generated if MEM_GOING_OFFLINE fails. Memory is available again from
> +  the memory block that we attempted to offline.
> +
> +MEM_OFFLINE
> +  Generated after offlining memory is complete.
> +
> +A callback routine can be registered by calling::
> +
> +  hotplug_memory_notifier(callback_func, priority)
> +
> +Callback functions with higher values of priority are called before callback
> +functions with lower values.
> +
> +A callback function must have the following prototype::
> +
> +  int callback_func(
> +    struct notifier_block *self, unsigned long action, void *arg);
> +
> +The first argument of the callback function (self) is a pointer to the block
> +of the notifier chain that points to the callback function itself.
> +The second argument (action) is one of the event types described above.
> +The third argument (arg) passes a pointer of struct memory_notify::
> +
> +	struct memory_notify {
> +		unsigned long start_pfn;
> +		unsigned long nr_pages;
> +		int status_change_nid_normal;
> +		int status_change_nid_high;
> +		int status_change_nid;
> +	}
> +
> +- start_pfn is start_pfn of online/offline memory.
> +- nr_pages is # of pages of online/offline memory.
> +- status_change_nid_normal is set node id when N_NORMAL_MEMORY of nodemask
> +  is (will be) set/clear, if this is -1, then nodemask status is not changed.
> +- status_change_nid_high is set node id when N_HIGH_MEMORY of nodemask
> +  is (will be) set/clear, if this is -1, then nodemask status is not changed.
> +- status_change_nid is set node id when N_MEMORY of nodemask is (will be)
> +  set/clear. It means a new(memoryless) node gets new memory by online and a
> +  node loses all memory. If this is -1, then nodemask status is not changed.
> +
> +  If status_changed_nid* >= 0, callback should create/discard structures for the
> +  node if necessary.
> +
> +The callback routine shall return one of the values
> +NOTIFY_DONE, NOTIFY_OK, NOTIFY_BAD, NOTIFY_STOP
> +defined in ``include/linux/notifier.h``
> +
> +NOTIFY_DONE and NOTIFY_OK have no effect on the further processing.
> +
> +NOTIFY_BAD is used as response to the MEM_GOING_ONLINE, MEM_GOING_OFFLINE,
> +MEM_ONLINE, or MEM_OFFLINE action to cancel hotplugging. It stops
> +further processing of the notification queue.
> +
> +NOTIFY_STOP stops further processing of the notification queue.
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
