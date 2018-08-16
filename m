Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99896C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 23:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4249820C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 23:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sn6jJzHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4249820C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeHQCfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 22:35:46 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55475 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeHQCfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 22:35:46 -0400
Received: by mail-it0-f68.google.com with SMTP id d10-v6so8779627itj.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 16:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3PyjKcCVKXNdX0/EuBi1AluHRvGNiq8M6Yozp3l9zgI=;
        b=Sn6jJzHXlid4pgR6w4jZ1eba2uZSjgDNa18C3SjegRb7GTSIZYVyA2nNe5DSa32Ty4
         fKzGZH7k/J9D0k70Euar8Hoc9tczp+A82TxiRiZ0Z9mJ3uoH3fsZUvjd1ihl6uNQbvqc
         BzcSeNpA1j+NtM7hEOj2JE5lpBwNXYIN7nVoC6cwHq0lja+fqx4i7Lt/VMgMYRIV62Kc
         v0/zksMjUHQ6qHSVq3Q5YXB/f3B049wHWrMyhXkCct7oG/E+LfztrMMPWycBg2njT2vy
         F5WHBK/Vo2BWBZG76sIxYfW5/WqZZrALGki3jNJSFemwjrC6PWsXsX6mg5pUr6RlB+LL
         Q/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3PyjKcCVKXNdX0/EuBi1AluHRvGNiq8M6Yozp3l9zgI=;
        b=MGiRRtH02cbxXyYbB8FBOmxoG71n8waC8v6SPAUNgoqeu7TIdszpi7J8lvjNUFvpcT
         F72nG8xN/7DJh4L46K2GmRdcmX76uepoGBl3s+hAI9jGhSIH5k3vT5a8naVfvDLjsiVU
         fJJ5EEHk1u4JQBDVgAsgI4cR8IZn67qYrKwWdKuHfeRw85sl1vbnN8FA4FM3RYGgrkLT
         849fAexLVoRZmr41ppiBbf3IaFKjG76ujbBjoeQ3DFXrgExUVwcyG6ujuMKCyGASCqmU
         MM52gKO1H5f/Ii5Eyww0Q+pOLBjPi1NAN8zGUyPPK547ceZp2/VQnqqiFqepfvaKT5L8
         pUeg==
X-Gm-Message-State: AOUpUlF3epLbhlDhGQWVCXeydteYMM4BqDV84CGZbiilFXMjI2cO/S8I
        85BYI8f0iHQC1O/i5eSl0BR9HL6md6Jr+dPqiA==
X-Google-Smtp-Source: AA+uWPyTIx0bylW0U8WntR7KscIERQAiR9UXR8UXU7T+MkUXQU0zISIIk6wdPTg/xuQmum2MENbSorS95Qiato2kC58=
X-Received: by 2002:a24:5d45:: with SMTP id w66-v6mr2370389ita.121.1534462483104;
 Thu, 16 Aug 2018 16:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20180816161825eucas1p11be9cea5d622b905154590bae90a47a4@eucas1p1.samsung.com>
 <20180816161817.12267-1-andrzej.p@samsung.com>
In-Reply-To: <20180816161817.12267-1-andrzej.p@samsung.com>
From:   =?UTF-8?Q?Bj=C3=B8rn_Forsman?= <bjorn.forsman@gmail.com>
Date:   Fri, 17 Aug 2018 01:34:30 +0200
Message-ID: <CAEYzJUHghs+2p4n1TesL3=VkCJcvs1TevjeFhqiQHdX+cqfqiQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "kbuild: create deterministic initramfs directory listings"
To:     andrzej.p@samsung.com
Cc:     LKML <linux-kernel@vger.kernel.org>, forney@google.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2018 at 18:18, Andrzej Pietrasiewicz
<andrzej.p@samsung.com> wrote:
>
> This reverts commit 9e6e0d5f2a2713402cf9dce69b9f9b516e4185d2.
>
> The reverted commit introduces broken builds. Even though the cpio archiv=
e
> does contain all the specified files, it seems that the kernel, while
> populating rootfs, scans the cpio buffer linearly and fails to create
> files whose parent directories are nonexistent at the moment of this fail=
ed
> creation. As a result, such files are not accessible when kernel boots in=
to
> initramfs.
>
> Here is how to reproduce, from inside kernel source directory, with the
> patch in question not reverted:
>
> $ mkdir -p ../test/find/me/if/you/can
> $ touch ../test/find/me/if/you/can/file.txt
> $ cat ../initramfs.list
> file /busybox-x86_64 ../initramfs/busybox-x86_64 0755 0 0
> dir /sbin 0755 0 0
> dir /proc 0755 0 0
> dir /sys 0755 0 0
> dir /bin 0755 0 0
> dir /usr 0755 0 0
> dir /usr/sbin 0755 0 0
> dir /usr/bin 0755 0 0
> dir /etc 0755 0 0
> dir /etc/init.d 0755 0 0
> file /etc/inittab ../initramfs/inittab 0755 0 0
> file /etc/init.d/rcS ../initramfs/rcS-x86_64 0755 0 0
> dir /lib 0755 0 0
> dir /lib/modules 0755 0 0
> $ ls ../initramfs
> busybox-x86_64  inittab  rcS-x86_64
> $ cat ../initramfs/inittab
> ::sysinit:/etc/init.d/rcS
> ::askfirst:-/bin/sh
> ::ctrlaltdel:/sbin/reboot
> ::shutdown:/sbin/swapoff -a
> ::shutdown:/sbin/umount -a -r
> ::restart:/sbin/init
> $ cat ../initramfs/rcS-x86_64
> #!/busybox-x86_64 sh
>
> /busybox-x86_64 --install
>
> mount -t proc none /proc
> mount -t sysfs none /sys
>
> mdev -s
> echo /sbin/mdev > /proc/sys/kernel/hotplug
> $ scripts/gen_initramfs_list.sh ../test/ ../initramfs.list
>
> #####################
> # ../test/
> # Last modified: 1534428527.0818855150
>
> file /find/me/if/you/can/file.txt ../test/find/me/if/you/can/file.txt 664=
 1000 1000
> dir /find/me/if/you/can 775 1000 1000
> dir /find/me/if/you 775 1000 1000
> dir /find/me/if 775 1000 1000
> dir /find/me 775 1000 1000
> dir /find 775 1000 1000

I'm unable to reproduce it. On my system the listing is sorted so that
it works (parent directories appear before files). I tried to run with
LANG=3DC and it also sorts correctly. What is your LANG=3D? I think we
better add a LANG=3DC somewhere in the kernel build system, because I
think you have a LANG=3D that makes it sort differently. A quick fix
would of course be to insert it right next to sort, but there may be
other places that may break due to LANG=3D settings.

Best regards,
Bj=C3=B8rn Forsman
