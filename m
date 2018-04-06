Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-219634-1522985933-5-9629950210775528558
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522985933; b=cxyYEG2ZxzgoS43g+ZJOcfWH8ufNlg3GnKsbSl1jygksy3ljAe
    4rvnBetHKKrtGPTFNq/U7cCp5+03ClZ/hZCDJFeve+gdJb77vBuWmcLylNNJ8mov
    ha3QWS2B/jlHaQcOvKCaq/POPvuLaV/Q23lGh82eZwHC6Jc43NDBVg23FOPX71x7
    mR7j7D61qz3Qbz8ueVjUFi1VmsVw6mIE8LFrq5OiHotat8CnalDizj7g1U8hK/iK
    UailnOAe/YGVTKszNS5vGhmZjdFZv2+D0ennABkpIDUxBugLla6qRKn5PRBqLqgI
    /9L8teC6CziDdgms+vkgOANYuRX88mJzGJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:from:date:message-id:subject
    :to:content-type:sender:list-id; s=fm2; t=1522985933; bh=xykLN/G
    7uRm+8uElHCi3UtrTvEjIlXuVFU1hFIWli5o=; b=BTrasNp7QVDQG97MTGR3h+J
    OcTW5ojvsRi00wmjSm3U790Sx1V3Eg3bI+cQT1H1thuyzM2xfBjNEw36LDMBv5K3
    ZbWMWSimC6Tr5RZEjavlbkEKvn8Cj50/POPCpKObiaXH53zRaeXczd/40eT6a70m
    lh5Zny50nx3cZRf53uYcm+vKkB0ApmonPc0Eley6QSJaXzboUoTZptt4lxG4mkKI
    yZ+nxFYj5zF7JobtuOWw/EEe4pX+0IH0UzRUjSDPssf5EpdkRT0RezdS2Dz0a87v
    PfCq4ychngeoSV8jwPGHW9/o8A16eFRSynNdxU0C8qfpB+k0e8kCStD/OOu3TOg=
    =
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qF6y4pG9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SWxVkEoF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qF6y4pG9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SWxVkEoF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKP8faC9d79j7/mFJstkN51EA7XpQZOfe83q7VvW+YtdXSr8mdOpW13UzxSsjEfUTcftHw4CjM1u4byDyZBd87D/iawtMOQggeH0V96d6MVYWdvHyWRR
    5HHG1Ayc3F5TfFG/Ql/cFOWtyjrN9HWOMagi6TXbW1Bgw/tZEguc2tU/sdcyxygarpyIwW0OqsSeKJMAt3NW5+Ee5i/P6jXEPlufGuvCY7xcnWdrlgw7nghl
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=m8xMgMeX2tgA:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=bhyhgwdzVtYS8JTV71oA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeDFDip (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 23:38:45 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:33039 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeDFDio (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 5 Apr 2018 23:38:44 -0400
X-Google-Smtp-Source: AIpwx4/kcvllegs4sgeptGAfoR1NCh6JAVUeAs+7/WQU0xc3bYRs66CsVM33tNpbBnvC520s0lR052dKNoNZZJ4EIUs=
MIME-Version: 1.0
From: Masanari Iida <standby24x7@gmail.com>
Date: Fri, 6 Apr 2018 12:38:42 +0900
Message-ID: <CALLJCT0MFg6b+dG50cqe_hv6hxmQDj-ZM066BOtQt_wOiC8ENA@mail.gmail.com>
Subject: make xmldocs failed with error after 4.17 merge period
To: linux-kernel@vger.kernel.org,
        linux-doc <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        heikki.krogerus@linux.intel.com,
        Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

After merge following patch during 4.17 merger period,
make xmldocs start to fail with error.

 [bdecb33af34f79cbfbb656661210f77c8b8b5b5f]
usb: typec: API for controlling USB Type-C Multiplexers

Error messages.
reST markup error:
/home/iida/Repo/linux-2.6/Documentation/driver-api/usb/typec.rst:215:
(SEVERE/4) Unexpected section title or transition.

------------------------
Documentation/Makefile:93: recipe for target 'xmldocs' failed
make[1]: *** [xmldocs] Error 1
Makefile:1527: recipe for target 'xmldocs' failed
make: *** [xmldocs] Error 2

$

An ascii graphic in typec.rst cause the error.

Masanari Iida
