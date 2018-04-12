Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-763432-1523533108-2-10433219823854076287
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523533107; b=FNGtCBpEWE7yDoJWuxCCDJtdDouB+QWOdmjNqrL9UY056xyGbg
    2B339rymzfWSHfT8OifQ9slNywGAhsbQ9UU9qBB9qPsi3BSQciHU8IaSvVgO0Okc
    KPtD2ECnVtzaMInAfY7PL0A6zeHpwMTaSLBU0/c3OINQBp7/FP7h6gsucj0XLKKw
    kgIEhYy7UkRbYZHp0Jtb+S0VKb9bEYIlc1qXlF4iU0N0ugw/T5LsOiBAEojjccBs
    Ce7DIdlBIzz943uOUcMuPkWYUAE08LyfyG1/kj1tkPjzp3bXBxhUuv5ur3O2lqzU
    ZzdmmR6oXXQgvYx0Pxd+nJzASdEGlNdW8uNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:in-reply-to
    :references:content-type:mime-version:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1523533107; bh=X5SOgozDKtO7
    j5qFnRTaXWqn6FQBmLwdbAhbQQ3kzMY=; b=aZAu4O/J7hWtD4NeGrXnxMiRwnXA
    pYMA12x8g2lc1ruOIRZ3JEJ3cr0ZHWT28xg7LD3S/tC1QSCSjeu0i3bxYX3rzGaF
    T3ASck7qkoBsHWrD0R/70EgPhYtfBzu3Hk7AnA9BEN57rXyce2Yiw7Syf5QeOiXS
    iunNPM6jQagWnikBptkWoAPTh+6cvJaAQNk3gWP8OtrzsfP+wkapog3Lm3p+pNBd
    mDlyt/IjOaB12kUFpD4vFRrMk93WnGrWDo37yxhlkZaEicjCVVO28l8F94JOhXBY
    CVGM91wYGjAiPfswRwwCNX1S7nU+xH/rG7P0/89znkJRaM+CyT83O+ZhvQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ/RBGmPk40ODewxLJMLdm3sgvt4U1njIMsWWPuSqDnF8ze4TL0d9r0rV9yk6m3giaH5xycyh7smA91oBtup+3rHo8CX/KkoTrmh7MVywJwR5jztOR6P
    38FYY+YoJmtZq3RVuWBXLMYahxpj3bgE4jlAy9DILzwpJY30/pP6yKf9ZPjZQeUy6HN+KddTw+JLAugvNMwXkOtMZG3zHpVQNVFMPANVQsORlAvOUNwKo7jw
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=9Rt4o3Z7AAAA:8 a=PtDNVHqPAAAA:8 a=VwQbUJbxAAAA:8
    a=pwH9GBqdFiE-RNno6p0A:9 a=QEXdDO2ut3YA:10 a=kXfSGICM7I4A:10 a=x8gzFH9gYPwA:10
    a=jE01AiZSAJ7eki2zvjzZ:22 a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751863AbeDLLiZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 07:38:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750763AbeDLLiZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 07:38:25 -0400
Subject: Re: [PATCH 06/24] kexec_load: Disable at runtime if the kernel is
 locked down
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Thu, 12 Apr 2018 07:38:17 -0400
In-Reply-To: <1523477375.5268.78.camel@linux.vnet.ibm.com>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
         <152346391877.4030.6270466586590461223.stgit@warthog.procyon.org.uk>
         <87po35k1q6.fsf@xmission.com> <1523477375.5268.78.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18041211-0040-0000-0000-0000042D7CFB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041211-0041-0000-0000-00002631958B
Message-Id: <1523533097.31852.11.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-12_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804120119
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-04-11 at 16:09 -0400, Mimi Zohar wrote:
> On Wed, 2018-04-11 at 14:00 -0500, Eric W. Biederman wrote:
> > David Howells <dhowells@redhat.com> writes:
> > 
> > > From: Matthew Garrett <mjg59@srcf.ucam.org>
> > >
> > > The kexec_load() syscall permits the loading and execution of arbitrary
> > > code in ring 0, which is something that lock-down is meant to prevent. It
> > > makes sense to disable kexec_load() in this situation.
> > >
> > > This does not affect kexec_file_load() syscall which can check for a
> > > signature on the image to be booted.
> > 
> > Maybing I am missing it but I am not seeing anything that would require
> > kexec_file_load be configured such that it checks the loaded kernel.
> > 
> > Without that I don't see the point of disabling kexec_load.
> > 
> > Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> The IMA "secure boot" policy requires the kexec image to be signed.
>  This call to kernel_is_locked_down() could be replaced with a call
> to security_kernel_read_file(NULL, READING_KEXEC_IMAGE).
> 
> It would be similar to the existing init_module syscall calling
> security_kernel_read_file().

David, enabling the IMA-appraisal "secure boot" policy should probably
not be dependent on lockdown either.

Mimi

