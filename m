Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45144C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D518520C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZSeov/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D518520C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbeJAVhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:37:04 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:38322 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbeJAVhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:37:04 -0400
Received: by mail-pf1-f177.google.com with SMTP id x17-v6so9410684pfh.5;
        Mon, 01 Oct 2018 07:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LfX5y/UenWFFDugMPSOvK602wZw/iRfKgOKWp0QWGtw=;
        b=mZSeov/NLwY3KZOvXpwgDlpxZO9zNdkzuPaphqkHFxJSZdqwk2HBNGjIGR8gTLBJGF
         tLbpT12/DkjyNUDbdifH/5SQzbqB4BRKVa3UFFKQnYUDXhkUdRA5Uf/uZ7cta3aocbV1
         h8ugDS8z6xwgQrIn1pvsOsYwW4wa/bF0uZZ0kI9A5ap4LpU+9v96dR8Vf+tmT0uofvig
         ucLJcVucFC+ua78O5Yyh10HUdsKuugTsRHUYqSlVcxxmCf08U7B/b2hrsluhKdmB/oMK
         gWG1owC70JZd4EJJNCPCyjqOk8ACTC+tr9RjPAwPpf5TZpIfux540zMnkPoWZjrifVTS
         lj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LfX5y/UenWFFDugMPSOvK602wZw/iRfKgOKWp0QWGtw=;
        b=MsxRk85zmXcRaG/8hFF4s+B/1RfIp2Fl6+0hWs90c0bVjjlgbe7vkVYWGuUIUq7wN+
         +jZxd0DjDZoWdyr7ibsWo8jgBTesfW7mVM2/frTwMEcKcGcmhDw7+gbnKSVO0GdjTSH0
         CC60TCd6xx57DPdi1b3cLamd0Tz8CEhj6WSdCzwP6FAcpA7UPsVmhdVyDiURIPla+vY6
         2TZ7/69CAXKR6pBTXUkY/lVxC6+EFcwh6rL2gxg4RBPxeIROHUQ7bJg36R3Wz835+SfW
         DWMLgDkve2gU7xHK74b5v9A9bnwe6nW0oLES7V/xkhV30CbE0bJTXAUEhXgqTp8XZ2gf
         PLIw==
X-Gm-Message-State: ABuFfojq8tTROuY3OSfZqJnmPNhLR6DlAqvWil+PobyYnUVPwW5ihX9o
        ruqHBH946fTQm+j02Ax50RrDRmyNPgnD4865AedUwKo5zfrWUQ==
X-Google-Smtp-Source: ACcGV60yNiWb0Ezkhu62vMr4SORQXgVU4DdNM0iJmv08G3eJG1LXdSdOgpA1v3fG8r2Ykt/lMCEM+buq7rRcsNFCDf8=
X-Received: by 2002:a62:2056:: with SMTP id g83-v6mr11922213pfg.165.1538405931087;
 Mon, 01 Oct 2018 07:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAEK8JBDPNqTap-LnoBxUZh4Bj9b+VgrsPm53QAivfOsLG7wuGw@mail.gmail.com>
 <20181001114146.GA2508@work-vm>
In-Reply-To: <20181001114146.GA2508@work-vm>
From:   Feng Li <lifeng1519@gmail.com>
Date:   Mon, 1 Oct 2018 22:58:24 +0800
Message-ID: <CAEK8JBBDPxTe0k8Nf=7PQ6gjYv4xyqQu=bef5VXmgaLVGw3JUg@mail.gmail.com>
Subject: Re: [Qemu-devel] virtio-console downgrade the virtio-pci-blk performance
To:     dgilbert@redhat.com
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        qemu-discuss@nongnu.org, qemu-devel@nongnu.org,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,
My comments are in-line.

Dr. David Alan Gilbert <dgilbert@redhat.com> =E4=BA=8E2018=E5=B9=B410=E6=9C=
=881=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=887:41=E5=86=99=E9=81=93=EF=
=BC=9A
>
> * Feng Li (lifeng1519@gmail.com) wrote:
> > Hi,
> > I found an obvious performance downgrade when virtio-console combined
> > with virtio-pci-blk.
> >
> > This phenomenon exists in nearly all Qemu versions and all Linux
> > (CentOS7, Fedora 28, Ubuntu 18.04) distros.
> >
> > This is a disk cmd:
> > -drive file=3Discsi://127.0.0.1:3260/iqn.2016-02.com.test:system:fl-isc=
si/1,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0,cache=3Dnone,aio=3Dnati=
ve
> > -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x6,drive=3Ddrive-=
virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1,write-cache=3Don
> >
> > If I add "-device
> > virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x5  ", the vi=
rtio
> > disk 4k iops (randread/randwrite) would downgrade from 60k to 40k.
> >
> > In VM, if I rmmod virtio-console, the performance will back to normal.
> >
> > Any idea about this issue?
> >
> > I don't know this is a qemu issue or kernel issue.
>
> It sounds odd;  can you provide more details on:
>   a) The benchmark you're using.
I'm using fio, the config is:
[global]
ioengine=3Dlibaio
iodepth=3D128
runtime=3D120
time_based
direct=3D1

[randread]
stonewall
bs=3D4k
filename=3D/dev/vdb
rw=3Drandread

>   b) the host and the guest config (number of cpus etc)
The qemu cmd is : /usr/libexec/qemu-kvm --device virtio-balloon -m 16G
--enable-kvm -cpu host -smp 8
or qemu-system-x86_64 --device virtio-balloon -m 16G --enable-kvm -cpu
host -smp 8

The result is the same.

>   c) Why are you running it with iscsi back to the same host - why not
>      just simplify the test back to a simple file?
>

Because my ISCSI target could supply a high IOPS performance.
If using a slow disk, the performance downgrade would be not so obvious.
It's easy to be seen, you could try it.


> Dave
>
> >
> > Thanks in advance.
> > --
> > Thanks and Best Regards,
> > Alex
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK



--=20
Thanks and Best Regards,
Feng Li(Alex)
