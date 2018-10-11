Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6A2C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6983820658
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNA/WErD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6983820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbeJKX4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:56:01 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39756 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbeJKX4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:56:01 -0400
Received: by mail-yw1-f65.google.com with SMTP id v1-v6so3822816ywv.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 09:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7QD4HVvsBbdmrGfOB/+v74Cc4BAA25PMJ/Y8wHtnZ3Q=;
        b=XNA/WErDz9KCkKiEsazD6y93MGJx29rkvxgGrY3nCM/jaxj5etKFw1wTb2hXlnUd/w
         hrgwoq+jW3ylWjVqFLZXUu4iQS9JXkzYn+Ixb/DzeRhhXAI5Fi1Pn/6zZlPe3lH4xoUe
         M1E6M4r/tC7jFofPFMvIl3wcQ5fTND5GsIDmbtjb5LZ+jMMwiHQI6aGa2XIMCeV4r5r5
         3Hz8/unDsM7+3808Hv++vnuMYx88ZneIpdYQjFfnNbIkliOTJvtyZfavgqNm7izlK1es
         me1GLippvsxC/ZUVqwMNU9xmP28FD2o4vdelWq4GnpMtbJA7gB7XRy4iHlZIdCbiF9TN
         rmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7QD4HVvsBbdmrGfOB/+v74Cc4BAA25PMJ/Y8wHtnZ3Q=;
        b=KeCrTBDMIf1gT7M6kMglKC6KOzPNLOGvCeVMO81oacXWZh5fRinwzgUpG2pS8Q4zon
         scFYmfD4uXjmnFl4+4OmxdlpUdKBM2EhakIM/a2e8q3pauGm9REpO8RjRp3JoncjTttG
         lgLQYe/b7eHhHc5iV/zBR72vU3b4O11Xq4HNtDeCen55uc4oxGMt0qsy791xSWqsEYxT
         XJRAVbX7/WAsMgyb+BBWxx3TLPF6hCpzP+sb0kToNyMXG+ZGpe0U4LDcUtOHaXd7XwHC
         M002ks6a9U0/tXR5idmOCxquAExAqo/D5qPWU5QO/+Mhn2MDTcOdwqEnCYxQY4hKg/Pc
         k0Tw==
X-Gm-Message-State: ABuFfoh8kSzgzgRZmLtOdesUQI2ceTjOZ5pEqkf1KdqWnN3lLTq0n988
        jLFeYMgiFh44I9d8z5yxO212ynIR2h5Hln+vqYSjC4U=
X-Google-Smtp-Source: ACcGV60l7S11hU3yp3AZi+HuJLZ/SsfhnAriLB9/SNaqtdKBMlCrycvJ5uzLgiyRAcfpKt7BiVrUOqjvkbtcnMdRri8=
X-Received: by 2002:a81:3146:: with SMTP id x67-v6mr1327157ywx.141.1539275282849;
 Thu, 11 Oct 2018 09:28:02 -0700 (PDT)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Date:   Fri, 12 Oct 2018 00:23:09 +0800
Message-ID: <CANnei0EzU-C+oXi+ur=S=VJgEZcqvN+e7jYZycaAjpN810xJkw@mail.gmail.com>
Subject: [Successful] Installation Notes for Teo En Ming Extremely Simple
 Linux 1810.11 on CentOS 6.10
To:     linux-kernel@vger.kernel.org
Cc:     Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Successful] Installation Notes for Teo En Ming Extremely Simple Linux
1810.11 on CentOS 6.10
=============================================================================================

Author: Mr. Turritopsis Dohrnii Teo En Ming
Country: Singapore
Date: 11th October 2018 Thursday

YouTube video: Teo En Ming Extremely Simple Linux 1810.11 (Successful)
URL: https://www.youtube.com/watch?v=L5da1xdQ7Kw

STEPS
=====

001. Download CentOS 6.10 Linux from your favorite mirror.

002. Install CentOS 6.10 as an Oracle Virtualbox 5.2.18 virtual
machine in Windows 10 version 1803 host operating system.

003. During installation, choose "Software Development Workstation".

004. Click Next.

005. Click Reboot to complete the installation of CentOS 6.10.

006. On VirtualBox in Windows host, click Machine > Setttings > Network.

007. Choose Bridged Adapter. Please note that you CANNOT choose a
Wireless LAN adapter. Bridging with a Wireless LAN adapter will never
work.

008. Login to CentOS 6.10 using Putty.

009. Search for gcc (GNU Compiler Collection).

[teoenming@teo-en-ming-pc ~]$ rpm -qa | grep gcc
gcc-gfortran-4.4.7-23.el6.x86_64
gcc-4.4.7-23.el6.x86_64
gcc-c++-4.4.7-23.el6.x86_64
libgcc-4.4.7-23.el6.x86_64

010. Search for make.

[teoenming@teo-en-ming-pc ~]$ rpm -qa | grep make
make-3.81-23.el6.x86_64
automake-1.11.1-4.el6.noarch

011. Search for ncurses.

[teoenming@teo-en-ming-pc ~]$ rpm -qa | grep ncurses
ncurses-libs-5.7-4.20090207.el6.x86_64
ncurses-devel-5.7-4.20090207.el6.x86_64
ncurses-5.7-4.20090207.el6.x86_64
ncurses-base-5.7-4.20090207.el6.x86_64

012. Search for perl.

[teoenming@teo-en-ming-pc ~]$ rpm -qa | grep perl
<Super long list...snipped>

013. Search for grub (Grand Unified Boot Loader).

[teoenming@teo-en-ming-pc ~]$ rpm -qa | grep grub
grubby-7.0.15-7.el6.x86_64
grub-0.97-99.el6.x86_64

Yay! Grub Legacy 0.97 is installed by default on CentOS 6.10.

014. Download the latest binutils-2.31

wget https://ftp.gnu.org/gnu/binutils/binutils-2.31.tar.xz

015. Download the latest busybox-1.29.3

wget https://busybox.net/downloads/busybox-1.29.3.tar.bz2

016. Download the latest Cross Linux From Scratch (CLFS) Bootscripts

wget http://ftp.osuosl.org/pub/clfs/conglomeration/clfs-embedded-bootscripts/clfs-embedded-bootscripts-1.0-pre5.tar.bz2

017. Download the latest GNU Compiler Collection (gcc) version 8.2.0

wget https://ftp.gnu.org/gnu/gcc/gcc-8.2.0/gcc-8.2.0.tar.xz

018. Download the latest GNU C Programming Library version 2.28

wget https://ftp.gnu.org/gnu/glibc/glibc-2.28.tar.xz

019. Download the latest gmp-6.1.2

wget https://ftp.gnu.org/gnu/gmp/gmp-6.1.2.tar.bz2

020. Download the latest Linux Kernel version 4.18.12 (stable branch)

wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.18.12.tar.xz

021. Download the latest mpc-1.1.0

wget https://ftp.gnu.org/gnu/mpc/mpc-1.1.0.tar.gz

022. Download the latest mpfr-4.0.1

wget https://ftp.gnu.org/gnu/mpfr/mpfr-4.0.1.tar.xz

023. Download the latest zlib-1.2.11

wget https://zlib.net/zlib-1.2.11.tar.gz

From now on, follow Petros Koutoupis' guide at Linux Journal.

[Guide] DIY: Build a Custom Minimal Linux Distribution from Source
Link: https://www.linuxjournal.com/content/diy-build-custom-minimal-linux-distribution-source

Follow the instructions until the section "Building the Cross Compiler".

At the Kernel Headers sub-section,

025. Extract the latest Linux Kernel 4.18.12 (stable branch)

tar xfvJ linux-4.18.12.tar.xz

026. Change directory into the Linux Kernel 4.18.12 source code directory

cd linux-4.18.12

Then continue following the instructions.

At the section on Glibc, glibc-2.28 (C Programming Library version
2.28) won't compile.

So we will use glibc-2.27 (C Programming Library version 2.27) instead.

027. Download C Programming Library version 2.27

wget https://ftp.gnu.org/gnu/glibc/glibc-2.27.tar.xz

Glibc 2.27 also cannot compile because the installed bison is too old.
Glibc 2.28 down to Glibc 2.21 requires bison 2.7 or later.
But bison 2.4 is installed by default on CentOS 6.10.

We will need to use glibc 2.20 as it DOES NOT depend on bison.

028. Download C Programming Library version 2.20

wget http://ftp.gnu.org/gnu/glibc/glibc-2.20.tar.xz

Continue following the instructions from the section Zlib until the command

sudo grub-install --root-directory=/home/teoenming/tmp/ /dev/sdb

This is the output of the command grub-install:

Probing devices to guess BIOS drives. This may take a long time.
Installation finished. No error reported.
This is the contents of the device map /home/teoenming/tmp/boot/grub/device.map.
Check if this is correct or not. If any of the lines is incorrect,
fix it and re-run the script `grub-install'.

(fd0)   /dev/fd0
(hd0)   /dev/sda
(hd1)   /dev/sdb

SUPER IMPORTANT NOTICE
======================

If you are using GRUB Legacy 0.97 in CentOS 6.10, please DO NOT use
/boot/grub/grub.cfg as provided by
Petros Koutoupis at Linux Journal. /boot/grub/grub.cfg as provided by
Petros is meant for GRUB2 only.

029. Rename /boot/grub/grub.cfg

mv /boot/grub/grub.cfg /boot/grub/grub.cfg.bak

030. Create Grub Legacy 0.97 Configuration File /boot/grub/menu.lst

031. The contents of /boot/grub/menu.lst are as follows:

default 0
timeout 60

title Teo En Ming Extremely Simple Linux 1810.11
root (hd0,0)
kernel /boot/vmlinuz-4.18.12 root=/dev/sda1 ro quiet

032. Run grub-install again.

# grub-install --root-directory=/home/teoenming/tmp /dev/sdb

*This will create a symbolic link /boot/grub/grub.conf which points to
/boot/grub/menu.lst*

033. Reboot Teo En Ming Extremely Simple Linux 1810.11. You will see
Grub Legacy 0.97 operating system selection menu
showing up now.

034. Congratulations! I have solved all the problems and I have
successfully created a custom minimal Linux distribution which looks a
bit like MS-DOS. Please watch my YouTube video(s).

===BEGIN SIGNATURE===

Turritopsis Dohrnii Teo En Ming's Academic Qualifications as at 30 Oct 2017

[1] https://tdtemcerts.wordpress.com/

[2] http://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

===END SIGNATURE===
