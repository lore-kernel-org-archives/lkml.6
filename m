Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeC2IB4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 04:01:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750716AbeC2IBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 04:01:54 -0400
Subject: Re: [PATCH net V2] vhost: correctly remove wait queue during poll
 failure
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Darren Kenny <darren.kenny@oracle.com>
References: <1522155052-13347-1-git-send-email-jasowang@redhat.com>
 <20180329071801-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <66bebbe2-25f3-5098-c6ac-f61fe160c940@redhat.com>
Date: Thu, 29 Mar 2018 16:01:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329071801-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年03月29日 12:20, Michael S. Tsirkin wrote:
> On Tue, Mar 27, 2018 at 08:50:52PM +0800, Jason Wang wrote:
>> We tried to remove vq poll from wait queue, but do not check whether
>> or not it was in a list before. This will lead double free. Fixing
>> this by switching to use vhost_poll_stop() which zeros poll->wqh after
>> removing poll from waitqueue to make sure it won't be freed twice.
>>
>> Cc: Darren Kenny<darren.kenny@oracle.com>
>> Reported-by:syzbot+c0272972b01b872e604a@syzkaller.appspotmail.com
>> Fixes: 2b8b328b61c79 ("vhost_net: handle polling errors when setting backend")
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
> OK with this the only bug we have is where get user pages returns 0
> (Reported-by:syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com)
>
>
>

Thanks for the reminder.

I post a patch to avoid this.
