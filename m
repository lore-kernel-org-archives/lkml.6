Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1918895-1528142040-2-17137173902303908308
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528142040; b=dbdIVC2Ai7eunb0nf/jGbtt6BbOWmUBpGzcL4qxLL118a3nbW0
    VRXJcPYCYXXi155HahFZ859zj5TD8vHjncPYnWEzcnaF3LQ8fxnNrzepqKVckPQ5
    +cF8dBVZhBi3HdHKhAXGT9mJ9psmZAHFBBJDoAV8QXF54qwYbcntnLel7iWr2Gy8
    I7jIwAPFKkeXlNJvj1aEZypmRf5swnm2oTJNbfCsexm4TTKZ9qT8doIHtO+88WZZ
    Y4Ien5zT1pG/PQ5kUcliwt9amOg90tKVVHdsrLU/JzFCvNe4bG4dGMvGMgIaTwuZ
    WJi8ERxvzCh73ROMmvneUH+QASfY4/oGdoRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:in-reply-to
    :references:content-type:mime-version:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1528142040; bh=vQqdSzbJ/bye
    9rf0weCqbDio+uIKF756hpt3aSM34qo=; b=DogDNVIsOCjNm6ny8V/4GHe4IC4v
    a1z35wd7XziUxcj+Q3d5NWnVd7F6ssFLPkxcxQ1hPDYyXR4yJeYjQ3HGlO3WJQc7
    jrKbgBQWu9mutKRslAwffXYHGCGoWqdhItElhTsmE2T/kohC0RxkXC0jYYAr4qSm
    ttV30V3C9Zscgcrs9VZB/JvOF/xEGFDRJyLrQW2qIFkJTyp4a0mhN74YLrQXAzVa
    4NZNpYJCleYXC2jtZ1SyYFU9UGamTWDKtkYDTifKTjJKbIwTAS0vcMBBNssdpqHP
    KwDONWtJ20qAWj4HiKe79k36aHh0OAz7wDrNW9yEKI1e49Zw5bythKQRwg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfDwgVsOeIrdz79zAwhpxn7wWrMNicCXnVqeLAE3E94oIPWlPzwWlK40VA5B0xZbMTnHNrojtXGHj6FS3yqTylsmYTZRd7H+1XdS7z5Z38SuHzIlIfhY/
    0l4G7SOXgH4uLa8azOU/10cLBKMTisYHHONIgXb5tR4By1NaqVNCUTCR51HdZMlNhrEVQCA903G8y5pPeBLRiHBR73JV1N79gLFueFvc8NjeW2Cdi4qxLPOs
    iSWN8FEnS8qNjuuIIhON2Q==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=BisZxQ6Ubofqs-P1gUUA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751017AbeFDTxz (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 15:53:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41380 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751010AbeFDTxw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Jun 2018 15:53:52 -0400
Subject: Re: [PATCH v4 0/8] kexec/firmware: support system wide policy
 requiring signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <james.l.morris@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jessica Yu <jeyu@kernel.org>
Date: Mon, 04 Jun 2018 15:53:40 -0400
In-Reply-To: <20180604193215.GA13553@mail.hallyn.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1528121025.3237.116.camel@linux.vnet.ibm.com>
         <20180604193215.GA13553@mail.hallyn.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18060419-4275-0000-0000-0000028A103E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060419-4276-0000-0000-0000379110B7
Message-Id: <1528142020.3237.138.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040228
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-06-04 at 14:32 -0500, Serge E. Hallyn wrote:
> Quoting Mimi Zohar (zohar@linux.vnet.ibm.com):
> > On Tue, 2018-05-29 at 14:01 -0400, Mimi Zohar wrote:
> > > Instead of adding the security_kernel_read_file LSM hook - or defining a
> > > wrapper for security_kernel_read_file LSM hook and adding it, or
> > > renaming the existing hook to security_kernel_read_data() and adding it
> > > - in places where the kernel isn't reading a file, this version of the
> > > patch set defines a new LSM hook named security_kernel_load_data().
> > > 
> > > The new LSM hook does not replace the existing security_kernel_read_file
> > > LSM hook, which is still needed, but defines a new LSM hook allowing
> > > LSMs and IMA-appraisal the opportunity to fail loading userspace
> > > provided file/data.
> > > 
> > > The only difference between the two LSM hooks is the LSM hook name and a
> > > file descriptor.  Whether this is cause enough for requiring a new LSM
> > > hook, is left to the security community.
> > 
> > Paul does not have a preference as to adding a new LSM hook or calling
> > the existing hook.  Either way is fine, as long as both the new and
> > existing hooks call the existing function.
> > 
> > Casey didn't like the idea of a wrapper.
> > James suggested renaming the LSM hook.
> > 
> > The maintainers for the callers of the LSM hook prefer a meaningful
> > LSM hook name.  The "null" argument is not as much of a concern.  Only
> > Eric seems to be asking for a separate, new LSM hook, without the
> > "null" argument.
> > 
> > Unless someone really objects, to accommodate Eric we'll define a new
> > LSM hook named security_kernel_load_data.  Eric, are you planning on
> 
> I'm confused - isn't that what this patchset did? :)

Right.  I'm trying to get consensus whether it is needed.

> 
> > Ack'ing patches 1 & 2?
> > 
> > Mimi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

