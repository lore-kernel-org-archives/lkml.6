Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425729AbeCBJ1z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:27:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1425027AbeCBJ1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:27:42 -0500
Subject: Re: [PATCH net] virtio-net: re enable XDP_REDIRECT for mergeable
 buffer
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.fastabend@gmail.com
References: <1519971929-15148-1-git-send-email-jasowang@redhat.com>
 <20180302080517.4526f384@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8e75beb6-ba0f-79f3-2d24-018656226b1e@redhat.com>
Date: Fri, 2 Mar 2018 17:27:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302080517.4526f384@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年03月02日 15:05, Jesper Dangaard Brouer wrote:
> On Fri,  2 Mar 2018 14:25:29 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> @@ -770,6 +774,19 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>>   				goto err_xdp;
>>   			rcu_read_unlock();
>>   			goto xdp_xmit;
>> +		case XDP_REDIRECT:
>> +			err = xdp_do_redirect(dev, &xdp, xdp_prog);
>> +			if (err) {
>> +				trace_xdp_exception(vi->dev, xdp_prog, act);
> Do not add a trace_xdp_exception here... this is handled inside
> xdp_do_redirect() invocation.
>
>

Right, let me post V2.

Thanks
