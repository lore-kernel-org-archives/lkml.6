Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69EEECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FD621473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igel-co-jp.20150623.gappssmtp.com header.i=@igel-co-jp.20150623.gappssmtp.com header.b="hCPCwfqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FD621473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeJRLYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:24:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41809 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbeJRLYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:24:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id m77-v6so14190383pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 20:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3R1trxg61+4u22Fe6T6bFbsV3shP8U9dUHPHGx4y3HM=;
        b=hCPCwfqdi6Wg+d0Z7KPkGztuBl48S6y3qDYWJKNhwEJQwSUnE82McS/OwgmoLWxife
         Mg9wrzImNRcxghMiBX7IOBZe2pxSOE30ZgwEGd66I9rhbYxtFwqJQeSR2EWLck/Uie6n
         L/Qv37gUNnb6Snh1LwwWGxbBh034VUeMAxcs28i4UONMWSu0GCGryHMX22LE9vEH2oFt
         i25cqOCOIQ0dBgjl+CkO4zDkds+VBfqAAGkOQ5j+TLVrrBc9NQ32sWkpGTPKARcp6Vb1
         1VibyCUu8EkGk374PbeZKY0FjX68nyJHL5z5WElq+BYb6D49vfCpH0rdVIwqVLb485DA
         3nPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3R1trxg61+4u22Fe6T6bFbsV3shP8U9dUHPHGx4y3HM=;
        b=CICP8xRZkFMWByJZtQj+NiCfXdpgVVzEMAiDip8EKW9mkjTJ3+mwCqNeu9uO2Vu5kS
         d06P/bTegR6Ylmc/Mz/q86AG+PdKRKuE1koeqDYrs6i0LqCQF514uAFpB5KGdxLqdTxz
         wF5DZvnX35oaEjAz+idQda5bzgBrYrSKiBd48XOPC0YS+E2CqydlT+Jeqn4P2Zbz4vZR
         n005K9wLaBoq73qOqWvsE3LugGL0Nq0HmJMLpcAnIrw2W+9ZRb64j3KRPa8viIBN+ubr
         ltyPYIimlzSnvLC/x16w12e2Lor5DjNtyiMqJhVKAucGnnNX6u2xypL30Vbpq4OdeIR4
         lNGQ==
X-Gm-Message-State: ABuFfoh37wnwISnPo1yZxr2lIQkPtJmY5R77VtpdZpQhVcNS3wldShnv
        srEMcXW93cckRM7WQvujTjv2WZO+XTSGIQ==
X-Google-Smtp-Source: ACcGV61ZbZZbshdKIGqJdoxPg03lybho8BWUx9gN1MluEWDtFzPN98BH3VhDrrbJo0qZsBgf9+ZVwg==
X-Received: by 2002:a63:3e49:: with SMTP id l70-v6mr126124pga.96.1539833118295;
        Wed, 17 Oct 2018 20:25:18 -0700 (PDT)
Received: from [10.16.144.1] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id l83-v6sm37982086pfi.172.2018.10.17.20.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 20:25:17 -0700 (PDT)
Subject: Re: [PATCH v3] virtio_net: avoid using netif_tx_disable() for
 serializing tx routine
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <276ac5bb-90f7-5fb6-a826-0bb05ecfa069@redhat.com>
 <20181017104419.13003-1-ake@igel.co.jp>
 <20181017110741-mutt-send-email-mst@kernel.org>
From:   ake <ake@igel.co.jp>
Message-ID: <abd5887e-e332-190c-0a4c-d729320cae76@igel.co.jp>
Date:   Thu, 18 Oct 2018 12:25:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181017110741-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/10/18 0:09, Michael S. Tsirkin wrote:
> On Wed, Oct 17, 2018 at 07:44:12PM +0900, Ake Koomsin wrote:
>> Commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
>> introduces netif_tx_disable() after netif_device_detach() in order to
>> avoid use-after-free of tx queues. However, there are two issues.
>>
>> 1) Its operation is redundant with netif_device_detach() in case the
>>    interface is running.
>> 2) In case of the interface is not running before suspending and
>>    resuming, the tx does not get resumed by netif_device_attach().
>>    This results in losing network connectivity.
>>
>> It is better to use netif_tx_lock_bh()/netif_tx_unlock_bh() instead for
>> serializing tx routine during reset. This also preserves the symmetry
>> of netif_device_detach() and netif_device_attach().
>>
>> Fixes commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
>> Signed-off-by: Ake Koomsin <ake@igel.co.jp>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Thanks a lot for debugging!
> Seems like stable material to me, right?

Yes. With this patch, we can avoid network connectivity lost
because of tx not get re-enabled under some situation. Plus, it avoids
redundant operation between netif_device_detach() and
netif_tx_disable().

I tested the patch on Linux net-next and QEMU master by suspending/
resuming the virtual machine repeatedly. The network looks no problem
and has no connectivity lost so far. I tested with both user-mode
networking and tap interface.

Best Regards

>> ---
>>  drivers/net/virtio_net.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 3f5aa59c37b7..3e2c041d76ac 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -2267,8 +2267,9 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>>  	/* Make sure no work handler is accessing the device */
>>  	flush_work(&vi->config_work);
>>  
>> +	netif_tx_lock_bh(vi->dev);
>>  	netif_device_detach(vi->dev);
>> -	netif_tx_disable(vi->dev);
>> +	netif_tx_unlock_bh(vi->dev);
>>  	cancel_delayed_work_sync(&vi->refill);
>>  
>>  	if (netif_running(vi->dev)) {
>> @@ -2304,7 +2305,9 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>>  		}
>>  	}
>>  
>> +	netif_tx_lock_bh(vi->dev);
>>  	netif_device_attach(vi->dev);
>> +	netif_tx_unlock_bh(vi->dev);
>>  	return err;
>>  }
>>  
>> -- 
>> 2.19.1
