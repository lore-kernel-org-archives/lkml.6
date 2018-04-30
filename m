Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1553610-1525102344-2-8973861818231602720
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525102343; b=PHaQkeRZkiUtseA/z9IArTZo4IRnGkJGvs+TtUEyJ1EM/w/O61
    lasDPjOGsz2sFDtNKa3C5xkJi2ZZ+v04zan3GBn+Nbg2uq4qmXx1DtLvwcKXgqQY
    6qh0JoDchxzDMexZF40AqqQVp8yqkISJNPa+SYbODOmAjWrgwJG5KNPlcPruEPaM
    B5QOHhFtiIgJIguBkr/24OVXB3O55gPZkrFXJPiTEQmtu3vaFsYdOxr2S30IyQic
    GbRuJTt+LJNvFFR0rHGy3RRh5zhkFML4Fl842VZ82b44QsNIOtdDphx2iXKz0Ags
    5IQ9sCvooec6sbCOH0poQU6Oe0h1xEu8GKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525102343;
    bh=AASlsTxAxDwwp0hdeihLNaopWVwXukEymATc4Oil+7g=; b=ZLdra3h2h02g
    nLl/QbpjuNUbTvAV1ATQMZkbfbnIBnw8VuEF5ob8xKsCLTDrTtwPKMnl1mdn0Awp
    mN2AFO/qnFLQVQIhwSN2mi40F6XgCNBnIVwFvOBJjYdavHMZKiYkTwHZniyoqJ4t
    /T0PVSnA0zBCGqaxMfttWvm9m7D0N1GsU4Fszoxws9E6SbouZMYN3yjn1PsiY+nV
    DAR5q1pR+Z+pWpmVc3Ufl8qx+dzHLlyP84oOI/vWW4njonx7wnuF4G0Fj55MPKvK
    0UHpnQoZaBEr3/mqmq6C1uE+h8OeXfLRvm4Kn7Lj5kfDAHoIaroSSNETvFGU1xBo
    tx2PKZechA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH0X4ydhiW9M3JMgDYjCeJvUfMBX8oCt08yLcc0BNkcs5nOmQ8+XKXyT28FMZlnXsvzjlyw+yprYtV9BTqIM3heaYsoAbGYaaKRrZywaix27P2pYlnKF
    w1ypnQcfc8BcQGa2UgY9PuWl+SzoGKweUi785OGgP7vVERIqe/eSdSX7qGYV9V8FItrFJ17TA2ZwovIgS+kaJkCfE9Pj1gV/XWHlBiab/9t9kSib7i3qLFM5
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=yG_PwrZDhR6S6znx1uUA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753582AbeD3PcV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 11:32:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:46990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752534AbeD3PcU (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 30 Apr 2018 11:32:20 -0400
Subject: Re: [PATCH] mm: don't show nr_indirectly_reclaimable in /proc/vmstat
To: David Rientjes <rientjes@google.com>
Cc: Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, kernel-team@fb.com,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20180425191422.9159-1-guro@fb.com>
 <20180426200331.GZ17484@dhcp22.suse.cz>
 <alpine.DEB.2.21.1804261453460.238822@chino.kir.corp.google.com>
 <99208563-1171-b7e7-a0d7-b47b6c5e2307@suse.cz>
 <alpine.DEB.2.21.1804271139500.152082@chino.kir.corp.google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <da797c29-129c-1591-bb85-79817dafd912@suse.cz>
Date: Mon, 30 Apr 2018 17:30:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1804271139500.152082@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 08:41 PM, David Rientjes wrote:
> On Fri, 27 Apr 2018, Vlastimil Babka wrote:
> 
>> It was in the original thread, see e.g.
>> <08524819-14ef-81d0-fa90-d7af13c6b9d5@suse.cz>
>>
>> However it will take some time to get that in mainline, and meanwhile
>> the current implementation does prevent a DOS. So I doubt it can be
>> fully reverted - as a compromise I just didn't want the counter to
>> become ABI. TBH though, other people at LSF/MM didn't seem concerned
>> that /proc/vmstat is an ABI that we can't change (i.e. counters have
>> been presumably removed in the past already).
>>
> 
> What prevents this from being a simple atomic_t that gets added to in 
> __d_alloc(), subtracted from in __d_free_external_name(), and read in 
> si_mem_available() and __vm_enough_memory()?

The counter is already in mainline, so I think it's easier to simply
just stop printing it now than trying to replace its implementation with
one that can cause cache ping pongs.
