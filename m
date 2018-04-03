Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2225902-1522781852-2-2709981294557197619
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522781851; b=Jent5eHW0fYpY8qrCoWjRXF4wizg+VtZDI2mo4oB1YqZZvzG+1
    af6lVuuYqS16bgVP0zqrHEzcxnqVuXAygVgIRySxzvEerK427GKIfqqYiYCJamQ6
    fNp3Hib8nl2R87p+Pe757NuWFYd7FscdtgAOb8d2FbZL42MPu9Rwgo2ai2W+e2ZM
    hKzvzxvCZHlPwmqAwZPRICjDqizjhv5x0/m/RV0aaQNRYNsViknj3vv6L47W8zsK
    UzLOqOJjgI7Go7Q9ZPRlDfa01ddLbNgTNC5hXYPJ7c0NB6ffh7/7OU3D1XrT2v1J
    WaCqwPzZ86N+5nKqHzu72IvVjUtcKO86Vb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522781851; bh=N9BrJn1Sf9IJ4BABXgHvPJaydmV1YT7UBj1W/oKNmo
    0=; b=mZaIvM09gTf4nKOqN2VrQA+XoLRj0zKDPVQpATH6Dg6ziXjqEtLx1TnpbX
    /IfNiTWR02D1IqnIhHOkoGqghhOnP4BybgG6Y9qD5J/u8ujfEiKEeMXseBCmSoT8
    2oLaVSgYPvjrXA0g6aBIZoumGhfDk1Heoqii0VnW4j4SSmrhNj0Z3wypW0+ViCNs
    wuVEPgpp9/PkCjk56uTaq9sR/4PAq+N3/g9mxLD5xhzs7JMyLz6ADOGxBS79ttz2
    FaiNQSs2UCnIoTf9ZDPgR49LPyyjMaryXizrvWnYwrSLU6pbFyrqKec/uPBxoVQ4
    U7RAc6oj/YQ7FKeK3qxaOoaPcJ/g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Uc593KXi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=eSsayK98 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DQ3wnDns;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Uc593KXi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=eSsayK98 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DQ3wnDns;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIZeTeOi6GC9yto6gR2AhNHEyLI5uXqwZS/O5ySxGPpiAKmRmOsyMxVlYNXw5vkA2HFdX498xP7AzOJxsPKL4PWO8T6mhahmWYEhqOHJuYBkOBCQYY3o
    hM5dkxF47kVyONj5AbnBbBWPvD86taCGITVU4Wfu1q8XcXdw2fNPXEpAHVd9D7v1nHDde5tpSst+W125TnQXPKwmCXlo1Fw8yzTyQkFMS9H6XBiGItNBDVmv
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=-uoBkjAQAAAA:8 a=VwQbUJbxAAAA:8 a=9njl3yIQHirBXqt2OuMA:9
    a=Q7cOHMkXx3qRB8Is:21 a=iXzm4GJm0ymKBAMI:21 a=QEXdDO2ut3YA:10
    a=A71SCvCayfUA:10 a=y0wLjPFBLyexm0soFTcm:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbeDCS53 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 14:57:29 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:37459 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbeDCS51 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Apr 2018 14:57:27 -0400
X-Google-Smtp-Source: AIpwx48lV/hAjEDdCfApaUSiRKK8xY9UukxantcldQLQmKJtn72LxJEmjkXASYFlJ3iJjr/lD1Obear/8HryOefhxQk=
MIME-Version: 1.0
In-Reply-To: <20180403181457.GB17679@vader>
References: <817147544aa3ecc2b78d6cadeab713869d8805e6.1522709616.git.osandov@fb.com>
 <20180403181457.GB17679@vader>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 11:57:26 -0700
X-Google-Sender-Auth: cvqtsn-y37mhkv_iHqX0SLsWIlg
Message-ID: <CA+55aFyDWoumDsNKNYD8B_zdMuFc19+Ngi0Nh7bUGVKn9TT=OA@mail.gmail.com>
Subject: Re: Please add 21035965f60b ("bitmap: fix memset optimization on
 big-endian systems") to the stable tree
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 11:14 AM, Omar Sandoval <osandov@osandov.com> wrote:
> Just wanted to make sure this doesn't get missed because I misspelled
> the stable email address in the patch. It applies to v4.13+.

The "stable@kernel.org" address for a stable cc is actually better
than stable@vger" imho, because afaik it still matches Greg's
automation (that also picks up on "Fixes:" tags), and it does *not*
cause extra email flurries when people use git-send-email scripts.

iirc, we had some vendor leak a security bug early because they
actually just cc'd everybody - including the stable list - on the
not-yet-publicly-committed change.

Greg - if your automation has changed, and you actually really want
the "vger", let me know. Because I tend to just use
"stable@kernel.org"

               Linus
