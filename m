Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3198856-1526416934-2-3827604623239197166
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526416934; b=a4GQB6x/BGHE0ZfAaYDiK3oeI8BOygSrVhfPaYGJLFRxVOrjNp
    S4IwMNL9jIegh5PYBW8374nfylIL5q4Sa2llh2iN2y29Ue2LyUFDve+XUNu+89u5
    tDnQHmmPXzXb5Y393Z3dgMdBddgcs14Idk+EgqYQUBNUk3Y8Qawpr7oFQie3znB1
    xfTMDFskxlb8chK79AFOyjGHLjI1IrA4Wm9yKdBJ2eG1Hzt3QSMyjt3wtyEsJlYk
    F/0jrs+i5WuXJjpEnqvQfCpNOU6CleEQ7Riz+ptZRxYivWIIA2M38qTEq4PlQq+R
    QSYlSGNzxSDIiLOaGhL7REGFbxPB380UScOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526416934; bh=J1gQ8NOOQ0qTlEbC7+ZHwR7QlEPFrJ
    691NBdcp1LKpE=; b=JhrGj4x77yszBl664m53tDtTUCgY/yS7Yq6l5cTYgOxy4s
    AyToOKDZU4Q7MdyWSkVjD1MCdiC26YKpOTbhdgL31le+r5WDceIwhFGGzJtqjf5Y
    ADGS/qitykEOXSmyOjDt9dyhR31ycn5UtG9fCFGu5eR4RP8v4iaWLTW/yVeBIWsd
    VGpvCCRS/hP8l17/nb6s2HisQVLXN6h3EMuK3HDtsVDAfstBexGN8PlKgQzyE8TF
    UoBu9nOuda9lDQSFzqZPVWwwj4+sGQmawUkEpFe4/AO8Y7yDLxNYNPYMDfnwdzS+
    Zunhxu+lp/JmlPcyZD4lEJU+Muz0gShaSdnWpUYA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLCIiopGqb4OdIl25gC11GRyzC+35TPmpcczUBJsLnsG9VU2Kq+Pt/fTSABWkZfqtUpyU1w217/1omhMnejr7jo8UTikfIk3JVNrI6x4Uix0osNxVGcE
    nbOtP6Nr6sSjSraWGxfMBqeLPCLyUW/YcoNmeLexVr4i0LyQIklGpHc/qRJxJp8hH9WNYjwnn37o1AM9ydpkJGl9q7GgZFvhPjbG/JnvcFf4PoQX4wrg6OWK
    C9n6K69RTlls3ijirm12eg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=3ku496MjA1XDouKguxMA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeEOUmM (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 16:42:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752510AbeEOUmL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 May 2018 16:42:11 -0400
Date: Tue, 15 May 2018 16:42:10 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org,
        Paul Moore <pmoore@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v2 22/35] vfs: don't open real
Message-ID: <20180515204210.GA26411@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
 <20180507083807.28792-23-mszeredi@redhat.com>
 <20180511185430.GE6044@redhat.com>
 <20180511194248.GF6044@redhat.com>
 <20180514135803.GA2777@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514135803.GA2777@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 09:58:03AM -0400, Vivek Goyal wrote:

[..]
> Talked to Dan and he mentioned that he was trying to test entrypoint
> failure (and not exec failure) and that's whey he might have allowed exec
> to mounter.
> 
> I think that current entrypoint test's expectations are wrong.
> User process sees overlay inode lablel which is rwx_t and that means
> overlay layer will allow entrypoint into that executable. This will be the
> behavior on a normal file system where underlying file's label will be
> completely overridden by context=.
> 
> So in my opinion, we should modify testsuite and not run this test with
> context= mounts.

Miklos, now a fix has been merged to the tests so that test passes both with
current kernels and proposed changes.

https://github.com/SELinuxProject/selinux-testsuite/pull/36

Thanks Dan Walsh, Stephen Smalley and Paul More.

Vivek
