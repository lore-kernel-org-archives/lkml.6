Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1144428-1525704442-2-2568067598755405411
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525704442; b=apQ0kxnxDwLZTKL+I4si07Eb94GWNM4evy+WlSzlS5+IKtllLo
    vdDHVRtuQMKcS7lypNVM4tBkFaRw/8jkwxu4n3cXGE5KS16Cr29/7QYisbsBf2s4
    9wemLD16mO8infDdwjHwOiDzIQJVWom6RWMhU+h+tO8LXxgxfePpIPN1Jgh21Y07
    g55/TzMErcXOUHusd7vJBPklCbOHjDxTYQDyZxrGvFxIeddjZ42wk55h4SM2QP0+
    hkALyy7eEM/CfKdryolGCrlawa80UiO8a2BkaNiwBnBWW5kgIYlI/pcrRSSgoQto
    NUAgzOzkt1UvBKTViR9PW8OR9KKl3XdQZPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1525704442; bh=qsZu5NZ50cX5aKDwFl0lBFn9iXcGu7VQ1qkVCQ2
    bhhE=; b=O2YL3fzts22XdiJ8kz31y9ibNzEFU5dQriBIS1JQN4FG1Xu+l8lMOsh
    yeNHN2SbUoa2YkbudG4TgLzyaHV3PnO5QgFVVPtzG4I1BBHO8C6HcsNfBM86Lxf2
    zwrDfocOpzxwCzyq4+rtTYKBNtvfVpp/9oDViJsUyL6qTtnqEqDM5PsEWkbdoXOi
    a5z7tEhwRK0ep5iiW+DoK/X3d4m3C0kv1kLGdBkHn8LHwzw1t9AN29TSBXGgl3CM
    FaypJSaIfattu62/q9m6mug+nQgIM9A1qEHib8wTEwh/JvLn4j0b7yiMomY5n74y
    iGSYnBl86l+/BSvbUo+t38L+H+yF5Fw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN32zoTzcxNZyap5VKnIQF+g5f6+6n14xvK372G4kr6jO8ky1ilf4209wtiAHGqgqR14CgdUtbKwvDoNPssYV1myXp4I5H0+aAv5u12H7tCeOyrnker/
    Fv1XxepblvMQHEvYvetSGSx/WC7lKv9xO2mF3kUlf/B+SvhxJa3cvlMV7vLHSoKJnCNoWc7zVL86UGX47J1MKq8bqnIan66yRgN1AffJClZ4uMVczVH9+CwG
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=khwyK8DuSVkA:10 a=VUJBJC2UJ8kA:10
    a=nlC_4_pT8q9DhB4Ho9EA:9 a=pD9kdB-ymQY_UX2dkwcA:9 a=mwGKb69_Zut9xlLT:21
    a=4Rtujqnes27ikyf6:21 a=QEXdDO2ut3YA:10 a=VwQbUJbxAAAA:8
    a=fUSZZkATYxXnQMecnGkA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeEGOrU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 10:47:20 -0400
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:41348 "EHLO
        resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752129AbeEGOrT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 7 May 2018 10:47:19 -0400
Date: Mon, 7 May 2018 09:47:17 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Prakash Sangappa <prakash.sangappa@oracle.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, kirill.shutemov@linux.intel.com,
        n-horiguchi@ah.jp.nec.com, drepper@gmail.com, rientjes@google.com
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node
 information
In-Reply-To: <98e34010-d55a-5f2d-7d98-cba424de2e74@oracle.com>
Message-ID: <alpine.DEB.2.21.1805070945200.21162@nuc-kabylake>
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com> <alpine.DEB.2.21.1805031259210.7831@nuc-kabylake> <c80ee329-084b-367f-1937-3175c178e978@oracle.com> <alpine.DEB.2.21.1805040955550.10847@nuc-kabylake>
 <98e34010-d55a-5f2d-7d98-cba424de2e74@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-764230289-1525704437=:21162"
X-CMAE-Envelope: MS4wfA919cCBIKH5pgJABzGl/qTIF4BJCl09sDX+Tlmr891f4HcGWwTB+Vu47Za7GCnRI1jd4ZPxF30y6zOhxmOPxb9Zk5/uOnhxlBd6eALj1ZUfW4kuhyYs
 +XxMxzpMNGl7hhBlQeNzHf3uAZWCG8xImP/4gakICsizh47BMzVWDym7icfHpD2Z6hx5J0b+ANLPmJOCbZ/jqgxZLzwe87nkTCmSGsKEJLg6N+v+/q9EdgXB
 v2HlqqXx4IzHyTIep5cbuJTOIGcgvOHMQOyk/V8AHvrtHEdQOLTYZI2Wx0AmQ60iQLxyKqvalqn8BHjaOPMpNaisC9wLx6t9PiPgYHJ7YcaWAs1Xq5tjYgj4
 hkYZfoPJrVeP1H7dXVKzbQAxRwQPwDShXANk5Hetn+s1dCMKjBr7OEHxR1uZLUeRuM9gtkkG2glTMrdQP1zNFoZXVMv+KY1cF/BG9Y3BG+kNx8uMeUAf3YAT
 DPQQ66D+eVqw+uch
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-764230289-1525704437=:21162
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 4 May 2018, Prakash Sangappa wrote:
> Currently 'numa_maps' gives a list of numa nodes, memory is allocated per
> VMA.
> Ex. we get something like from numa_maps.
>
> 04000  N0=1,N2=2 kernelpagesize_KB=4
>
> First is the start address of a VMA. This VMA could be much larger then 3 4k
> pages.
> It does not say which address in the VMA has the pages mapped.

Not precise. First the address is there as you already said. That is the
virtual address of the beginning of the VMA. What is missing? You need
each address for each page? Length of the VMA segment?
Physical address?

--8323329-764230289-1525704437=:21162--
