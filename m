Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1359032-1525296809-2-7537311954396401859
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525296809; b=VUVFbrUdQMu/7FdJqCp6LPCEVK1fDvegoh9A9R84BRzeJQ+qxu
    TSka6A4sGwdKpuDLUpIzynS+qS54Rxo+G7lQnn9bekE1nt2SBIyTf3Ak9RGelHsS
    ps+et3To5neXcLqTzltN0MfNhgg8XuAMC8FklELYNGN/yhhyRr/iU/WMp/PaRiyX
    Y2XHNYCpN/06omY/n9GDmoNmCvMTR/ycbkG20l/CAZetbtjO+fBlh8m4I+KHzBJ+
    gSLUyc1DkS5KzPzV0k7qkuFdO5Z2x2wCkHi6CB6ujeWLA6pKQOajnwMv/K1/fG+c
    jc1iWgpyWN4bPx7aXIoaWwJD75jfopBIixjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525296809;
    bh=CNE/v9YyQJffGUgIYKzX5fZLJMvdzalmccfO+OnH8iQ=; b=SJ3tqcFZErt+
    h7UAWgt91H0dRQDIzuKUeHSel9EKQ53aVPUrtrmRAYh6m9UmhzUsuhlzNSPslYPm
    TYTyjFn03wQ3CeRKaB/WQHiNfeLcb4uO1b/8VewIhKi/x2E8Bfwk59/evZfzR1OT
    ub2ckBGvBaCaNqqiMs4zPbXRCG0y7yqDcgkiVXc+lGCNMbyrkxc9q5HcaisE4N58
    DU3NB5PPVfTSnEEw46raRfnTL1TIO9vO9IVexLkEfCY8ve5jCRHPYDR8eP22k9jn
    4qk14JKrrils9kG8xv5wmvhCmyfvG/yikg3mHes9OPdw+Qy7tSTnDoKsgp2qvfKH
    Yg63R/ZgsA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-foundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-foundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLoiV1/XfP+aXqLr4yt3Z4jI5fQ5Gq5icm0HPI5lDqJr8erjYpASnOFKzMTvvgULYaui/2MXnyLGpqYoNpRptJkHWsS2Dlj0TfixAfcZoAY95jr6rpAm
    P02j9WSZ8YNxiAn8qeI/RaHR4PDmZRrn2IMxr0HmlK17fSWGnuHouUr1UKQWOINQic0fw56getKvPo7VmPbU4LNTKir8aDikjKX3BZKQXeBqZDrbHbWl46/5
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=gu6fZOg2AAAA:8 a=VwQbUJbxAAAA:8 a=ROkQo8crJBWIbZ9XIVwA:9
    a=O7hx8p9rRDoi0CO9:21 a=odK1GHfTZDmBwBIc:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
    a=2RSlZUUhi9gRBrsHwhhZ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751711AbeEBVd0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 17:33:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47890 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbeEBVd0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 2 May 2018 17:33:26 -0400
Date: Wed, 2 May 2018 14:33:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, n-horiguchi@ah.jp.nec.com,
        drepper@gmail.com, rientjes@google.com,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node
 information
Message-Id: <20180502143323.1c723ccb509c3497050a2e0a@linux-foundation.org>
In-Reply-To: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue,  1 May 2018 22:58:06 -0700 Prakash Sangappa <prakash.sangappa@oracle.com> wrote:

> For analysis purpose it is useful to have numa node information
> corresponding mapped address ranges of the process. Currently
> /proc/<pid>/numa_maps provides list of numa nodes from where pages are
> allocated per VMA of the process. This is not useful if an user needs to
> determine which numa node the mapped pages are allocated from for a
> particular address range. It would have helped if the numa node information
> presented in /proc/<pid>/numa_maps was broken down by VA ranges showing the
> exact numa node from where the pages have been allocated.
> 
> The format of /proc/<pid>/numa_maps file content is dependent on
> /proc/<pid>/maps file content as mentioned in the manpage. i.e one line
> entry for every VMA corresponding to entries in /proc/<pids>/maps file.
> Therefore changing the output of /proc/<pid>/numa_maps may not be possible.
> 
> Hence, this patch proposes adding file /proc/<pid>/numa_vamaps which will
> provide proper break down of VA ranges by numa node id from where the mapped
> pages are allocated. For Address ranges not having any pages mapped, a '-'
> is printed instead of numa node id. In addition, this file will include most
> of the other information currently presented in /proc/<pid>/numa_maps. The
> additional information included is for convenience. If this is not
> preferred, the patch could be modified to just provide VA range to numa node
> information as the rest of the information is already available thru
> /proc/<pid>/numa_maps file.
> 
> Since the VA range to numa node information does not include page's PFN,
> reading this file will not be restricted(i.e requiring CAP_SYS_ADMIN).
> 
> Here is the snippet from the new file content showing the format.
> 
> 00400000-00401000 N0=1 kernelpagesize_kB=4 mapped=1 file=/tmp/hmap2
> 00600000-00601000 N0=1 kernelpagesize_kB=4 anon=1 dirty=1 file=/tmp/hmap2
> 00601000-00602000 N0=1 kernelpagesize_kB=4 anon=1 dirty=1 file=/tmp/hmap2
> 7f0215600000-7f0215800000 N0=1 kernelpagesize_kB=2048 dirty=1 file=/mnt/f1
> 7f0215800000-7f0215c00000 -  file=/mnt/f1
> 7f0215c00000-7f0215e00000 N0=1 kernelpagesize_kB=2048 dirty=1 file=/mnt/f1
> 7f0215e00000-7f0216200000 -  file=/mnt/f1
> ..
> 7f0217ecb000-7f0217f20000 N0=85 kernelpagesize_kB=4 mapped=85 mapmax=51
>    file=/usr/lib64/libc-2.17.so
> 7f0217f20000-7f0217f30000 -  file=/usr/lib64/libc-2.17.so
> 7f0217f30000-7f0217f90000 N0=96 kernelpagesize_kB=4 mapped=96 mapmax=51
>    file=/usr/lib64/libc-2.17.so
> 7f0217f90000-7f0217fb0000 -  file=/usr/lib64/libc-2.17.so
> ..
> 
> The 'pmap' command can be enhanced to include an option to show numa node
> information which it can read from this new proc file. This will be a
> follow on proposal.

I'd like to hear rather more about the use-cases for this new
interface.  Why do people need it, what is the end-user benefit, etc?

> There have been couple of previous patch proposals to provide numa node
> information based on pfn or physical address. They seem to have not made
> progress. Also it would appear reading numa node information based on PFN
> or physical address will require privileges(CAP_SYS_ADMIN) similar to
> reading PFN info from /proc/<pid>/pagemap.
> 
> See
> https://marc.info/?t=139630938200001&r=1&w=2
> 
> https://marc.info/?t=139718724400001&r=1&w=2

OK, let's hope that these people will be able to provide their review,
feedback, testing, etc.  You missed a couple (Dave, Naoya).

>  fs/proc/base.c     |   2 +
>  fs/proc/internal.h |   3 +
>  fs/proc/task_mmu.c | 299 ++++++++++++++++++++++++++++++++++++++++++++++++++++-

Some Documentation/ updates seem appropriate.  I suggest you grep the
directory for "numa_maps" to find suitable locations.

And a quick build check shows that `size fs/proc/task_mmu.o' gets quite
a bit larger when CONFIG_SMP=n and CONFIG_NUMA=n.  That seems wrong -
please see if you can eliminate the bloat from systems which don't need
this feature.


