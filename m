Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2618787-1527625967-2-6212033940460435239
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527625966; b=c4Vetb7gIjQQvqQubYL79c8B3njidue1QnSIYnrut6BHhlgStl
    NHOYtXL1MH11FRTzzxrbkKVhcFGHXR4UXKPUUenYinMuFOksdCH4W30YHgs+DJdK
    Xwr6KxVr5hehTbDYEsgEyDc6wv5ZvhLhh24+bBL7FCRqzz5GiX7URFmbDMs4Dvze
    5CO91rI/BjmwfNtAK1OPGM1PlEoDhqkcN4TvhL42IGNtggGSRBdJIYcOd44nk7RQ
    BAueaSv0gfDjdD95jtwanXDUhdkPF7Ske3MKr/CmndCDmatGE2TYGvXvWyghvZu+
    YTZ2ybiXo2bvBQqDSjMnXfBDlYDaOpQkYk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1527625966; bh=8y8gMuGs6tj4GkUdL9AlaM+TwDX6PH5wHejD+NA
    16is=; b=nSChyeP4ZCpDkYVj/tK/QViOdh80V+Q7xVVZaCFtyIO2NfU15Rr38IU
    pinZkyE9QJg+sGwusQCrg2qspWfM8Y9pZTafZgVFYTjbKCU6cWROgIyLuSPPYBFL
    u4SZy69wDKvKu4j1S571Z532E2cFEPV5wPTL1sLt+d1ynTUGzXw0eCStZvnWU5XY
    JqHOCu6GEhHTIVxCIsOnRFPEwrvaaVMJyG+QTnkRHkHPksSHbbrcwPad3VaLk7Og
    CdoYsaTH2Dp03Kq38btRMqPPTW9q9QmJ0B42JQamBEbHamAq7uNH4fupOvQ96HIt
    vlLhrpQbEQyOs5RbjhWnmBke2HSkBrQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=namei.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=namei.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=namei.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=namei.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCygMAh4vKrv5Q1GTdNujMJ/zjSXtGtTKLrGxBI1YZ8EAarExZSuTPqFTtaIo6gHbU7fRV/aepz9Ye3HhU2E7uplq4XbyYc/Ctfl+fCOdWcj1zLk0quM
    odPljwjuGlplVMHV2f4B0pvcKj2qj4wy4XIPPpoLj4rlFG5VpRfisc/kTNcNmpRB+1CkcrJTCPTs0ri3bjJsXzu/o3ZbWOGe1EFctKhpz9RSJWRk2ax7qTYA
    W7c52X8+4Cc9hNcuiF2DBg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=K6HrmWtEAAAA:8 a=VwQbUJbxAAAA:8 a=cnofKsjC2EhE87belkgA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=yV38gEssg_2GhkhKF82i:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966580AbeE2Ucn (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 16:32:43 -0400
Received: from namei.org ([65.99.196.166]:57578 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966399AbeE2Ucm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 May 2018 16:32:42 -0400
Date: Wed, 30 May 2018 06:32:16 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v3 1/7] security: rename security_kernel_read_file()
 hook
In-Reply-To: <871sdzy0nv.fsf@xmission.com>
Message-ID: <alpine.LRH.2.21.1805300629220.2647@namei.org>
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com> <1527160176-29269-2-git-send-email-zohar@linux.vnet.ibm.com> <87po1k2304.fsf@xmission.com> <alpine.LRH.2.21.1805260139030.11624@namei.org> <871sdzy0nv.fsf@xmission.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 25 May 2018, Eric W. Biederman wrote:

> James Morris <jmorris@namei.org> writes:
> 
> > On Thu, 24 May 2018, Eric W. Biederman wrote:
> >
> >> Below is where I suggest you start on sorting out these security hooks.
> >> - Adding a security_kernel_arg to catch when you want to allow/deny the
> >>   use of an argument to a syscall.  What security_kernel_file_read and
> >>   security_kernel_file_post_read have been abused for.
> >
> > NAK. This abstraction is too semantically weak.
> >
> > LSM hooks need to map to stronger semantics so we can reason about what 
> > the hook and the policy is supposed to be mediating.
> 
> I will take that as an extremely weak nack as all I did was expose the
> existing code and what the code is currently doing.  I don't see how you
> can NAK what is already being merged and used.

It's a strong NAK.

LSM is a logical API, it provides an abstraction layer for security 
policies to mediate kernel security behaviors.

Adding an argument to a syscall is not a security behavior.

Loading a firmware file is.

=
-- 
James Morris
<jmorris@namei.org>

