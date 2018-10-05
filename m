Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478A8C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1264220834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1264220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeJEWdI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:33:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42150 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeJEWdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:33:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id b7-v6so5424819edd.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 08:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vfD2hkc6A7Ng/TUG8sg5MrzsrxO0H6pNnp7VTDvolys=;
        b=fe7mw9OGkAwcl1ShcvHz00wyagdAMxoiROy/q0DGACZU9a+A9jb+gXllxe9D8eO37M
         KglrvvrYjBJ/OWDnlcnUQwX+LsR+e0uAjSdk6snRhx8LgA1OA/xuvGAkAmQChO0E6xl3
         IpQiw1sbCE0Pk2nTzQo6EANV8BLu5Tsu1bSg89smAMXvfOohHTp9DDahFNh3T+0aRWYr
         +B+tIRbW0LzvEPbBELPq07uJDlExOLdOXUFsI2lnsesw76Jn86t69k/DAADA9jd4RuFc
         8BgzJarbnLRhnrQ7JBvZ8U9NwGWgkrnXiCC0AcPHZDO3AENSrIvJrdwbE0EY6cQEwF+r
         lhrQ==
X-Gm-Message-State: ABuFfog872xiA+tvop20FNUH66beVJNVyMiYD60L2oi0s5S0iFCLFgE3
        fPEyxLFevkgZQnHODekSnYizlQ==
X-Google-Smtp-Source: ACcGV61abPVXAYo+B9QTFgFpJEVmzGRNAgyE7Qrhs5sSNUHzTmcrYgAm21wNVC6y/63b18dK0yqtvQ==
X-Received: by 2002:a50:9886:: with SMTP id j6-v6mr15323831edb.160.1538753634472;
        Fri, 05 Oct 2018 08:33:54 -0700 (PDT)
Received: from [192.168.77.22] (val06-1-88-182-161-34.fbx.proxad.net. [88.182.161.34])
        by smtp.gmail.com with ESMTPSA id z33-v6sm2670913edb.85.2018.10.05.08.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 08:33:53 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2] virtio-gpu: add VIRTIO_GPU_F_EDID feature
From:   Christophe de Dinechin <cdupontd@redhat.com>
In-Reply-To: <20181005144127.GE31561@phenom.ffwll.local>
Date:   Fri, 5 Oct 2018 17:33:50 +0200
Cc:     Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>, virtio-dev@redhat.com,
        dri-devel@lists.freedesktop.org,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <2CB183E2-B7ED-481C-9899-CA908558D39F@redhat.com>
References: <20181005125154.19824-1-kraxel@redhat.com>
 <1BA83F18-87E5-4B01-A2D9-01777078B637@redhat.com>
 <20181005144127.GE31561@phenom.ffwll.local>
To:     Daniel Vetter <daniel@ffwll.ch>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 5 Oct 2018, at 16:41, Daniel Vetter <daniel@ffwll.ch> wrote:
> 
> On Fri, Oct 05, 2018 at 04:38:11PM +0200, Christophe de Dinechin wrote:
>> 
>> 
>>> On 5 Oct 2018, at 14:51, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>> 
>>> The feature allows the guest request an EDID blob (describing monitor
>>> capabilities) for a given scanout (aka virtual monitor connector).
>>> 
>>> It brings a new command message, which has just a scanout field (beside
>>> the standard virtio-gpu header) and a response message which carries the
>>> EDID data.
>>> 
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>> ---
>>> include/uapi/linux/virtio_gpu.h | 17 +++++++++++++++++
>>> 1 file changed, 17 insertions(+)
>>> 
>>> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
>>> index f43c3c6171..1cef1ff339 100644
>>> --- a/include/uapi/linux/virtio_gpu.h
>>> +++ b/include/uapi/linux/virtio_gpu.h
>>> @@ -41,6 +41,7 @@
>>> #include <linux/types.h>
>>> 
>>> #define VIRTIO_GPU_F_VIRGL 0
>>> +#define VIRTIO_GPU_F_EDID  1
>>> 
>>> enum virtio_gpu_ctrl_type {
>>> 	VIRTIO_GPU_UNDEFINED = 0,
>>> @@ -56,6 +57,7 @@ enum virtio_gpu_ctrl_type {
>>> 	VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING,
>>> 	VIRTIO_GPU_CMD_GET_CAPSET_INFO,
>>> 	VIRTIO_GPU_CMD_GET_CAPSET,
>>> +	VIRTIO_GPU_CMD_GET_EDID,
>>> 
>>> 	/* 3d commands */
>>> 	VIRTIO_GPU_CMD_CTX_CREATE = 0x0200,
>>> @@ -76,6 +78,7 @@ enum virtio_gpu_ctrl_type {
>>> 	VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
>>> 	VIRTIO_GPU_RESP_OK_CAPSET_INFO,
>>> 	VIRTIO_GPU_RESP_OK_CAPSET,
>>> +	VIRTIO_GPU_RESP_OK_EDID,
>>> 
>>> 	/* error responses */
>>> 	VIRTIO_GPU_RESP_ERR_UNSPEC = 0x1200,
>>> @@ -291,6 +294,20 @@ struct virtio_gpu_resp_capset {
>>> 	__u8 capset_data[];
>>> };
>>> 
>>> +/* VIRTIO_GPU_CMD_GET_EDID */
>>> +struct virtio_gpu_get_edid {
>>> +	struct virtio_gpu_ctrl_hdr hdr;
>>> +	__le32 scanout;
>>> +};
>>> +
>>> +/* VIRTIO_GPU_RESP_OK_EDID */
>>> +struct virtio_gpu_resp_edid {
>>> +	struct virtio_gpu_ctrl_hdr hdr;
>>> +	__le32 scanout;
>>> +	__le32 size;
>>> +	__u8 edid[1024];
>> 
>> Wouldn’t it be enough to stick to EDID 2.0 (256 bytes)?
>> 
>> If not, maybe add comment to explain why you chose 1024.
> 
> EDID in the wild can be up to 512 bytes.

Does this return a physical EDID? I thought it would be made-up by virtio-gpu.

Thanks,
Christophe

> 
>> 
>>> +};
>>> +
>>> #define VIRTIO_GPU_EVENT_DISPLAY (1 << 0)
>>> 
>>> struct virtio_gpu_config {
>>> -- 
>>> 2.9.3
>>> 
>> 
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

