Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeBKCqB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 21:46:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751050AbeBKCqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 21:46:00 -0500
Subject: Re: [PATCH V4 2/2] ptr_ring: try vmalloc() when kmalloc() fails
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <1518169550-5987-1-git-send-email-jasowang@redhat.com>
 <1518169550-5987-2-git-send-email-jasowang@redhat.com>
 <20180209173914-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9c9bcbf9-02df-20ee-55ea-7234558ceded@redhat.com>
Date: Sun, 11 Feb 2018 10:45:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180209173914-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年02月09日 23:53, Michael S. Tsirkin wrote:
> On Fri, Feb 09, 2018 at 05:45:50PM +0800, Jason Wang wrote:
>> This patch switch to use kvmalloc_array() for using a vmalloc()
>> fallback to help in case kmalloc() fails.
> Above isn't really saying anything about the motivation, it
> just explains what kvmalloc_array does.
>
> How about:
>
> Switch ptr_ring from kmalloc to kvmalloc. This way it can support larger
> ring sizes.
>
>> Reported-by:syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com
>> Fixes: 2e0ab8ca83c12 ("ptr_ring: array based FIFO for pointers")
> I don't see this as a bugfix - it's more of an enhancement.
>
> Do we need this in net or can we defer this to net-next?

Consider they are users of tx_queue_len of more than 1000000 from google 
searching. We'd better have this in -net.

Thanks

>
> I'm not sure myself. For now
>
> Acked-by: Michael S. Tsirkin<mst@redhat.com>
>
