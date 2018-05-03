Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3209358-1525387076-2-20738424123728397
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='windows-1252'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525387075; b=b0fJzupBo5w9G+3p8PUx4+4ktJMKXarITO2TAtycRfDVpSznOm
    TvDCZl2YorQlYrJIwwaBhlkgj7eStskQxkkFSZFpHPnXhmGb+Ab83OeiZCBSQa5S
    b9eUlrume5X7CgCq0i+//H3Jei2EqYwasoiU0WMtl/anr+xGaRhIsNxGaqEQOgGT
    srzKEBJh19+FZVKUdvN/+/C/AMlyJfRk9Q94oH1q4GwmepuiPV++Ps6LpUG4hAS1
    Lpzkh5QR70CqFd+YgPW/xgQFzDEMZwXTM7aYjiim0XZAVegijwjLV2UeCaZDDzZY
    WP4qdEJBgMMzC6Ym2NQSu9DiFC1ACjJdBtcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=reply-to:subject:references:to:cc:from
    :message-id:date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525387075;
    bh=1E2kX+Y/Cs4tp1W1Im9DkTWPkx6FXCoa5pMlwKl62dM=; b=VNJOJMvAK/do
    qgLE/jAniNX/nGtLWjRV1fi9WKosnv7T7TQJj6LpkH4eJj0FkcaNc3NHzNpJJi8l
    B4wOaDcF4nRkyUHu712O/v0qeG3O+MN2/wJ6AA2pj2HZpQXXGRGlKc73LDDMhSw/
    6tUHAMJAEu7IOyE3HhrH1Dpmy9UZIHo4aFM/zCdCBhcxfM1tSQK/gR+p9DGr7f9K
    FJckjrSUwU2nNCnl3xihWnJt0IEt2IdJ+k9pRH+i2kp1PH+jyBvp+jAie0O/Sh6P
    eSZH76x88r2jT0Pp+Mi5R/k1DEXjJwE64X0Oth5z//awhSnyWR8fle30E/2VLiRU
    pYS+AI5Sbw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=NRBS5U1j x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=NRBS5U1j x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBSJwp+uv33Hj3jjY+mYsG7aht9nO6MJzwwkGOdxgOWpBxXto9UFolO8aBK/WWHCbroKRIk4jFYJHLxSAasJhwFA5wqKfkJERD92FrhZFJJ3hZpvFuVm
    RkQTk2RA63bdGUS7GFzwLLcwISBPspEBX5tE4DaTFCHTYosql0zj40w2lmxtRJkAIFQDT26VeyK7wI1Lqcps6dxXp8SP+O9ulDLq1pSvpZcdrNfBW4g8FgZ0
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=N659UExz7-8A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=QHC2kOqy_hB1d3D8XDEA:9 a=d7o8OXacX9z-gkP0:21
    a=iOJPyZaFPLUKR1n6:21 a=pILNOxqGKmIA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750970AbeECWhx (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 18:37:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45826 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbeECWhw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 18:37:52 -0400
Reply-To: prakash.sangappa@oracle.com
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
 <alpine.DEB.2.21.1805031259210.7831@nuc-kabylake>
To: Christopher Lameter <cl@linux.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, kirill.shutemov@linux.intel.com,
        n-horiguchi@ah.jp.nec.com, drepper@gmail.com, rientjes@google.com
From: "prakash.sangappa" <prakash.sangappa@oracle.com>
Message-ID: <c80ee329-084b-367f-1937-3175c178e978@oracle.com>
Date: Thu, 3 May 2018 15:39:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1805031259210.7831@nuc-kabylake>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8882 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805030196
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/03/2018 11:03 AM, Christopher Lameter wrote:
> On Tue, 1 May 2018, Prakash Sangappa wrote:
>
>> For analysis purpose it is useful to have numa node information
>> corresponding mapped address ranges of the process. Currently
>> /proc/<pid>/numa_maps provides list of numa nodes from where pages are
>> allocated per VMA of the process. This is not useful if an user needs to
>> determine which numa node the mapped pages are allocated from for a
>> particular address range. It would have helped if the numa node information
>> presented in /proc/<pid>/numa_maps was broken down by VA ranges showing the
>> exact numa node from where the pages have been allocated.
> Cant you write a small script that scans the information in numa_maps and
> then displays the total pages per NUMA node and then a list of which
> ranges have how many pages on a particular node?

Don't think we can determine which numa node a given user process
address range has pages from, based on the existing 'numa_maps' file.

>> reading this file will not be restricted(i.e requiring CAP_SYS_ADMIN).
> So a prime motivator here is security restricted access to numa_maps?
No it is the opposite. A regular user should be able to determine
numa node information.
