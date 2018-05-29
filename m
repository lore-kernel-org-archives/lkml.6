Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2038031-1527597052-2-2509759474115794484
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527597052; b=JCay2RaP+8tVIsVIyy/fTjWaGCKGKOiEiIteKzOAM1WSG5spLS
    JkX/ds6IThfr0+f1182qAgha56Y67g1Yu41UUBoV/LBWrMU8rdXO6DNB79Vh30M3
    6+P7ul4KIdyNBFnn/LKYU+qiwv/Jazba05JaKf7F+5kndc19ELBWrXtyz/eAF9fd
    KttODDHef9zefjVi5e1Njm8umINoDjnq3fF1hbMS7A9BlAE/jjxA+JcAW1SHcDhr
    +yfYE/Smu0PGAzBvcqWQercgNJKqkL9X/TOk/LJaEEnf67pyFrFn9rr+YLWGH6TL
    Pq1DjVk4jTHVqRtgrsIPsfYuqfCJ6WlmrNeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:in-reply-to
    :references:content-type:mime-version:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1527597052; bh=FMO8PBD6SRZX
    ORoJUlUM4AjrreMnK/3cW/b8dWJIHzA=; b=IPDZ6DLzUwcWLz6qnaHhNIAGYVUu
    NPkEEOerWkIOdAhxRLcL4BhJa/bf4ZD9WAkqWZqFuJj0VAK4Ur+DOza2vnQ/6G4P
    eF5c48mTDr6vKzq/o7BwbmH8WffD2Ve4Vp93f+bG1P8hoHCH7yWjmNcvjwRNucgZ
    W9LpJlZokwiBA1PzCrOx3PJRfkMxkVnSTw40SiIsbymD+UWfhOrkauOfdBSo4jeJ
    f4uY820SEvvo0tzveygBnmosRJ+aA5wSVWepJv4F+3f6z7H6QpUAMVKeWqVJvRCJ
    BzKYLR7clRhL3fS93csY2OqHZ8DutDhsMSW004CgO/ATQvXDFI3mnEalvg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJN4STBtThS6cbqEJWa6Bu48AB3WDm68rmknGoNjCiEnMFNp+nM5Fc7PtK+j0OKgvtsY+RxVdKibynO9+4/+LNY0a6FFkIJhy9Br6YhG0cB7HwNcxLZH
    g0JLh2jdjN+fCXnj8K9DtFbm3+tZL/IKe9gv7gk1p6gtUE4ZAeExIJV4P9CcsVAw+cJqCphtTjXxJYK1DSfk1EGkzwa8zKWJKDUCzid5E94k8RcTIeibsl2R
    9PQ5+3MQZqQBgNZcMkUehw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=nwZw_7uSb73Hb-8ZWD8A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933761AbeE2Mau (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 08:30:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47830 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933728AbeE2Mas (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 May 2018 08:30:48 -0400
Subject: Re: [PATCH] EVM: Fix null dereference on xattr when xattr fails to
 allocate
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Colin King <colin.king@canonical.com>,
        Matthew Garrett <mjg59@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 May 2018 08:30:27 -0400
In-Reply-To: <20180527225510.25612-1-colin.king@canonical.com>
References: <20180527225510.25612-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18052912-0044-0000-0000-00000557F62A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052912-0045-0000-0000-0000289A042E
Message-Id: <1527597027.10176.16.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805290143
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Colin,

On Sun, 2018-05-27 at 23:55 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where the allocation of xattr fails and xattr is NULL, the
> error exit return path via label 'out' will dereference xattr when
> kfree'ing xattr-name.  Fix this by only kfree'ing xattr->name and xattr
> when xattr is non-null.
> 
> Detected by CoverityScan, CID#1469366 ("Dereference after null check")
> 
> Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verified xattrs")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  security/integrity/evm/evm_secfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> index fb8bc950aceb..cf5cd303d7c0 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -253,8 +253,10 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
>  out:
>  	audit_log_format(ab, " res=%d", err);
>  	audit_log_end(ab);
> -	kfree(xattr->name);
> -	kfree(xattr);
> +	if (xattr) {
> +		kfree(xattr->name);
> +		kfree(xattr);
> +	}
>  	return err;
>  }
> 

Thanks!  To fix this problem, I think more is needed.

Without the xattr, there is nothing to audit except the attempt to
extend the xattr list.  Failure to allocate the xattr or xattr->name
should either result in a different audit message or return
immediately without any audit message.

Mimi

