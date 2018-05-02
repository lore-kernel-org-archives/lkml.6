Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1503315-1525304525-2-3007411080933511966
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
    1525304524; b=Fg7B52R6jRWhefHSn4XnH4L+VJnnYYQ4n64cpMx1NlSkNjZ2c8
    MXCy+T+KInLAey0pudhVx2S/+moG49jLZe/GcFa3YnIox3u5c2pG5fqbY6PPvtCM
    LfaPHTPSE2Cst5pSOy1kzClcrzCzVXRef7QlfcF2iNU+5o5sDkxW4HQq83h5S1gY
    WcOiqhgJx6saPLDdYX6MM7kWL9v4mvHYOlNF8/W6r2JHD+nn3xre6SM2yd54Gb/l
    tBqD6mBjH92OlVSB8oC1+ZCMMZ1iFGkzlv07Bwwqi6uRhvmR5lqDlP00ZJylAQGA
    IqYkrggy8o79Z6eh0GH1kT6zGcqliPryF8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=reply-to:subject:references:to:cc:from
    :message-id:date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525304524;
    bh=U/rzFhsM2NJZNA8xoMTJCyHMj6i03LtdkRcYEAo6Mos=; b=XjkZ1KCR5U7L
    9kwfyBhOz6gLo8GRNI9e4m94XqdEtdgrkLTIVsyu+FrJhD8FysTTHv1JfysZDPMM
    eTecHoDBdalvHE6KQ4Z5r87etHNFl/xivciSq7L7A8dKEteMkbcEcZOiZQkowzSX
    WT2Te2wznISJedbYD2f7gEOLjFD+F+9s1vTWRxIgahh29phauE4AWzOMIlZVJGCI
    826pRpjqrPlAwgg5QoSULkiO12+KJ/ujSQS4++UG6bGTTNQ17mgaLbOEfwMeCI4D
    xWktDiQtgHHSANQnDE/g4MhICzVyJcxh8V8Damef3NOaSLje1lTWzT6Z9VXIRjyt
    bccbYCP8XA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=TuXEvQqu x-bits=2048
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=TuXEvQqu x-bits=2048
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
X-CM-Envelope: MS4wfDAVjOhIhcZeOPP3AdeP9KpHsybo+LDKST6RlMlAFo42ttL6FbbLVUqsoXHIeKS5bxNwMhqWzMBhQduYqSZuyq9A6S7o0NfA8J9tCiKDm3A4+J901EzQ
    Lm7zIjDanWlY4MFEiN5laRgXQvh1gdR2rg+MT+AwtfmHxMrv0r29co/xsHQcoyFp8aIZGr77yS9IMo1/SGH/P6tZfYJPs2zFGmTbqoDUHhTHiLM3Y5k7HeCI
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=N659UExz7-8A:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=gu6fZOg2AAAA:8 a=VwQbUJbxAAAA:8 a=OQAES5cftXfc17pCIZEA:9
    a=Aw60hDW8sQHXP9ve:21 a=99SKAL-VLvJZGIOJ:21 a=pILNOxqGKmIA:10
    a=x8gzFH9gYPwA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
    a=2RSlZUUhi9gRBrsHwhhZ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbeEBXmD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 19:42:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52488 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbeEBXmC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 19:42:02 -0400
Reply-To: prakash.sangappa@oracle.com
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
 <20180502143323.1c723ccb509c3497050a2e0a@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, n-horiguchi@ah.jp.nec.com,
        drepper@gmail.com, rientjes@google.com,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>
From: "prakash.sangappa" <prakash.sangappa@oracle.com>
Message-ID: <cac754ee-efb9-0259-a50b-4efa11783058@oracle.com>
Date: Wed, 2 May 2018 16:43:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180502143323.1c723ccb509c3497050a2e0a@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8881 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805020198
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/02/2018 02:33 PM, Andrew Morton wrote:
> On Tue,  1 May 2018 22:58:06 -0700 Prakash Sangappa <prakash.sangappa@oracle.com> wrote:
>
>> For analysis purpose it is useful to have numa node information
>> corresponding mapped address ranges of the process. Currently
>> /proc/<pid>/numa_maps provides list of numa nodes from where pages are
>> allocated per VMA of the process. This is not useful if an user needs to
>> determine which numa node the mapped pages are allocated from for a
>> particular address range. It would have helped if the numa node information
>> presented in /proc/<pid>/numa_maps was broken down by VA ranges showing the
>> exact numa node from where the pages have been allocated.
>>
>> The format of /proc/<pid>/numa_maps file content is dependent on
>> /proc/<pid>/maps file content as mentioned in the manpage. i.e one line
>> entry for every VMA corresponding to entries in /proc/<pids>/maps file.
>> Therefore changing the output of /proc/<pid>/numa_maps may not be possible.
>>
>> Hence, this patch proposes adding file /proc/<pid>/numa_vamaps which will
>> provide proper break down of VA ranges by numa node id from where the mapped
>> pages are allocated. For Address ranges not having any pages mapped, a '-'
>> is printed instead of numa node id. In addition, this file will include most
>> of the other information currently presented in /proc/<pid>/numa_maps. The
>> additional information included is for convenience. If this is not
>> preferred, the patch could be modified to just provide VA range to numa node
>> information as the rest of the information is already available thru
>> /proc/<pid>/numa_maps file.
>>
>> Since the VA range to numa node information does not include page's PFN,
>> reading this file will not be restricted(i.e requiring CAP_SYS_ADMIN).
>>
>> Here is the snippet from the new file content showing the format.
>>
>> 00400000-00401000 N0=1 kernelpagesize_kB=4 mapped=1 file=/tmp/hmap2
>> 00600000-00601000 N0=1 kernelpagesize_kB=4 anon=1 dirty=1 file=/tmp/hmap2
>> 00601000-00602000 N0=1 kernelpagesize_kB=4 anon=1 dirty=1 file=/tmp/hmap2
>> 7f0215600000-7f0215800000 N0=1 kernelpagesize_kB=2048 dirty=1 file=/mnt/f1
>> 7f0215800000-7f0215c00000 -  file=/mnt/f1
>> 7f0215c00000-7f0215e00000 N0=1 kernelpagesize_kB=2048 dirty=1 file=/mnt/f1
>> 7f0215e00000-7f0216200000 -  file=/mnt/f1
>> ..
>> 7f0217ecb000-7f0217f20000 N0=85 kernelpagesize_kB=4 mapped=85 mapmax=51
>>     file=/usr/lib64/libc-2.17.so
>> 7f0217f20000-7f0217f30000 -  file=/usr/lib64/libc-2.17.so
>> 7f0217f30000-7f0217f90000 N0=96 kernelpagesize_kB=4 mapped=96 mapmax=51
>>     file=/usr/lib64/libc-2.17.so
>> 7f0217f90000-7f0217fb0000 -  file=/usr/lib64/libc-2.17.so
>> ..
>>
>> The 'pmap' command can be enhanced to include an option to show numa node
>> information which it can read from this new proc file. This will be a
>> follow on proposal.
> I'd like to hear rather more about the use-cases for this new
> interface.  Why do people need it, what is the end-user benefit, etc?

This is mainly for debugging / performance analysis. Oracle Database
team is looking to use this information.

>> There have been couple of previous patch proposals to provide numa node
>> information based on pfn or physical address. They seem to have not made
>> progress. Also it would appear reading numa node information based on PFN
>> or physical address will require privileges(CAP_SYS_ADMIN) similar to
>> reading PFN info from /proc/<pid>/pagemap.
>>
>> See
>> https://marc.info/?t=139630938200001&r=1&w=2
>>
>> https://marc.info/?t=139718724400001&r=1&w=2
> OK, let's hope that these people will be able to provide their review,
> feedback, testing, etc.  You missed a couple (Dave, Naoya).
>
>>   fs/proc/base.c     |   2 +
>>   fs/proc/internal.h |   3 +
>>   fs/proc/task_mmu.c | 299 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
> Some Documentation/ updates seem appropriate.  I suggest you grep the
> directory for "numa_maps" to find suitable locations.

Sure, I can update Documentation/filesystems/proc.txt file which is
where 'numa_maps' is documented.

>
> And a quick build check shows that `size fs/proc/task_mmu.o' gets quite
> a bit larger when CONFIG_SMP=n and CONFIG_NUMA=n.  That seems wrong -
> please see if you can eliminate the bloat from systems which don't need
> this feature.
>
>
Ok will take a look.

