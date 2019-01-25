Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7639AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF1A218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfAYJQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:16:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfAYJQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:16:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 31A30CF311;
        Fri, 25 Jan 2019 09:16:51 +0000 (UTC)
Received: from [10.72.12.101] (ovpn-12-101.pek2.redhat.com [10.72.12.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FAC36153A;
        Fri, 25 Jan 2019 09:16:35 +0000 (UTC)
Subject: Re: [PATCH net-next V4 5/5] vhost: access vq metadata through kernel
 virtual address
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20190123095557.30168-1-jasowang@redhat.com>
 <20190123095557.30168-6-jasowang@redhat.com>
 <20190123085821-mutt-send-email-mst@kernel.org>
 <335ba55b-087f-4b35-6311-540070b9647f@redhat.com>
 <20190124215912-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <18e64692-2598-6e95-3b93-c34528d04c1b@redhat.com>
Date:   Fri, 25 Jan 2019 17:16:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124215912-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 25 Jan 2019 09:16:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/25 上午11:00, Michael S. Tsirkin wrote:
> On Thu, Jan 24, 2019 at 12:07:54PM +0800, Jason Wang wrote:
>>> Meanwhile, could you pls post data comparing this last patch with the
>>> below?  This removes the speculation barrier replacing it with a
>>> (useless but at least more lightweight) data dependency.
>> SMAP off
>>
>> Your patch: 7.2MPPs
>>
>> vmap: 7.4Mpps
> OK so while we keep looking into vmap, why don't we merge something like
> the below?  Seems quite straight forward ...
>

The problem is it gives ~8% regression on PPS when SMAP is on. This is 
probably because the latency of lfence is hided by previous stac as 
mentioned in the commit b3bbfb3fb5d25776b8e3f361d2eedaabb0b496cd.

Thanks

