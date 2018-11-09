Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43422C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0447920818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0447920818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeKJCzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:55:25 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43140 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeKJCzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:55:25 -0500
Received: from [IPv6:2a02:8109:92c0:207d:f07b:cfbc:c44a:965] (unknown [IPv6:2a02:8109:92c0:207d:f07b:cfbc:c44a:965])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: robertfoss)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8E1222686FF;
        Fri,  9 Nov 2018 17:13:55 +0000 (GMT)
Subject: Re: [PATCH v4 3/4] drm/virtio: add in/out fence support for explicit
 synchronization
To:     Gerd Hoffmann <kraxel@redhat.com>,
        Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Gustavo Padovan <gustavo.padovan@collabora.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.velikov@collabora.com>
References: <20181105114152.2088-1-robert.foss@collabora.com>
 <20181105114152.2088-4-robert.foss@collabora.com>
 <CACvgo53vCBbgmu4OV4e0WeOYQSXNk=3qwyRBtPx+XAcCSZO8aQ@mail.gmail.com>
 <20181109101354.dc7cv4i4etu3bkhh@sirius.home.kraxel.org>
From:   Robert Foss <robert.foss@collabora.com>
Message-ID: <f5143d56-3e11-51f7-a07a-9106aa8bda49@collabora.com>
Date:   Fri, 9 Nov 2018 18:13:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181109101354.dc7cv4i4etu3bkhh@sirius.home.kraxel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Gerd,

On 2018-11-09 11:13, Gerd Hoffmann wrote:
> On Mon, Nov 05, 2018 at 05:25:05PM +0000, Emil Velikov wrote:
>> On Mon, 5 Nov 2018 at 11:42, Robert Foss <robert.foss@collabora.com> wrote:
>>>
>>> When the execbuf call receives an in-fence it will get the dma_fence
>>> related to that fence fd and wait on it before submitting the draw call.
>>>
>>> On the out-fence side we get fence returned by the submitted draw call
>>> and attach it to a sync_file and send the sync_file fd to userspace. On
>>> error -1 is returned to userspace.
>>>
>>> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
>>> Signed-off-by: Robert Foss <robert.foss@collabora.com>
>>> Suggested-by: Rob Herring <robh@kernel.org>
>>> Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
>>> ---
>>>
>>> Changes since v3:
>>>   - Move all in_fence handling to the same VIRTGPU_EXECBUF_FENCE_FD_IN block
>> Fwiw my suggestion was to explicitly document whether the IOCTL can
>> support, simultaneously, IN and OUT fence.
> 
> Yes, that would be good.  Code looks like it is supposed to work, but
> explicitly saying so in the commit message would be nice.

On it! Will send out a v5.

> 
> Also: should we use separate fields for in/out fds?

I'm not sure I understand which fields you're referring to.

> 
> cheers,
>    Gerd
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
