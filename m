Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3243332-1523345301-2-8685058828053417925
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523345301; b=lgWcLACEd6wvWyLMN+klGQP7yFLsBrDczQuissmm4ObIQnCb1y
    b055ZGdufBPWV1/qdLfeiGOAa9cz2RdDP0dddn+9BFvkVT/Kyw2G29+ZthWaYvQV
    wy3rjaeBks7XW4/3gzkFB78mSKRhNsy8k4/+ZupcYSP4EwK1lK5bsvPIOKrLqfUg
    UxD8seC8rlHM3o571T6k7KGc/fdZQbpaJ00DLNb5bEcBD3oUWSyq8clTeIrqW/pj
    snutvKVXwzfG3B8dRa4eTi91kvp8wobx8Z2AjpyGW+Uz8BPwfQcupZ8vg+UNdbMg
    zBj5RHea6/RJ9/IJnFm6IfZmfdFYZypMuyGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:in-reply-to:references:mime-version
    :content-type:content-transfer-encoding:subject:to:cc:from
    :message-id:sender:list-id; s=fm2; t=1523345301; bh=cFKU/LYTDJ7K
    kKwrN5sVED1kok36ZDovNjZBW7BGFQ4=; b=K+CC56vKyCpvQeNMpsQ2QpXB0B7P
    5wul65kRItjb/5WjeDvboutlmzFuTlbtqEJKVfWnYHvviQcF8Qc/CWpZAW/0y/Aa
    VqHL7UZBGtNgo0xn377MEYBeqBe5xFn3EKBU69w8t2IyCm61OYhh3U6ceTO8NeeU
    1ncWueCOTdtYtIRnsWLFcdr26uqGFZjB3kH1N2NRNvwjeL98h/l5d01tzLIogiLL
    pyRI7xJdjkm9CjDmO1F0t71fHv/ACttIMNZOmgAZBAQMk2kit+BYBMSH+uxsucJt
    YWHkLbAvde2MhQ0JLqowPTJphrkfZ2+oNzjXO5IIPkUcQQVqmNkJcnuafw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ulA2jWOI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qUA6myqg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=spam score=190 state=1
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ulA2jWOI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qUA6myqg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=spam score=190 state=1
X-ME-VSCategory: spam
X-CM-Envelope: MS4wfEm0xCo28/8XgP4L9DX+Cnvixkp4JhkQFizMAGdITmJYZLrO0yTlIWcH1m2uZegb9bnfYDl9weJPvYFZqYw7sMJJtld9VA6dkgvA4QZwZsQ84lGCC5HB
    Sb8/kfs4L7d5OXwQO4tBYg5lbj3VaCl43ClctfIJV79JZg4NfxA7nA0jNcsntZmrTfugP8NYzeKFBS0NOPEcnReGioV4jieFvPNpkXmDA2fFeePg3xeJzSaE
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=0aEd6-21V0kA:10 a=Kd1tUaAdevIA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8
    a=hczLF5baBjJ9V6-OXH0A:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeDJH2T (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 03:28:19 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39982 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbeDJH2T (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 03:28:19 -0400
X-Google-Smtp-Source: AIpwx48INgaqxwHEZYRqCxDBwPjtzzHgNynjVBo/ScS1PAi+XSbSQt5r3CQsDxxjyIW1EXCThnvm0g==
Date: Tue, 10 Apr 2018 12:58:11 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20180410071346.GA31194@kroah.com>
References: <20180410071346.GA31194@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Linux 3.18.104
To: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
CC: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
From: Harsh Shandilya <msfjarvis@gmail.com>
Message-ID: <4656CE49-AAA7-4698-B71D-A968DBABD27A@gmail.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 10 April 2018 12:43:46 PM IST, Greg KH <gregkh@linuxfoundation=2Eorg> w=
rote:
>I'm announcing the release of the 3=2E18=2E104 kernel=2E
>
>Only users who had build errors in 3=2E18=2E103 need to upgrade, this is =
a
>single-bugfix-only release=2E
>
>The updated 3=2E18=2Ey git tree can be found at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable=2E=
git
>linux-3=2E18=2Ey
>and can be browsed at the normal kernel=2Eorg git web browser:
>	http://git=2Ekernel=2Eorg/?p=3Dlinux/kernel/git/stable/linux-stable=2Egi=
t;a=3Dsummary


OnePlus3T doesn't use the fec so nothing there to really test, but this bu=
ilds fine=2E

>thanks,
>
>greg k-h
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
