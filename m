Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2825552-1525784006-3-8449420121976047570
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525784006; b=Yfm4tL4ItjzLpT9RDgvJRNuM7sFFPeo3TAzziu0NYjI1uwO94F
    qpVSpxIzlh9CF/ZRcXp7s5BWrAM/Pel/puwAZuZtVJhKsyscndACaOow5qcB65Zu
    ZyYgHRbnwNiQn3ZTHQrmV5KV5UHxAT6+xmfB/QY0w88AdZMWFV48dGntx6yzLZQs
    U+r7EnClqy9iAfLQyu3kKFxjXRV6HvlWw6k8voOwn53elMlr0LkMDg37ZVTcZYdG
    3cNMJg535C4LPcc4Itljll+DF9CsgFOmXw5J+EHHAv23bHOcOk2xvMP/I/R6XFUZ
    FgXoPXM7rrI2hJmlPwpppeUINGLe4vpA1D+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1525784006; bh=puLVS3AO3ycIzmYO4CYIKQ2EspneBj2n9zEn8El
    Dtj8=; b=bKVivGboG76PXaH4lF9pbsh24O1vAMXzeTpylU6vKjxW5brELw0G58w
    TdmIMtY1GMM6U/9+bP6p5F8TSx+vB9855YNOwJV+BEUXagb8I0MQSrGgXRXDpfh5
    0qxH6yAu/VkqfWo38ZJwaj1RMpXAxnJ/J13COMIP2H0bL1YI+0hvQnDRJEynpueF
    ZCKU46Ef80ndhQuN77S9nsKZl2eDPcgNm+R0iivO6F6B2hSb3qY6gq0sjkpkw0qq
    UUW6PsfIl1k1eGo4pF8eChhnPv+6KrOprkpxZaEOB3AXLyWo0fGboNXI0HCBsvMQ
    T7h1yjDmjxg6pSwxV2k2aT4kHmbdWOg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE7wIeDoOrq9MmdDh+uzQGWUSjoYC4Sdtj7CpHTSBB/J1CkMH2gsnSDf+5ycMU821rdklAXsIeDy/f79z1dvo5YVgqrk96zBUIe3YjG2MR9+Hmdpfjai
    MooMTiL1CbJaLsB7cNpVUvNd69PAb0cVPwu74uaEKreYzmAcGSq7GklM9C5Nd5gmd7panBqEeE03J6Bsv8IP5DWgRvwCjdda1n7+19uVhGFV4JM3+UAo7+jB
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=khwyK8DuSVkA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=aZaSOSad2OFiYjp05i0A:9
    a=mWuM6YlQJLvkDC3-:21 a=aJLBX6vC2ph9w2Zq:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=pRQRx_yQ9a0A:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754983AbeEHMxX (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 08:53:23 -0400
Received: from resqmta-ch2-03v.sys.comcast.net ([69.252.207.35]:52602 "EHLO
        resqmta-ch2-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754527AbeEHMxX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 8 May 2018 08:53:23 -0400
Date: Tue, 8 May 2018 07:53:21 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: "prakash.sangappa" <prakash.sangappa@oracle.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, kirill.shutemov@linux.intel.com,
        n-horiguchi@ah.jp.nec.com, drepper@gmail.com, rientjes@google.com
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node
 information
In-Reply-To: <a61bc7b6-ed98-045d-95c0-b6c91fc8d1da@oracle.com>
Message-ID: <alpine.DEB.2.21.1805080747480.1849@nuc-kabylake>
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com> <alpine.DEB.2.21.1805031259210.7831@nuc-kabylake> <c80ee329-084b-367f-1937-3175c178e978@oracle.com> <alpine.DEB.2.21.1805040955550.10847@nuc-kabylake> <98e34010-d55a-5f2d-7d98-cba424de2e74@oracle.com>
 <alpine.DEB.2.21.1805070945200.21162@nuc-kabylake> <a61bc7b6-ed98-045d-95c0-b6c91fc8d1da@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfHlL3cipq14VGidN1P14PlKyIBTc5QfGV+bfHQih1k497KIxv/S4T71+Cdv0htEpSPlq7y4TtptQYmpkECD/Ok/WLfGNDk3ivXXNj9D8qBVnHzWvOqYb
 8h2pJy7MdMybo23Euv6ghmD4J31ju5561LJKDLHIQSRm8Czcp8ZAdowih2e4YAmtsYQ93YZsOrdkf8ZhEuO1kHA9YUs/hqpbWqYDAFRPG2pxS0ap6MFw7v4t
 e7KAw8RE4nuE0Sx/2/CA+AxLy8yX/WcSx/JZEIrKxdHXjxoO030btA+N++LrbNqucsU3oIxZaOsoGy6ctN4gPFp1RPL2EeN0gICYtPPhgT4ip9qYL29dvyl1
 wWEBOccvExk1PWlxjCG9vMje9p2SwhbW/Wq3c0Rjdv0yCapDwzHIPsLznKqpKgehT1oQ7TWdumz8NQo2St66zZQ2lLntV6YkocJ/h3dyl6Ovb6xtKyU3DjIW
 vMPW444pOBUs5od4
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 7 May 2018, prakash.sangappa wrote:

> > each address for each page? Length of the VMA segment?
> > Physical address?
>
> Need numa node information for each virtual address with pages mapped.
> No need of physical address.

You need per page information? Note that there can only be one page
per virtual address. Or are we talking about address ranges?

https://www.kernel.org/doc/Documentation/vm/pagemap.txt ?

Also the move_pages syscall has the ability to determine the location of
individual pages.



