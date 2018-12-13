Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029AFC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45A520811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45A520811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeLMCmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:42:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbeLMCmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:42:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 087B03DE2F;
        Thu, 13 Dec 2018 02:42:09 +0000 (UTC)
Received: from [10.72.12.167] (ovpn-12-167.pek2.redhat.com [10.72.12.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88CC160C44;
        Thu, 13 Dec 2018 02:42:04 +0000 (UTC)
Subject: Re: [PATCH net V2 0/4] Fix various issue of vhost
To:     David Miller <davem@davemloft.net>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181212100819.21295-1-jasowang@redhat.com>
 <20181212.153134.1249380470735153418.davem@davemloft.net>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <cc5e477f-b452-ce6f-d412-46ff8a4cfa5d@redhat.com>
Date:   Thu, 13 Dec 2018 10:42:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212.153134.1249380470735153418.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 13 Dec 2018 02:42:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/13 上午7:31, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Wed, 12 Dec 2018 18:08:15 +0800
>
>> This series tries to fix various issues of vhost:
>>
>> - Patch 1 adds a missing write barrier between used idx updating and
>>    logging.
>> - Patch 2-3 brings back the protection of device IOTLB through vq
>>    mutex, this fixes possible use after free in device IOTLB entries.
>> - Patch 4-7 fixes the diry page logging when device IOTLB is
>>    enabled. We should done through GPA instead of GIOVA, this was done
>>    through intorudce HVA->GPA reverse mapping and convert HVA to GPA
>>    during logging dirty pages.
>>
>> Please consider them for -stable.
>>
>> Thanks
>>
>> Changes from V1:
>> - silent compiler warning for 32bit.
>> - use mutex_trylock() on slowpath instead of mutex_lock() even on fast
>>    path.
> Hello Jason.
>
> Look like Michael wants you to split out patch #4 and target
> net-next with it.
>
> So please do that and respin the first 3 patches here with Michael's
> ACKs.
>
> Thanks.


Yes, will send V3.

Thanks

