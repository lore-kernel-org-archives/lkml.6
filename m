Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2697307-1524560334-2-17683864460404842920
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: from='ISO-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524560333; b=iLvbp6fNnaoaMwG9QJ8D2/ctI2ARKVE6p/zGyWWuxbS0r+l3xU
    X9erL34+DZ0W0aguKysQ0JDOiuLzG2DwNSF+7+O/1XxUtpbtrcJuLWSAYtykDSDo
    CmJF/h5MeuPQiCp5WT1IobhG50AhNOhjfz+ERMlyVoo35RRJmniDlFZTEbdV2/9a
    6B2E/iMhbNTBRISrpo1ZN26NdgHUpUq/qTrQHAfEmXSWTL53+1zcWj5DzYjHeiYR
    qUgZPDO2fh+w2K5TD42+5DwHN0TzpYnc2Bn1P5Vo5oJ7MRzpHbvpEUfqdMFs+Kvi
    Woc0aHFGiZaCVd1/cJx3RBHNb7kytiTcim0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=fm2; t=1524560333; bh=Ma+2+DSETh
    gi7tQO+y//kcG6DLnShvFpRRsLOjN1goU=; b=gJDxtRX2U4/i+fuuygSOMk1nMm
    SxRi5cgFMBN9b4TMqyyjcilAuu+pd9Yiv4PKX7+RYgnELeE47QdMDZGyeRKGH0X4
    4pJt5r/Gq/8GEKxRrGn2jfL7QYuzbfzFonidMPJn10CLn51L+Y2hpZ+8nByXxxvA
    TEih2x39Qf2phOJOkwzWMvEpfQLHjf4fZZx0VT1iIROYOtO9RinNp3g4QEC+4k7o
    Av+U1mbgHfh+uvAQpff9FoWQr6jlDco5NQ7oceqmv5FqvMuRIIWzUiHdWUtdOC4J
    oS7ix9dBvh0r5vB06jJuoGvrFVMp2ipowkn/lF/ACle2PNKIRKOydb76Qh8g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sntech.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=sntech.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sntech.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=sntech.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM2qyD2CrdMAQH9/jTkH0wsNVm+3DzLqIAXil6OPlIwtHy+9yn7fd1Q8Se/EQheAQIAu7hGcH1/PFpz9sG/d1iAO/kpaVIfgtcZ+oAZn5gVMGw94DIVF
    0d75g+f+YZa0Oyyrj2CjMaP8KorhndA6l5g/mSWyMzUYBjv8+NKAZyPAVzonSxdnEf22bGA7r7vzM/YRNVlxengmGP1+nTD0+JsQ6cMrrPdrhtPwd7cGBqc+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=U0zfkUukAAAA:8 a=VwQbUJbxAAAA:8 a=6yyd5MNi27w3wdfhYjwA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=rXRU1dkEVDZ1dOovDhQH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752771AbeDXI6t (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 04:58:49 -0400
Received: from gloria.sntech.de ([95.129.55.99]:48384 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752743AbeDXI6r (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 24 Apr 2018 04:58:47 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v4] usb: dwc2: dwc2_vbus_supply_init: fix error check
Date: Tue, 24 Apr 2018 10:58:34 +0200
Message-ID: <3454244.YafNKb8Syk@diego>
In-Reply-To: <CAAObsKC3BiojwOhHoDe1-NJ-p135GZmpLGpTBRKP3-9ryuY2uA@mail.gmail.com>
References: <20180322093943.49717-1-tomeu.vizoso@collabora.com> <410670D7E743164D87FA6160E7907A560113AE831F@am04wembxb.internal.synopsys.com> <CAAObsKC3BiojwOhHoDe1-NJ-p135GZmpLGpTBRKP3-9ryuY2uA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Tomeu,

Am Montag, 23. April 2018, 15:24:04 CEST schrieb Tomeu Vizoso:
> Hi,
> 
> could this patch be picked up, please? Or if for some reason it cannot
> be, could the commit that introduced the regression be reverted?
> 
> It's causing some tests in KernelCI to fail:
> 
> https://storage.kernelci.org/next/master/next-20180423/arm/multi_v7_defconfi
> g/lab-collabora/sleep-rk3288-veyron-jaq.html

I think at this point, it might be good to do a "v4 RESEND" in a _new_ mail 
thread, because from the lack of communication it really looks like this
fell through completely.

Ideally also include in the commit message that his breaks kernelCI tests
and real board users (and of course recent tags).


Heiko

