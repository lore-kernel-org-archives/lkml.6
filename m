Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBD8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D293C217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfBSGu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:50:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfBSGu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 01:50:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE5001244F6;
        Tue, 19 Feb 2019 06:50:55 +0000 (UTC)
Received: from [10.72.12.172] (ovpn-12-172.pek2.redhat.com [10.72.12.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B3E865F9D0;
        Tue, 19 Feb 2019 06:50:48 +0000 (UTC)
Subject: Re: [PATCH net] vhost: correctly check the return value of
 translate_desc() in log_used()
To:     David Miller <davem@davemloft.net>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stephen@networkplumber.org
References: <20190215075324.18891-1-jasowang@redhat.com>
 <20190215.100356.251698752340585300.davem@davemloft.net>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <43623186-8759-507f-836e-0ef633b23264@redhat.com>
Date:   Tue, 19 Feb 2019 14:50:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215.100356.251698752340585300.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 19 Feb 2019 06:50:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/2/16 上午2:03, David Miller wrote:
> From: Jason Wang<jasowang@redhat.com>
> Date: Fri, 15 Feb 2019 15:53:24 +0800
>
>> When fail, translate_desc() returns negative value, otherwise the
>> number of iovs. So we should fail when the return value is negative
>> instead of a blindly check against zero.
>>
>> Reported-by: Stephen Hemminger<stephen@networkplumber.org>
>> Fixes: cc5e71075947 ("vhost: log dirty page correctly")
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
> Jason, please put the Fixes tag first.
>
> Thank you.


Ok. Will post V2.

Thanks

