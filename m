Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-886641-1526506846-2-10555908177350593878
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526506846; b=RYK1o22ujkk/iZ/kw9H1j4zygo15keg2BhHxxnIL9ngOmNAWaI
    oXD3D/+AXJ8VGbsFMDjLQ6Ty1He6LwLP0FIaM/iZd8gWBMmFhb/lVnLAWQKco/K0
    PrPsohV9YN1t7Nru1Q/U6kHMnNymSW6yDgiZmImLuLbxSCqXsIm+81pSXXVMdJV7
    RBlJVJiYMmK3uDiiNk4fchr5t7S06XrXn49/VUYNIstAhYUYo+I68WRRrUZP1bEt
    BevXdqTiegZRD09EylwZiqgwOhSFwODb6B4ypF1ugNGZihpd/97/g6T8FLR8VmYM
    KzyxIur2KmB/+FB4wrec0PadisfrQDIQfnIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:in-reply-to
    :references:content-type:mime-version:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1526506846; bh=bR1maibQ6hv1
    gFK86GHFAkpc67Ysq0uhsI4PLcFrtPQ=; b=Mjrmhl9WmZdaj3unxMIBFZZdtrLc
    xurObNoefsIAFYSFTffahXmXqAgjCWxmOBYS+Uo9V8aOsiwxlJr/luY2gR48AjZL
    5Fc5zxJj+vcRYgfsdOU9PyIXWwNV78jigc6EnkVBM1NB1AfN3R9HzJI8FM6jDM86
    r8/fe4b3JOgovsSIfC2iVgKe3zZEIdLjEUHOx3/BAdmhmkRimnXdPTp6FoV0NX+F
    2CxSW1qBa9CDObYm7mbdO9dSDIAm5J3bCnvdtWXAGhYahr/twtGqbfQxS9S5Qufq
    9s5SMX5mzbDSZehSMqNfh2uYUaVuoTHLsaFhIm2Bs7hRKZNuJ3Y4Ujqxfg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHyKkknQAM84IQgQOlyMDWk7LARRNW84nciRxgHFCYji89vMCkREUyMtSQI5cSZpMA2pwD6dxs+lR3p1jxQEKskF9LXcm1WmI57hSqomhpOtf+XAXH9Z
    9NTTURWYSl/iLyIUHFp+jysbR/CpdfAy5yguaD7J+NxZdHSmuPqkPtIULK4BKlLmO4p48l5Vth/PYLad+OUovNajytWrcdzX/3avO1dA+XHOi2mTrGnZ9/cj
    WGewo56xFIcU8rrqGjXNkQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=kNTEMl3_5DkBcBIvinMA:9
    a=QEXdDO2ut3YA:10 a=-bWi_RMRg4sA:10 a=x8gzFH9gYPwA:10 a=_2N7QWRe9ZMA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbeEPVkm (ORCPT <rfc822;linux@kroah.com>);
        Wed, 16 May 2018 17:40:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751132AbeEPVkm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 May 2018 17:40:42 -0400
Subject: Re: [RFC PATCH v4 3/5] ima: differentiate auditing policy rules
 from "audit" actions
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: serge@hallyn.com, sunyuqiong1988@gmail.com, david.safford@ge.com,
        mkayaalp@cs.binghamton.edu, James.Bottomley@HansenPartnership.com,
        ebiederm@xmission.com, john.johansen@canonical.com,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>
Date: Wed, 16 May 2018 17:40:31 -0400
In-Reply-To: <2496f165-67f7-304d-08a0-ea8eedd3c3d4@linux.vnet.ibm.com>
References: <20180511144230.75384-1-stefanb@linux.vnet.ibm.com>
         <20180511144230.75384-4-stefanb@linux.vnet.ibm.com>
         <1526391655.3937.151.camel@linux.vnet.ibm.com>
         <2496f165-67f7-304d-08a0-ea8eedd3c3d4@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18051621-0008-0000-0000-000004F73E3E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051621-0009-0000-0000-00001E8BAF81
Message-Id: <1526506831.3254.13.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805160212
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-05-16 at 16:28 -0400, Stefan Berger wrote:
> On 05/15/2018 09:40 AM, Mimi Zohar wrote:
> > Hi Stefan,
> >
> > On Fri, 2018-05-11 at 10:42 -0400, Stefan Berger wrote:
> >> From: Mimi Zohar <zohar@linux.vnet.ibm.com>
> >>
> >> The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
> >> the IMA "audit" policy action.  This patch defines AUDIT_INTEGRITY_POLICY
> >> to reflect the IMA policy rules.
> >>
> >> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > We do need to separate out auditing the IMA policy rules from the
> > "IMA-audit" messages.  Based on the IMA policy rule aspect of the
> > discussions [1],  I would really appreciate if you could work with
> > Richard and Steve on the new IMA policy rule audit format.

> Is your patch below still valid for splitting it up into 'two distinct 
> audit record types' ?

We need to separate the IMA policy audit rules from the IMA-audit
messages.  As we're changing the audit numbers, we need to take into
account Richard's and Steve's comments about the IMA policy record
format at the same time.

This patch is incomplete and needs to address their comments.

Mimi

> >
> > This change can be upstreamed independently of either the IMA
> > namespacing or the audit containerid patch sets.  The sooner we make
> > this change and upstream it, the better.
> >
> > [1] https://www.redhat.com/archives/linux-audit/2018-March/msg00092.html
> >
> > thanks,
> >
> > Mimi
> >
> >> ---
> >>   include/uapi/linux/audit.h          | 3 ++-
> >>   security/integrity/ima/ima_policy.c | 2 +-
> >>   2 files changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> >> index 4e61a9e05132..8966e7ff1c4c 100644
> >> --- a/include/uapi/linux/audit.h
> >> +++ b/include/uapi/linux/audit.h
> >> @@ -146,7 +146,8 @@
> >>   #define AUDIT_INTEGRITY_STATUS	    1802 /* Integrity enable status */
> >>   #define AUDIT_INTEGRITY_HASH	    1803 /* Integrity HASH type */
> >>   #define AUDIT_INTEGRITY_PCR	    1804 /* PCR invalidation msgs */
> >> -#define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
> >> +#define AUDIT_INTEGRITY_RULE	    1805 /* IMA "audit" action policy msgs  */
> >> +#define AUDIT_INTEGRITY_POLICY	    1806 /* IMA policy rules */
> >>
> >>   #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. */
> >>
> >> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> >> index 915f5572c6ff..3a1412db02a3 100644
> >> --- a/security/integrity/ima/ima_policy.c
> >> +++ b/security/integrity/ima/ima_policy.c
> >> @@ -619,7 +619,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
> >>   	bool uid_token;
> >>   	int result = 0;
> >>
> >> -	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_RULE);
> >> +	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_POLICY);
> >>
> >>   	entry->uid = INVALID_UID;
> >>   	entry->fowner = INVALID_UID;
> 
> 

