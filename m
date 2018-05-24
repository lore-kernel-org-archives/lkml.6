Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2737493-1527204607-2-16543861408161013982
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527204607; b=N3+ux90YgA6RB1NEesB2Wb2/O8oIAvHIUC50xXFEhea1FfwA4B
    ZhYn+TOgtzUJkrdldPrn3XTLGW+/zqwZBKUXzy4cH3KP1Df/ChttZ/jnDw0rH4dc
    t6c6vNN4J6Z1NEYnnBLZRqvsVOFWtQLE+Rhsq0yMtWW8zoi4YEvlYkf4rC4OO8lS
    Sb84gA19aNWJq3Z76QWsuimHEwShk0SeI2Nu5qZMwByrvrzffxXiqEBVJXQTGuwZ
    KL3ZPZ10q5AqMR3VmPA1m1stg2OPCEVuLuNuoZZLfvR1Lk+hmxzSgNf5W3pCNixs
    uoxZF3zgRNuQvgdqrdNVp9eB/tm1KKBORT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:in-reply-to
    :references:content-type:mime-version:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1527204607; bh=xNh4+EUmUmyd
    6vglaZWbbr4XAKC7cn/7dKfWYTzQ+0U=; b=kum+MaYglipUsYOE4hFyNEqySo26
    xSkdbwe5rO6sI68ZGR/dd90T7ZWDeBfSTdjWQ6gd6uPcvC8j4sshDtFSNgNPIl3r
    44wYHAPdhsNgap88lDyFh/J7fd6zsUUCtBtjiQXmWdEEq/QkL7G+EfODoEM32dO0
    CQYB/HYffllL7vsmU1ntqiiZMp51pyxb57kgMnuqiZTcgMRM75bMbh/n4HB88Dn+
    KGNV3BB0D8CzCVs5vUo6/UpfW2TbQRrVxMX0lWUHWts8hp+ZqDscJNLyLMXaYEd7
    pGTSVw9D+sfpkEdi+lPxyZ3P+fUdD7NTdFZMmH9C1rQUJIP8W96J7vYYYg==
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
X-CM-Envelope: MS4wfCRn3c7lM3Cw1DWFdtayGE5qwDa65qgsc+PSOKSE1Y+i87pzP9BAiplYF6sNVKMrTA3unuYAzJRuy2XoZmdfJU/W6CUjy+f6M+JRO9mBMxgduXGVG8sF
    uRNBrSlsAzn3GqlfzVB8nxv58LTWOwiRk8ziwVV/Brf2KHnNh3Vr70Dnn+wXOTtVy16MfvpkW7loV7BK9O3ng4UiWivg/o50FjT1qRfSs/xzliSUCLhvpxnI
    Xhqu5yQuHKiDaytWcL51qA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=z1LBzrSQqLL1LhDuqVwA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965699AbeEXXaD (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 19:30:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965666AbeEXXaC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 May 2018 19:30:02 -0400
Subject: Re: [PATCH v3 1/7] security: rename security_kernel_read_file() hook
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
        James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 May 2018 19:29:52 -0400
In-Reply-To: <87po1k2304.fsf@xmission.com>
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1527160176-29269-2-git-send-email-zohar@linux.vnet.ibm.com>
         <87po1k2304.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18052423-0040-0000-0000-0000043D95F2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052423-0041-0000-0000-00002642D581
Message-Id: <1527204592.3424.132.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-24_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805240264
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-05-24 at 15:49 -0500, Eric W. Biederman wrote:
> I already nacked this approach because the two cases don't
> share a bit of code.  When I looked closer it was even crazier.

It hasn't been clear what you meant by "the two cases don't share a
bit of code".  The first attempt called
security_kernel_read_file().  As per your comments, kexec_load doesn't
load a file.  Thinking it was a naming issue the second attempt
defined a wrapper named security_kernel_read_blob() for
security_kernel_read_file().  Still thinking it was a naming issue,
this attempt renamed the security_kernel_read_file() to
security_kernel_read_data().

> 
> The way ima uses this hook and the post_load hook today is a travesty.

Instead of having multiple functions, each a bit different, for
reading a file from the kernel, kernel_read_file() is a generic
implementation with both pre and post security calls.

 I think the pre and post security kernel_read_file() LSM hooks are
quite well thought out.  The security_kernel_read_file is called
before the kernel reads the file.  The security_kernel_post_read_file
is called after the kernel reads the file.

> The way the security_kernel_file_read and security_kernel_file_post_read
> are called today and are used by ima don't make the least little bit of
> sense.
> 
> Abusing security_kernel_file_read in the module loader and then abusing
> security_kernel_file_post_read in the firmware loader is insane.  The
> loadpin lsm could not even figure this out and so it failed to work
> because of these shenanighans.
> 
> Only implementing kernel_file_read to handle the !file case is pretty
> much insane.   There is no way this should be expanded to cover kexec
> until the code actually makes sense.  We need a maintainable kernel.

It wasn't implemented *only* for the IMA !file case, but as a generic
mechanism.  True, IMA is only using the security_kernel_read_file hook
for detecting !file, but the security_kernel_post_read_file hook is
used for verifying the file's integrity.

> Below is where I suggest you start on sorting out these security hooks.
> - Adding a security_kernel_arg to catch when you want to allow/deny the
>   use of an argument to a syscall.  What security_kernel_file_read and
>   security_kernel_file_post_read have been abused for.

Assuming we define a new LSM hook named "security_kernel_arg", would
we also define a new enumeration or could we still use the existing
kernel_read_file_id?

> 
> - Removing ima_file_read because it is completely subsumed by the new
>   call.

The existing IMA function wouldn't be removed, but renamed to whatever
the new LSM hook is named.

> 
> - Please note with adding this new hook there is no code shared between
>   the cases, and the lsm code becomes simpler shorter when it can assume
>   security_kernel_file_post_read always takes a struct file.  (Even with
>   the addition of a new security hook).

We would be defining a new LSM hook, not removing the existing
security_kernel_read_file hook, and only renaming the IMA usage of the
hook.

If defining a new LSM hook named security_kernel_arg makes you happy,
I don't have a problem with implementing it.

James, Casey, are you Ok with this?

Mimi

