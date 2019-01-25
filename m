Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFACC282C5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE26218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfAYCdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:33:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728602AbfAYCdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:33:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B616AB439;
        Fri, 25 Jan 2019 02:33:10 +0000 (UTC)
Received: from [10.72.12.140] (ovpn-12-140.pek2.redhat.com [10.72.12.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4577F60464;
        Fri, 25 Jan 2019 02:33:04 +0000 (UTC)
Subject: Re: [PATCH net-next V4 5/5] vhost: access vq metadata through kernel
 virtual address
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20190123095557.30168-1-jasowang@redhat.com>
 <20190123095557.30168-6-jasowang@redhat.com>
 <20190123085821-mutt-send-email-mst@kernel.org>
 <335ba55b-087f-4b35-6311-540070b9647f@redhat.com>
 <4521d3d8-561e-53f5-98e1-bf7ace003701@redhat.com>
 <20190123235219-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <99d02d64-34d1-9b31-77bc-1d53a3b89d28@redhat.com>
Date:   Fri, 25 Jan 2019 10:33:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190123235219-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 25 Jan 2019 02:33:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/24 下午12:53, Michael S. Tsirkin wrote:
>>>> - How hard is it to figure out which mode uses which code.
>> It's as simple as tracing __get_user() usage in vhost process?
>>
>> Thanks
> Well there are now mtu notifiers etc etc. It's hardly as well
> contained as that.
>
>

We can setup filter out exactly what sets of function that we wan to 
trace. E.g we can only trace the usage of __get_user() and 
invalidate_range_start(). This should be sufficient.

In the long run, we may want to have some tracepoints for vhost_net.

Thanks

