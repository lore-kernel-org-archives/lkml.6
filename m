Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA1BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4567820672
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbeLQMmI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:42:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732170AbeLQMmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:42:03 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBHCclnB005278
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:42:02 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pea1tnkhc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:42:02 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Mon, 17 Dec 2018 12:41:59 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Dec 2018 12:41:57 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBHCfuZE7799282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Dec 2018 12:41:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2C735204E;
        Mon, 17 Dec 2018 12:41:55 +0000 (GMT)
Received: from osiris (unknown [9.152.212.95])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id B64755204F;
        Mon, 17 Dec 2018 12:41:55 +0000 (GMT)
Date:   Mon, 17 Dec 2018 13:41:54 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        prudo@linux.vnet.ibm.com, linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org
Subject: Re: [PATCH] seccomp, s390: fix build for syscall type change
References: <20181213201030.4072-1-tycho@tycho.ws>
 <CAGXu5jLY16CjNZZ0QvkyaKep-qD8kEVZEnTQ7JqfozqAm=so_Q@mail.gmail.com>
In-Reply-To: <CAGXu5jLY16CjNZZ0QvkyaKep-qD8kEVZEnTQ7JqfozqAm=so_Q@mail.gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 18121712-0016-0000-0000-00000237AB43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121712-0017-0000-0000-0000328FF4C0
Message-Id: <20181217124154.GA3560@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812170116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 04:50:06PM -0800, Kees Cook wrote:
> On Thu, Dec 13, 2018 at 12:10 PM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > A recent patch landed in the security tree [1] that changed the type of the
> > seccomp syscall. Unfortunately, I didn't quite get every instance of the
> > forward declarations, and thus there is a build failure. Here's the last
> > one that I could find, for s390. It should go through the security tree,
> > although hopefully some s390 people can check and make sure it looks
> > reasonable?
> >
> > The only oddity is the trailing semicolon; some lines around this patch
> > have it, and some lines don't. I've left this one as-is.
> >
> > [1]: https://lore.kernel.org/lkml/20181212231630.GA31584@beast/T/#u
> >
> > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> 
> Thanks! Added to my -next tree.
> 
> -Kees

Hi Kees,

did you forget to push your tree? At least today's linux-next kernel
fails to compile on s390 because of this missing patch.

> >  arch/s390/kernel/compat_wrapper.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/s390/kernel/compat_wrapper.c b/arch/s390/kernel/compat_wrapper.c
> > index 2ce28bf0c5ec..48c4ce668244 100644
> > --- a/arch/s390/kernel/compat_wrapper.c
> > +++ b/arch/s390/kernel/compat_wrapper.c
> > @@ -164,7 +164,7 @@ COMPAT_SYSCALL_WRAP3(finit_module, int, fd, const char __user *, uargs, int, fla
> >  COMPAT_SYSCALL_WRAP3(sched_setattr, pid_t, pid, struct sched_attr __user *, attr, unsigned int, flags);
> >  COMPAT_SYSCALL_WRAP4(sched_getattr, pid_t, pid, struct sched_attr __user *, attr, unsigned int, size, unsigned int, flags);
> >  COMPAT_SYSCALL_WRAP5(renameat2, int, olddfd, const char __user *, oldname, int, newdfd, const char __user *, newname, unsigned int, flags);
> > -COMPAT_SYSCALL_WRAP3(seccomp, unsigned int, op, unsigned int, flags, const char __user *, uargs)
> > +COMPAT_SYSCALL_WRAP3(seccomp, unsigned int, op, unsigned int, flags, void __user *, uargs)
> >  COMPAT_SYSCALL_WRAP3(getrandom, char __user *, buf, size_t, count, unsigned int, flags)
> >  COMPAT_SYSCALL_WRAP2(memfd_create, const char __user *, uname, unsigned int, flags)
> >  COMPAT_SYSCALL_WRAP3(bpf, int, cmd, union bpf_attr *, attr, unsigned int, size);

