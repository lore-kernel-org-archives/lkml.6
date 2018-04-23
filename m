Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1269041-1524492939-2-720645170098051020
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524492939; b=NsUZ84La9Q/tbjvI/DljnG2Ixic1b2ShsgZ3oMopERi4U7kSFK
    Flkiyginuuv6WElndoAsoWPSJlqi4RWU65Q0IeQOG6jYMBcRcgAEjwUmYWV3uCHv
    Ylb5iTwomRlHhgyzI2kzwFG7xG9P8MRc9MXhGuDJrOU5uzrF1qsQYRM6tK32sypJ
    uRnCoPLSzHEvbUhatOpWxEmtBfrOAv+ysCSIR92Ny3u7beFgZ2606h4un8lEbkYq
    a+dUl/1tm6EF0QIRVOKqH0SUgHNt59Gf5ZzgNY7r0ottpYVtwB2feN9U6jjByUDM
    EM2S1FHWFY5RTWW21y9cbSOsJzFEkqQRD0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:from:date:message-id:subject
    :to:cc:content-type:sender:list-id; s=fm2; t=1524492939; bh=lHLd
    0UxSfLnoC6Z9z0LgL8ivEClVEFSYY0Cdm2piy/8=; b=aB94qeLETy+K7uQI/X+T
    MpCJ134WA4ULH2zenhbaKNv2LB962L0WpVhNRtjJhx3hAIyCOJauveZuSNK2RW6X
    Uv9ka8C0ZhkzTltgHuUPjFpyBh5QOfC2/qnhtOX74OKLb/Od5dGdTgaz08vWmOhm
    9QuVip1CvvAi0KBfYFnRlJkq7dOpjM+K5tscGNCtaxUUtV/qH2jJPEs1x9+bs6T4
    JN3EtbigzXmhwbxtoUwY1HyLSJUPE4sue1Ubh7CCWuissuq0TtbEFu1hqkdJVbY+
    KRCGSJwPFC7fVZn69KP/k8aSnJd79hTm3vU4QWHu6JcKHMEWnpwBk7MIcBv3RPAX
    1w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OfTSRskV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mYkKstJg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OfTSRskV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mYkKstJg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKx94oKEzrDaLYTDJ2r1sPBYU84JmJ6Qpjpz40T17Ir9x2toyvhJoRPsXD7lQ7vg94pyarQrL4zHkLkBTFCw+LqoHWynUYbt4u4x9v3W7EZQNBIcUF2B
    hclwRgjnHGsSOl00ewE0nJvn6iSdNQLhNIhMk5ndATXApZRuAUG7dSJcoyRKZn4pheY3sg9wxLgHJ27YavuZ/QKPrDBtXmhnJrIT8DiYP9COh4+DzWjdkHnI
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=oKQYTnOvZvwA:10 a=Kd1tUaAdevIA:10 a=gu6fZOg2AAAA:8 a=FKYsJQZddeuuKPT3cFEA:9
    a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
    a=2RSlZUUhi9gRBrsHwhhZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755770AbeDWOP0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 10:15:26 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:52035 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932066AbeDWOPW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 10:15:22 -0400
X-Google-Smtp-Source: AB8JxZoIwiCIj1345FS1/qKIOA5qhOIp8CLYxjOvIp1IiNwSBppX0W8EY5LhfWwfn3Ihvd3fVMNIg7TNiaSIGcmtU8U=
MIME-Version: 1.0
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 23 Apr 2018 16:15:20 +0200
Message-ID: <CAOi1vP-oSB65aqWkYX+2AWMHUg4Q8jeRkN65b1xftACR1A=dmA@mail.gmail.com>
Subject: Re: [4.4,50/97] ext4: add validity checks for bitmap block numbers -- regression?
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Theodore Tso <tytso@mit.edu>, Wen Xu <wen.xu@gatech.edu>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

Commit 7dac4a1726a9 ("ext4: add validity checks for bitmap block
numbers") seems to be the cause of the regression reported here:

  https://marc.info/?l=linux-ext4&m=152416385122029&w=2

ext4 folks are probably busy at LSF, so no reply yet.  Should this
commit be held until we get word from Ted?

Please excuse broken threading.

Thanks,

                Ilya
