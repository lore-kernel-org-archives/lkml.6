Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36352C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36A22082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfBDXuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:50:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726083AbfBDXuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:50:02 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x14M3eLc103077
        for <linux-kernel@vger.kernel.org>; Mon, 4 Feb 2019 17:05:17 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qevkqavgv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 17:05:17 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 4 Feb 2019 22:05:15 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Feb 2019 22:05:13 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x14M5CZf63504394
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 22:05:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DFD411C052;
        Mon,  4 Feb 2019 22:05:12 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5313E11C04A;
        Mon,  4 Feb 2019 22:05:11 +0000 (GMT)
Received: from dhcp-9-31-103-153.watson.ibm.com (unknown [9.31.103.153])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Feb 2019 22:05:11 +0000 (GMT)
Subject: Re: [PATCH] x86/ima: require signed kernel modules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Justin Forbes <jforbes@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Mon, 04 Feb 2019 17:05:10 -0500
In-Reply-To: <20190204203850.GP11489@garbanzo.do-not-panic.com>
References: <1548962339-10681-1-git-send-email-zohar@linux.ibm.com>
         <1548962339-10681-2-git-send-email-zohar@linux.ibm.com>
         <20190204203850.GP11489@garbanzo.do-not-panic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19020422-0020-0000-0000-0000031193D0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020422-0021-0000-0000-00002162A20B
Message-Id: <1549317910.4146.124.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-04_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902040167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-04 at 12:38 -0800, Luis Chamberlain wrote:
> On Thu, Jan 31, 2019 at 02:18:59PM -0500, Mimi Zohar wrote:
> > diff --git a/kernel/module.c b/kernel/module.c
> > index 2ad1b5239910..70a9709d19eb 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -275,16 +275,23 @@ static void module_assert_mutex_or_preempt(void)
> >  
> >  static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
> >  module_param(sig_enforce, bool_enable_only, 0644);
> > +static bool sig_required;
> >  
> >  /*
> >   * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
> >   * on that instead of directly to CONFIG_MODULE_SIG_FORCE config.
> 
> But the docs were't updated.

Neither "CONFIG_MODULE_SIG_FORCE" nor "module.sig_enforce" has
changed.  Which docs are you referring to? 

> 
> >   */
> > -bool is_module_sig_enforced(void)
> > +bool is_module_sig_enforced_or_required(void)
> >  {
> > -	return sig_enforce;
> > +	return sig_enforce || sig_required;
> >  }
> > -EXPORT_SYMBOL(is_module_sig_enforced);
> > +EXPORT_SYMBOL(is_module_sig_enforced_or_required);
> 
> Meh, this is getting sloppy, the module signing infrastructure should
> just be LSM'ified now that we have stacked LSMs. That would
> compartamentaliz that code and make this much easier to read / understand
> and mantain.
> 
> Can you take a look at doing it that way instead?

This patch is about coordinating the existing methods of verifying
kernel module signatures.

> 
> > +
> > +void set_module_sig_required(void)
> > +{
> > +	sig_required = true;
> > +}
> > +EXPORT_SYMBOL(set_module_sig_required);
> 
> Since this is a *new* symbol, not yet used, and only used by IMA I'd
> prefer this to be EXPORT_SYMBOL_GPL().

Oops, this function shouldn't be exported.

> 
> >  /* Block module loading/unloading? */
> >  int modules_disabled = 0;
> > @@ -2789,7 +2796,7 @@ static int module_sig_check(struct load_info *info, int flags)
> >  	}
> >  
> >  	/* Not having a signature is only an error if we're strict. */
> > -	if (err == -ENOKEY && !is_module_sig_enforced())
> > +	if (err == -ENOKEY && !is_module_sig_enforced_or_required())
> 
> This is where I think a proper LSM hook would make sense. I think
> that these "questions" model for signing don't work well on the LSM
> hook model, perhaps just:
> 
> kernel_module_signed()
> 
> Suffices, therefore if not enforced or required its signed. If its
> enforced or required and really signed, then it signed.
> 
> >  		err = 0;
> >  
> >  	return err;
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 357edd140c09..bbaf87f688be 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -563,7 +563,7 @@ int ima_load_data(enum kernel_load_data_id id)
> >  		}
> >  		break;
> >  	case LOADING_MODULE:
> > -		sig_enforce = is_module_sig_enforced();
> > +		sig_enforce = is_module_sig_enforced_or_required();
> 
> Yet another user.
> 
> >  		if (ima_enforce && (!sig_enforce
> >  				    && (ima_appraise & IMA_APPRAISE_MODULES))) {
> > -- 
> > 2.7.5
> 
> Plus I think LSM'ifying module signing may help cleaning up some of the
> #ifdery and config options around module signing. I'm suggestin this now 
> as this has been on my mental TODO list for a while, and just not sure
> when we'd get to it, if not you, not sure when it'd get done.
> 
> Then, do we have proper unit tests for the mixture of options to ensure
> we can easily ensure we don't regress?
> 

There are already two methods  - appended signatures and IMA xattrs -
for validating kernel modules.

Kernel modules shouldn't be treated any differently than any other file.  Based on the IMA policy, the kernel module signature can be verified.  Also based on the IMA policy, the file hash added to the measurement list, and the file hash used to extend the TPM PCR.  Lastly, based on policy the file hash can be added to the audit log.

I don't see a need for an additional LSM just for verifying kernel module signatures.

Mimi

