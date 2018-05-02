Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeEBDuB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 23:50:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750859AbeEBDt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 23:49:58 -0400
Subject: Re: [RFC v3 0/5] virtio: support packed ring
To: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com, jfreimann@redhat.com
References: <20180425051550.24342-1-tiwei.bie@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <31839145-3e87-2cc7-dfca-a09ae64b976a@redhat.com>
Date: Wed, 2 May 2018 11:49:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425051550.24342-1-tiwei.bie@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年04月25日 13:15, Tiwei Bie wrote:
> Hello everyone,
>
> This RFC implements packed ring support in virtio driver.
>
> Some simple functional tests have been done with Jason's
> packed ring implementation in vhost:
>
> https://lkml.org/lkml/2018/4/23/12
>
> Both of ping and netperf worked as expected (with EVENT_IDX
> disabled). But there are below known issues:
>
> 1. Reloading the guest driver will break the Tx/Rx;

It looks like the reason is we don't sync wrap counter information 
between host and qemu through VHOST_SET/GET_VRING_BASE. And both vhost 
and qemu need to do this through encoding warp counters to higher bits 
of vhost_vring_state.num,

Thanks
