Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56584C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DEF20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DEF20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbeJKROB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:14:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbeJKROA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:14:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A650308FEC3;
        Thu, 11 Oct 2018 09:47:30 +0000 (UTC)
Received: from [10.72.12.114] (ovpn-12-114.pek2.redhat.com [10.72.12.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 26C8F66FE4;
        Thu, 11 Oct 2018 09:47:21 +0000 (UTC)
Subject: Re: [PATCH net-next V3] virtio_net: ethtool tx napi configuration
To:     David Miller <davem@davemloft.net>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        willemb@google.com
References: <20181009020626.31723-1-jasowang@redhat.com>
 <20181010.223458.915344551656019248.davem@davemloft.net>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <429a1196-b1a1-42ff-4dbb-b3e1b35c6652@redhat.com>
Date:   Thu, 11 Oct 2018 17:47:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010.223458.915344551656019248.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 11 Oct 2018 09:47:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年10月11日 13:34, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Tue,  9 Oct 2018 10:06:26 +0800
>
>> Implement ethtool .set_coalesce (-C) and .get_coalesce (-c) handlers.
>> Interrupt moderation is currently not supported, so these accept and
>> display the default settings of 0 usec and 1 frame.
>>
>> Toggle tx napi through setting tx-frames. So as to not interfere
>> with possible future interrupt moderation, value 1 means tx napi while
>> value 0 means not.
>>
>> Only allow the switching when device is down for simplicity.
>>
>> Link: https://patchwork.ozlabs.org/patch/948149/
>> Suggested-by: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Willem de Bruijn <willemb@google.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>> Changes from V2:
>> - only allow the switching when device is done
>> - remove unnecessary global variable and initialization
>> Changes from V1:
>> - try to synchronize with datapath to allow changing mode when
>>    interface is up.
>> - use tx-frames 0 as to disable tx napi while tx-frames 1 to enable tx napi
> Applied, with...
>
>> +	bool running = netif_running(dev);
> this unused variable removed.

My bad, thanks for the fixup.
