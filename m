Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-7860-1525432339-2-8574414895174867238
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
    1525432338; b=dqpMGGVGp3RPQ1ThZXrM/EVXdC2Uh1MVZHRrHJXbKdwSiOM5q9
    AIunIV3I70qdrmDEIP0c8GOs8wbFejT2GLzKG9yw/Zimw1UfJx9X9j4MA4rV0avV
    ufVbX6LZA0k/YtHleiopwcrtU0WGYslz8HYGFDu954fBteUorpEwr5c8cnfJo944
    GqmwVa26mTsqko2B19m3vkSf6vTqBTbWNmrdbmNRIIHOmD1QwM2U9GocBoTOU/UM
    AbxYj2Nr6tetp1JfGlgSRxaTsjhxbUZ5FkYojTIDxfe7Dn9WgY9SYN1cSF44fWMn
    rsVDjeOcQavcHYSV3jcEJM6myobEbZN0NeOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525432338; bh=vFRWzMlNq2MOO138yFQbS41XtfeEQN
    junYof82UlzwY=; b=EKsAaGgXsI+WTPxR2aRQ9QNBeAxo1dWYJK0Gww7DXlG8Jm
    64ERgDmf5L2n412CEGDlfshNhafR+i2XgV2IKVxIYGFB7UpNVYCiwb8/mP8c518M
    HYJVXaTZpTBaTB7C85ep5nFQX0KG6eRT8vUoo+azyHCpizR+OiDBTJg0FNpUZNAE
    ZqAuJdGy6/hqQ5sJkwfyGm9bKM/ZEhhwUx1eW/vXfpaJpykmvoSMFWm7zZJj85Qi
    D0fQXN90Z+1/v0XSj2UkqGcY03omh/n8BNXDRfRADoVrosfh3e937sZZRoM7o3Lq
    7Ou94y0Dep9NDxsXqiOr/L4JBH60FxUTwRKuI9cw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfNjXdGvCLjuw8LrPqWxYg9kzZzxXnRKHCDJCDY5fQ/oBgFwqUES56bUxvHianFc87R12jnY2njpBUPQY9zXw0cklNK2FyT/NzZJdeZhIJJuocTIQ3qbh
    CER7gz4W1XzIAVa15CGxWiNw6SE2vzJ/dABVT6GPK0ORdghvNpaLYYKKa7zOAoTrlN4odmQYpSOi4q9yRw6kEyG1EE7IZj54XGup9yovnh5HODhCNShuFJFF
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=iwlF-hDM4qxIaMuNqEQA:9 a=TTKmP-rBUTzsLqnf:21
    a=NBsgW4alb1mBrQWD:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751196AbeEDLMQ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 07:12:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:49201 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751106AbeEDLMP (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 4 May 2018 07:12:15 -0400
Date: Fri, 4 May 2018 13:12:11 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "prakash.sangappa" <prakash.sangappa@oracle.com>
Cc: Christopher Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        n-horiguchi@ah.jp.nec.com, drepper@gmail.com, rientjes@google.com
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
Message-ID: <20180504111211.GO4535@dhcp22.suse.cz>
References: <1525240686-13335-1-git-send-email-prakash.sangappa@oracle.com>
 <alpine.DEB.2.21.1805031259210.7831@nuc-kabylake>
 <c80ee329-084b-367f-1937-3175c178e978@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c80ee329-084b-367f-1937-3175c178e978@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 03-05-18 15:39:49, prakash.sangappa wrote:
> 
> 
> On 05/03/2018 11:03 AM, Christopher Lameter wrote:
> > On Tue, 1 May 2018, Prakash Sangappa wrote:
> > 
> > > For analysis purpose it is useful to have numa node information
> > > corresponding mapped address ranges of the process. Currently
> > > /proc/<pid>/numa_maps provides list of numa nodes from where pages are
> > > allocated per VMA of the process. This is not useful if an user needs to
> > > determine which numa node the mapped pages are allocated from for a
> > > particular address range. It would have helped if the numa node information
> > > presented in /proc/<pid>/numa_maps was broken down by VA ranges showing the
> > > exact numa node from where the pages have been allocated.
> > Cant you write a small script that scans the information in numa_maps and
> > then displays the total pages per NUMA node and then a list of which
> > ranges have how many pages on a particular node?
> 
> Don't think we can determine which numa node a given user process
> address range has pages from, based on the existing 'numa_maps' file.

yes we have. See move_pages...
 
> > > reading this file will not be restricted(i.e requiring CAP_SYS_ADMIN).
> > So a prime motivator here is security restricted access to numa_maps?
> No it is the opposite. A regular user should be able to determine
> numa node information.

Well, that breaks the layout randomization, doesn't it?
-- 
Michal Hocko
SUSE Labs
