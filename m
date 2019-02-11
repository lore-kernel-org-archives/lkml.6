Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523CBC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB9721B24
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbfBKQT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:19:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33400 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728126AbfBKQTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:19:25 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1BGEtg5031957
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:19:24 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qkbj1374f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:19:24 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 11 Feb 2019 16:19:21 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Feb 2019 16:19:17 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1BGJG1A43974816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Feb 2019 16:19:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAC6FAE045;
        Mon, 11 Feb 2019 16:19:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85C70AE053;
        Mon, 11 Feb 2019 16:19:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.85])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Feb 2019 16:19:15 +0000 (GMT)
Subject: Re: [PATCH] x86/ima: require signed kernel modules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Justin Forbes <jforbes@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Mon, 11 Feb 2019 11:19:04 -0500
In-Reply-To: <20190211155609.GC20732@linux-8ccs>
References: <1548962339-10681-1-git-send-email-zohar@linux.ibm.com>
         <1548962339-10681-2-git-send-email-zohar@linux.ibm.com>
         <20190211155609.GC20732@linux-8ccs>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021116-0008-0000-0000-000002BF213A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021116-0009-0000-0000-0000222B370A
Message-Id: <1549901944.12743.162.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-11_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902110122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-11 at 16:56 +0100, Jessica Yu wrote:
> +++ Mimi Zohar [31/01/19 14:18 -0500]:
> >Require signed kernel modules on systems with secure boot mode enabled.
> >
> >To coordinate between appended kernel module signatures and IMA
> >signatures, only define an IMA MODULE_CHECK policy rule if
> >CONFIG_MODULE_SIG is not enabled.
> >
> >This patch defines a function named set_module_sig_required() and renames
> >is_module_sig_enforced() to is_module_sig_enforced_or_required().  The
> >call to set_module_sig_required() is dependent on CONFIG_IMA_ARCH_POLICY
> >being enabled.
> >
> >Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> >---
> > arch/x86/kernel/ima_arch.c        |  9 ++++++++-
> > include/linux/module.h            |  7 ++++++-
> > kernel/module.c                   | 15 +++++++++++----
> > security/integrity/ima/ima_main.c |  2 +-
> > 4 files changed, 26 insertions(+), 7 deletions(-)
> >
> >diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
> >index e47cd9390ab4..96a023238a83 100644
> >--- a/arch/x86/kernel/ima_arch.c
> >+++ b/arch/x86/kernel/ima_arch.c
> >@@ -64,12 +64,19 @@ static const char * const sb_arch_rules[] = {
> > 	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
> > #endif /* CONFIG_KEXEC_VERIFY_SIG */
> > 	"measure func=KEXEC_KERNEL_CHECK",
> >+#if !IS_ENABLED(CONFIG_MODULE_SIG)
> >+	"appraise func=MODULE_CHECK appraise_type=imasig",
> >+#endif
> >+	"measure func=MODULE_CHECK",
> > 	NULL
> > };
> >
> > const char * const *arch_get_ima_policy(void)
> > {
> >-	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot())
> >+	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
> >+		if (IS_ENABLED(CONFIG_MODULE_SIG))
> >+			set_module_sig_required();
> > 		return sb_arch_rules;
> >+	}
> > 	return NULL;
> > }
> >diff --git a/include/linux/module.h b/include/linux/module.h
> >index 8fa38d3e7538..af51c8ec755f 100644
> >--- a/include/linux/module.h
> >+++ b/include/linux/module.h
> >@@ -659,7 +659,8 @@ static inline bool is_livepatch_module(struct module *mod)
> > }
> > #endif /* CONFIG_LIVEPATCH */
> >
> >-bool is_module_sig_enforced(void);
> >+bool is_module_sig_enforced_or_required(void);
> >+void set_module_sig_required(void);
> >
> > #else /* !CONFIG_MODULES... */
> >
> >@@ -780,6 +781,10 @@ static inline bool is_module_sig_enforced(void)
> > 	return false;
> > }
> >
> >+static inline void set_module_sig_required(void)
> >+{
> >+}
> >+
> > /* Dereference module function descriptor */
> > static inline
> > void *dereference_module_function_descriptor(struct module *mod, void *ptr)
> >diff --git a/kernel/module.c b/kernel/module.c
> >index 2ad1b5239910..70a9709d19eb 100644
> >--- a/kernel/module.c
> >+++ b/kernel/module.c
> >@@ -275,16 +275,23 @@ static void module_assert_mutex_or_preempt(void)
> >
> > static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
> > module_param(sig_enforce, bool_enable_only, 0644);
> >+static bool sig_required;
> >
> > /*
> >  * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
> >  * on that instead of directly to CONFIG_MODULE_SIG_FORCE config.
> >  */
> >-bool is_module_sig_enforced(void)
> >+bool is_module_sig_enforced_or_required(void)
> > {
> >-	return sig_enforce;
> >+	return sig_enforce || sig_required;
> > }
> 
> Hi Mimi,
> 
> Just wondering, is there any particular reason why a distinction is
> made between sig_enforce and sig_required? Doesn't sig_enforce imply
> that signed modules are required? In other words, why introduce
> another variable instead of just using sig_enforce? It may be
> confusing in the case of a user looking at /sys/module/module/parameters/sig_enforce
> and it having a value of 0 yet module signatures are being required by ima.

Hi Jessica,

It would definitely be a lot better not having to differentiate
between the builtin CONFIG/module parm enforced and runtime enforced.
 For some reason the "lockdown" patch doesn't directly modify
sig_enforce.

Mimi

> 
> >-EXPORT_SYMBOL(is_module_sig_enforced);
> >+EXPORT_SYMBOL(is_module_sig_enforced_or_required);
> >+
> >+void set_module_sig_required(void)
> >+{
> >+	sig_required = true;
> >+}
> >+EXPORT_SYMBOL(set_module_sig_required);
> >
> > /* Block module loading/unloading? */
> > int modules_disabled = 0;
> >@@ -2789,7 +2796,7 @@ static int module_sig_check(struct load_info *info, int flags)
> > 	}
> >
> > 	/* Not having a signature is only an error if we're strict. */
> >-	if (err == -ENOKEY && !is_module_sig_enforced())
> >+	if (err == -ENOKEY && !is_module_sig_enforced_or_required())
> > 		err = 0;
> >
> > 	return err;
> >diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> >index 357edd140c09..bbaf87f688be 100644
> >--- a/security/integrity/ima/ima_main.c
> >+++ b/security/integrity/ima/ima_main.c
> >@@ -563,7 +563,7 @@ int ima_load_data(enum kernel_load_data_id id)
> > 		}
> > 		break;
> > 	case LOADING_MODULE:
> >-		sig_enforce = is_module_sig_enforced();
> >+		sig_enforce = is_module_sig_enforced_or_required();
> >
> > 		if (ima_enforce && (!sig_enforce
> > 				    && (ima_appraise & IMA_APPRAISE_MODULES))) {
> >-- 
> >2.7.5
> >
> 

