Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1229218-1523416441-2-10827400124464789176
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523416440; b=H3txkkNdlTqqoSF69F9DjGy12AmwMPd3m0/k+GgXAWC+5tjGZd
    Sk8RjH7rYajw6sgwV4/Wyk5tIBJPaRfDEXTmEgXYq/YmPYO2/xQGsBXRxUGkTgxj
    ehFCLKQkPPsgQt6oOjAJC4UmfVHWRYwy2co9E5NHe5uo3ExT8jyoKifSucIYmQmD
    YV8Sv3TnuG2le6TmfzvpKOwArM8rlPrQfJ/yyuyTbs71xGfW2m04e6w0UbIXb25J
    okdpfmTiwem2+QBDQj5JhkABxGSW+FrO6eBnFMJz3eawN9pAOyM1ogMvOJblSlLv
    f7RrCH8rEK+vsjFLK6HKdloXNct2tyDRadxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523416440; bh=eoDJVZiyu9ofZ2UCg8V0M/bU3WPYfneFqPivudRUW5
    Y=; b=rwmY3qSOK60NNmYXnlj0WC2wKJnl2/xPJKRqwePzIm0aGPqbw8eiUHX+te
    +xr2+XqPkUx5AWqtTU1CmfgGdK2vtRjGKY+f0JEswz3bWYX/WnettzJ9uCEvXO+O
    pf60P395HvlI13j7dBEDW4KCK8N/cwfqYcz2PJZzmBiFVfA4MYQKD37yJplZjjPN
    KQe4j4fDPF0TYlIKlMv+F5sGyWHA/gY5SREktb2Ped7fLWex1KvqqTWJVOycI3KW
    /cs70nnHLyiS3PwTUum1mzog94cfmlD1qKOFrG4V8XoLHcec7g5tQXQP1E8ajSGs
    GJNoYiJ/PqtsznRL1+RPZlCYBtmA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=GehDUZNQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=T5G4aeLg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=GehDUZNQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=T5G4aeLg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPyCnr6jYjy/XEuujFjJrJKT6O2BgfroojT8w6XdS3ZJ5lRavYAUeY633wUC5dVGKpvk54gMAsVgmgnoamRYfqVa44B53QNgl+kPdq2oNReeqF3wf+/J
    mqezoo1XShC02rckiKOa2VKgstaaBw8eLCbl14AIClKuivIwbjtFbr3LSe5wL5B/7DlEDqYPR+RcSQmMVD7Q21M5QMoJWMVHcx/4jtvObwR35xNm5qcmQorl
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=9Pvjed8DAAAA:8 a=PFpMCP7YTIj9feKiLWUA:9 a=QEXdDO2ut3YA:10
    a=98p92QZDbKytObK42HRb:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeDKDNs (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 23:13:48 -0400
Received: from mail-yb0-f180.google.com ([209.85.213.180]:36751 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752500AbeDKDNr (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 23:13:47 -0400
X-Google-Smtp-Source: AIpwx4892I75WAEY4A4Esca/JJuu/O0fDEX8o0BxUzQylOW7TLl3se+Kri1XRTm5BiOmSb6iGuNQ37wePEMaEJhA1lA=
MIME-Version: 1.0
References: <20180406080324.160306-1-gthelen@google.com> <DM5PR2101MB10326066D3508A2D9892B508FBBE0@DM5PR2101MB1032.namprd21.prod.outlook.com>
 <ea1a6d50-b8bd-237b-5ccd-2726da54d8d6@meituan.com>
In-Reply-To: <ea1a6d50-b8bd-237b-5ccd-2726da54d8d6@meituan.com>
From: Greg Thelen <gthelen@google.com>
Date: Wed, 11 Apr 2018 03:13:34 +0000
Message-ID: <CAHH2K0bcehi-OH3AQs-VK7+d4-THOVXARTXik2UxRhZOuDrHTQ@mail.gmail.com>
Subject: Re: [PATCH] writeback: safer lock nesting
To: Wang Long <wanglong19@meituan.com>
Cc: Alexander.Levin@microsoft.com, npiggin@gmail.com,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        heguanjun@meituan.com
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 7:44 PM Wang Long <wanglong19@meituan.com> wrote:

> > Hi,
> >
> > [This is an automated email]
> >
> > This commit has been processed by the -stable helper bot and determined
> > to be a high probability candidate for -stable trees. (score: 44.5575)
> >
> > The bot has tested the following trees: v4.16.1, v4.15.16, v4.14.33,
v4.9.93, v4.4.127.
> >
> > v4.16.1: Build OK!
> > v4.15.16: Build OK!
> > v4.14.33: Build OK!
> > v4.9.93: Build OK!
> > v4.4.127: Failed to apply! Possible dependencies:
> >      62cccb8c8e7a ("mm: simplify lock_page_memcg()")
> Hi Sasha,

> I test the memory cgroup in lts v4.4, for this issue, 62cccb8c8e7a ("mm:
> simplify lock_page_memcg()")
> need to adjust and there are several other places that need to be fixed.

> I will make the patch for lts v4.4 if no one did.

I'm testing a 4.4-stable patch right now.  ETA is a few hours.
