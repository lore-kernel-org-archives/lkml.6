Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2931836-1525370637-2-9965842551074438142
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
    1525370636; b=RFHEqqmignEamtEYLRCAiZIhswTq1Dbm6TIfYwg4XiEIpBZz/S
    zIs9/xgfPLs94DPLSoDCaoSPITEF5+K+7i2tlVgU7XIqBDioadmvU6c/yunFCfgO
    txdOa7nK9pCZ6ZHduTtYYUWPbRaOoenzdV0nGSbYS4Rlna+s//fr/4gyHN1VCPZv
    ugjeshumJJ59egECwTG85BU8XZmNFej+9T+7Y6l55nMcoq+m8d06CV+8N+5VYJ0z
    z2pQjv8XkfmPq19/v8RtH3pTEAqNvZetFB1gTJjobFE9ep952W+IchH7PFfRf+vO
    laD5zUUA6qEA+Upbi1n6BakRUgZYdbkXP3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1525370636; bh=gpzhFJC4j+JFGEOZTMuA4BO37Cf5hivHr6zJ8LE
    e4cU=; b=l41+I3W97EvAkadfuIodpae3FHhkHBHpHj1cOTAD97aDCdPdBEEHPAt
    8+2HY8Sxg6HOIiiL+TNN+GLNsX4R9qgLwRHNkji6vtO7KYiv6B8JOujdZr6nivgn
    F915ukTlelXnzkeEPWTkD6xSLq+EuxnNX5oGk3W15t1dyb/d6+BNNRvZFeqyzFcw
    Tsp1j26DmrHmmTJD6vHc5NF/Q4eYIfgf2U2tCgko2d8oWJRP1Uf4Vrus5pLxQVFT
    fMqBifSbMPp+N0OU8SwVCXJzNKXLN536CgjHIePMk/ZXDN2Nchsp8Ju6pp1+cWxl
    NHEKOHn7hYHtxT/B88ig4MYbBqFUE2A==
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
    x-vs=clean score=-100 state=0
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
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ/YvNxjojpJakCqvmO/pmfeaBeqaDWiIDH1OZiXeha92wj2FMbk47mjO1EeTS844uw0AeVSJuMwsZImTMirPOugS+85A7oUWHNKmM6Pc+5NEcgtT1Jw
    iwPFk6HyDulJYLBIWA8cH7B95tElZKZXNtc9UjaysQUajU2WiV0TZVdGdoE7PKyBKV8krhx1AQI0mx4msG1T+lcvFMcrXs6Ko7giWEYA/pCP+0kLnxz5Wvjq
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=khwyK8DuSVkA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=DQmsFx0OO9BfC7CClZQA:9
    a=69fdB_sVe-1yFxps:21 a=z1IX_iUsNbQi6Y5J:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751075AbeECSDy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 14:03:54 -0400
Received: from resqmta-ch2-01v.sys.comcast.net ([69.252.207.33]:44558 "EHLO
        resqmta-ch2-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750947AbeECSDx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 14:03:53 -0400
Date: Thu, 3 May 2018 13:03:51 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Prakash Sangappa <prakash.sangappa@oracle.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, kirill.shutemov@linux.intel.com,
        n-horiguchi@ah.jp.nec.com, drepper@gmail.com, rientjes@google.com
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node
 information
In-Reply-To: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
Message-ID: <alpine.DEB.2.21.1805031259210.7831@nuc-kabylake>
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfMQj+j9pzr/a7KIxG+yDgC92sSsHCTYpwzj66p0zHTyYdShZRcLsAvnw3/9fRBtz2AYp/kGUC+hKSi7Bon3s8a1C8QIHqhZPQqRZHA0Sj7kLgl4K/Geq
 QkmBUkzKlCbld9fyyPNF0y+nUc1+xdpeUtNW/JNZmpsE2ucvrB2EKAo5rjp9X0OJ1Lbo4UN/R3mAm6F5kLEQFflkVbAcSJ14jf+SYwdHBxhi5n4UXIZ5M+sh
 Z88FO7lwsrl2GAzHUUA0CF9HUiAQMUIEY9jnibAINJ6T6SGi/3QJ87yfOY0aqHAQJlBocESt3FFm5g480XV7EmAcJav9gjJl9hvzSSTUBYLWgh0OeNvXmfiF
 j8SLzCZTurn4kEUpj7ixFtY42inUe23puiv5aj+HOQshCFg5+TjUSB7aRHtOT/IknYwRhi4yODiIrmiim+/B4V+1WHpogzrmbj/G10DWOMAtUvt5ta0zAmCL
 beUqbwos0tcPx+FU
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 1 May 2018, Prakash Sangappa wrote:

> For analysis purpose it is useful to have numa node information
> corresponding mapped address ranges of the process. Currently
> /proc/<pid>/numa_maps provides list of numa nodes from where pages are
> allocated per VMA of the process. This is not useful if an user needs to
> determine which numa node the mapped pages are allocated from for a
> particular address range. It would have helped if the numa node information
> presented in /proc/<pid>/numa_maps was broken down by VA ranges showing the
> exact numa node from where the pages have been allocated.

Cant you write a small script that scans the information in numa_maps and
then displays the total pages per NUMA node and then a list of which
ranges have how many pages on a particular node?

> reading this file will not be restricted(i.e requiring CAP_SYS_ADMIN).

So a prime motivator here is security restricted access to numa_maps?
