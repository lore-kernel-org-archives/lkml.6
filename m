Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1708975-1527783074-2-17786885180672465176
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527783074; b=cJBLhamOR48P9WAHkjs8mWo5CjamV6q3fUwt5KtAWWFVB5wDk3
    5a2l1jeYV0RJkZqqQq0p1pB2Po+iSEIKIyQexjA2QCa+A9R1+RO2uAPrTRrRp0PV
    hoJ6fsaH4KNo6RUxe9TEQegpTB0E3FLtIFfJ9dMOgYcdURCCDN8veIWMVQmWSuwD
    E8TqHBcFxhPO4vIGybHhi76qkN83gWk86LesZkehWheuS8tJW3hozOti6vnyXl0q
    Seb4GsK5tCW6HeYF2h0zxAGtnZsOThsWr97c2KNC6vNK4NmvI+b9T/Yd3hG4S2+d
    FBgJEQ7jpmaHlM3RsH5286qgACJnk4r4IUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527783074; bh=s6xT/yxa7zw0V49Tk8sfpnWgojWX8m
    6Fb+KdrugwGVY=; b=TGHXWjy5NQmCSXP3B1U0/vWFpkIbmmGU2MImxRmeIZKOJs
    Wf2vfIjfLYZ+5/ljuAxkPwc3TfsFsAmAiX4Qa7r2lT+murmCUU60/1opanmnYWaF
    u87XVDgr/41g2vXnN15B3uFjkAHzJn5eJ85CqKnAEjx8QWV//9GG9aMwwUeH36z6
    qMj0QsNzybqT3pIVLgYXA+u68ayinyLXoCq0nzqni8Pbf8G/7AuzOKbkc4qlO81j
    e6F0wy3gHicpbfa5pvw4u1skpwYql8sKKbcoHSV1cMunAGdQU1djgW/biaEtlJXG
    gO30sNGCQWwZHuDiwQn36ePtgnowxLsPv3G+SvQg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=qj9nqHvb
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=UiXxCL+8;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=qj9nqHvb
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=UiXxCL+8;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIETHUTy55FDJIoXc6EjhgDQ+Lx1HDxhdmgUOj52j62PgVetN95ZtiooQKsXMkkUvHU1rp/TioUywpFtaVuyNDyj2nq0+TOFY/Oc9/lkEqKbrzoLkuCw
    kMSHxpAezD14/+kkU4DL2NHexLWH/u5wi9NSxAaqmSxMTR4GoxkzTgYzV306eEwbyUgLvDCC+aQO/Y/lTVsZTfvvP18Szh2IZ32c+5OB1tg52adPt361lkY3
    2xXzjmD+CECvIkrKcxIkyA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=ZcWpN81wZGfSTRTvrR0A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755632AbeEaQLL (ORCPT <rfc822;linux@kroah.com>);
        Thu, 31 May 2018 12:11:11 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33286 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755562AbeEaQLK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 May 2018 12:11:10 -0400
X-Google-Smtp-Source: ADUXVKKkx2J6y6ei7zChPFZClLs0XCBkYRuTBhvdbiI3RJRBb6Y3F6OsLSw6aUxjzZTwd7bZEOsSZA==
Date: Thu, 31 May 2018 09:11:07 -0700
From: Tejun Heo <tj@kernel.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: CHANDAN VN <chandan.vn@samsung.com>, gregkh@linuxfoundation.org,
        bfields@fieldses.org, jlayton@kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        cpgs@samsung.com, sireesha.t@samsung.com,
        Chris Wright <chrisw@sous-sol.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/1] Fix memory leak in kernfs_security_xattr_set and
 kernfs_security_xattr_set
Message-ID: <20180531161107.GV1351649@devbig577.frc2.facebook.com>
References: <CGME20180531092848epcas1p24b638ccd6da00f1e039bdb64de7e1a5b@epcas1p2.samsung.com>
 <1527758911-18610-1-git-send-email-chandan.vn@samsung.com>
 <20180531153943.GR1351649@devbig577.frc2.facebook.com>
 <4f00f9ae-3302-83b9-c083-d21ade380eb2@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f00f9ae-3302-83b9-c083-d21ade380eb2@schaufler-ca.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 31, 2018 at 09:04:25AM -0700, Casey Schaufler wrote:
> On 5/31/2018 8:39 AM, Tejun Heo wrote:
> > (cc'ing more security folks and copying whole body)
> >
> > So, I'm sure the patch fixes the memory leak but API wise it looks
> > super confusing.  Can security folks chime in here?  Is this the right
> > fix?
> 
> security_inode_getsecctx() provides a security context. Technically,
> this is a data blob, although both provider provide a null terminated
> string. security_inode_getsecurity(), on the other hand, provides a
> string to match an attribute name. The former releases the security
> context with security_release_secctx(), where the later releases the
> string with kfree().
> 
> When the Smack hook smack_inode_getsecctx() was added in 2009
> for use by labeled NFS the alloc value passed to
> smack_inode_getsecurity() was set incorrectly. This wasn't a
> major issue, since labeled NFS is a fringe case. When kernfs
> started using the hook, it became the issue you discovered.
> 
> The reason that we have all this confusion is that SELinux
> generates security contexts as needed, while Smack keeps them
> around all the time. Releasing an SELinux context frees memory,
> while releasing a Smack context is a null operation.

Any chance this detail can be hidden behind security api?  This looks
pretty error-prone, no?

Thanks.

-- 
tejun
