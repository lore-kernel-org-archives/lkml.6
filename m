Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06D1C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0112075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0112075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbeJWSNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:13:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:9652 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeJWSNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:13:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 02:51:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,415,1534834800"; 
   d="scan'208";a="101677964"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 23 Oct 2018 02:50:58 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Subject: Re: [PATCH] gpu/drm/virtio/virtgpu_vq.c: Use kmem_cache_zalloc
In-Reply-To: <CAFqt6zbdxjUF4tEh8WXRZT-eo58sfw0tKa3DyxTXCesjEJkqfA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <5bc9ff7e.1c69fb81.105c2.1fef@mx.google.com> <CAFqt6zbdxjUF4tEh8WXRZT-eo58sfw0tKa3DyxTXCesjEJkqfA@mail.gmail.com>
Date:   Tue, 23 Oct 2018 12:50:36 +0300
Message-ID: <87sh0xc7pv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Oct 2018, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Fri, Oct 19, 2018 at 9:30 PM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
>>
>> Replaced kmem_cache_alloc + memset with kmem_cache_zalloc
>
> Put a new line gap in between these two lines and send v2.

Nah, the maintainers can trivially add the newline while
applying. Review is much more valuable than nitpicking on the commit
message.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

>
>> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_vq.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
>> index 020070d..e001b79 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
>> @@ -98,10 +98,9 @@ virtio_gpu_get_vbuf(struct virtio_gpu_device *vgdev,
>>  {
>>         struct virtio_gpu_vbuffer *vbuf;
>>
>> -       vbuf = kmem_cache_alloc(vgdev->vbufs, GFP_KERNEL);
>> +       vbuf = kmem_cache_zalloc(vgdev->vbufs, GFP_KERNEL);
>>         if (!vbuf)
>>                 return ERR_PTR(-ENOMEM);
>> -       memset(vbuf, 0, VBUFFER_SIZE);
>>
>>         BUG_ON(size > MAX_INLINE_CMD_SIZE);
>>         vbuf->buf = (void *)vbuf + sizeof(*vbuf);
>> --
>> 2.7.4
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Jani Nikula, Intel Open Source Graphics Center
