Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527A9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2272175B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438168AbfBNSra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:47:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404249AbfBNSr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:47:29 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EIcw1d121912
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 13:47:29 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qnbxv078n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 13:47:28 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 14 Feb 2019 18:47:26 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Feb 2019 18:47:22 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1EIlLWG55967832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Feb 2019 18:47:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BC754C046;
        Thu, 14 Feb 2019 18:47:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4710D4C04A;
        Thu, 14 Feb 2019 18:47:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.92.228])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Feb 2019 18:47:20 +0000 (GMT)
Subject: Re: [PATCH v2] x86/ima: require signed kernel modules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Date:   Thu, 14 Feb 2019 13:47:09 -0500
In-Reply-To: <20190214175823.GG11489@garbanzo.do-not-panic.com>
References: <1550060279-8624-1-git-send-email-zohar@linux.ibm.com>
         <20190214175823.GG11489@garbanzo.do-not-panic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021418-0028-0000-0000-00000348A777
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021418-0029-0000-0000-00002406D47C
Message-Id: <1550170029.4107.29.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-14 at 09:58 -0800, Luis Chamberlain wrote:
> On Wed, Feb 13, 2019 at 07:17:59AM -0500, Mimi Zohar wrote:
> > Require signed kernel modules on systems with secure boot mode enabled.
> > 
> > Requiring appended kernel module signatures may be configured, enabled
> > on the boot command line, or with this patch enabled in secure boot
> > mode.
> 
> But only if IMA is enabled?

The patch subject line indicates this is for IMA, but sure I can amend
the patch description, making it clearer.

> If so, should this statement be true if
> IMA is disabled?

This patch coordinates the PE and IMA signatures so that both
signature types aren't required.  Only if
"CONFIG_KEXEC_VERIFY_SIGNATURE" is not enabled, is an IMA policy rule
defined.  A custom IMA policy can still define an IMA kexec rule,
requiring an IMA signature, even if the PE signature is required.

For the case when IMA is disabled and PE signatures are required, then
there isn't a problem.  The issue is when neither signature
verification method is enabled.  I'll leave that for someone else to
address.

> 
> Either way, this is not clear from the commit log and code, can the
> commit log be clear if set_module_sig_enforced() will be set if
> IMA is disabled but secure boot mode enabled?
> 
> > This patch defines set_module_sig_enforced().
> > 
> > To coordinate between appended kernel module signatures and IMA
> > signatures, only define an IMA MODULE_CHECK policy rule if
> > CONFIG_MODULE_SIG is not enabled.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> > 
> > Changelog:
> > - Removed new "sig_required" flag and associated functions, directly set
> >   sig_enforce.
> > 
> >  arch/x86/kernel/ima_arch.c | 9 ++++++++-
> >  include/linux/module.h     | 1 +
> >  kernel/module.c            | 5 +++++
> >  3 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
> > index e47cd9390ab4..3fb9847f1cad 100644
> > --- a/arch/x86/kernel/ima_arch.c
> > +++ b/arch/x86/kernel/ima_arch.c
> > @@ -64,12 +64,19 @@ static const char * const sb_arch_rules[] = {
> >  	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
> >  #endif /* CONFIG_KEXEC_VERIFY_SIG */
> >  	"measure func=KEXEC_KERNEL_CHECK",
> > +#if !IS_ENABLED(CONFIG_MODULE_SIG)
> > +	"appraise func=MODULE_CHECK appraise_type=imasig",
> > +#endif
> > +	"measure func=MODULE_CHECK",
> >  	NULL
> >  };
> >  
> >  const char * const *arch_get_ima_policy(void)
> >  {
> > -	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot())
> > +	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
> > +		if (IS_ENABLED(CONFIG_MODULE_SIG))
> > +			set_module_sig_enforced();
> >  		return sb_arch_rules;
> > +	}
> >  	return NULL;
> >  }
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 8fa38d3e7538..75e2a5c24a2b 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -660,6 +660,7 @@ static inline bool is_livepatch_module(struct module *mod)
> >  #endif /* CONFIG_LIVEPATCH */
> >  
> >  bool is_module_sig_enforced(void);
> > +void set_module_sig_enforced(void);
> >  
> >  #else /* !CONFIG_MODULES... */
> 
> I think you need the !CONFIG_MODULES definition of set_module_sig_enforced()
> then...

Good catch, thanks.

> 
> > diff --git a/kernel/module.c b/kernel/module.c
> > index 2ad1b5239910..4cb5b733fb18 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -286,6 +286,11 @@ bool is_module_sig_enforced(void)
> >  }
> >  EXPORT_SYMBOL(is_module_sig_enforced);
> >  
> > +void set_module_sig_enforced(void)
> > +{
> > +       sig_enforce = true;
> > +}
> 
> The export is not needed as it is bool eh?

IMA is builtin, so it doesn't need to be exported.

Mimi

