Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366CBC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6972087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTLKi07R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6972087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbeJKRmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:42:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42601 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeJKRmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:42:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id c8-v6so3997173plo.9;
        Thu, 11 Oct 2018 03:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vpn3aYVNPMpLsPYay1z5r7wrzaQaZTpl2jSKBzJJlqA=;
        b=sTLKi07RBz2LDTFFY2Rr+fRb7DGlRTK1BSO8OgYgNKIWdgM99wxvcCSp20Fa0lprHj
         PUyR+9r2djdT/6lsTNjANc92vLJCrBlhmMg81R1pu0sHqybAKBO7kNWzNw4TsnmCgj6R
         anmiYl1LOHrW45fKwsR1HdN8RFDUIF9ZpyVENDfiTL45QEmN8a7SY38jl30Tqcs3dmWA
         KALhU3NXd0ICH1/dINmorbsJgux2Icp5EZqEdd5J1ogCSbdCmKxH6ge0ypn5PMFM9sVI
         gzpDvqH4stsiqYggYXFjVdYG9ESXNiS/CEvTBnyQ6N64B31og/uvnBVEdtSGu2GnWAyz
         c9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vpn3aYVNPMpLsPYay1z5r7wrzaQaZTpl2jSKBzJJlqA=;
        b=YkIv41fTA33hEAeu6am89SfhpF5FA38i1OjuECwpTk+ngBlIyIvXr4sjgEgdEuKsFi
         utJK7pnZwZ/5j7uEE3X20rbu+kjYnOGUBw/uXPo+DVBmPC/64KW0Mh/XFb3EP1BN7UVy
         6zuFLyRqWKIIp70zq43eCm7Ss/Z2kwaAk0glxVk6xC5WvXmkycm2YHveGCmZBn7+Pd6o
         HfZpOceW5wrn6yNk7ZO7Ve2sIcopDah/zQqFXq7IQyqLU9C/KmzZUlf/Kb8vnKXg6SHq
         ZaAgfhiCLr7UaTh24aYR2y2cWhmzYl2BISg8XlEL6yAUBE838lORsLon+gkZJhHhzYOW
         V+nQ==
X-Gm-Message-State: ABuFfoi79/bMideRi+sbWzVKJyLdQ0S+MnR+BzpEsb/ufKUYJPBrVDnD
        MVmKNIhtIQXv3TcYAqH4rzcPgzZecPXj7w4jEaY=
X-Google-Smtp-Source: ACcGV60xragSyBhXhmgNfir7d2OB8XKBcDglLS82RKL8bL1vO1KllKMEavOAO9b+b8qYxAoM43b2meAh9wH6SxvYYU8=
X-Received: by 2002:a17:902:b403:: with SMTP id x3-v6mr938396plr.237.1539252968849;
 Thu, 11 Oct 2018 03:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAEK8JBDPNqTap-LnoBxUZh4Bj9b+VgrsPm53QAivfOsLG7wuGw@mail.gmail.com>
 <20181001114146.GA2508@work-vm> <CAEK8JBBDPxTe0k8Nf=7PQ6gjYv4xyqQu=bef5VXmgaLVGw3JUg@mail.gmail.com>
In-Reply-To: <CAEK8JBBDPxTe0k8Nf=7PQ6gjYv4xyqQu=bef5VXmgaLVGw3JUg@mail.gmail.com>
From:   Feng Li <lifeng1519@gmail.com>
Date:   Thu, 11 Oct 2018 18:15:41 +0800
Message-ID: <CAEK8JBC-HKGb43UynWx69Lj-y48Em038eNMpOb7G72XfLF_mDg@mail.gmail.com>
Subject: Re: [Qemu-devel] virtio-console downgrade the virtio-pci-blk performance
To:     dgilbert@redhat.com, amit@kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        qemu-discuss@nongnu.org, qemu-devel@nongnu.org,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Amit Shah.

After some tests, we found:
- the virtio serial port number is inversely proportional to the iSCSI
virtio-blk-pci performance.
If we set the virio-serial ports to 2("<controller
type=3D'virtio-serial' index=3D'0' ports=3D'2'/>), the performance downgrad=
e
is minimal.

- use local disk/ram disk as virtio-blk-pci disk, the performance
downgrade is still obvious.


Could anyone give some help about this issue?

Feng Li <lifeng1519@gmail.com> =E4=BA=8E2018=E5=B9=B410=E6=9C=881=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8810:58=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Dave,
> My comments are in-line.
>
> Dr. David Alan Gilbert <dgilbert@redhat.com> =E4=BA=8E2018=E5=B9=B410=E6=
=9C=881=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=887:41=E5=86=99=E9=81=93=
=EF=BC=9A
> >
> > * Feng Li (lifeng1519@gmail.com) wrote:
> > > Hi,
> > > I found an obvious performance downgrade when virtio-console combined
> > > with virtio-pci-blk.
> > >
> > > This phenomenon exists in nearly all Qemu versions and all Linux
> > > (CentOS7, Fedora 28, Ubuntu 18.04) distros.
> > >
> > > This is a disk cmd:
> > > -drive file=3Discsi://127.0.0.1:3260/iqn.2016-02.com.test:system:fl-i=
scsi/1,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0,cache=3Dnone,aio=3Dna=
tive
> > > -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x6,drive=3Ddriv=
e-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1,write-cache=3Don
> > >
> > > If I add "-device
> > > virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x5  ", the =
virtio
> > > disk 4k iops (randread/randwrite) would downgrade from 60k to 40k.
> > >
> > > In VM, if I rmmod virtio-console, the performance will back to normal=
.
> > >
> > > Any idea about this issue?
> > >
> > > I don't know this is a qemu issue or kernel issue.
> >
> > It sounds odd;  can you provide more details on:
> >   a) The benchmark you're using.
> I'm using fio, the config is:
> [global]
> ioengine=3Dlibaio
> iodepth=3D128
> runtime=3D120
> time_based
> direct=3D1
>
> [randread]
> stonewall
> bs=3D4k
> filename=3D/dev/vdb
> rw=3Drandread
>
> >   b) the host and the guest config (number of cpus etc)
> The qemu cmd is : /usr/libexec/qemu-kvm --device virtio-balloon -m 16G
> --enable-kvm -cpu host -smp 8
> or qemu-system-x86_64 --device virtio-balloon -m 16G --enable-kvm -cpu
> host -smp 8
>
> The result is the same.
>
> >   c) Why are you running it with iscsi back to the same host - why not
> >      just simplify the test back to a simple file?
> >
>
> Because my ISCSI target could supply a high IOPS performance.
> If using a slow disk, the performance downgrade would be not so obvious.
> It's easy to be seen, you could try it.
>
>
> > Dave
> >
> > >
> > > Thanks in advance.
> > > --
> > > Thanks and Best Regards,
> > > Alex
> > >
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>
>
> --
> Thanks and Best Regards,
> Feng Li(Alex)



--
Thanks and Best Regards,
Feng Li(Alex)
