Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B0CC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFFE2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="CsN/kRkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfBAJbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:31:32 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:46997 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbfBAJba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=RrZM2L3QxwQY4Hi1gdGKfL2+wO/xGqf+7sW6A9JRRyI=;
        b=CsN/kRkrFj1iIGWpXy+iSEQUwqmgMNNwgLU/ORB26YV9frMLA60mnai9wsCnhmcfIClv1FxXNzQIGxU2YOeSn87HH7K2b1KqNKiDVPeJkctptieyBU00uMZJ4fPuDX8pmveyzn++B2+WskYQV47Xek0/9BiVJVvMVW5tUNxmUjJFU055Z2RlGD6+CKvjQgv6kUtPEs8py+TrnUpQv77mFWvkzsVe1ND40URgVmO7w8WNjJAvWK116oYF9UYRlI9N0OAEhTCDujxWwMN1axKYDSwwOR98BIYEzhu129kaO7vKb3XFF9u9TAOHX2RmiZKe4JMRGCKbGiDs4yasXITdcA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:60288 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gpVAV-0006xQ-O3; Fri, 01 Feb 2019 10:31:27 +0100
Subject: Re: [PATCH v2 4/6] drm/virtio: params struct for
 virtio_gpu_cmd_create_resource_3d()
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
References: <20190130094338.14203-1-kraxel@redhat.com>
 <20190130094338.14203-5-kraxel@redhat.com>
 <4d3064ef-9993-106a-74b5-73a29c08975e@tronnes.org>
 <20190201080113.mhlzpyek62cfc5qe@sirius.home.kraxel.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <b1d7b700-6d0f-fee1-bec9-3b4f9962a9f5@tronnes.org>
Date:   Fri, 1 Feb 2019 10:31:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190201080113.mhlzpyek62cfc5qe@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 01.02.2019 09.01, skrev Gerd Hoffmann:
> On Thu, Jan 31, 2019 at 11:47:38AM +0100, Noralf Trønnes wrote:
>>
>>
>> Den 30.01.2019 10.43, skrev Gerd Hoffmann:
>>> Add 3d resource parameters to virtio_gpu_object_params struct.  With
>>> that in place we can use it for virtio_gpu_cmd_resource_create_3d()
>>> calls.
>>>
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>> ---
>>
>> You don't remove the struct virtio_gpu_resource_create_3d definition,
>> but it looks like there's no users left?
> 
> virtio_gpu_cmd_resource_create_3d() still uses it (and has to, it is
> part of the guest <-> host protocol).
> 

Acked-by: Noralf Trønnes <noralf@tronnes.org>
