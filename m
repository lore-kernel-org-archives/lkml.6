Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD545C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B86208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/mKHIS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B86208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeJPKOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:14:37 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:45255 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbeJPKOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:14:37 -0400
Received: by mail-pf1-f177.google.com with SMTP id u12-v6so10613751pfn.12;
        Mon, 15 Oct 2018 19:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OH2uVsRzY0fMDKD79VxDM7NUq0AJ6Gr9BODRXlDwNwk=;
        b=c/mKHIS50jeg9nqTecxD1FBmMzMa2TJGwoRNctAo03zWbGiKIJELPtbOyq8CYhgf3v
         tYMpYaHrsPJmrwMVwAUyzkWnAaQxFhlMFvDbVeMC3BtjdnTcVZgYH2n0JQYLfIPAZPc7
         4AeCoB8M9bw4yst7w/gupmDBBsacGeFyMn2rwTzpJDIzosWmXaaJrupMxkumBgbdFQGH
         7ChRYVY5jTiNeMObdSSvQgGo7JbSk/YN0icH+0JmLIWMMEb1CwRXSHYYeOev5GHkG9Dy
         s2V2kbTWdxL979OqJdUAfWXnSyPK61ovTZqgOidf7uIDgbxjzxdkS7aN08FPKqmHpLIn
         UJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OH2uVsRzY0fMDKD79VxDM7NUq0AJ6Gr9BODRXlDwNwk=;
        b=I3K0LvSocjNEHn1Pego/0iSAtFXUf7ZvVZMtqplQgRfbaz6sSIwCEPZsnEYQKFt7ks
         BJeC4G0XskrTD2/ewbI0H5sRCV/dTt0O/fasP3gZY2I8+KFavcUpvJ/ylRJD1YaPKKEl
         V7vsx0tVBD0WbhL7/AoEQYIG+soyI+mdOZKJ9fFrBVUiaijN6pCIH1HfRz3e92cqdrHn
         EM7kMP99ipReOb/wAOhxOpnNT0G8kA+PnUAoJRjlxXqTKtcWeZTJA6hfqGxJTRVtA2Xa
         Pf47ZcNkszG7vyMegVUP+BthOh7Kr783RloWnXt5Y0Aa7jVHOdwuvO1pswNHkZO07U5A
         iyIw==
X-Gm-Message-State: ABuFfohRKwWuLx53t/ps2ur+zCFaAXbEEGsDuCxxhF2jo7n02qkeb3Gj
        0N6yux/7Pqul8o0teM5umza25E2C3wrr7UFDTe0vWyganO9XYQ==
X-Google-Smtp-Source: ACcGV61Y6Q9FO55+HFieJAw2UmFKCnr6+8BPruvxFYSWwvwhEYIddEV8qCO4LXH7uOC2+yMoXh7nENtMVsjAnmghQhI=
X-Received: by 2002:a63:cd12:: with SMTP id i18-v6mr18714771pgg.319.1539656795007;
 Mon, 15 Oct 2018 19:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAEK8JBDPNqTap-LnoBxUZh4Bj9b+VgrsPm53QAivfOsLG7wuGw@mail.gmail.com>
 <20181001114146.GA2508@work-vm> <CAEK8JBBDPxTe0k8Nf=7PQ6gjYv4xyqQu=bef5VXmgaLVGw3JUg@mail.gmail.com>
 <CAEK8JBC-HKGb43UynWx69Lj-y48Em038eNMpOb7G72XfLF_mDg@mail.gmail.com> <20181015185115.GA3247@grmbl.mre>
In-Reply-To: <20181015185115.GA3247@grmbl.mre>
From:   Feng Li <lifeng1519@gmail.com>
Date:   Tue, 16 Oct 2018 10:26:08 +0800
Message-ID: <CAEK8JBDpy+AvCfEZ5UAM+FojFBK2Cy1BqsrctkX-6QD6jvTK4w@mail.gmail.com>
Subject: Re: [Qemu-devel] virtio-console downgrade the virtio-pci-blk performance
To:     amit@kernel.org
Cc:     dgilbert@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        qemu-discuss@nongnu.org, qemu-devel@nongnu.org,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

Thanks for your response.

See inline comments.

Amit Shah <amit@kernel.org> =E4=BA=8E2018=E5=B9=B410=E6=9C=8816=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=882:51=E5=86=99=E9=81=93=EF=BC=9A
>
> On (Thu) 11 Oct 2018 [18:15:41], Feng Li wrote:
> > Add Amit Shah.
> >
> > After some tests, we found:
> > - the virtio serial port number is inversely proportional to the iSCSI
> > virtio-blk-pci performance.
> > If we set the virio-serial ports to 2("<controller
> > type=3D'virtio-serial' index=3D'0' ports=3D'2'/>), the performance down=
grade
> > is minimal.
>
> If you use multiple virtio-net (or blk) devices -- just register, not
> necessarily use -- does that also bring the performance down?  I

Yes. We just register the virtio-serial, and not use it, it brings the
virtio-blk performance down.

> suspect it's the number of interrupts that get allocated for the
> ports.  Also, could you check if MSI is enabled?  Can you try with and
> without?  Can you also reproduce if you have multiple virtio-serial
> controllers with 2 ports each (totalling up to whatever number that
> reproduces the issue).

This is the full cmd:
/usr/libexec/qemu-kvm -name
guest=3D6a798fde-c5d0-405a-b495-f2726f9d12d5,debug-threads=3Don -machine
pc-i440fx-rhel7.5.0,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff -cpu host -=
m
size=3D2097152k,slots=3D255,maxmem=3D4194304000k   -uuid
702bb5bc-2aa3-4ded-86eb-7b9cf5c1e2d9 -drive
file.driver=3Discsi,file.portal=3D127.0.0.1:3260,file.target=3Diqn.2016-02.=
com.smartx:system:zbs-iscsi-datastore-1537958580215k,file.lun=3D74,file.tra=
nsport=3Dtcp,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0,cache=3Dnone,ai=
o=3Dnative
-device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x6,drive=3Ddrive-virt=
io-disk0,id=3Dvirtio-disk0,bootindex=3D1,write-cache=3Don
-drive file.driver=3Discsi,file.portal=3D127.0.0.1:3260,file.target=3Diqn.2=
016-02.com.smartx:system:zbs-iscsi-datastore-1537958580215k,file.lun=3D182,=
file.transport=3Dtcp,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk1,cache=
=3Dnone,aio=3Dnative
-device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x7,drive=3Ddrive-virt=
io-disk1,id=3Dvirtio-disk1,bootindex=3D2,write-cache=3Don
-device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x8 -vnc
0.0.0.0:100 -netdev user,id=3Dfl.1,hostfwd=3Dtcp::5555-:22 -device
e1000,netdev=3Dfl.1 -msg timestamp=3Don   -device
virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x5

qemu version: qemu-kvm-2.10.0-21

I guess the MSI is enabled, I could see some logs:
[    2.230194] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MS=
I]
[    3.556376] virtio-pci 0000:00:05.0: irq 24 for MSI/MSI-X

The issue could reproduce easily, using one virtio-serial with 31
ports, and this is the default port num.
I think it's not necessary to reproduce with multiple controllers.

>
>                 Amit
>
> >
> > - use local disk/ram disk as virtio-blk-pci disk, the performance
> > downgrade is still obvious.
> >
> >
> > Could anyone give some help about this issue?
> >
> > Feng Li <lifeng1519@gmail.com> =E4=BA=8E2018=E5=B9=B410=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8810:58=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Hi Dave,
> > > My comments are in-line.
> > >
> > > Dr. David Alan Gilbert <dgilbert@redhat.com> =E4=BA=8E2018=E5=B9=B410=
=E6=9C=881=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=887:41=E5=86=99=E9=81=
=93=EF=BC=9A
> > > >
> > > > * Feng Li (lifeng1519@gmail.com) wrote:
> > > > > Hi,
> > > > > I found an obvious performance downgrade when virtio-console comb=
ined
> > > > > with virtio-pci-blk.
> > > > >
> > > > > This phenomenon exists in nearly all Qemu versions and all Linux
> > > > > (CentOS7, Fedora 28, Ubuntu 18.04) distros.
> > > > >
> > > > > This is a disk cmd:
> > > > > -drive file=3Discsi://127.0.0.1:3260/iqn.2016-02.com.test:system:=
fl-iscsi/1,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0,cache=3Dnone,aio=
=3Dnative
> > > > > -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x6,drive=3D=
drive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1,write-cache=3Don
> > > > >
> > > > > If I add "-device
> > > > > virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x5  ", =
the virtio
> > > > > disk 4k iops (randread/randwrite) would downgrade from 60k to 40k=
.
> > > > >
> > > > > In VM, if I rmmod virtio-console, the performance will back to no=
rmal.
> > > > >
> > > > > Any idea about this issue?
> > > > >
> > > > > I don't know this is a qemu issue or kernel issue.
> > > >
> > > > It sounds odd;  can you provide more details on:
> > > >   a) The benchmark you're using.
> > > I'm using fio, the config is:
> > > [global]
> > > ioengine=3Dlibaio
> > > iodepth=3D128
> > > runtime=3D120
> > > time_based
> > > direct=3D1
> > >
> > > [randread]
> > > stonewall
> > > bs=3D4k
> > > filename=3D/dev/vdb
> > > rw=3Drandread
> > >
> > > >   b) the host and the guest config (number of cpus etc)
> > > The qemu cmd is : /usr/libexec/qemu-kvm --device virtio-balloon -m 16=
G
> > > --enable-kvm -cpu host -smp 8
> > > or qemu-system-x86_64 --device virtio-balloon -m 16G --enable-kvm -cp=
u
> > > host -smp 8
> > >
> > > The result is the same.
> > >
> > > >   c) Why are you running it with iscsi back to the same host - why =
not
> > > >      just simplify the test back to a simple file?
> > > >
> > >
> > > Because my ISCSI target could supply a high IOPS performance.
> > > If using a slow disk, the performance downgrade would be not so obvio=
us.
> > > It's easy to be seen, you could try it.
> > >
> > >
> > > > Dave
> > > >
> > > > >
> > > > > Thanks in advance.
> > > > > --
> > > > > Thanks and Best Regards,
> > > > > Alex
> > > > >
> > > > --
> > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >
> > >
> > >
> > > --
> > > Thanks and Best Regards,
> > > Feng Li(Alex)
> >
> >
> >
> > --
> > Thanks and Best Regards,
> > Feng Li(Alex)
>
>                 Amit
> --
> http://amitshah.net/



--=20
Thanks and Best Regards,
Feng Li(Alex)
