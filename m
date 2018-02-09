Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbeBIDJB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 22:09:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:64444 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752191AbeBIDI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 22:08:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,481,1511856000";
   d="scan'208";a="28616856"
Message-ID: <5A7D116B.9070502@intel.com>
Date: Fri, 09 Feb 2018 11:11:39 +0800
From: Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        pbonzini@redhat.com, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com, huangzhichao@huawei.com, dgilbert@redhat.com
Subject: Re: [PATCH v28 0/4] Virtio-balloon: support free page reporting
References: <1518083420-11108-1-git-send-email-wei.w.wang@intel.com> <20180208215048-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180208215048-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2018 03:55 AM, Michael S. Tsirkin wrote:
> On Thu, Feb 08, 2018 at 05:50:16PM +0800, Wei Wang wrote:
>
>> Details:
>> Set up a Ping-Pong local live migration, where the guest ceaselessy
>> migrates between the source and destination. Linux compilation,
>> i.e. make bzImage -j4, is performed during the Ping-Pong migration. The
>> legacy case takes 5min14s to finish the compilation. With this
>> optimization patched, it takes 5min12s.
> How is migration time affected in this case?


When the linux compilation workload runs, the migration time (both the 
legacy and this optimization case) varies as the compilation goes on. It 
seems not easy to give a static speedup number, some times the migration 
time is reduced to 33%, sometimes to 50%, it varies, and depends on how 
much free memory the system has at that moment. For example, at the 
later stage of the compilation, I can observe 5GB memory being used as 
page cache. But overall, I can observe obvious improvement of the 
migration time.


Best,
Wei
