Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeA3G4U (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 01:56:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751606AbeA3G4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 01:56:19 -0500
Subject: Re: [PATCH net-next] ptr_ring: fix integer overflow
To: David Miller <davem@davemloft.net>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        john.fastabend@gmail.com
References: <1516865502-20835-1-git-send-email-jasowang@redhat.com>
 <20180129.120124.892750865825553841.davem@davemloft.net>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f69970a7-f991-b038-5e9f-701cf6d8ec41@redhat.com>
Date: Tue, 30 Jan 2018 14:56:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180129.120124.892750865825553841.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年01月30日 01:01, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Thu, 25 Jan 2018 15:31:42 +0800
>
>> We try to allocate one more entry for lockless peeking. The adding
>> operation may overflow which causes zero to be passed to kmalloc().
>> In this case, it returns ZERO_SIZE_PTR without any notice by ptr
>> ring. Try to do producing or consuming on such ring will lead NULL
>> dereference. Fix this detect and fail early.
>>
>> Fixes: bcecb4bbf88a ("net: ptr_ring: otherwise safe empty checks can overrun array bounds")
>> Reported-by: syzbot+87678bcf753b44c39b67@syzkaller.appspotmail.com
>> Cc: John Fastabend <john.fastabend@gmail.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> I'm dropping this because I am to understand that Michael Tsirkin's patch
> series covers this issue.

Yes.

>
> Let me know if I still need to apply this.
>
> Thanks.

No need for this.

Thanks
