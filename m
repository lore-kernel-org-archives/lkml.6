Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8971BC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9082081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tj6PvwHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9082081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbeKEB4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 20:56:22 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40924 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbeKEB4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 20:56:22 -0500
Received: by mail-qk1-f194.google.com with SMTP id y16so9749925qki.7;
        Sun, 04 Nov 2018 08:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i5KkxHPWwlVtRRAKCcZv0UXfZ8ae9qRyW5qTL0yRtkE=;
        b=tj6PvwHIZYkc6Buc8LKc6rE7+A0MVIrY2GBBbnWfYihstEcJ7WXgJY0gd2L752WE85
         IMGFWtGFg5PSv9IdmtrXcwEajvjqlrPJYlswpnN7NwtjuEjs2yrEvN3XjwBKqiPBShXF
         TEyy4GB3E8U6NKXoVPscIwMoDrlJ5ZdJvgMzDrkT4lgriqFkgOz4fTIi3by27Wp8/tGY
         nUZAzacaVieYquS4oAsESqqjuSklKv/T146Dba+BEqD5aB27ggzcZ27vlG26nKyLBa4K
         9g5nsOnGvYGS33nua8wOm7cQWdRhLjLN8zDZiiYaUu++sUwvMROoDDuSa3obb+aQcR+W
         nzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i5KkxHPWwlVtRRAKCcZv0UXfZ8ae9qRyW5qTL0yRtkE=;
        b=EWD2PCj3slmf0CLRBQUAywiVdfR/jBT1S7p+qe66iYTiygsSM4LfNZNl4qajS9xr68
         ZdiZeBBzlH/+8Cx1Im26OyQgY+p5aw0RHhl85Lih6HG9IOjcsaPsR7yb9LgQt9wrnHrV
         9tmVfHJ7KqfvZhloKrAdmDFf5Yq6ppOmTxJjUuUZnI0nCLI7QuvdueKcG8ny9IyBjI2H
         hFKxWFRqab42Vs11rRX73BCsd69B1AgphAMidgo//fWY/faMJkScXcH2OTLQEGRCiYG8
         D5yBPwaMsscJF6sZULFjwvXk+7yGi119+5+bj6JpQy05w2JF8gY/oXb2UiA+VMwOjDH4
         HKbA==
X-Gm-Message-State: AGRZ1gJCDU2ICUD999PdWQoWOpHwd+nBQ8j56Fl6wy+pF46qN2OwSmdC
        gAgmjNUXGgHHiuGOtI7xPec9NpxREIDoqDlSSotC93s8
X-Google-Smtp-Source: AJdET5foEGrQSThOdvHam56dK242B6WSzksQk9G5D4/fYXgGnEPS24RLV+WyedCtlKfaMVgc9MKcG40K2egD+CF0IvE=
X-Received: by 2002:aed:30a2:: with SMTP id 31-v6mr18423595qtf.127.1541349648558;
 Sun, 04 Nov 2018 08:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20181102182123.29420-1-v.mayatskih@gmail.com> <bf92bdb6dcb0e94014b3e1ffc8acce260a3df61e.camel@redhat.com>
In-Reply-To: <bf92bdb6dcb0e94014b3e1ffc8acce260a3df61e.camel@redhat.com>
From:   Vitaly Mayatskih <v.mayatskih@gmail.com>
Date:   Sun, 4 Nov 2018 11:40:36 -0500
Message-ID: <CAGF4SLhxvC5WN8W_ApoqMTe1i1r8FwX92Bb9UewpNwkKCZepnQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
To:     mlevitsk@redhat.com
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

On Sun, Nov 4, 2018 at 6:57 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:

> Hi!
> I am also working in this area, and so I am very intersted in this driver.
>
> > 1  171k  151k  148k 151k 195k  187k  175k
> If I understand correctly this is fio --numjobs=1?
> It looks like you are getting better that native performance over bare metal in
> E,F,G (vhost-blk cases in fact). Is this correct?

Yes. At such speeds it is a matter of how the workers are scheduled,
i.e. how good is batching. There are other factors why vhost-blk is on
par or slightly higher than fio running in userspace on bare metal,
but from my observation the right batching all through the stack is
more important.

> Could you share the full fio command line you have used?

sysctl -w vm.nr_hugepages=8300; numactl -p 1 -N 1 ./qemu-system-x86_64
-enable-kvm -cpu host -smp 16 -mem-prealloc -mem-path
/dev/hugepages/foo -m 8G -nographic -drive
if=none,id=drive0,format=raw,file=/dev/mapper/mirror-hello,cache=none
-device virtio-blk-pci,id=blk0,drive=drive0,num-queues=16 -drive
if=none,id=drive1,format=raw,file=/dev/mapper/mirror-volume,cache=none
-device vhost-blk-pci,id=blk1,drive=drive1,num-queues=16

for i in `seq 1 16`; do echo -n "$i "; ./fio --direct=1 --rw=randread
--ioengine=libaio --bs=4k --iodepth=128 --numjobs=$i --name=foo
--time_based --runtime=15 --group_reporting --filename=/dev/vda
--size=10g | grep -Po 'IOPS=[0-9\.]*k'; done

> Which IO device did you use for the test? NVME?

That was LVM mirror over 2 network disks. On the target side it was
LVM stripe over few NVMe's.

> Which system (cpu model/number of cores/etc) did you test on?

Dual socket: "model name    : Intel(R) Xeon(R) Gold 6142 CPU @
2.60GHz" with HT enabled, so 64 logical cores in total. The network
was something from Intel with 53 Gbps PHY and served by fm10k driver.

-- 
wbr, Vitaly
