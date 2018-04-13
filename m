Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2461903-1523587363-2-13338279774261388050
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
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
    1523587363; b=CVWPmm9D39GRofplm0ilya74BKwkn792P5Is5OTWXLvpfh1z/D
    VEsdy2Cr91o5pNozrER6C9N1NuuL7htQF5+xt67huuyenlbJz9So6g2isUH++xmr
    +eJBh5cMQ/fPsI67tIBTRgl+Sk3QEsNs5F9Emha/uT5r5vbUy3p1+9j7qSdpQZDj
    sYeK43tuemVbf2uTHUXrAXbioK4SZ8kPz22TuSm/2CsJOqpy+47Ym3b4hghy9VNq
    Lvx63Q4TJGQm1H/1p64mt2lwXCfe7lHUJON45bqG610VA/DhU9Bk+use60Ar0uuD
    +jDg+UtATi+qOQZlHh9cUWDXLA4B6jeZvnXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:in-reply-to:references:mime-version
    :content-type:content-transfer-encoding:subject:to:cc:from
    :message-id:sender:list-id; s=fm2; t=1523587363; bh=81jmLzRL6VQA
    mNhLMhV483qj5tEHVaYvpy3MN3ZJvd0=; b=ZI5cJK97uIJClrQubXggbWj7Dbvs
    sYkJMSCx1Q+cls3eglENmjiD6kiwY6/uazI1w1LyVAXo0TnVD+RYJZEfHOH2hm1z
    fzFFvq69P0q/8W8WoWyMUIGw9XyLQhxDRtj+UdB2OrPIbEH++ZMbNgidpVnrqAZc
    u0m8fs7GDcDheT+1E24EuDcE9eN/msR/EhfPPpFbMqA2Z+zlyiK/pG4pBe21OEKe
    jSDSxXH/H/xiuPEh9xtAqjZhbkRgzyaY9gQk5W528TLLsGhBXOp+fRVA6auNjwqq
    SFisOI6W3ICAA2+9sj/PQY/Hq29+VepYuYfiXDi0b99RJyjQnpRy/4nyHA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gGkiAP5R x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cgE642uz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=spam score=190 state=1
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gGkiAP5R x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cgE642uz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=spam score=190 state=1
X-ME-VSCategory: spam
X-CM-Envelope: MS4wfL9mdgrnUoH2mAIMthtW8TMLBPy6jlq8j2A/JChpaeMwU6RA9PVH6T0NURY7w49BbCiA9uzpSqaLG09xLbHcGaGLBUKMFS9yd8zO1UgyCTW5FEZc2qCb
    aWxpTybgSK8AdoKIUoJfbgKnE0EJCPg/gZK3G7xYrOFV0j6NGO9UwfDbtkbbvaZiVGCRc3Ptn5rp9oNLeQfeRxuBKucu6gutFYzVJodhEyoGgXvPLvkKdeT5
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=0aEd6-21V0kA:10 a=Kd1tUaAdevIA:10 a=1XWaLZrsAAAA:8 a=X8nGv5HNMEBxuxuXHBUA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752961AbeDMCmk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 22:42:40 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44005 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752489AbeDMCmj (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Apr 2018 22:42:39 -0400
X-Google-Smtp-Source: AIpwx4/NCan54zupxMfMj/cgQOGUyTyNXGJv/UmxCbseyOVPGx16ys8hI6XSSwJ31Fx4Zg96VmBnXw==
Date: Fri, 13 Apr 2018 08:12:31 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20180413002951.155762-1-ghackmann@google.com>
References: <20180413002951.155762-1-ghackmann@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Revert "xhci: plat: Register shutdown for xhci_plat"
To: Greg Hackmann <ghackmann@google.com>,
        Adam Wallis <awallis@codeaurora.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Badhri Jagan Sridharan <badhri@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
From: Harsh Shandilya <msfjarvis@gmail.com>
Message-ID: <F4A1736F-B00A-4EA6-94CD-BCD6CC7758C3@gmail.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 13 April 2018 5:59:51 AM IST, Greg Hackmann <ghackmann@google=2Ecom> wro=
te:
>Pixel 2 field testers reported that when they tried to reboot their
>phones with some USB devices plugged in, the reboot would get wedged
>and
>eventually trigger watchdog reset=2E  Once the Pixel kernel team found a
>reliable repro case, they narrowed it down to this commit's 4=2E4=2Ey
>backport=2E  Reverting the change made the issue go away=2E

Are you allowed to make the repro steps public? I'm writing this from a wa=
lleye and would be grateful if I could test for this in the modifed tree I'=
m running atm=2E=20
--=20
Harsh Shandilya, PRJKT Development LLC
