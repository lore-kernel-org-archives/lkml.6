Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3148351-1525383089-2-6160319295745698418
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525383088; b=gFMmgXL6geGlWC9i96JF6jOUeD0xPudI+CC4CPr5q2OIYU2Jrw
    8xLWbrWxCPtIRDylUdJojb+hRxaUTblK/J4hGSrwGq4Q83B+djJuiYpTCfLJjHQW
    hPfc9/UQG9aUFLogNQsaBeIRAmh9g5fokzvoOEuxHwA4GHYwXbmy9phyfxpDCYw2
    6TrE8+PqIi/nb7kctTPWzkYemv+RoKGjd+i6wX4MfjPgSUhTdXrwItFO6nq8askT
    IYOHJwFiChhLkNEO2w/yYMMPTwFofGkRc2lbLMRRhWNglkJ5wlh6iSEJ8JBP+RzJ
    sW/JWfBwiqKA5iOrjv/Am+gFqnEpOvJIA9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:in-reply-to
    :references:content-type:mime-version:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1525383088; bh=PmoBgKnGr7t2
    kEvUK8d2S97BRZH3XgiCkgyRf3BdMBo=; b=UO7LR3Qct/MSu3vz1xlvUeJsFGST
    nXQ8dnnE0ZUnA49Y6P7lD9JoTLc31AtI5gWw2Z4rAT9ruQX7dzlYpk1EVzDaPLDX
    x85ieClVhQ5iC4CNqtuDAYNgdHryNikgixBAk12Qw9ldLctkt+X6VWTfW93nBbBk
    b/L+7us5UWiFqJgSXIm3bbyRRRAAhpp7WVZBV+I3/qyjOmxGdeUNEf7eOPXfRSBu
    ELsqMTG6zreDB5xm4rAOnjxoYy3e/HlZ8Ygy/E9+8xPNpa3x5AZ3e+iXqsiJg6K7
    6NZ13z+Ui18iUdu+ZVoXoal3oXTgLjahVHdZuLWgSlPu6L29DKF7JB1DmQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOdLsizidlJGgRvenH+e0HGsTGQTiuA51loK8grXnm06VuWBeA6nus6gBZQfZRb60tsMKuvvYiY1fTmRnlr46b6yPANiPnRXy10TXJBkZa93r/yjXBIw
    88EiVQEveaY172QSTQjTMqZQm0+TQnKdBhKD5bnsdNLUK2+MPL+8SwIIlEJFunIqc39npQjh4H/LyjUonjEXdYtG2KsgzAvkNLOckdU0e8umimXs2zdJ0ygA
    oUjqsW3Z+EPAd4eB+gCFhg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=bHLSQKsBI4kpnCWO79EA:9
    a=GQnX5GE6Xc20WrQG:21 a=EkvNLplSnOF7QWIh:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbeECVbZ (ORCPT <rfc822;linux@kroah.com>);
        Thu, 3 May 2018 17:31:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751132AbeECVbY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 May 2018 17:31:24 -0400
Subject: Re: [PATCH 0/3] kexec: limit kexec_load syscall
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc: David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Date: Thu, 03 May 2018 17:31:15 -0400
In-Reply-To: <87r2mso5up.fsf@xmission.com>
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
         <87r2mso5up.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050321-0012-0000-0000-000005D1B510
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050321-0013-0000-0000-0000194EDE66
Message-Id: <1525383075.3539.67.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805030185
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[Cc'ing Kees and kernel-hardening]

On Thu, 2018-05-03 at 15:13 -0500, Eric W. Biederman wrote:
> Mimi Zohar <zohar@linux.vnet.ibm.com> writes:
> 
> > In environments that require the kexec kernel image to be signed, prevent
> > using the kexec_load syscall.  In order for LSMs and IMA to differentiate
> > between kexec_load and kexec_file_load syscalls, this patch set adds a
> > call to security_kernel_read_file() in kexec_load_check().
> 
> Having thought about it some more this justification for these changes
> does not work.  The functionality of kexec_load is already root-only.
> So in environments that require the kernel image to be signed just don't
> use kexec_load.  Possibly even compile kexec_load out to save space
> because you will never need it.  You don't need a new security hook to
> do any of that.  Userspace is a very fine mechanism for being the
> instrument of policy.

True, for those building their own kernel, they can disable the old
syscalls.  The concern is not for those building their own kernels,
but for those using stock kernels.  

By adding an LSM hook here in the kexec_load syscall, as opposed to an
IMA specific hook, other LSMs can piggy back on top of it.  Currently,
both load_pin and SELinux are gating the kernel module syscalls based
on security_kernel_read_file.

If there was a similar option for the kernel image, I'm pretty sure
other LSMs would use it.

>From an IMA perspective, there needs to be some method for only
allowing signed code to be loaded, executed, etc. - kernel modules,
kernel image/initramfs, firmware, policies.

> If you don't trust userspace that needs to be spelled out very clearly.
> You need to talk about what your threat models are.
> 
> If the only justification is so that that we can't boot windows if
> someone hacks into userspace it has my nack because that is another kind
> of complete non-sense.

The usecase is the ability to gate the kexec_load usage in stock
kernels.

> 
> Given that you are not trusting userspace this changeset also probably
> needs to have the kernel-hardening list cc'd.  Because the only possible
> justification I can imagine for something like this is kernel-hardening.

Sure, Cc'ing linux-hardening and Kees.

Mimi

