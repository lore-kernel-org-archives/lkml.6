Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63763C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F0320862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fj7jD23Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F0320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbeKGFOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:14:36 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46816 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeKGFOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:14:36 -0500
Received: by mail-qt1-f196.google.com with SMTP id c16-v6so4059826qtj.13;
        Tue, 06 Nov 2018 11:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GodY/84tz4FwhIr7Yuy0Y2FkisBudIR213gl0P3Oanw=;
        b=Fj7jD23YgeK20f/kHPCIygDI+WsVbfb4wqyqQuFT2cBaV0tnjULgpQGtC9vBAMss0Y
         MeKjiPJp+SWCdhxSlErGsU5BcyaWEUo5uozefh5GjtDsKbCP/72PceaYw9b4jXvU+N/g
         8ezpAlhUKoofHvHcO12DOeSNH2S9+Q3ttYEEpmZ1E9SIc8aIDnYZ/VHMjKxp65w2llEr
         gFKa76tfZpoaR0Qa3ZCBjRlkmRM9uwPOuGj6F/+0Q37GDFCSBS/EsQnb0Yawu/+5ygz4
         BUsluZXoHIV5O5KEIfNdHBZirn3vkImk6m7LrYHBpGDLIOUXJbAmYbtBQcp7C6CcoSil
         w1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GodY/84tz4FwhIr7Yuy0Y2FkisBudIR213gl0P3Oanw=;
        b=cT6qL2Oedr+2FTWy4qu4zSk+TiJapQ4gS5OdeEIEIwzCMNib3zDd7pz6b5TRbsUISl
         teyme5OjVDruV+3i64jptSRQxIE9G4FYlU5zWSp2FSlNlxVyHybiGfIwsvZo24cBZgQO
         dc1sbYPW3E3FFnj559k/3uP6j7SfKSo/Kuj99sDLr+QfdVlIQBHIBNHZ7pRFpFY0Blod
         McnuRsMYqKZveh+SyEfyHlxV0eKuuqfGqkz3re+ABuoVTdc7PjVita5eB1BZ3eKlDDu0
         wWNsUqNS7v56C4MQPbrvkGzJz12k+E4GIrmNaAP63Ib+Hcqay3udWQCXOKZh8PGyv0bH
         1hOg==
X-Gm-Message-State: AGRZ1gIdTXHIqOl5hi1wbZcj3skROdMbfssinJLm1k46O8+cDNLq745t
        G+SLOsKt9XYZ9zSTsH+ZwpJFQHDFWMFm5mb1BVNNnuPlBJ8=
X-Google-Smtp-Source: AJdET5euGWXqvFxOwRtjRCBA5+WBASpQsS+MUhTD6ns3bzk4jFYgUmxwnkIOMJ316EprXlMQaZGIuWBrJmJCo8xpkEg=
X-Received: by 2002:a0c:c404:: with SMTP id r4mr11152542qvi.131.1541533666232;
 Tue, 06 Nov 2018 11:47:46 -0800 (PST)
MIME-Version: 1.0
References: <20181102182123.29420-1-v.mayatskih@gmail.com> <20181102182123.29420-2-v.mayatskih@gmail.com>
 <20181106160316.GC31579@stefanha-x1.localdomain>
In-Reply-To: <20181106160316.GC31579@stefanha-x1.localdomain>
From:   Vitaly Mayatskih <v.mayatskih@gmail.com>
Date:   Tue, 6 Nov 2018 14:47:30 -0500
Message-ID: <CAGF4SLipgZ9e9qNWcJqvECDWuVbBMaAYPvXTqxbaUDeh7O-SkA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add vhost_blk driver
To:     stefanha@gmail.com
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 11:03 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:

> Did you look at vhost-user-blk?  It does things slightly differently:
> more of the virtio-blk device model is handled by the vhost-user device
> (e.g. config space).  That might be necessary to implement
> virtio_blk_config.writeback properly.

Yes, vhost-user-blk was used as a template.

> > +enum {
> > +     VHOST_BLK_VQ_MAX = 16,
> > +     VHOST_BLK_VQ_MAX_REQS = 128,
> > +};
>
> These limits seem arbitrary and probably too low.

It fits cache and TLB, since the data structures are statically
allocated. I saw a worse performance with bigger max-reqs. I'll make
it configurable.

> > +     if ((type == VIRTIO_BLK_T_IN) || (type == VIRTIO_BLK_T_OUT)) {
> > +             bool write = (type == VIRTIO_BLK_T_OUT);
> > +             int nr_seg = (write ? req->out_num : req->in_num) - 1;
> > +             unsigned long sector = le64_to_cpu(req->hdr.sector);
>
> Using little-endian instead of the virtio types means that only VIRTIO
> 1.0 modern devices are supported (older devices may not be
> little-endian!).  In that case you'd need to put the VIRTIO_1 feature
> bit into the features mask.

Yeah, I'm making first baby steps in virtio ;) Thanks!

> > +     switch (ioctl) {
> > +     case VHOST_SET_MEM_TABLE:
> > +             vhost_blk_stop(blk);
> > +             ret = vhost_blk_pass_ioctl(blk, ioctl, argp);
> > +             break;
>
> Why is this necessary?  Existing vhost devices pass the ioctl through
> without an explicit case for it.

vq->private_data is populated, vhost_set_vring_num returns -EBUSY if
ioctl is passed as is. It can be a bug in vhost, too, but I don't have
enough knowledge.

diff --git a/drivers/vhost/blk.c b/drivers/vhost/blk.c
index aefb9a61fa0f..da3eb041a975 100644
--- a/drivers/vhost/blk.c
+++ b/drivers/vhost/blk.c
@@ -438,7 +438,7 @@ static long vhost_blk_ioctl(struct file *f,
unsigned int ioctl,

        switch (ioctl) {
        case VHOST_SET_MEM_TABLE:
-               vhost_blk_stop(blk);
+//             vhost_blk_stop(blk);
                ret = vhost_blk_pass_ioctl(blk, ioctl, argp);
                break;
        case VHOST_SET_VRING_NUM:

./x86_64-softmmu/qemu-system-x86_64 --enable-kvm -cpu host -smp 4 -m
2G -vnc 192.168.122.104:5 --drive
if=none,id=drive0,format=raw,file=/dev/vde -device
vhost-blk-pci,id=blk0,drive=drive0,num-queues=4
qemu-system-x86_64: vhost_set_vring_num failed: Device or resource busy (16)
qemu-system-x86_64: Error starting vhost: 16

> > +     case VHOST_SET_VRING_NUM:
> > +             if (copy_from_user(&s, argp, sizeof(s)))
> > +                     return -EFAULT;
> > +             ret = vhost_blk_pass_ioctl(blk, ioctl, argp);
> > +             if (!ret)
> > +                     blk->num_queues = s.index + 1;
>
> Where is this input checked against ARRAY_SIZE(blk->queue)?

In vhost itself. I capture the parameter only if vhost ioctl completes
without errors. Perhaps, worth a comment.

Thanks for review, this is exactly what I hoping for!

--
wbr, Vitaly
