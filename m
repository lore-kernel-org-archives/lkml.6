Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752505AbeDKBSr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 21:18:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:7737 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752245AbeDKBSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 21:18:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,434,1517904000";
   d="scan'208";a="32725588"
Message-ID: <5ACD6339.6040806@intel.com>
Date: Wed, 11 Apr 2018 09:22:01 +0800
From: Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, pbonzini@redhat.com,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com,
        huangzhichao@huawei.com
Subject: Re: [PATCH v29 1/4] mm: support reporting free page blocks
References: <1522031994-7246-1-git-send-email-wei.w.wang@intel.com> <1522031994-7246-2-git-send-email-wei.w.wang@intel.com> <20180326142254.c4129c3a54ade686ee2a5e21@linux-foundation.org> <20180410211719-mutt-send-email-mst@kernel.org> <20180410135429.d1aeeb91d7f2754ffe7fb80e@linux-foundation.org> <20180411022440-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180411022440-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2018 07:25 AM, Michael S. Tsirkin wrote:
> On Tue, Apr 10, 2018 at 01:54:29PM -0700, Andrew Morton wrote:
>> On Tue, 10 Apr 2018 21:19:31 +0300 "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>>> Andrew, were your questions answered? If yes could I bother you for an ack on this?
>>>
>> Still not very happy that readers are told that "this function may
>> sleep" when it clearly doesn't do so.  If we wish to be able to change
>> it to sleep in the future then that should be mentioned.  And even put a
>> might_sleep() in there, to catch people who didn't read the comments...
>>
>> Otherwise it looks OK.
> Oh, might_sleep with a comment explaining it's for the future sounds
> good to me. I queued this - Wei, could you post a patch on top pls?
>

I'm just thinking if it would be necessary to add another might_sleep, 
because we've had a cond_resched there which has wrapped a __might_sleep.

Best,
Wei
