Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0482C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E4F20833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E4F20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeILKbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 06:31:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726073AbeILKbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 06:31:52 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8C5NhIj119549
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:29:02 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2meqxw16yy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:29:02 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Wed, 12 Sep 2018 06:29:00 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Sep 2018 06:28:57 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8C5Suxd53084372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Sep 2018 05:28:56 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43F46A405B;
        Wed, 12 Sep 2018 08:28:45 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02E04A4051;
        Wed, 12 Sep 2018 08:28:45 +0100 (BST)
Received: from mschwideX1 (unknown [9.145.38.104])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 12 Sep 2018 08:28:44 +0100 (BST)
Date:   Wed, 12 Sep 2018 07:28:54 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, "Theodore Ts'o" <tytso@mit.edu>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 06/11] compat_ioctl: remove /dev/random commands
In-Reply-To: <CAK8P3a0+0=P7BDm08iqMWCbB295E8Q0Nwxvj65DNjoF4BqgYQQ@mail.gmail.com>
References: <20180908142837.2819693-1-arnd@arndb.de>
        <20180908142837.2819693-6-arnd@arndb.de>
        <20180909041114.GD19965@ZenIV.linux.org.uk>
        <CAK8P3a0+0=P7BDm08iqMWCbB295E8Q0Nwxvj65DNjoF4BqgYQQ@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18091205-0028-0000-0000-000002F80577
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091205-0029-0000-0000-000023B1A285
Message-Id: <20180912072854.13b4c3b8@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809120058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018 22:26:54 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Sun, Sep 9, 2018 at 6:12 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Sat, Sep 08, 2018 at 04:28:12PM +0200, Arnd Bergmann wrote:  
> > > These are all handled by the random driver, so instead of listing
> > > each ioctl, we can just use the same function to deal with both
> > > native and compat commands.  
> >
> > Umm...  I don't think it's right -
> >  
> > >       .unlocked_ioctl = random_ioctl,
> > > +     .compat_ioctl = random_ioctl,  
> >
> >  
> > ->compat_ioctl() gets called in  
> >                         error = f.file->f_op->compat_ioctl(f.file, cmd, arg);
> > so you do *NOT* get compat_ptr() for those - they have to do it on their
> > own.  It's not hard to provide a proper compat_ioctl() instance for that
> > one, but this is not it.  What you need in drivers/char/random.c part of
> > that one is something like  
> 
> Looping in some s390 folks.
> 
> As you suggested in another reply, I had a look at what other drivers
> do the same thing and have only pointer arguments. I created a
> patch to move them all over to using a new helper function that
> adds the compat_ptr(), and arrived at
> 
>  drivers/android/binder.c                    | 2 +-
>  drivers/crypto/qat/qat_common/adf_ctl_drv.c | 2 +-
>  drivers/dma-buf/dma-buf.c                   | 4 +---
>  drivers/dma-buf/sw_sync.c                   | 2 +-
>  drivers/dma-buf/sync_file.c                 | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c    | 2 +-
>  drivers/hid/hidraw.c                        | 4 +---
>  drivers/iio/industrialio-core.c             | 2 +-
>  drivers/infiniband/core/uverbs_main.c       | 4 ++--
>  drivers/media/rc/lirc_dev.c                 | 4 +---
>  drivers/mfd/cros_ec_dev.c                   | 4 +---
>  drivers/misc/vmw_vmci/vmci_host.c           | 2 +-
>  drivers/nvdimm/bus.c                        | 4 ++--
>  drivers/nvme/host/core.c                    | 6 +++---
>  drivers/pci/switch/switchtec.c              | 2 +-
>  drivers/platform/x86/wmi.c                  | 2 +-
>  drivers/rpmsg/rpmsg_char.c                  | 4 ++--
>  drivers/s390/char/sclp_ctl.c                | 8 ++------
>  drivers/s390/char/vmcp.c                    | 2 ++----
>  drivers/s390/cio/chsc_sch.c                 | 8 ++------
>  drivers/sbus/char/display7seg.c             | 2 +-
>  drivers/sbus/char/envctrl.c                 | 4 +---
>  drivers/scsi/3w-xxxx.c                      | 4 +---
>  drivers/scsi/cxlflash/main.c                | 2 +-
>  drivers/scsi/esas2r/esas2r_main.c           | 2 +-
>  drivers/scsi/pmcraid.c                      | 4 +---
>  drivers/staging/android/ion/ion.c           | 4 +---
>  drivers/staging/vme/devices/vme_user.c      | 2 +-
>  drivers/tee/tee_core.c                      | 2 +-
>  drivers/usb/class/cdc-wdm.c                 | 2 +-
>  drivers/usb/class/usbtmc.c                  | 4 +---
>  drivers/video/fbdev/ps3fb.c                 | 2 +-
>  drivers/video/fbdev/sis/sis_main.c          | 4 +---
>  drivers/virt/fsl_hypervisor.c               | 2 +-
>  fs/btrfs/super.c                            | 2 +-
>  fs/ceph/dir.c                               | 2 +-
>  fs/ceph/file.c                              | 2 +-
>  fs/fuse/dev.c                               | 2 +-
>  fs/notify/fanotify/fanotify_user.c          | 2 +-
>  fs/userfaultfd.c                            | 2 +-
>  net/rfkill/core.c                           | 2 +-
>  41 files changed, 48 insertions(+), 76 deletions(-)
> 
> Out of those, there are only a few that may get used on s390,
> in particular at most infiniband/uverbs, nvme, nvdimm,
> btrfs, ceph, fuse, fanotify and userfaultfd.
> [Note: there are three s390 drivers in the list, which use
> a different method: they check in_compat_syscall() from
> a shared handler to decide whether to do compat_ptr().

Using in_compat_syscall() seems to be a good solution, no?

> According to my memory from when I last worked on this,
> the compat_ptr() is mainly a safeguard for legacy binaries
> that got created with ancient C compilers (or compilers for
> something other than C)  and might leave the high bit set
> in a pointer, but modern C compilers (gcc-3+) won't ever
> do that.

And compat_ptr clears the upper 32-bit of the register. If
the register is loaded to e.g. "lr" or "l" there will be
junk in the 4 upper bytes.

> You are probably right about /dev/random, which could be
> used in lots of weird code, but I wonder to what degree we
> need to worry about it for the rest.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

