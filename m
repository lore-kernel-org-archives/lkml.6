Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40694C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC76217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfBHNW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:22:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47512 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727377AbfBHNW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:22:58 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x18DGCjE086861
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 08:22:56 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qh854f59u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 08:22:56 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Fri, 8 Feb 2019 13:22:54 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Feb 2019 13:22:51 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x18DMoC359113596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Feb 2019 13:22:50 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E79ED42047;
        Fri,  8 Feb 2019 13:22:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8430B4203F;
        Fri,  8 Feb 2019 13:22:45 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.102.1.73])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  8 Feb 2019 13:22:45 +0000 (GMT)
Date:   Fri, 8 Feb 2019 18:52:38 +0530
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Petr Mladek <pmladek@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alice Ferrazzi <alicef@alicef.me>, jeyu@kernel.org,
        jikos@kernel.org, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: Re: [PATCH v2] livepatch: core: Return EOPNOTSUPP instead of ENOSYS
References: <20190204183324.30775-1-alicef@alicef.me>
 <20190205155933.r6ey474lq4m5nlmp@treble>
 <20190206102832.apa7sekkwljo4ejg@pathway.suse.cz>
 <20190208062005.GA21436@JAVRIS.in.ibm.com>
 <alpine.LSU.2.21.1902081013100.24868@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1902081013100.24868@pobox.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19020813-0020-0000-0000-000003146E20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020813-0021-0000-0000-000021657D64
Message-Id: <20190208132238.GA32656@JAVRIS.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miroslav,

On Fri, Feb 08, 2019 at 10:24:21AM +0100, Miroslav Benes wrote:
> Hi Kamalesh,
> 
> On Fri, 8 Feb 2019, Kamalesh Babulal wrote:
> 
> > On Wed, Feb 06, 2019 at 11:28:32AM +0100, Petr Mladek wrote:
> > > On Tue 2019-02-05 09:59:33, Josh Poimboeuf wrote:
> > > > On Tue, Feb 05, 2019 at 03:33:28AM +0900, Alice Ferrazzi wrote:
> > > > > From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > > > > 
> > > > > As a result of an unsupported operation is better to use EOPNOTSUPP
> > > > > as error code.
> > > > > ENOSYS is only used for 'invalid syscall nr' and nothing else.

[...]

> > After removal of the immediate flag by
> > commit d0807da78e11 ("livepatch: Remove immediate feature"), every
> > architecture enabling livepatching is required to have implemented
> > reliable stack trace.  Is it a better idea to make
> > HAVE_RELIABLE_STACKTRACE a config dependency, which will disable
> > livepatching support for architectures without reliable stack trace
> > function during kernel build?
> 
> if I am not mistaken, s390x is currently the only one which is supported 
> (the redirection works) but has no reliable stacktraces (so far, it is my 
> plan to take a look soon).
> 
> Theoretically, it could still work. We have the fake signal and we can 
> force the remaining tasks (kthreads). It is not something to be used in 
> production but it could make sense for a limited testing.

That was my understanding too, s390 doesn't set HAVE_RELIABLE_STACKTRACE.

(below output is right trimmed for readability)

arch $ find . -name 'Kconfig'|xargs egrep -an "HAVE_LIVEPATCH"                                                                                                                                                                               
./powerpc/Kconfig:209:  select HAVE_LIVEPATCH ...
./x86/Kconfig:171:      select HAVE_LIVEPATCH ...
./s390/Kconfig:161:     select HAVE_LIVEPATCH

arch $ find . -name 'Kconfig'|xargs egrep -an "HAVE_RELIABLE_STACKTRACE"                                                                                                                                                                     
./powerpc/Kconfig:223:  select HAVE_RELIABLE_STACKTRACE ...
./x86/Kconfig:189:      select HAVE_RELIABLE_STACKTRACE ...
./Kconfig:690:config HAVE_RELIABLE_STACKTRACE

klp_have_reliable_stack() will guard against loading of livepatching
module on s390, for the same reason being that HAVE_RELIABLE_STACKTRACE
is not set. My explanation is purely based on the above grep output
on Kconfig files, which might be partial. Am I missing something here?

> > The idea is to remove klp_have_reliable_stack() by moving
> > CONFIG_HAVE_RELIABLE_STACKTRACE as a config dependency to Kconfig file
> > and adding the other CONFIG_STACKTRACE as a config dependency is not
> > required, as it's selected via CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > dependency chain. With the patch on architecture without
> > HAVE_RELIABLE_STACKTRACE, the user should see:

[...]

> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index fe1993399823..9a80f7574d75 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -1002,12 +1002,6 @@ int klp_enable_patch(struct klp_patch *patch)
> >         if (!klp_initialized())
> >                 return -ENODEV;
> >  
> > -       if (!klp_have_reliable_stack()) {
> > -               pr_err("This architecture doesn't have support for the livepatch consistency model.\n");
> > -               return -ENOSYS;
> > -       }
> > -
> > -
> >         mutex_lock(&klp_mutex);
> >  
> >         ret = klp_init_patch_early(patch);
> 
> On the other hand, I like this change. So we have two options, I think. 
> We can apply this and wait if someone complains (because of s390x 
> testing), or we can wait for the full support of s390x and then enforce 
> it.

Thanks, I am ok with either of the options.  We could enforce the config
dependency, in case the above assumption in regard to s390 is correct.

Thanks,
Kamalesh

