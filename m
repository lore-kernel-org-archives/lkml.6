Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380E8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0075120851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp1TLQrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0075120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbeKSV0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:26:06 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45753 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbeKSV0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:26:06 -0500
Received: by mail-ed1-f67.google.com with SMTP id d39so21690137edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 03:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZgUNx2+//dqdjYil+CXt4JkhO3WwbBvtrV9JNeBhZuQ=;
        b=Kp1TLQrQp92rQxlxK+wTe2CzfjiBz9myofgVPxoPO9HGgX7/JDUdP1WQP5a9h2iiOp
         DUcpfbr/ennNGdOVlhkogrw+FocfX8a0WiCzgRRjCHSFQxOZLlAjX74PUxP+x/lgGP4R
         0V5gpi6K0oyxXyiVw2bFje66T6HBPiG5RtfQrzxHZcbtP4qkv1aqJx+GQU2S9YN6Qz6U
         QTLw1PC2JFa5O89e3T1VSaWaQWq0g2BGZbtL4oTy+ANwr2ljwvekGTBf/D9oQy1aAv69
         q5wUTyyJdQFhgFtZfi1NHMAOaECGLAli0GLf+s1gxrMSWO5q2w8uFXMeIv1aRnAM7pFH
         LnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZgUNx2+//dqdjYil+CXt4JkhO3WwbBvtrV9JNeBhZuQ=;
        b=U80qC26EfpZDsSDU92oAT4CDGJsXeqCBONswUgwL9MeVTHJQLbN3ARV2Ty1DIgrSQG
         DnpgF/oFGXonCbnVH1xpoHKGwS5fhCoXfrN6b3TijSRQsZNxNmtUlMAx7p5jy4FsQ+ai
         Hvt9VNVtyo2ETj3bxxxfku4iiRwoCCPPcJo5hx63aOxFlidSBVLadk6sDUVxOuWzOYQw
         F6CXa6UiLsMKI7Gvt85hHw+kT6xEaiVj000HJ5Jy5kEkBghF3RIO2lXwnnCvk6yaBnfo
         LuLINd/v10AsHWkSNiopwUjXDZPdXOeeja6akD6vb8G5qKIpHJfVZoraOuMe++mlqwfF
         F85A==
X-Gm-Message-State: AA+aEWYQzv6nk7jaRI+Rt/QLNKYqIzNNwMgJmU3w2Wap66QawHqCaPiG
        CwoJU6El2Evhq5CHfD7zc5w=
X-Google-Smtp-Source: AFSGD/VMibsAlhCgD1GhIfNNStmgbXrQqFHx6nFUK8FlrDdTz2RPXbSN4d5J1sRlhFaeTH7fgiGkRg==
X-Received: by 2002:a50:8d8c:: with SMTP id r12mr1961570edh.105.1542625368182;
        Mon, 19 Nov 2018 03:02:48 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id d27-v6sm3331587eja.20.2018.11.19.03.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 03:02:47 -0800 (PST)
Subject: Re: [Xen-devel] [PATCH 5/9] drm/xen/xen_drm_front_gem.c: Convert to
 use vm_insert_range
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        oleksandr_andrushchenko@epam.com, airlied@linux.ie,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org
References: <20181115154912.GA27969@jordon-HP-15-Notebook-PC>
 <ed294bea-bf07-6a4d-51ec-9e7082703b61@gmail.com>
 <CAFqt6zZ_FnWg2K3Lh=-1KFOk1XteHnroua6QzJrKo+khZTgieg@mail.gmail.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <c76fc2fa-d08b-7db3-5693-d9c303cd7126@gmail.com>
Date:   Mon, 19 Nov 2018 13:02:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFqt6zZ_FnWg2K3Lh=-1KFOk1XteHnroua6QzJrKo+khZTgieg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/18 12:42 PM, Souptick Joarder wrote:
> On Mon, Nov 19, 2018 at 3:22 PM Oleksandr Andrushchenko
> <andr2000@gmail.com> wrote:
>> On 11/15/18 5:49 PM, Souptick Joarder wrote:
>>> Convert to use vm_insert_range() to map range of kernel
>>> memory to user vma.
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> Reviewed-by: Matthew Wilcox <willy@infradead.org>
>>> ---
>>>    drivers/gpu/drm/xen/xen_drm_front_gem.c | 20 ++++++--------------
>>>    1 file changed, 6 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
>>> index 47ff019..a3eade6 100644
>>> --- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
>>> +++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
>>> @@ -225,8 +225,7 @@ struct drm_gem_object *
>>>    static int gem_mmap_obj(struct xen_gem_object *xen_obj,
>>>                        struct vm_area_struct *vma)
>>>    {
>>> -     unsigned long addr = vma->vm_start;
>>> -     int i;
>>> +     int err;
>> I would love to keep ret, not err
> Sure, will add it in v2.
> But I think, err is more appropriate here.

I used "ret" throughout the driver, so this is just to remain consistent:

grep -rnw err drivers/gpu/drm/xen/ | wc -l
0
grep -rnw ret drivers/gpu/drm/xen/ | wc -l
204

>>>        /*
>>>         * clear the VM_PFNMAP flag that was set by drm_gem_mmap(), and set the
>>> @@ -247,18 +246,11 @@ static int gem_mmap_obj(struct xen_gem_object *xen_obj,
>>>         * FIXME: as we insert all the pages now then no .fault handler must
>>>         * be called, so don't provide one
>>>         */
>>> -     for (i = 0; i < xen_obj->num_pages; i++) {
>>> -             int ret;
>>> -
>>> -             ret = vm_insert_page(vma, addr, xen_obj->pages[i]);
>>> -             if (ret < 0) {
>>> -                     DRM_ERROR("Failed to insert pages into vma: %d\n", ret);
>>> -                     return ret;
>>> -             }
>>> -
>>> -             addr += PAGE_SIZE;
>>> -     }
>>> -     return 0;
>>> +     err = vm_insert_range(vma, vma->vm_start, xen_obj->pages,
>>> +                             xen_obj->num_pages);
>>> +     if (err < 0)
>>> +             DRM_ERROR("Failed to insert pages into vma: %d\n", err);
>>> +     return err;
>>>    }
>>>
>>>    int xen_drm_front_gem_mmap(struct file *filp, struct vm_area_struct *vma)
>> With the above fixed,
>>
>> Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
