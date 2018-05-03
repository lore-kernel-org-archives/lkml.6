Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2775900-1525364537-2-1258111303550008599
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525364537; b=k8aEj0hodPlGQOYFxgEGChfNbuaMCGRl+DzVPbZbyZEGWH5/W4
    eq208y2c8c8eV5rPHJYI//E+EPjn/DIGHhU92GHhrfV+Roac5WnFNHnwGQar0v0X
    isR9uOTfC8ls6qTBFky7DzdZoOsL9e3o9ExPuFCU9FBiywzcvGTx2Mru+Rs74SE0
    i06vj9c8EIb4l2ynHAf7vMpheMEk8YbGb62zuiRDAG5dgcSCEJld2yNK67oQkJYB
    IW1Yvixo44vaQRRUhfV/UgLcZWPUxX1WKzdkTFpxpj/8B8AJFI2UYvEYUITMPVSB
    ecjGyK8QDAhkY77IKV/xrJdWoKUimnT3S4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525364537; bh=tzC1UUktbaU1JS//xguZlZyIyNraHU7mJXoAG4uQcx
    w=; b=WzBU4WN+gwr1qualatLAOJUWQZDAFqzZJ9/YyqJiE8SOICAe2XQt42ujy9
    o9x60+QA3fdmWkp8mK4Dlt2EflS57HJr9pN6VU+jH9WRahAQrJXe+v5jvJY2hXD7
    KuDgqJgEtV+Gso4a6V3+9s9U0J1cwc1VEdCv/f8wbtNwhG5favitBtnr5LvDupG/
    4maPiS+0Vy4YP+lga/ET/1PmZ9CrpbULMDeUPpfBKLlSGNFqNEByOHo3b7IbOFAl
    C8nK1t74hVxSVFJWeXFWkUY7iE0ruMTAf8JOkgSfyMScvgAwoInJeTqzy+Y3TVY2
    0t3UD6m74xv/1ZNJybCFZ7PTFzWA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=BUOUMp24 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=YS2FBDTR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=BUOUMp24 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=YS2FBDTR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIhlVxpTa0+OF6jN52z6q5QjialZL2Jv7ZKASlmBkQSOqaTS0pzWBzMKxGaKIK0kJv1eG32fEd9qwizdWWxprEi1UH/IBYDthxPgnuKvmSyVQE3b4r1y
    BEuCKTcAD/dEK/FKmxQD5wUVd5354oWf48SR5nalxuynPPUxiBnVPbj6N/k7xh6PI1W3+juzXzrrKtOdhU0PdWMChb4Wdlgp/HgK3zCiG/jJ8W1Ln8jNwDky
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=QmzpKjqqkK4bt3WRvCoA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbeECQWO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 12:22:14 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:41479 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbeECQWN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 12:22:13 -0400
X-Google-Smtp-Source: AB8JxZqrsITVGlxrGRpfSZlYspD2DMRWtTjvcJX2TuYkY/r2LkNehQBarMg2NdDKL+JLGPjHvoEvGIlYnCQzSOjUPrk=
MIME-Version: 1.0
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com>
 <660904075.9201.1525276988842.JavaMail.zimbra@efficios.com>
 <CAKOZueu_7Ha_WXMyxqMEScXo1aHWr9qYRxqyb-Rpd4k1JP3xHA@mail.gmail.com> <1718748931.10084.1525363941807.JavaMail.zimbra@efficios.com>
In-Reply-To: <1718748931.10084.1525363941807.JavaMail.zimbra@efficios.com>
From: Daniel Colascione <dancol@google.com>
Date: Thu, 03 May 2018 16:22:00 +0000
Message-ID: <CAKOZuetW5NEvbROjuquQ_AxrW7BqR5Qfp6BYfy+zUrnPkZDaTw@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 00/14] Restartable Sequences
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        boqun.feng@gmail.com, luto@amacapital.net, davejwatson@fb.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux@arm.linux.org.uk, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, Andrew Hunter <ahh@google.com>, andi@firstfloor.org,
        cl@linux.com, bmaurer@fb.com, rostedt@goodmis.org,
        josh@joshtriplett.org, torvalds@linux-foundation.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 3, 2018 at 9:12 AM Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:
> By the way, if we eventually find a way to enhance user-space mutexes in
the
> fashion you describe here, it would belong to another TLS area, and would
> be registered by another system call than rseq. I proposed a more generic
> "TLS area registration" system call a few years ago, but Linus told me he
> wanted a system call that was specific to rseq. If we need to implement
> other use-cases in a TLS area shared between kernel and user-space in a
> similar fashion, the plan is to do it in a distinct system call.

If we proliferate TLS areas; we'd have to register each one upon thread
creation, adding to the overall thread creation path. There's already a
provision for versioning the TLS area. What's the benefit of splitting the
registration over multiple system calls?
