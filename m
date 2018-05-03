Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3209358-1525386942-2-17795411613409990267
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
    1525386941; b=NumcaYf8sgCurFlaN5DM10N1Q0m9FlhPFcQbKH2X83HmZVfrmi
    mR7ix0SM3zNtgFHzUpWTFeDKhqaNVbMl3J/1BJ+4PANOudY2tV6iuvhoDVGMHxmw
    +V7TNgLSSUK8jKyRc/cGu9Noz37ELzgpFaC04OGx5Yj6ra+NdkL9+vLh8UH/EWWm
    vdnfKJXAaQH0HCOhwFF11ZTTVWXj+hSQUjBM/XYVJFqO17DRP9djnhtbpun1/nil
    BDn8lcU3TjcvfPHZENn6FhVsDkHWfi2/xTlpatNAtUCZMTFzBiZRK9SlNF8wtzq/
    gsPTMMSiVfR1IMGXOCrJck2uOApASEkoItIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=reply-to:subject:references:to:cc:from
    :message-id:date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525386941;
    bh=00r6e3EFmwkIq8TcvmCgE7YLwkLUQUP1EhF3ZkCyi0Q=; b=nnPnJ3rbbyf/
    NS1PEatC60eEkKfd+AVC0PcpUQbmD/JHxAWIS7fybzAWWRj4K3TISaO5TBfBhF3T
    sK01EDLXL6X1DphOaY14cu4X22TDcJQwblshspIUCSeaBB96fnp4Ey2/5yH7MAg8
    lkz7hwajdMSM2uMiZHF6ZeRh5unx9PbYDiJuQwYRKSn3wZOQlqdECENRjzheUaZA
    1uGAqTyG8ObJCmpBjvzzW8vmHpWS9y51xcoUn6UWmmpjFk+LpN85n0RQJYawfFSQ
    nFytDPb/EXFRnuhDx+tEBC99FlqBSv99z0vFodRJEIa+Z087qqqYJZrxu/Qldw98
    Zs+5R7FGMw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=obIXE7W4 x-bits=2048
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=obIXE7W4 x-bits=2048
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
X-CM-Envelope: MS4wfFOIful+3GeFH8rsWog30F7DTGzPPc9l/OD31/Sz3/oYXeqFyZVdBhft306vzMNJIXCYMQz+N/RHkmSDr+SSNgxbIqAGcwGkHWLFk9CH9ov29cQM+lgn
    bkmU36dXpDQDzgPArBB9hYWyh8SzkAGasg1W2iv2hc8sLBkpeTpjSPr/+szgqV+Y+YJXr8wrHe45elvr568Sc0844MoosocUN7ZAlcdcTdL6fDe0Y7YNfVFt
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=N659UExz7-8A:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=lRUHs8lAtFBmPJScfi4A:9
    a=o7wfbem24o8-aZiB:21 a=jdSJ6KPdBChI_HY-:21 a=pILNOxqGKmIA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751181AbeECWfk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 18:35:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36760 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeECWfj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 May 2018 18:35:39 -0400
Reply-To: prakash.sangappa@oracle.com
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
 <20180502143323.1c723ccb509c3497050a2e0a@linux-foundation.org>
 <cac754ee-efb9-0259-a50b-4efa11783058@oracle.com>
 <20180503085741.GD4535@dhcp22.suse.cz>
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, kirill.shutemov@linux.intel.com,
        n-horiguchi@ah.jp.nec.com, drepper@gmail.com, rientjes@google.com,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>
From: "prakash.sangappa" <prakash.sangappa@oracle.com>
Message-ID: <40be68bb-8322-2bef-f454-22e1ab9029da@oracle.com>
Date: Thu, 3 May 2018 15:37:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180503085741.GD4535@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8882 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805030195
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/03/2018 01:57 AM, Michal Hocko wrote:
> On Wed 02-05-18 16:43:58, prakash.sangappa wrote:
>>
>> On 05/02/2018 02:33 PM, Andrew Morton wrote:
>>> On Tue,  1 May 2018 22:58:06 -0700 Prakash Sangappa <prakash.sangappa@oracle.com> wrote:
>>>
>>>> For analysis purpose it is useful to have numa node information
>>>> corresponding mapped address ranges of the process. Currently
>>>> /proc/<pid>/numa_maps provides list of numa nodes from where pages are
>>>> allocated per VMA of the process. This is not useful if an user needs to
>>>> determine which numa node the mapped pages are allocated from for a
>>>> particular address range. It would have helped if the numa node information
>>>> presented in /proc/<pid>/numa_maps was broken down by VA ranges showing the
>>>> exact numa node from where the pages have been allocated.
>>>>
>>>> The format of /proc/<pid>/numa_maps file content is dependent on
>>>> /proc/<pid>/maps file content as mentioned in the manpage. i.e one line
>>>> entry for every VMA corresponding to entries in /proc/<pids>/maps file.
>>>> Therefore changing the output of /proc/<pid>/numa_maps may not be possible.
>>>>
>>>> Hence, this patch proposes adding file /proc/<pid>/numa_vamaps which will
>>>> provide proper break down of VA ranges by numa node id from where the mapped
>>>> pages are allocated. For Address ranges not having any pages mapped, a '-'
>>>> is printed instead of numa node id. In addition, this file will include most
>>>> of the other information currently presented in /proc/<pid>/numa_maps. The
>>>> additional information included is for convenience. If this is not
>>>> preferred, the patch could be modified to just provide VA range to numa node
>>>> information as the rest of the information is already available thru
>>>> /proc/<pid>/numa_maps file.
>>>>
>>>> Since the VA range to numa node information does not include page's PFN,
>>>> reading this file will not be restricted(i.e requiring CAP_SYS_ADMIN).
>>>>
>>>> Here is the snippet from the new file content showing the format.
>>>>
>>>> 00400000-00401000 N0=1 kernelpagesize_kB=4 mapped=1 file=/tmp/hmap2
>>>> 00600000-00601000 N0=1 kernelpagesize_kB=4 anon=1 dirty=1 file=/tmp/hmap2
>>>> 00601000-00602000 N0=1 kernelpagesize_kB=4 anon=1 dirty=1 file=/tmp/hmap2
>>>> 7f0215600000-7f0215800000 N0=1 kernelpagesize_kB=2048 dirty=1 file=/mnt/f1
>>>> 7f0215800000-7f0215c00000 -  file=/mnt/f1
>>>> 7f0215c00000-7f0215e00000 N0=1 kernelpagesize_kB=2048 dirty=1 file=/mnt/f1
>>>> 7f0215e00000-7f0216200000 -  file=/mnt/f1
>>>> ..
>>>> 7f0217ecb000-7f0217f20000 N0=85 kernelpagesize_kB=4 mapped=85 mapmax=51
>>>>      file=/usr/lib64/libc-2.17.so
>>>> 7f0217f20000-7f0217f30000 -  file=/usr/lib64/libc-2.17.so
>>>> 7f0217f30000-7f0217f90000 N0=96 kernelpagesize_kB=4 mapped=96 mapmax=51
>>>>      file=/usr/lib64/libc-2.17.so
>>>> 7f0217f90000-7f0217fb0000 -  file=/usr/lib64/libc-2.17.so
>>>> ..
>>>>
>>>> The 'pmap' command can be enhanced to include an option to show numa node
>>>> information which it can read from this new proc file. This will be a
>>>> follow on proposal.
>>> I'd like to hear rather more about the use-cases for this new
>>> interface.  Why do people need it, what is the end-user benefit, etc?
>> This is mainly for debugging / performance analysis. Oracle Database
>> team is looking to use this information.
> But we do have an interface to query (e.g. move_pages) that your
> application can use. I am really worried that the broken out per node
> data can be really large (just take a large vma with interleaved policy
> as an example). So is this really worth adding as a general purpose proc
> interface?

I guess move_pages could be useful. There needs to be a tool or
command which can read the numa node information using move_pages
to be used to observe another process.

 From an observability point of view, one of the use of the proposed
new file 'numa_vamaps' was to modify  'pmap' command to display numa
node information broken down by address ranges.  Would having pmap
show numa node information be useful?
