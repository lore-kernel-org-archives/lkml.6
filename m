Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3892947-1523368405-2-7925771543106298382
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523368405; b=nnICrCrreXsZY7kBquQ+F4QGFOm0Tyb+QSBvFWU/B02W6acuTr
    1IUq3YbEBhoePXTZ44L0QDoITeLU8T5stgfqS6rDcprI65rg26yhqnoP/X9N3cnM
    wRnSn0YEyD5C8jDG0Osz4734kYB5GkMlGAea7ae3YMjns1G2dJqIj8p6IkPNprNO
    87x/p9YYtVtH6NOaPNZ3q+/eu/lFykc0vXb9yTsLr6Gs+9Sn7cHUqUNDfYay/wv7
    G53P3ngceDDhacVKLYwncvM1FbE0An5CGGgBp9os19LGU8FZ7HeF7spggSVqgxJb
    pqM4RFqy+FQYQ8SAOjDEe9f7o/6l6s4gzZ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523368405;
    bh=xQ40VVVm7LMI5APNJGiU1+WGdEAXOJmWyDMTcmsLYmo=; b=lbvTBWZS9gj+
    ihTDozWLi6Sn1ppNQ3eK6ukYD8xO2Xn4OZ2RAKAwYiy+GdBmYUevdXErKr20+N8P
    EMURtrZfwPnyxYv6CLSICQ+k06ev6/u68I/vuBW4PS6h7TFlE1NV4T1x+J3O1prg
    VOdXMRbCTIWdmX5l58LxUIR6fOmdB/hWT4G4Ur59jbhGn8oILsdX+rrJkiG6U/NU
    Vt0pwrfpMAjXXz+/jklWCgffIDru1HjiOvdhkXDO2kZvS85FEPS1kq85sN+Xu7vn
    d0CNwIWZlNfkwpZDYCc6akyYYoSMUex4WbUfN7BeZOW+h8YCXjhXvGdI/BKCc20u
    Q1j0notAQA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=e0jVOkXj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EgPiOX6D;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=e0jVOkXj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EgPiOX6D;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIW38FD4jYWo99idY2+g7pS9ih3VxrDVmLpi7QT24lvOY4zkRNNvnLsiizv5fsBuV73dK34Vwq+ATbYyeH57BnGxNWIxKfcpgm4q6hyEZei84WqU3rDR
    XAN6hMNMN1/g8c6O5RMBMMKasgBqkmVVd+e06FjlTMbsub5PMvq491oEciECFi6+dRXymfBzQ+SdSYGEo7kxZy7T1a4x95sqnm/KyHwxPcKdEiS+4RJp/0EW
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=XT5P2k9a7GMA:10 a=Kd1tUaAdevIA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8
    a=yZGjzPN3ceS47gLXukUA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754437AbeDJNxL (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 09:53:11 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:46949 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753149AbeDJNxJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 09:53:09 -0400
X-Google-Smtp-Source: AIpwx483NjWs3z5Z2IrQbwTO10o0nJ+aDdu9K4fjRhc3weT/7FRBCmy3f2rHWKYuEsxXiQt6deK1Lg==
Subject: Re: [PATCH 1/2] slab: __GFP_ZERO is incompatible with a constructor
To: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        stable@vger.kernel.org
References: <20180410125351.15837-1-willy@infradead.org>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <fee8a8bc-3db5-a66a-33cb-0729143ba615@gmail.com>
Date: Tue, 10 Apr 2018 06:53:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180410125351.15837-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/10/2018 05:53 AM, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> __GFP_ZERO requests that the object be initialised to all-zeroes,
> while the purpose of a constructor is to initialise an object to a
> particular pattern.  We cannot do both.  Add a warning to catch any
> users who mistakenly pass a __GFP_ZERO flag when allocating a slab with
> a constructor.
> 
> Fixes: d07dbea46405 ("Slab allocators: support __GFP_ZERO in all allocators")
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: stable@vger.kernel.org


Since there are probably no bug to fix, what about adding the extra check
only for some DEBUG option ?

How many caches are still using ctor these days ?
