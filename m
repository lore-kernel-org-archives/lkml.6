Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3366326-1526020800-2-1605416810231678408
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526020800; b=jH4ozB3c+YwzJkij5JeObYboFPqWmV4W12PMZbu5wg1EalOxMv
    ERuTsDIcYg8Ddt2BZ4D+dylnUYQqzGUPo6P9/6+AUH8LnVSxM+UJdYd5drZnwS2T
    prqayHCLSQ7bv9VWIGgPgNk2GnKEq6pglG2l1fjRh1Wjm7QB1wgww5928KR9ZxOy
    nPvaOTexOcl4QD1Eb7bxijSL9V/16DOIU4GFDgGTjTZdPI3eJ+Ok5vpI2Tg7DWoQ
    Ep3GwT0NhJrmt4vqNE/zNFRardFV92o7+PR0GfiJPvR3BprS+glObZUgzNuj7YJJ
    XH8p14njKFd4AvegBazVl65KZiYwCtKg/Zwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526020800; bh=8jQvg+m8y+9VYMvUs0FCbmJkGJM9kc
    eBSz7UwRQkKIE=; b=aHr1Jqoe1CSZKpJZndTjHAOJeTPUXr4tc+6nY5523HdDq3
    /nrRP1x/wT0MaqNEVUFxlK0sLn9lGAm0QY/eWjFbAHvMA46R2rKdXHAnP199i1TO
    zM5IZrSy31OxsUAKedelN/yjgyMtRAdB1w1wGfdzc1144nqm3/kj3U8pH4SGN9ww
    tAfbWNq6o55tX5kmTVnQae0RMsz8Etp8MNfm8hxhRY0YAwCpGZdXMfsOM9Mpi+Ue
    M1yojga3uyjg+GRVnFSAwdObFdlc2LotLfCAeA9YdhZc1YW2g+KvCoFni6gxjNe8
    KDIqKSYqlNnVfQXnrZxEZsk6fGgzRAkhzPMFq1uQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ3eSuUGe8VEe+4jZGmOrm37qmtzdUvcnjpJmb8UgwlTsRvTB3aY5E0avvt7yJY7vmUZMkJHwRTbaW7vLu31OACUhllEiDuIo59rgltMfRAmOoc00C19
    XaDjoDKi11W3rerYmm2eIXpRKNZoTChsVJL4ysWlZ2jYvmdQtXna8TzNAhDW+Pw6kuzjmC/yfKK95nENIG2sJzV8vY1y2ja3oimLgUDk7+w/0oYDbdV7Ea1j
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=gw_BKDNX6y9Z78C2mqcA:9 a=yY7Z6Ytd3otwJNjr:21
    a=uALRfo8tMosxGS-p:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeEKGj5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 02:39:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:48558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752043AbeEKGj5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 May 2018 02:39:57 -0400
Date: Fri, 11 May 2018 08:39:52 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: Christopher Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        n-horiguchi@ah.jp.nec.com, drepper@gmail.com, rientjes@google.com
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
Message-ID: <20180511063952.GA23231@dhcp22.suse.cz>
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
 <alpine.DEB.2.21.1805031259210.7831@nuc-kabylake>
 <c80ee329-084b-367f-1937-3175c178e978@oracle.com>
 <20180504111211.GO4535@dhcp22.suse.cz>
 <de18dc06-6448-d6e5-fa80-c6065edd3aa4@oracle.com>
 <20180510074254.GE32366@dhcp22.suse.cz>
 <ce2c36aa-8c03-63d6-e1ce-031197f45a5d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce2c36aa-8c03-63d6-e1ce-031197f45a5d@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 10-05-18 09:00:24, Prakash Sangappa wrote:
> 
> 
> On 5/10/18 12:42 AM, Michal Hocko wrote:
> > On Fri 04-05-18 09:18:11, Prakash Sangappa wrote:
> > > 
> > > On 5/4/18 4:12 AM, Michal Hocko wrote:
> > > > On Thu 03-05-18 15:39:49, prakash.sangappa wrote:
> > > > > On 05/03/2018 11:03 AM, Christopher Lameter wrote:
> > > > > > On Tue, 1 May 2018, Prakash Sangappa wrote:
> > > > > > 
> > > > > > > For analysis purpose it is useful to have numa node information
> > > > > > > corresponding mapped address ranges of the process. Currently
> > > > > > > /proc/<pid>/numa_maps provides list of numa nodes from where pages are
> > > > > > > allocated per VMA of the process. This is not useful if an user needs to
> > > > > > > determine which numa node the mapped pages are allocated from for a
> > > > > > > particular address range. It would have helped if the numa node information
> > > > > > > presented in /proc/<pid>/numa_maps was broken down by VA ranges showing the
> > > > > > > exact numa node from where the pages have been allocated.
> > > > > > Cant you write a small script that scans the information in numa_maps and
> > > > > > then displays the total pages per NUMA node and then a list of which
> > > > > > ranges have how many pages on a particular node?
> > > > > Don't think we can determine which numa node a given user process
> > > > > address range has pages from, based on the existing 'numa_maps' file.
> > > > yes we have. See move_pages...
> > > Sure using move_pages, not based on just 'numa_maps'.
> > > 
> > > > > > > reading this file will not be restricted(i.e requiring CAP_SYS_ADMIN).
> > > > > > So a prime motivator here is security restricted access to numa_maps?
> > > > > No it is the opposite. A regular user should be able to determine
> > > > > numa node information.
> > > > Well, that breaks the layout randomization, doesn't it?
> > > Exposing numa node information itself should not break randomization right?
> > I thought you planned to expose address ranges for each numa node as
> > well. /me confused.
> 
> Yes, are you suggesting this information should not be available to a
> regular
> user?

absolutely. We do check ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)
to make sure the access is authorised.
> 
> Is it not possible to get that same information using the move_pages() api
> as a regular
> user, although one / set of pages at a time?

No, see PTRACE_MODE_READ_REALCREDS check in move_pages.

-- 
Michal Hocko
SUSE Labs
