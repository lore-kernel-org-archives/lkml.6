Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-260683-1525446367-2-4549504243796899609
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525446366; b=JNUHdITllvvqB+q9MTR5OrODL3AIdblC3C0DVTWFu6JYp5fXhE
    NvbpvNf/YxS2z87g7nuJ8e6GgBRJWLho6Mo+UZ/yOQrf3xR0QAoiarKFz1YOaazd
    BZdzbCRZPY/05DY2kerEQD/425/4Pcjic4GlMnWdMOuFkq244HCTPVChSZUEWX49
    NL9fEkkyWouZnfBN7+YpvoGFFGOOcFJ/JTom13euINU12ugCvd0Z36coZ8Lcyxnv
    b3DrpPT4FtTES/ePTdE2uEKvcyXHMGdMIz99JiUjGvffa/62OJRpB0L5iK1QBuT1
    0/1uTdX9A+inLi75JwKpvTPz6DEWyVvhe3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1525446366; bh=CiOW3lxKQXOuSm20aoaDQeyChOh0bePlYkjjIlS
    ezg0=; b=LwvzPzNZA3euiVak9pKFgEfhKbaaY3axMi1NOFn0zIT3hNeCL3jhrnC
    wugQ9Ff3iTg54LiwSICXWQiPLUi/1G0tw1fXjDosdSy0Kmil8N7rSjPcjHvUbof4
    Lc82OXKvW050DY+FxK7NUxRK9qKUPpSX+PMUteDULvsG0eFD8srKQgZBb3Cfo+2J
    K64EY5WPqmFLL3mLKFR6h2F7hnvFLEHj9aKI97aZaESvCCDEqxewMKIY9SfA/AL5
    NOcg6mZ7Auw+C48D9CrWZ2t0zJUbtI4SMSS3TJbAFXFzI9qS+a1mOfnQRM7YZMsk
    sebx+rLSlQbeQxoRgUn2mDuuzmbr5XA==
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
X-CM-Envelope: MS4wfJRQdAZHXXoHewhYPEjr3VeE4PMHhv5G74Bu0DHbtDI3oW8BgMxHCTdTh6duY0/D5GicbqC/mv/Hh8P2a4+bC40XQVokweMfbfMP3yMA9rM5OjUNtgqw
    A8ppTyv66U5JR+oY9P6EfkSdvAEjXPU4IG/onU6SOSXjUZbY/nqeF3qGvuTG6igcbcBrVfw6q/3Afqph9QQAgI+YUWXbC3rOAN2vXugWWRzh0ICl0ZYdzbKp
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=khwyK8DuSVkA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=BIh_LTftfGNm6TsQa50A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbeEDPGE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 11:06:04 -0400
Received: from resqmta-po-07v.sys.comcast.net ([96.114.154.166]:59102 "EHLO
        resqmta-po-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751059AbeEDPGE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 May 2018 11:06:04 -0400
Date: Fri, 4 May 2018 09:57:54 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: "prakash.sangappa" <prakash.sangappa@oracle.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, kirill.shutemov@linux.intel.com,
        n-horiguchi@ah.jp.nec.com, drepper@gmail.com, rientjes@google.com
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node
 information
In-Reply-To: <c80ee329-084b-367f-1937-3175c178e978@oracle.com>
Message-ID: <alpine.DEB.2.21.1805040955550.10847@nuc-kabylake>
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com> <alpine.DEB.2.21.1805031259210.7831@nuc-kabylake> <c80ee329-084b-367f-1937-3175c178e978@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfKvdZldehWcAmSyTKkxzqPGkHq0l7Z3QFh3oJuvqKcN9rFnGsr0rIMxr9Vw3fNVoWRO0FsdFxKxHs87RSSYMUXmW+oW7Gi51KE4Zk/mUCEuRJkSbRP8O
 eatn8aDv2NEmYt8GDCmniJAjTbYJrTQ5wAzfGhWRaX9I0EbCYlTUa+6q7caDp/xCC4kcSyymheiPtg3GHUkyTsrdOTpWyYHDijzLmyG+RuIlkZrRVFzqT3OM
 bNtsIEqbqFu/qejQ2Uq9A5xWcd0O23gEMdVMIdhSQsXkUrOmbf+6iN79p9336Vwl72emmqsCVF/qDLUEK0hlmrjMPj3P2ZZrbctJcr+qmrQop2vIK/JRBdVC
 GuZHlRToBj0gUWkOXWnZFtd5AMOAOC97WwDVdSVjU6sllYMD3BJ2bvYA9o63jySTvQ03qC2K/T+rZqKMYdcJf5sjb+koKOAwhkFriYIi0Do44ONlG7sJylh5
 Dx4bi7MbFceeUN8Q
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 3 May 2018, prakash.sangappa wrote:

> > > exact numa node from where the pages have been allocated.
> > Cant you write a small script that scans the information in numa_maps and
> > then displays the total pages per NUMA node and then a list of which
> > ranges have how many pages on a particular node?
>
> Don't think we can determine which numa node a given user process
> address range has pages from, based on the existing 'numa_maps' file.

Well the information is contained in numa_maps I thought. What is missing?

> > > reading this file will not be restricted(i.e requiring CAP_SYS_ADMIN).
> > So a prime motivator here is security restricted access to numa_maps?
> No it is the opposite. A regular user should be able to determine
> numa node information.

That used to be the case until changes were made to the permissions for
reading numa_maps.

