Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2505978-1525351158-2-12347671056279286905
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525351158; b=Mj/i+FBSc/tmbLOlIuNKVa3/8VptsuNdDVxpyUaDsAWIsgKjBC
    5UhlSvInZyNffpt78D2rpoYu6dhtRcPWe8YpN7NO/wSpgHIaOP1Wkekb8MdGL0jZ
    CHxQip8BqHNOhlrJUK18cLd5sPzcbDQftVhBepPyxTS87V/wnGRIrRI7X+jU/2Em
    SpBPkHqrmXsZLziCCtgTlDDPpW1LhOplpOr//nPnAxbz1i7Qwq1LC1jA1Cs5olmP
    b3C7S7X5aQVhuGQowOHuQYtSYzja3SEr6YveiYwVNWhTQJPRKP1dQGRuyVi59PEc
    IlSih19IQSrDy2jS0ASRdmg1Rj1AUNcK4rBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:from:date:message-id:subject
    :to:content-type:sender:list-id; s=fm2; t=1525351158; bh=sMIspWt
    dMsvuAfev2Q8WDexCWvN+9QiHE8qCXHXH6go=; b=MowLNarDBB+8ISTVUpXde61
    4fEbuuYdn8pFIlT+KOeo7+MPMrQH5CTqADH/OO5Yvm319UJZrDa44+bJPKmXTadk
    Wexvlnmm6uE05QwBFZGaqG+FB2YWckjPCsx5xNYeUi76xfztbStE3wtMTWXKV4Js
    6UCHkA4whIFgTReMY03fHbeuHAaw3E3HLKWudh9l6Ml98wCj8/QRdCRvRv62b/QS
    DXD6SesS/XzRRKYduTVpgi8DhniXGbAPJXU8Fed7QLeGBWbY7l+1Xb4jUOQlV3Rc
    w3pakRRSctlnrPR4gdJWZt9Y/IQX7A4rCZDCwHedbsjXVJbx95C7h7RtjQC+muw=
    =
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=pUyN8VgO x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=IaZgGqCz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=pUyN8VgO x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=IaZgGqCz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBkoEapnPIvQw/FxyvCVH5YvxqciSJlw9RoGup9SfYdqrA6jsxFd9FEDCXMOTdNllgXhuds84asC/FeF0cZwMmi9d4Ks2XBrOSATPFhXsBezlgkfFmEA
    UNVJ/PUSLPOWEBuC1DKek+5dV7R8LaEHZ9OIqQXlbGakMVxSkqyUkeh2bZ93sZySmZor7pCy0E6RNue0ajAcFUBPKE6V05nqpt/kvDEGnpLeRl+hXVRZySHF
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=a7Dl5lcatpwA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=_3iAN5dmJPxjh_Nw_akA:9
    a=QEXdDO2ut3YA:10 a=_zDC0-8_D9QA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeECMjQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 08:39:16 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:35569 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbeECMjP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 May 2018 08:39:15 -0400
X-Google-Smtp-Source: AB8JxZqYDQAn8tMzCUx25XlFbVCj/tcVzfnloDWqbj4l2bbq3v34rv15Dv7pn1PCj3zhaH8++cq8WgWrSFqfsQjHeRE=
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Thu, 3 May 2018 18:09:13 +0530
Message-ID: <CAHhAz+hrmLiRJ77cM=CYj+iyH8aUJ64R6FtAwGqqB2pOS0n0aQ@mail.gmail.com>
Subject: serial: custom baud rate
To: linux-serial <linux-serial@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi All,

>From include/asm-generic/termbits.h , I see baudrate can be one of the
standard values: 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800,
2400, 4800, 9600, 19200, 38400, 57600, 115200, 230400, 460800, 500000,
576000, 921600, 1000000, 1152000, 1500000, 2000000, 2500000, 3000000,
3500000, 4000000.


If I need to set a custom baud rates(e.g. 14400, 128000, 256000), does
Linux serial framework has any supporting method?



-- 
Thanks,
Sekhar
