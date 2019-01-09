Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2FEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B99B20859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbfAIMUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:20:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfAIMUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 07:20:06 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38FBF89AC6;
        Wed,  9 Jan 2019 12:20:06 +0000 (UTC)
Received: from [10.72.12.30] (ovpn-12-30.pek2.redhat.com [10.72.12.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1289C1001F5D;
        Wed,  9 Jan 2019 12:20:01 +0000 (UTC)
Subject: Re: [PATCH net-next V2 0/3] basic in order support for vhost_net
To:     mst@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190109080530.18572-1-jasowang@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <93632cde-bfc6-a284-c40c-d544d7c12d7c@redhat.com>
Date:   Wed, 9 Jan 2019 20:19:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109080530.18572-1-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 09 Jan 2019 12:20:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/9 下午4:05, Jason Wang wrote:
> Hi:
>
> This series implement basic in order feature support for
> vhost_net. This feature requires both driver and device to use
> descriptors in order which can simplify the implementation and
> optimizaton for both side. The series also implement a simple
> optimization that avoid read available ring. Test shows 10%
> performance improvement at most.
>
> More optimizations could be done on top.
>
> Changes from V1:
> - no code changes
> - add result of SMAP off


Just notice the patch works only for some specific case e.g a buffer 
only contain one descriptor. Will respin.

Thanks


>
> Jason Wang (3):
>    virtio: introduce in order feature bit
>    vhost_net: support in order feature
>    vhost: don't touch avail ring if in_order is negotiated
>
>   drivers/vhost/net.c                |  6 ++++--
>   drivers/vhost/vhost.c              | 19 ++++++++++++-------
>   include/uapi/linux/virtio_config.h |  6 ++++++
>   3 files changed, 22 insertions(+), 9 deletions(-)
>
