Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977D6C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FC020882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FC020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeIMLu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 07:50:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726680AbeIMLu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 07:50:56 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8D6dESj071470
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 02:42:50 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mfhtjt7pe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 02:42:49 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Thu, 13 Sep 2018 07:42:48 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Sep 2018 07:42:45 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8D6gis360227658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Sep 2018 06:42:44 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9F435204E;
        Thu, 13 Sep 2018 09:42:32 +0100 (BST)
Received: from mschwideX1 (unknown [9.145.50.194])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8CBF752051;
        Thu, 13 Sep 2018 09:42:32 +0100 (BST)
Date:   Thu, 13 Sep 2018 08:42:42 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, "Theodore Ts'o" <tytso@mit.edu>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 06/11] compat_ioctl: remove /dev/random commands
In-Reply-To: <CAK8P3a19rCHbtuV65A4rZbUkxHngep44dtitmEM3p99VdWcjdA@mail.gmail.com>
References: <20180908142837.2819693-1-arnd@arndb.de>
        <20180908142837.2819693-6-arnd@arndb.de>
        <20180909041114.GD19965@ZenIV.linux.org.uk>
        <CAK8P3a0+0=P7BDm08iqMWCbB295E8Q0Nwxvj65DNjoF4BqgYQQ@mail.gmail.com>
        <20180912072854.13b4c3b8@mschwideX1>
        <CAK8P3a19rCHbtuV65A4rZbUkxHngep44dtitmEM3p99VdWcjdA@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18091306-0020-0000-0000-000002C5AC2B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091306-0021-0000-0000-00002113060A
Message-Id: <20180913084242.217e6b77@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-13_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809130071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018 16:02:40 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wed, Sep 12, 2018 at 7:29 AM Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> > On Tue, 11 Sep 2018 22:26:54 +0200 Arnd Bergmann <arnd@arndb.de> wrote:  
> > > On Sun, Sep 9, 2018 at 6:12 AM Al Viro <viro@zeniv.linux.org.uk> wrote:  
> 
> > > Out of those, there are only a few that may get used on s390,
> > > in particular at most infiniband/uverbs, nvme, nvdimm,
> > > btrfs, ceph, fuse, fanotify and userfaultfd.
> > > [Note: there are three s390 drivers in the list, which use
> > > a different method: they check in_compat_syscall() from
> > > a shared handler to decide whether to do compat_ptr().  
> >
> > Using in_compat_syscall() seems to be a good solution, no?  
> 
> It works fine for you, but wouldn't work on architecture-independent
> code, since 32-bit architectures generally don't provide
> a compat_ptr() implementation. This could of course
> be changed easily, but after this change it, your drivers
> work just as well with a couple few lines, and more consistent
> with other drivers:
> 
> --- a/drivers/s390/char/sclp_ctl.c
> +++ b/drivers/s390/char/sclp_ctl.c
> @@ -93,12 +93,8 @@ static int sclp_ctl_ioctl_sccb(void __user *user_area)
>  static long sclp_ctl_ioctl(struct file *filp, unsigned int cmd,
>                            unsigned long arg)
>  {
> -       void __user *argp;
> +       void __user *argp = (void __user *)arg;
> 
> -       if (is_compat_task())
> -               argp = compat_ptr(arg);
> -       else
> -               argp = (void __user *) arg;
>         switch (cmd) {
>         case SCLP_CTL_SCCB:
>                 return sclp_ctl_ioctl_sccb(argp);
> @@ -114,7 +110,7 @@ static const struct file_operations sclp_ctl_fops = {
>         .owner = THIS_MODULE,
>         .open = nonseekable_open,
>         .unlocked_ioctl = sclp_ctl_ioctl,
> -       .compat_ioctl = sclp_ctl_ioctl,
> +       .compat_ioctl = generic_compat_ioctl_ptrarg,
>         .llseek = no_llseek,
>  };
> 
> This should probably be separate from the change to using compat_ptr()
> in all other drivers, and I could easily drop this change if you prefer,
> it is meant only as a cosmetic change.

So generic_compat_ioctl_ptrarg will to the compat_ptr thing on the
"unsigned int cmd" argument? Should work just fine.


> > > According to my memory from when I last worked on this,
> > > the compat_ptr() is mainly a safeguard for legacy binaries
> > > that got created with ancient C compilers (or compilers for
> > > something other than C)  and might leave the high bit set
> > > in a pointer, but modern C compilers (gcc-3+) won't ever
> > > do that.  
> >
> > And compat_ptr clears the upper 32-bit of the register. If
> > the register is loaded to e.g. "lr" or "l" there will be
> > junk in the 4 upper bytes.  
> 
> I don't think we hit that problem anywhere: in the ioctl
> argument we pass an 'unsigned long' that has already
> been zero-extended by the compat_sys_ioctl() wrapper,
> while any other usage would get extended by the compiler
> when casting from compat_uptr_t to a 64-bit type.
> This would be different if you had a function call with the
> wrong prototype, i.e. calling a function declared as taking
> an compat_uptr_t, but defining it as taking a void __user*.
> (I suppose that is undefined behavior).

That is true. For the ioctls we have a compat "unsigned int"
or "unsigned long" and the system call wrapper must have cleared
the upper half already. There are a few places where we copy
a data structure from user space, then read a 32-bit pointer
from the structure. These get the compat_ptr treatment as well.
All of those structure definitions should use compat_uptr_t
though, the compiler has to do the zero extension at the time
the 32-bit value is cast to a pointer.

> Unless I'm missing something, compat_ptr() should
> always just clear bit 31. What I'd like to confirm is whether
> you have encountered any code that actually passes
> a pointer with that bit set by a user application in the
> past 15 years. As Al said, it's probably best to just always
> apply the compat_ptr() conversion in each case that s390
> needs it even for drivers that don't run on s390, but I'd also
> like to understand how much it matters in practice.
> (A separate question would be how long we expect to need
> 32 bit compat mode on arch/s390 at all, but for the moment
> I assume this is not up for debate at all).

I don't know if that is worth the risk, yes it should work if
compat_ptr just removes bit 31 and leaves the other bits alone.
But if you have to clear one bit, you can as well remove all
the other bits as well.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

