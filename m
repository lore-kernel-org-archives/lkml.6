Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeDKNqE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:46:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752598AbeDKNqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:46:03 -0400
Subject: Re: [PATCH] vhost: Fix vhost_copy_to_user()
To: Jason Wang <jasowang@redhat.com>, eric.auger.pro@gmail.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, mst@redhat.com, kvmarm@lists.cs.columbia.edu
References: <1523453438-4266-1-git-send-email-eric.auger@redhat.com>
 <85c033b9-b230-7ef9-744c-4e2799684609@redhat.com>
Cc: stefanha@redhat.com
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <355234b2-651e-4e85-b5d2-d92bb6e33f13@redhat.com>
Date: Wed, 11 Apr 2018 15:45:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <85c033b9-b230-7ef9-744c-4e2799684609@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 11/04/18 15:44, Jason Wang wrote:
> 
> 
> On 2018年04月11日 21:30, Eric Auger wrote:
>> vhost_copy_to_user is used to copy vring used elements to userspace.
>> We should use VHOST_ADDR_USED instead of VHOST_ADDR_DESC.
>>
>> Fixes: f88949138058 ("vhost: introduce O(1) vq metadata cache")
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> This fixes a stall observed when running an aarch64 guest with
>> virtual smmu
>> ---
>>   drivers/vhost/vhost.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index bec722e..f44aead 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -744,7 +744,7 @@ static int vhost_copy_to_user(struct
>> vhost_virtqueue *vq, void __user *to,
>>           struct iov_iter t;
>>           void __user *uaddr = vhost_vq_meta_fetch(vq,
>>                        (u64)(uintptr_t)to, size,
>> -                     VHOST_ADDR_DESC);
>> +                     VHOST_ADDR_USED);
>>             if (uaddr)
>>               return __copy_to_user(uaddr, from, size);
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> Thanks!
> 
> Stable material I think.

yes I think so.

Thanks

Eric
