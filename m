Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FD4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EB6222D2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438198AbfBNKBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:01:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438146AbfBNKBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:01:07 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0D8C81DFA;
        Thu, 14 Feb 2019 10:01:05 +0000 (UTC)
Received: from [10.36.117.7] (ovpn-117-7.ams2.redhat.com [10.36.117.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D9C15D9CC;
        Thu, 14 Feb 2019 10:00:42 +0000 (UTC)
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
To:     "Wang, Wei W" <wei.w.wang@intel.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "lcapitulino@redhat.com" <lcapitulino@redhat.com>,
        "pagupta@redhat.com" <pagupta@redhat.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "riel@surriel.com" <riel@surriel.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "dodgen@google.com" <dodgen@google.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF68060@shsmsx102.ccr.corp.intel.com>
 <17adc05d-91f9-682b-d9a4-485e6a631422@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF6B52A@shsmsx102.ccr.corp.intel.com>
 <62b43699-f548-e0da-c944-80702ceb7202@redhat.com>
 <286AC319A985734F985F78AFA26841F73DF6F195@shsmsx102.ccr.corp.intel.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <19d2d9bd-a9dc-9c5f-6dcc-d456d50b9e10@redhat.com>
Date:   Thu, 14 Feb 2019 11:00:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <286AC319A985734F985F78AFA26841F73DF6F195@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 14 Feb 2019 10:01:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.19 10:08, Wang, Wei W wrote:
> On Wednesday, February 13, 2019 5:19 PM, David Hildenbrand wrote:
>> If you have to resize/alloc/coordinate who will report, you will need locking.
>> Especially, I doubt that there is an atomic xbitmap  (prove me wrong :) ).
> 
> Yes, we need change xbitmap to support it.
> 
> Just thought of another option, which would be better:
> - xb_preload in prepare_alloc_pages to pre-allocate the bitmap memory;
> - xb_set/clear the bit under the zone->lock, i.e. in rmqueue and free_one_page

And how to preload without locking?

> 
> will not be concurrently called to race on the same bitmap.
> And we don't add any new locks to generate new doubts.
> Also, we can probably remove the arch_alloc/free_page part.
> 
> For the first step, we could optimize VIRTIO_BALLOON_F_FREE_PAGE_HINT for the live migration optimization:
> - just replace alloc_pages(VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG,
>                            VIRTIO_BALLOON_FREE_PAGE_ORDER)
> with get_free_page_hints()
> 
> get_free_page_hints() was designed to clear the bit, and need put_free_page_hints() to set it later after host finishes madvise. For the live migration usage, as host doesn't free the backing host pages, so we can give get_free_page_hints a parameter option to not clear the bit for this usage. It will be simpler and faster.
> 
> I think get_free_page_hints() to read hints via bitmaps should be much faster than that allocation function, which takes around 15us to get a 4MB block. Another big bonus is that we don't need free_pages() to return all the pages back to buddy (it's a quite expensive operation too) when migration is done.
> 
> For the second step, we can improve ballooning, e.g. a new feature VIRTIO_BALLOON_F_ADVANCED_BALLOON to use the same get_free_page_hints() and another put_free_page_hints(), along with the virtio-balloon's report_vq and ack_vq to wait for the host's ack before making the free page ready.
> (I think waiting for the host ack is the overhead that the guest has to suffer for enabling memory overcommitment, and even with this v8 patch series it also needs to do that. The optimization method was described yesterday)
> 

As I already said, I don't like that approach, because it has the
fundamental issue of page allocs getting blocked. That does not mean
that it is bad, but that I think what Nitesh has is superior in that
sense. Of course, things like "how to enable/disable", and much more
needs to be clarified.

If you believe in your approach, feel free to come up with a prototype.
 Especially the "no global locking" could be tricky in my opinion :)

>> Yes, but as I mentioned this has other drawbacks. Relying on a a guest to free
>> up memory when you really need it is not going to work. 
> 
> why not working? Host can ask at any time (including when not urgently need it) depending on the admin's configuration.

Because any heuristic like "I am running out of memory, quickly ask
someone who will need time to respond" is prone to fail in some
scenarios. It might work for many, but it is not a "I am running out of
memory, oh look, this page has been flagged via madv(FREE), let's just
take that."

> 
>> It might work for
>> some scenarios but should not dictate the design. It is a good start though if
>> it makes things easier.
>  > Enabling/disabling free page hintning by the hypervisor via some
>> mechanism is on the other hand a good idea. "I have plenty of free space,
>> don't worry".
> 
> Also guests are not treated identically, host can decide whom to offer the free pages first (offering free pages will cause the guest some performance drop).

Yes, it should definetly be configurable somehow. You don't want free
page hinting always and in any setup.


-- 

Thanks,

David / dhildenb
