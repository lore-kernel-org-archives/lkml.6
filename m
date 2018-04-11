Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477390-2-2445152235758653362
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
    1523477389; b=K+sfQJBMTIf9FgSTt9D8ocvVvLBjbI1U+LnZW2LB/gJNysndt0
    f9K2LBn004t3Qh/2j9uRxX9njeDJTxJnKLSDKq+voG08jvayCZvPz9Jivmqqxzog
    rOhkhRMdmtjH8ZkGPPi0l/vq/NEenqpGNVuFW9a4BQExhlgyo5YhnlujsIiZsP+t
    D6guX/jO07CTVveD3yibSroNDUMVkWKgXYKMgPJs8orFZb65asBckDESKMhTBww3
    OLpu06LqKwobATAGp7G5njb0+AWmbdKYg2j+d4MNDBGc81PEvg+5vg4DiEQ//QKl
    D4WiKJ7D7GT5sQnlYounkDB+C/Veo+sE4Ngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:in-reply-to
    :references:content-type:mime-version:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1523477389; bh=Rk3Qq1458eCG
    frdb+Un4XR0TOIUYwGfzTbl9vEeOmdI=; b=hhF6VqR/hdLQzSkKjr3HE4865Y9I
    6VEelY835E/FaviKA9hy1RVrPIl9ekIWAd8JalfegLStIMr5lOSFkjxKv858FsID
    V2S3y/KGIuWN4So7+RUQ4paCOWvmhTp5LARUwQjYZ8goifJXRGGZuSjHRZapsdOT
    yWVQPu0njJscOhfuYi7+j32MbPBIWDqti00chesvfOWfxBAkxPbadm7UhSOydiW3
    59Fj35mWZoPHGIskYPRLzUz4x0QW+st3UBv4NyQWmcAWDUJjrduXBt45KdWqGvRW
    ht7hxx6G4U9ZoeVOz+lEcKIAjKtxSdVtm0owqcSgyvHPwiLATwJ0h04KcQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfDoNPnr4szwo+kY9/aoQTYPcoY5ttguBQAz9WQ0IaxRUpjT/MsqMYfM2mvIgSssee+CDXysPsnkm1NzC/pUCV+4mnMBPN8oMPVOPV6iPfsHRn2OHpP2H
    c6XDSt7c/TMIGslZU7siNZYPG3Hy1QLzLBe9ZgtdQ81krh+Gz1aTqjlj3kkPjiZQ+Zc8P9WvUqrNla9qvs3NB+G3UwYJX+gZjSgToNZNIucHG/mNhErOl/hk
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=9Rt4o3Z7AAAA:8 a=PtDNVHqPAAAA:8 a=VwQbUJbxAAAA:8
    a=vE38cTjSauNEQu4spSIA:9 a=QEXdDO2ut3YA:10 a=kXfSGICM7I4A:10 a=x8gzFH9gYPwA:10
    a=jE01AiZSAJ7eki2zvjzZ:22 a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932423AbeDKUJn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:09:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756229AbeDKUJn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 16:09:43 -0400
Subject: Re: [PATCH 06/24] kexec_load: Disable at runtime if the kernel is
 locked down
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date: Wed, 11 Apr 2018 16:09:35 -0400
In-Reply-To: <87po35k1q6.fsf@xmission.com>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
         <152346391877.4030.6270466586590461223.stgit@warthog.procyon.org.uk>
         <87po35k1q6.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18041120-0012-0000-0000-000005C9BD7D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041120-0013-0000-0000-00001945EF8C
Message-Id: <1523477375.5268.78.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804110186
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-04-11 at 14:00 -0500, Eric W. Biederman wrote:
> David Howells <dhowells@redhat.com> writes:
> 
> > From: Matthew Garrett <mjg59@srcf.ucam.org>
> >
> > The kexec_load() syscall permits the loading and execution of arbitrary
> > code in ring 0, which is something that lock-down is meant to prevent. It
> > makes sense to disable kexec_load() in this situation.
> >
> > This does not affect kexec_file_load() syscall which can check for a
> > signature on the image to be booted.
> 
> Maybing I am missing it but I am not seeing anything that would require
> kexec_file_load be configured such that it checks the loaded kernel.
> 
> Without that I don't see the point of disabling kexec_load.
> 
> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

The IMA "secure boot" policy requires the kexec image to be signed.
 This call to kernel_is_locked_down() could be replaced with a call
to security_kernel_read_file(NULL, READING_KEXEC_IMAGE).

It would be similar to the existing init_module syscall calling
security_kernel_read_file().

Mimi

