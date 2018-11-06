Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56157C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202922085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnrAvwq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202922085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbeKGFff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:35:35 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39636 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeKGFfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:35:34 -0500
Received: by mail-qk1-f193.google.com with SMTP id e4so19257359qkh.6;
        Tue, 06 Nov 2018 12:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YbiDXKdV5AWrnVl4kLV8SNsPJBhEtXN0ieTivrA3r5Y=;
        b=MnrAvwq0jvmnMwoDH7eQgRWvlSnjv13o8TECOn2arPyQ+Se88zkDuEUGKUPCGUkmsl
         F3YupPktRz93dq9DzUZoORMzgXNGmH5buhZzFvkLtsRipFEXgmvLrAhyqc5GmGdLExIU
         iQ7wyG4xcsPhnc12lM+tDvREV7bUxck+dKIgHsuDI/IqJyWKMBq6VnY6KYt5AwbaFZCv
         33qmYVVQ7NeJhemRCGGeo55TQ1ysFvjsc0HIKBXgU/pAsXbRNmev8c5/r5DA97eT1SJ7
         eIZ4S4yWX6xv4NB8Eouj6KdRTliNYBrsUK0LWrewvBYjbYvdUjh+cKslOQmt7TiM9wsH
         UmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YbiDXKdV5AWrnVl4kLV8SNsPJBhEtXN0ieTivrA3r5Y=;
        b=cLWnPzJRztY9tdDpUFlnqTxQdKZlRhmXxa73E7RWG7iRti7Ftu8VF54nOQ4L/T6poR
         +CZKWhooVTbZrdQcPlcY6Su7HqrDvIt9diwgN/JsZZs9fGrswDU5BOr0olNqqssdutD5
         u1Sz6b16MlH11yvqUD5w7CNOx/YF8d6PQ3Srw5KEuodJfZo4UKHHo8ZRhFmWvar5kbfg
         jap4mWEeNBkRpH2BdYz4JSz7bruf5Q8tsk+vKlptn4adrUQ2N2g/eA3zED7dw1AUfwOp
         Hsicx8uRbdpq54jLmtOOUez3f5VYwtK/+bNaHsY7R2IkBzBXexOAjUJrBKll5U3afsQi
         CphA==
X-Gm-Message-State: AGRZ1gIuar5Z1sKIsURc+QBWC3uAt4h0TYFd6ORRDe6PLffZOS+1oa4V
        cIGV13rUIi/ENdC/5QCxsSi8kjmxW/j1nLON2Jncrr0eW3A=
X-Google-Smtp-Source: AJdET5eWfaB47+ButiUNVUp4XUiTTF/mlU3fhZeVz0j6nav3wkF7h31mJWwt3eoiYWOy/DXXA0qnP2lOcWw0epZ6CEk=
X-Received: by 2002:a37:bb86:: with SMTP id l128-v6mr27262306qkf.237.1541534919450;
 Tue, 06 Nov 2018 12:08:39 -0800 (PST)
MIME-Version: 1.0
References: <20181102182123.29420-1-v.mayatskih@gmail.com> <20181102142446-mutt-send-email-mst@kernel.org>
 <20181106154048.GB31579@stefanha-x1.localdomain>
In-Reply-To: <20181106154048.GB31579@stefanha-x1.localdomain>
From:   Vitaly Mayatskih <v.mayatskih@gmail.com>
Date:   Tue, 6 Nov 2018 15:08:26 -0500
Message-ID: <CAGF4SLjKD_=ra4A6CQFv5bsETNoEyVKjA7FRBek7DwuWjyNbCA@mail.gmail.com>
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
To:     stefanha@gmail.com
Cc:     Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>, den@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 10:40 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:

> Previously vhost_blk.ko implementations were basically the same thing as
> the QEMU x-data-plane=on (dedicated thread using Linux AIO), except they
> were using a kernel thread and maybe submitted bios.
>
> The performance differences weren't convincing enough that it seemed
> worthwhile maintaining another code path which loses live migration, I/O
> throttling, image file formats, etc (all the things that QEMU's block
> layer supports).
>
> Two changes since then:
>
> 1. x-data-plane=on has been replaced with a full trip down QEMU's block
> layer (-object iothread,id=iothread0 -device
> virtio-blk-pci,iothread=iothread0,...).  It's slower and not truly
> multiqueue (yet!).
>
> So from this perspective vhost_blk.ko might be more attractive again, at
> least until further QEMU block layer work eliminates the multiqueue and
> performance overheads.

Yes, this work is a direct consequence of insufficient performance of
virtio-blk's host side. I'm working on a storage driver, but there's
no a good way to feed all these IOs into one disk of one VM. The
nature of storage design dictates the need of very high IOPS seen by
VM. This is only one tiny use case of course, but the vhost/QEMU
change is small enough to share.

> 2. SPDK has become available for users who want the best I/O performance
> and are willing to sacrifice CPU cores for polling.
>
> If you want better performance and don't care about QEMU block layer
> features, could you use SPDK?  People who are the target market for
> vhost_blk.ko would probably be willing to use SPDK and it already
> exists...

Yes. Though in my experience SPDK creates more problems most of times
than it solves ;) What I find very compelling in using a plain Linux
block device is that it is really fast these days (blk-mq) and the
device mapper can be used for even greater flexibility. Device mapper
is less than perfect performance-wise and at some point will need some
work for sure, but still can push few million IOPS through. And it's
all standard code with decades old user APIs.

In fact, Linux kernel is so good now that our pure-software solution
can push IO at rates up to the limits of fat hardware (x00 GbE, bunch
of NVMes) without an apparent need for hardware acceleration. And,
without hardware dependencies, it is much more flexible. Disk
interface between the host and VM was the only major bottleneck.

> From the QEMU userspace perspective, I think the best way to integrate
> vhost_blk.ko is to transparently switch to it when possible.  If the
> user enables QEMU block layer features that are incompatible with
> vhost_blk.ko, then it should fall back to the QEMU block layer
> transparently.

Sounds like an excellent idea! I'll do that. Most of vhost-blk support
in QEMU is a boilerplate code anyways.

> I'm not keen on yet another code path with it's own set of limitations
> and having to educate users about how to make the choice.  But if it can
> be integrated transparently as an "accelerator", then it could be
> valuable.

Understood. Agree.

Thanks!
-- 
wbr, Vitaly
