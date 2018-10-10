Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5200EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE1E20841
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YerLm2gH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE1E20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJJMpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 08:45:39 -0400
Received: from mail-yb1-f171.google.com ([209.85.219.171]:46258 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJJMpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 08:45:39 -0400
Received: by mail-yb1-f171.google.com with SMTP id o8-v6so1699590ybk.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 22:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qpauH2OdO0vX79ag75hJS1KXY58Zib7JCOgS2Nuf8x4=;
        b=YerLm2gH4qWeWONV3z8gnp/70EwN6IW8miW66ITYtEtrQQF3GfrO8HFDttXFwY6HQi
         cxETcy90SS4NMYLdG0wa2kzHIYaxwF47HJWmv80p4n6eoT9B2uHNPGt1UoIMBIhlyGdx
         N1XGk+eTSgHyiFb7egK6HnmthINUgwXId4F3O6FpoiJFTPSDqOMgbqYX8aHRZi2o5gy5
         VGwNJY2PSiB7fBae+D68gynZUrOba1a7qRq6VCbqplzaOiI961mDQjqmS2Xc+eSjpyqR
         s0tfmwRH1i7Nq4CNHrBTSqYVJCNCc38GP1jKBZ9Q7axbZD4rLe1O3mdyPAR4we8RbYLe
         awzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qpauH2OdO0vX79ag75hJS1KXY58Zib7JCOgS2Nuf8x4=;
        b=AndpsmcI6mH6DGDtXszfQOrQJ5SVljL+LiwCYdQDhFzEoUT5X/EA0z3PPIDCyWE3OT
         M6DLn33/yXONnNGQmE3b5y6+kIN+fVn/MQ7m3DI1Z6/5Lb6OigLhVQ7p8lYsmL3Q+Rqc
         CfyG1Ka4plU0gWzsW/Knixdi34HmMjFcG0xh1A8ZzT2VLGe5PGuFeewL1GgfT+XNDcYK
         zlxm7984p9kENTQmSEVUuL8+kYtTrV6EkL6skPIrRBus69sjyswAChO5sDPRmpiLtWQE
         3TbBYHCrbT3cHXaL/YqGRY2Mqywi3O2IyKcaa8QmKcjXBfn9/pn1jh2EIH9Bzxv8TneN
         8d0g==
X-Gm-Message-State: ABuFfogdiO4A6lxINPwoLRsVpViHj62WtYhTKy+/pHjdqrhE3QUzdvyw
        x8LTXUr0qBgNykhXs11wQ6sSd1vmJcWjVofQwJy2BXc=
X-Google-Smtp-Source: ACcGV61P1Wg4K2ADQ5no3UbHbRx+KZkKwSYYCBZgpVtXPgeplJ0TfZfzqOdcCHzQDCnWPu8ktLQ7jqU541CAhukKYL4=
X-Received: by 2002:a25:e80b:: with SMTP id k11-v6mr17598415ybd.415.1539149113395;
 Tue, 09 Oct 2018 22:25:13 -0700 (PDT)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Date:   Wed, 10 Oct 2018 13:26:23 +0800
Message-ID: <CANnei0GriNpF1dVWD2j1z_iNbr=2Aip08FmPmTnXEu6EU-gQ8g@mail.gmail.com>
Subject: Installation Notes for Teo En Ming Extremely Simple Linux 1810.08
To:     linux-kernel@vger.kernel.org
Cc:     Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Installation Notes for Teo En Ming Extremely Simple Linux 1810.08
=================================================================

Definitely must watch YouTube video: https://www.youtube.com/watch?v=YrJADssqaQU

Author: Mr. Turritopsis Dohrnii Teo En Ming
Country: Singapore

Start: 8th October 2018 Monday 10:00 PM Singapore Time GMT+8
End: 9th October 2018 Tuesday 2:30 AM Singapore Time GMT+8

NOTE: Compiling a Linux operating system on Intel Core i7-5820K (6
cores) will take
approximately 4.5 hours.

Steps
=====

001. Download CentOS 7.5 1804 from the mirror at National University
of Singapore (NUS)
http://mirror.nus.edu.sg/centos/7.5.1804/isos/x86_64/CentOS-7-x86_64-DVD-1804.iso

002. Install CentOS 7.5 1804 as an Oracle VirtualBox 5.2.18 virtual
machine in Windows 10 version 1803 host operating system.

003. During Software Selection, choose *Development and Creative
Workstation*. This is mandatory for compiling software and
operating systems.

004. Click Additional Development.

005. Click Development Tools.

006. Click Perl for Web.

007. Click Platform Development.

008. Click Done.

009. After completing installation, login to CentOS 7.5 1804 using Putty.

010. Search for gcc (GNU Compiler Collection).

[teoenming@centos ~]$ rpm -qa | grep gcc
gcc-4.8.5-28.el7.x86_64
gcc-c++-4.8.5-28.el7.x86_64
gcc-gfortran-4.8.5-28.el7.x86_64
libgcc-4.8.5-28.el7.x86_64

011. Search for make.

[teoenming@centos ~]$ rpm -qa | grep make
make-3.82-23.el7.x86_64
automake-1.13.4-3.el7.noarch
cmake-2.8.12.2-2.el7.x86_64

012. Search for ncurses.

[teoenming@centos ~]$ rpm -qa | grep ncurses
ncurses-base-5.9-14.20130511.el7_4.noarch
ncurses-devel-5.9-14.20130511.el7_4.x86_64
ncurses-5.9-14.20130511.el7_4.x86_64
ncurses-libs-5.9-14.20130511.el7_4.x86_64

013. Search for perl.

[teoenming@centos ~]$ rpm -qa | grep perl
<Super long list...snipped>

014. Search for grub (Grand Unified Boot Loader).

[root@centos ~]# rpm -qa | grep grub
grub2-pc-modules-2.02-0.65.el7.centos.2.noarch
grubby-8.28-23.el7.x86_64
grub2-2.02-0.65.el7.centos.2.x86_64
grub2-common-2.02-0.65.el7.centos.2.noarch
grub2-tools-minimal-2.02-0.65.el7.centos.2.x86_64
grub2-tools-extra-2.02-0.65.el7.centos.2.x86_64
grub2-tools-2.02-0.65.el7.centos.2.x86_64
grub2-pc-2.02-0.65.el7.centos.2.x86_64

***Apparently GRUB Legacy 0.97 has been deprecated on CentOS 7.5.
GRUB2 is now installed by default on CentOS 7.5.***

015. Download the latest binutils-2.31

wget https://ftp.gnu.org/gnu/binutils/binutils-2.31.tar.xz

016. Download the latest busybox-1.29.3

wget https://busybox.net/downloads/busybox-1.29.3.tar.bz2

017. Download the latest Cross Linux From Scratch (CLFS) Bootscripts

wget http://ftp.osuosl.org/pub/clfs/conglomeration/clfs-embedded-bootscripts/clfs-embedded-bootscripts-1.0-pre5.tar.bz2

018. Download the latest GNU Compiler Collection (gcc) version 8.2.0

wget https://ftp.gnu.org/gnu/gcc/gcc-8.2.0/gcc-8.2.0.tar.xz

019. Download the latest C Programming Library version 2.28

wget https://ftp.gnu.org/gnu/glibc/glibc-2.28.tar.xz

020. Download the latest gmp-6.1.2

wget https://ftp.gnu.org/gnu/gmp/gmp-6.1.2.tar.bz2

021. Download the latest Linux Kernel version 4.18.12 (stable branch)

wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.18.12.tar.xz

022. Download the latest mpc-1.1.0

wget https://ftp.gnu.org/gnu/mpc/mpc-1.1.0.tar.gz

023. Download the latest mpfr-4.0.1

wget https://ftp.gnu.org/gnu/mpfr/mpfr-4.0.1.tar.xz

024. Download the latest zlib-1.2.11

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

At "The Bootscripts" section, modify Makefile in the root directory as follows.
You *CANNOT* copy and paste the following code section into a
patchfile and use the patch command
patch -p0 <patchfile

@@ -19,7 +19,9 @@ dist:
        rm -rf "dist/clfs-embedded-bootscripts-$(VERSION)"

 create-dirs:
-       install -d -m ${DIRMODE} ${EXTDIR}/rc.d/{init.d,start,stop}
+       install -d -m ${DIRMODE} ${EXTDIR}/rc.d/init.d
+       install -d -m ${DIRMODE} ${EXTDIR}/rc.d/start
+       install -d -m ${DIRMODE} ${EXTDIR}/rc.d/stop

 install-bootscripts: create-dirs
        install -m ${CONFMODE} clfs/rc.d/init.d/functions ${EXTDIR}/rc.d/init.d/

Now it is time to install the target image.

At the section on "Installing the Target Image", we *CANNOT* use the
grub-install command since GRUB Legacy 0.97
has been deprecated on CentOS 7.5. GRUB2 is installed by default on CentOS 7.5.

Since I am no expert on the Grand Unified Boot Loader (GRUB), I am
going to use the GRUB2 grub2-install command.

028. grub2-install --root-directory=/home/teoenming/tmp/ /dev/sdb

/dev/sdb is another virtual harddisk in Oracle Virtualbox 5.2.18.

Although GRUB2 is installed in Teo En Ming Extremely Simple Linux
1810.08, I am not seeing any operating system selection menu.
This is because /boot/grub/grub.cfg as seen in Petros' instructions is
defined for GRUB Legacy 0.97 only.
You will see a grub> prompt instead.

At the grub> prompt, execute the following commands.

grub> linux /boot/vmlinuz-4.18.12 root=/dev/sda1 ro quiet
grub> boot

Teo En Ming Extremely Simple Linux 1810.08 will now boot up.

Please watch my YouTube video at https://www.youtube.com/watch?v=YrJADssqaQU

Question: Should I use CentOS 6 as my development workstation instead?
This is because CentOS 6 will definitely have GRUB Legacy.


===BEGIN SIGNATURE===

Turritopsis Dohrnii Teo En Ming's Academic Qualifications as at 30 Oct 2017

[1] https://tdtemcerts.wordpress.com/

[2] http://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

===END SIGNATURE===
