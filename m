Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-647902-1518803007-2-15528792714586427707
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='COM', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518803007; b=Wv88ou5KbA6WveSIkEak3Gb/5wZ35Coi64GO18kdIQJClr3
    6XSuAPiD9OM74d5SBhnyBlcSGprz0RyRTd6rwt7p07BGXAHeW3BX0fFbnvaN97jV
    Ja/m64COOPdrlSXsznMef6KHA/gS2KO6bWWeotIEz8PRQu96bi1zHtwVe5gOIGB2
    57F/1GobK8o5TAR4PyX/1y+gIbTkGaUYCTK8NZLEefUWZTg3/JJYTxvGYdSPDSXa
    QTyk6gSktn/35Ay2OKbDkUPfMiiZkzHOL0mAKt7z8AUiEjMhGroHBkLU6p+gPxKg
    xvTbycoCQZpLxE07vpYtoAE0D2NI5frtqKpal6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518803007; bh=WIkkeSZnlDXijGBPqcI5/RiNEymQJc5ZTVII6uUpfwk=; b=F
    9ZuQemISAN3PrfCkx1Im0Avw1RUNFItkEF6H8pNYp6oo/LSj0fxcmLMtjM44pBMH
    vrhCXfQVWnU6nlowjniljR5/7e6wsxg9eadWc7u3TOgnh4cmCErIxmVXhHZ/jQZ0
    dphOOkA+O9o8uH4W6dBpwiyQvV8MvgsV57pNbwZOPQ7c/la679LMyLjrz4h2Lrxo
    wXwVuAI0qHk1GA2H3s8AXgBW7w4LRcDP6n/Lxa2VTsmWtwL78ZS/LaJVCZqaK+GO
    ekii47N/E+E5CCKlRDsYl48uQVShEsfTe5ZZvgzkMGwKCb3NzDZHuI1HAz1WFChe
    N3pim/W7bA5cO/YeuBrRA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=XKI2imrN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=XKI2imrN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756035AbeBPRnZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 12:43:25 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39322 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbeBPRnZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 12:43:25 -0500
Subject: Re: [PATCH] mm: don't defer struct page initialization for Xen pv
 guests
To: Juergen Gross <jgross@suse.com>, Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, akpm@linux-foundation.org,
        stable@vger.kernel.org
References: <20180216133726.30813-1-jgross@suse.com>
 <20180216135940.GQ7275@dhcp22.suse.cz>
 <1424bb25-7d6a-ee21-83b4-0e90369d6132@suse.com>
From: Pavel Tatashin <pasha.tatashin@ORACLE.COM>
Message-ID: <b277a7be-05d4-67e7-f8ad-50f7865e87fe@oracle.com>
Date: Fri, 16 Feb 2018 09:21:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1424bb25-7d6a-ee21-83b4-0e90369d6132@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8807 signatures=668673
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=890
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802160211
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/16/2018 09:02 AM, Juergen Gross wrote:
> On 16/02/18 14:59, Michal Hocko wrote:
>> [CC Pavel]
>>
>> On Fri 16-02-18 14:37:26, Juergen Gross wrote:
>>> Commit f7f99100d8d95dbcf09e0216a143211e79418b9f ("mm: stop zeroing
>>> memory during allocation in vmemmap") broke Xen pv domains in some
>>> configurations, as the "Pinned" information in struct page of early
>>> page tables could get lost.
>>
>> Could you be more specific please?
> 
> In which way? Do you want to see the resulting crash in the commit
> message or some more background information?

Hi Juergen,

Could you please provide details how to reproduce the problem, and crash 
message. Also, information about where exactly xen access struct pages 
before deferred pages are initialized.

Thank you,
Pasha

> 
>>
>>> Avoid this problem by not deferring struct page initialization when
>>> running as Xen pv guest.
>>>
>>> Cc: <stable@vger.kernel.org> #4.15
>> Fixes: f7f99100d8d9 ("mm: stop zeroing memory during allocation in vmemmap")
>>
>> please
> 
> Okay.
> 
> 
> Juergen
> 
