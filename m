Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1800233-1525938182-2-12780137693555348714
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525938181; b=XFHumh24AFKKVEvY6CLBy8qqLhE6PUs/3VY2PebsEov+c5JF/z
    ZlY199tQbiklHApoovCI+tfii1CyBPpuyI2tIrWvgpkoRotaVpDE3JodsHyP9Ise
    Qv0Rp8UqbkdicQgaSfeeefRwR695BjkcOvVl2s0JtSqU3s0YGbiYdA9xRsArNYhh
    8JbxBSqae5OXMOmuxoVvd2eI/7FlIU0hA6zmpGlewWY1VWo1xdrwRamiEWOuDWwM
    q5VftpHM3RTYjfJtlcetEb7bweLwgwFylcHc0oNjCLU9q3FC5GfCMh7whdElNhcv
    pIFu8FoX6e83qx04EG8BiTWr637Swz7YD2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525938181; bh=5Jns0EXgqvD
    l+Otyc+Il458y7mCuDj7Au6cMtXh+xbA=; b=PTktnJK+uR79yx3KtuvXb1uUf2C
    6NrSjFNDG2vS7/HdLe67qt073S/6NqpeL0ev2SZtcbMBhQ9zzoh1ygd/bEKIFYVr
    q8tITPtvSh8dyH0IdJJOK4eDES4HGLbzJjjN5v72MYxOoLnrC4JAGAA/uvFYUotZ
    b2FzIZHscahebrOu51Y/Xs3crvD26q+iiwiw/sVnow0xjGuUMtXiYgxh3sj1lpdo
    hm3bLohWLW7PyDU3UNeaEdOGLNyxvNDx6gLpqGRRI235N7ZTprKgDLZ6PFTLosLL
    h2iHYho2yOh49CBSqtQS6b9qZuWmzQaYuDDGyQYtPzLAWolXEOQnM+ghgSA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfHpZK3T24R6pub44iDkrPDbwRH5gcY0H/ZV1PEtpQunCD68foMRlhf0yFop0XynpMC3nByhcjqb671PdZnX/P4cQx0aDp2hQLKbhz3CtOeLGZQxwznDq
    rMPrac+0J/SrTkI7bfbgEbeB7PTj5euRoX4Zna/rO1jA4WFHSwGmx5cynJhFxM/qwXD3VcXTfG8asKNYOmHW42K8bAGuWTHUGId4ZbY7wP6VN4d2M/ajWNZB
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=iYgYpim1DT6qtMvEznsA:9 a=HCd11zB5tW36QQ5F:21
    a=EARSHR5XqxJbYjRT:21 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934110AbeEJHm6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 03:42:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:50269 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933589AbeEJHm5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 10 May 2018 03:42:57 -0400
Date: Thu, 10 May 2018 09:42:54 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: Christopher Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        n-horiguchi@ah.jp.nec.com, drepper@gmail.com, rientjes@google.com
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
Message-ID: <20180510074254.GE32366@dhcp22.suse.cz>
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
 <alpine.DEB.2.21.1805031259210.7831@nuc-kabylake>
 <c80ee329-084b-367f-1937-3175c178e978@oracle.com>
 <20180504111211.GO4535@dhcp22.suse.cz>
 <de18dc06-6448-d6e5-fa80-c6065edd3aa4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de18dc06-6448-d6e5-fa80-c6065edd3aa4@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 04-05-18 09:18:11, Prakash Sangappa wrote:
> 
> 
> On 5/4/18 4:12 AM, Michal Hocko wrote:
> > On Thu 03-05-18 15:39:49, prakash.sangappa wrote:
> > > 
> > > On 05/03/2018 11:03 AM, Christopher Lameter wrote:
> > > > On Tue, 1 May 2018, Prakash Sangappa wrote:
> > > > 
> > > > > For analysis purpose it is useful to have numa node information
> > > > > corresponding mapped address ranges of the process. Currently
> > > > > /proc/<pid>/numa_maps provides list of numa nodes from where pages are
> > > > > allocated per VMA of the process. This is not useful if an user needs to
> > > > > determine which numa node the mapped pages are allocated from for a
> > > > > particular address range. It would have helped if the numa node information
> > > > > presented in /proc/<pid>/numa_maps was broken down by VA ranges showing the
> > > > > exact numa node from where the pages have been allocated.
> > > > Cant you write a small script that scans the information in numa_maps and
> > > > then displays the total pages per NUMA node and then a list of which
> > > > ranges have how many pages on a particular node?
> > > Don't think we can determine which numa node a given user process
> > > address range has pages from, based on the existing 'numa_maps' file.
> > yes we have. See move_pages...
> 
> Sure using move_pages, not based on just 'numa_maps'.
> 
> > > > > reading this file will not be restricted(i.e requiring CAP_SYS_ADMIN).
> > > > So a prime motivator here is security restricted access to numa_maps?
> > > No it is the opposite. A regular user should be able to determine
> > > numa node information.
> > Well, that breaks the layout randomization, doesn't it?
> 
> Exposing numa node information itself should not break randomization right?

I thought you planned to expose address ranges for each numa node as
well. /me confused.

> It would be upto the application. In case of randomization, the application
> could generate  address range traces of interest for debugging and then
> using numa node information one could determine where the memory is laid
> out for analysis.

... even more confused

-- 
Michal Hocko
SUSE Labs
