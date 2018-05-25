Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935792AbeEYCbg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 22:31:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36078 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935184AbeEYCbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 22:31:33 -0400
Subject: Re: [RFC v5 0/5] virtio: support packed ring
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com, jfreimann@redhat.com
References: <20180522081648.14768-1-tiwei.bie@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b19e0888-61dc-c067-0b05-fde3b5eb0902@redhat.com>
Date: Fri, 25 May 2018 10:31:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522081648.14768-1-tiwei.bie@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月22日 16:16, Tiwei Bie wrote:
> Hello everyone,
>
> This RFC implements packed ring support in virtio driver.
>
> Some simple functional tests have been done with Jason's
> packed ring implementation in vhost (RFC v4):
>
> https://lkml.org/lkml/2018/5/16/501
>
> Both of ping and netperf worked as expected w/ EVENT_IDX
> disabled. Ping worked as expected w/ EVENT_IDX enabled,
> but netperf didn't (A hack has been added in the driver
> to make netperf test pass in this case. The hack can be
> found by `grep -rw XXX` in the code).

Looks like this is because a bug in vhost which wrongly track 
signalled_used and may miss an interrupt. After fixing that, both side 
works like a charm.

I'm testing vIOMMU and zerocopy, and will post a new version shortly. 
(Hope it would be the last RFC version).

Thanks
