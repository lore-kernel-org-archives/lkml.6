Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0D2C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 06:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD2B21917
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 06:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfBHGUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 01:20:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbfBHGUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 01:20:21 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x186J8x6021611
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 01:20:20 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qh3n0hrak-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 01:20:20 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Fri, 8 Feb 2019 06:20:18 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Feb 2019 06:20:14 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x186KDrS9044296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Feb 2019 06:20:13 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08E4411C04A;
        Fri,  8 Feb 2019 06:20:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F94C11C050;
        Fri,  8 Feb 2019 06:20:11 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.124.35.53])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  8 Feb 2019 06:20:11 +0000 (GMT)
Date:   Fri, 8 Feb 2019 11:50:05 +0530
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206102832.apa7sekkwljo4ejg@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19020806-0016-0000-0000-00000253EC57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020806-0017-0000-0000-000032ADFDB0
Message-Id: <20190208062005.GA21436@JAVRIS.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902080046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 11:28:32AM +0100, Petr Mladek wrote:
> On Tue 2019-02-05 09:59:33, Josh Poimboeuf wrote:
> > On Tue, Feb 05, 2019 at 03:33:28AM +0900, Alice Ferrazzi wrote:
> > > From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > > 
> > > As a result of an unsupported operation is better to use EOPNOTSUPP
> > > as error code.
> > > ENOSYS is only used for 'invalid syscall nr' and nothing else.
> > > 
> > > Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > 
> > Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> I have applied the patch into for-5.1/atomic-replace branch.

Sorry to jump into the discussion so late. Thinking a little more about
the check itself, previously with immediate flag an architecture can do
livepatching with limitations and without the reliable stack trace
implemented yet.

After removal of the immediate flag by
commit d0807da78e11 ("livepatch: Remove immediate feature"), every
architecture enabling livepatching is required to have implemented
reliable stack trace.  Is it a better idea to make
HAVE_RELIABLE_STACKTRACE a config dependency, which will disable
livepatching support for architectures without reliable stack trace
function during kernel build?

The idea is to remove klp_have_reliable_stack() by moving
CONFIG_HAVE_RELIABLE_STACKTRACE as a config dependency to Kconfig file
and adding the other CONFIG_STACKTRACE as a config dependency is not
required, as it's selected via CONFIG_DYNAMIC_FTRACE_WITH_REGS
dependency chain. With the patch on architecture without
HAVE_RELIABLE_STACKTRACE, the user should see:

# insmod ./livepatch-sample.ko 
insmod: ERROR: could not insert module ./livepatch-sample.ko: Invalid module format

# dmesg
...
[  286.453463] livepatch_sample: module is marked as livepatch module, but livepatch support is disabled

I have done limited testing on PowerPC and to test the unsupported case,
the config dependency HAVE_RELIABLE_STACKTRACE was misspelled in Kconfig
file. If the idea sounds ok I will send a formal patch.

-------8<----------------------------

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 53551f470722..7848c7bbffbb 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -214,12 +214,6 @@ static inline bool klp_patch_pending(struct task_struct *task)
        return test_tsk_thread_flag(task, TIF_PATCH_PENDING);
 }
 
-static inline bool klp_have_reliable_stack(void)
-{
-       return IS_ENABLED(CONFIG_STACKTRACE) &&
-              IS_ENABLED(CONFIG_HAVE_RELIABLE_STACKTRACE);
-}
-
 typedef int (*klp_shadow_ctor_t)(void *obj,
                                 void *shadow_data,
                                 void *ctor_data);
diff --git a/kernel/livepatch/Kconfig b/kernel/livepatch/Kconfig
index ec4565122e65..16b3692ddf9f 100644
--- a/kernel/livepatch/Kconfig
+++ b/kernel/livepatch/Kconfig
@@ -9,6 +9,7 @@ config LIVEPATCH
        depends on MODULES
        depends on SYSFS
        depends on KALLSYMS_ALL
+       depends on HAVE_RELIABLE_STACKTRACE
        depends on HAVE_LIVEPATCH
        depends on !TRIM_UNUSED_KSYMS
        help
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index fe1993399823..9a80f7574d75 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1002,12 +1002,6 @@ int klp_enable_patch(struct klp_patch *patch)
        if (!klp_initialized())
                return -ENODEV;
 
-       if (!klp_have_reliable_stack()) {
-               pr_err("This architecture doesn't have support for the livepatch consistency model.\n");
-               return -ENOSYS;
-       }
-
-
        mutex_lock(&klp_mutex);
 
        ret = klp_init_patch_early(patch);

