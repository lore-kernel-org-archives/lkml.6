Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4064485-1524446699-2-3099568890003188428
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524446698; b=BAm7hiBF09nQFSCXxWd3QgXCKBzuc+zR0VOc2mYs+UJJPKokFg
    XwNvZIYf6pfcFT/ZILX+PBq1anyzara8nSDH9ZT6xmaLFJNJlY6fuT15EmxWjCuI
    wFQw0NVFuq4xt/UyvZiD5y8GzoViuCB/O070DPBXXZGb8XGArXZBcBb/sci0j53T
    efGMkFUMHhXjav7Y+I+ok0NWLi9OtDL0//DOlKpES0amysTPqGF3fL83FQbycTmp
    m7Z0P+JkRpRlMSYEiFSMaUHtK/wuPGLL+9iiarGvsmgk+ygaa2eFvp+ovlBGIcOg
    Gn1JAOp23yiKqmjJntxne9dIl+k9jxGACNkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524446698; bh=L+KYDGZYtCgi+HD5DvJazNvIEhPGQ5/9oKwbFSHshj
    M=; b=uF9MmtXWphDk44QrlAGil/cLRCkDegw9NSSaE7PvkwpPaSfZU6K6pYbYxt
    QU13PBncc6yzfdfK3T/ml1SohRpyf/IJ/Tbee8+06lmN58uzuBigQaLDqoB30X5c
    3dVnb9UslW05B44WflbO2Pzs4KaNNlCfX4Cg9nPojWEXvu+SAcMUbh3Ed1aDvuCi
    v+RfQ44reGOEZbOvfF92ev7Qnjk8NXRL70A22Apqh2AGA5LUKhMkbglCd4oAAEyL
    dJi5lG1KwGy4cI7d9SjjoSol6196Itf+cFiT3Xsn2V8IWUbrATkTGCjSwPdq3LhU
    5OHgr3DL/UoJcUE/mAahm6eJkT8w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Te7VeoAB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tv3ZArjD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Te7VeoAB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tv3ZArjD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLxAy4lDXvNOJNKbnBZJnWh7VFqw9Hy4DTf4Z8ZI/U9egPnQK8cWq47/CBZxwyu8iQZlLgE4Kfsbd+wqgBPVScKLYKCaBaMS5HNuuSwfB2/Baub8y1Zt
    4IhuaUhCXK7nOzOoJ50PBga89EHm9bdSAkzu+De/dFZ+iaVHi9sW42qng6rrG2thwjyErL3VuuD2vrbgDPxZ4jgoIyvkuGv0gv+nt9PUajJnvToNsQIhHsn8
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=7r91qGjMZeEA:10 a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
    a=ePdMqToNAAAA:8 a=e5mUnYsNAAAA:8 a=5fokZXytzZwPIruiQLsA:9
    a=KZX-cwnQVb550q-Z:21 a=-TEee3JBT8Ei5dJY:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=fq9aknvlO0Q50tsIl6NS:22 a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753821AbeDWBY4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 21:24:56 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43226 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753783AbeDWBYz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 21:24:55 -0400
X-Google-Smtp-Source: AIpwx49sZh+LHDJz59TXE4TRwjxsaIFysleorHnezyH0Un8r5Bbt6PTlltaaWmX3up/APEwS6dhouER+NUrZvB3Q9I8=
MIME-Version: 1.0
In-Reply-To: <20180420072228.uorb3h7snx4io6xs@sirius.home.kraxel.org>
References: <20180403095904.11152-1-kraxel@redhat.com> <20180420072228.uorb3h7snx4io6xs@sirius.home.kraxel.org>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 23 Apr 2018 11:24:53 +1000
Message-ID: <CAPM=9tw6jK2QrjjGnH8JqhV-Z0VMngySLyFvayn98otw3efOPg@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: fix vq wait_event condition
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        amagloire@blackberry.com, stable@vger.kernel.org,
        "open list:VIRTIO GPU DRIVER"
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20 April 2018 at 17:22, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Tue, Apr 03, 2018 at 11:59:04AM +0200, Gerd Hoffmann wrote:
>> Wait until we have enough space in the virt queue to actually queue up
>> our request.  Avoids the guest spinning in case we have a non-zero
>> amount of free entries but not enough for the request.
>
> Ping airlied, can you please either pick it up or review so I can commit
> myself?

Just in case it got lost from my phone,

Reviewed-by: Dave Airlie <airlied@redhat.com>

>
> thanks,
>   Gerd
>
>> Cc: stable@vger.kernel.org
>> Reported-by: Alain Magloire <amagloire@blackberry.com>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_vq.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
>> index 48e4f1df6e..020070d483 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
>> @@ -293,7 +293,7 @@ static int virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
>>       ret = virtqueue_add_sgs(vq, sgs, outcnt, incnt, vbuf, GFP_ATOMIC);
>>       if (ret == -ENOSPC) {
>>               spin_unlock(&vgdev->ctrlq.qlock);
>> -             wait_event(vgdev->ctrlq.ack_queue, vq->num_free);
>> +             wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= outcnt + incnt);
>>               spin_lock(&vgdev->ctrlq.qlock);
>>               goto retry;
>>       } else {
>> @@ -368,7 +368,7 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
>>       ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
>>       if (ret == -ENOSPC) {
>>               spin_unlock(&vgdev->cursorq.qlock);
>> -             wait_event(vgdev->cursorq.ack_queue, vq->num_free);
>> +             wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
>>               spin_lock(&vgdev->cursorq.qlock);
>>               goto retry;
>>       } else {
>> --
>> 2.9.3
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
