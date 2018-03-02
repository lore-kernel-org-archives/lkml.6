Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164956AbeCBEVE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 23:21:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1164881AbeCBEVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 23:21:01 -0500
Subject: Re: [PATCH net-next 1/2] virtio-net: re enable XDP_REDIRECT for
 mergeable buffer
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, brouer@redhat.com,
        john.fastabend@gmail.com
References: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
 <1519874345-10235-2-git-send-email-jasowang@redhat.com>
 <20180301153441-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8c57f936-8fea-e2b8-ef8e-1dda81e190a6@redhat.com>
Date: Fri, 2 Mar 2018 12:20:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301153441-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年03月01日 21:36, Michael S. Tsirkin wrote:
> On Thu, Mar 01, 2018 at 11:19:04AM +0800, Jason Wang wrote:
>> XDP_REDIRECT support for mergeable buffer was removed since commit
>> 7324f5399b06 ("virtio_net: disable XDP_REDIRECT in receive_mergeable()
>> case"). This is because we don't reserve enough tailroom for struct
>> skb_shared_info which breaks XDP assumption. Other complaints are, the
>> complex linearize logic and EWMA estimation may increase the
>> possibility of linearizing.
>>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
> How about reposting just this patch for net? It's pretty small
> and this way we don't have broken redirect there.
> Probably keeping the linearize in here to reduce the
> amount of changes.
>

Looks possible, let me post a version for net.

Thanks
