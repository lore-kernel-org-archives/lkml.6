Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6FBC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1F920844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfBHONZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:13:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727959AbfBHONY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:13:24 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x18E99bu043151
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 09:13:23 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qhawh1egq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:13:23 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Fri, 8 Feb 2019 14:13:20 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Feb 2019 14:13:15 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x18EDELL50528310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Feb 2019 14:13:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE9FAAE053;
        Fri,  8 Feb 2019 14:13:14 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 781AEAE057;
        Fri,  8 Feb 2019 14:13:12 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.102.1.73])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  8 Feb 2019 14:13:12 +0000 (GMT)
Date:   Fri, 8 Feb 2019 19:43:09 +0530
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Alice Ferrazzi <alicef@alicef.me>, jeyu@kernel.org,
        jikos@kernel.org, mbenes@suse.cz, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: Re: [PATCH v2] livepatch: core: Return EOPNOTSUPP instead of ENOSYS
References: <20190204183324.30775-1-alicef@alicef.me>
 <20190205155933.r6ey474lq4m5nlmp@treble>
 <20190206102832.apa7sekkwljo4ejg@pathway.suse.cz>
 <20190208062005.GA21436@JAVRIS.in.ibm.com>
 <20190208093445.zvxkgaummsait5z6@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208093445.zvxkgaummsait5z6@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19020814-4275-0000-0000-0000030D1AAE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020814-4276-0000-0000-0000381B26E4
Message-Id: <20190208141309.GA2215@JAVRIS.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=968 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 10:34:45AM +0100, Petr Mladek wrote:
> On Fri 2019-02-08 11:50:05, Kamalesh Babulal wrote:
> > On Wed, Feb 06, 2019 at 11:28:32AM +0100, Petr Mladek wrote:
> > > On Tue 2019-02-05 09:59:33, Josh Poimboeuf wrote:
> > > > On Tue, Feb 05, 2019 at 03:33:28AM +0900, Alice Ferrazzi wrote:
> > > > > From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > > > > 
> > > > > As a result of an unsupported operation is better to use EOPNOTSUPP
> > > > > as error code.
> > > > > ENOSYS is only used for 'invalid syscall nr' and nothing else.
> > > > > 
> > > > > Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > > > 
> > > > Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > 
> > > I have applied the patch into for-5.1/atomic-replace branch.

[...]

> > After removal of the immediate flag by
> > commit d0807da78e11 ("livepatch: Remove immediate feature"), every
> > architecture enabling livepatching is required to have implemented
> > reliable stack trace.  Is it a better idea to make
> > HAVE_RELIABLE_STACKTRACE a config dependency, which will disable
> > livepatching support for architectures without reliable stack trace
> > function during kernel build?
> > 
> > The idea is to remove klp_have_reliable_stack() by moving
> > CONFIG_HAVE_RELIABLE_STACKTRACE as a config dependency to Kconfig
> > file
> 
> Looks like a nice cleanup.

Thanks

> 
> > and adding the other CONFIG_STACKTRACE as a config dependency is not
> > required, as it's selected via CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > dependency chain. With the patch on architecture without
> > HAVE_RELIABLE_STACKTRACE, the user should see:
> 
> Hmm, I see the following in kernel/trace/Kconfig:
> 
> config TRACING
> [...]
> 	select STACKTRACE if STACKTRACE_SUPPORT
> 
> It seems that the depency is not guaranted. Or do I miss anything?

I should have tried drawing the config dependency of CONFIG_STACKTRACE
in the mail.  It would saved me from nagivating wrong indirections in
tricky Kconfigs. You are right, CONFIG_STACKTRACE is not selected via
CONFIG_DYNAMIC_FTRACE_WITH_REGS config dependency chain.

> 
> Anyway, it is pretty indirect. I would prefer to add dependency
> on STACKTRACE explicitly into config LIVEPATCH.

Agree, explicitly listing CONFIG_STACKTRACE as one of the dependencies
under config LIVEPATCH will guarantee the dependency is met.  On the
curious note, digging through the git logs, CONFIG_STACKTRACE_SUPPORT
is enabled by default on x86/PowerPC for quite long now.

Thanks,
Kamalesh

