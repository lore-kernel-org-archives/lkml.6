Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2888030-1527213385-2-16888474282956015809
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527213384; b=WGiqGYsNEJQXXtmyRdNVNmIrRL8xvO9bJVrd7iFlSHtxDbeKdE
    6E0KhFBbvtWew6R6ECzzxbLvqjOm5BCc5lDcBTgD1+fMmUbVfphnNcneoQ5lHG8w
    eSNVk7IztDMWgNnwgLSYtm41oTR8Yf50R+MUak9/q/hRQumOmIqwjgH/a9i5wNj/
    9j/xU27pP5w5SoEuUamYmwGoCDGIm2ZbYl+uIAdur3OWRisYdWMZ+2gAuxNPBH63
    8V2YlpaiFjtkIraEuHQTj92Tx7WKqNkOKdZCj51JvsunydYddS0ZNEej/hq2uata
    WhTMyuRTwxH3rrEGF4ozOwXY/XK8axQ66nVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527213384;
    bh=ssfbV+K7I94rbyKFvIj+wsfk8D0e3l7jGIl9L9J89C8=; b=ggJrynt+8ONh
    oYSdiCBmL9oSBxiWBaOZ+vM+Q+1omcdhjOjnINcEgZs0La5fkuOtHutFfR3uyhyD
    ivQWQg+E1SY0Ib5neHJx70yxgHjyYBVgBJplCj2tw1vLSKt4RrPDRxiiDFUzl7Cp
    vsCoIB1ya1NqeE0utvMeSfA/URE/W94Zj/jDUjYmle1612P4eYlT+KAF6CTOqCDQ
    N4pTKAmrlsImXA56C6naE0wJISY4KQ7UFqB/U198KQRFys4wFJYXtU996uMqol8K
    Xw05kGGAAxoSvUwRtTzn1fO7ggvTHWnOlyvsO11uUMKRho4+cgoODPhQmt4tLOGS
    kxvi8An2OA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ascade.co.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ascade.co.jp header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ascade.co.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ascade.co.jp header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCmte4QdkWOWPDT+bLyw3c6d7M6Snj8GHBFp/0zRkgD3gCuT2IJB2DLZkgnnyT8NUFcsQzkXBN/dGVH9cuP8/5xnBtyR6PDXCIr7U8jrBByDS61ND+P9
    bg1V/B69nRS9TaxLcujlSa0NGMrZf4/GsRmYCGo2whA0CNzImzdzmutP2J5vZ2bSiOxIOReczSckpsqvriFHLKRZBgujUxMg7YrCbsEi8rZVmhNGg+CifsW3
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=95ZnEdb1Q-e6vTfvmPUA:9 a=FwUn5x9ZHDrIPT95:21
    a=m1viVhZOcCoU6r1z:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933236AbeEYB4V (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 21:56:21 -0400
Received: from ext-host0001.ascade.co.jp ([218.224.228.194]:63543 "EHLO
        ns.ascade.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754765AbeEYB4S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 May 2018 21:56:18 -0400
Subject: Re: [PATCH v2 0/7] mm: pages for hugetlb's overcommit may be able to
 charge to memcg
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Marc-Andre Lureau <marcandre.lureau@redhat.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
References: <e863529b-7ce5-4fbe-8cff-581b5789a5f9@ascade.co.jp>
 <20180522135148.GA20441@dhcp22.suse.cz>
 <af1a3050-7365-428a-dfb1-2f3da37dc9ff@ascade.co.jp>
 <4078bc2d-4aaf-cd1b-0145-5915e382852f@oracle.com>
From: TSUKADA Koutaro <tsukada@ascade.co.jp>
Message-ID: <5943db59-1c33-7004-7574-fc07e577e1ee@ascade.co.jp>
Date: Fri, 25 May 2018 10:55:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <4078bc2d-4aaf-cd1b-0145-5915e382852f@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018/05/25 2:45, Mike Kravetz wrote:
[...]
>> THP does not guarantee to use the Huge Page, but may use the normal page.
> 
> Note.  You do not want to use THP because "THP does not guarantee".

[...]
>> One of the answers I have reached is to use HugeTLBfs by overcommitting
>> without creating a pool(this is the surplus hugepage).
> 
> Using hugetlbfs overcommit also does not provide a guarantee.  Without
> doing much research, I would say the failure rate for obtaining a huge
> page via THP and hugetlbfs overcommit is about the same.  The most
> difficult issue in both cases will be obtaining a "huge page" number of
> pages from the buddy allocator.

Yes. If do not support multiple size hugetlb pages such as x86, because
number of pages between THP and hugetlb is same, the failure rate of
obtaining a compound page is same, as you said.

> I really do not think hugetlbfs overcommit will provide any benefit over
> THP for your use case.

I think that what you say is absolutely right.

>  Also, new user space code is required to "fall back"
> to normal pages in the case of hugetlbfs page allocation failure.  This
> is not needed in the THP case.

I understand the superiority of THP, but there are scenes where khugepaged
occupies cpu due to page fragmentation. Instead of overcommit, setup a
persistent pool once, I think that hugetlb can be superior, such as memory
allocation performance exceeding THP. I will try to find a good way to use
hugetlb page.

I sincerely thank you for your help.

-- 
Thanks,
Tsukada
