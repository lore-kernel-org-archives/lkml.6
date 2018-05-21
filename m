Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1449503-1526944232-2-10803793067230069626
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='ISO-8859-1', plain='ISO-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526944232; b=gBor1yq9uY767XmVlbLnZJqaCC8l2GTsbGQ1h3/w1xEnN2/ZV/
    1AhW/lANvS/VlPCyuCeJ/3UiLsOK39RZgg+zWvJMEW/GFrdK1PwQYovbiCdADzA8
    e21oO93fXB5mQNF2xGM+KKbiPrDD871o/9aLMgiq2MT3FwOigr1Wwi6RB0Sv4Kdd
    cjQo6IoHgyZJJSaoeNuqHKT7+lOO7NZql19JH9n8rwfVQfMSqNn+MzlkUbdFE+Dp
    h/VX2X/6U4l89aTlxGTreEIYn9HlCQSoPS8PO2dGwFyurKWzZhXTw+M7zTC/76ob
    ZOpk3LRXldvFnEGyXOIUQL+s6HrvWG2Qzdlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526944232;
    bh=xSqpWsOSj7tyJu9vJQxmd1tB0wd/zxJq6G14L4Q5uuQ=; b=c3dsLDZlsEZk
    XliC8weY4Zf8IMz0SbJ3vW1HfZ/RYByPZPT+71oYasp86aRIq9PegTyRqv0IlZdD
    e9qjwXYW90hy6I3ZkDBVz9nCPXI/1q/SmrbYBs9C8rr/YwPxlX1D5Vzyb0KBA8xD
    FQjvh50Y+XhIMhRE0qjv1SPqL+/ItSO0Fyh6p4Zyhb/mDlOs8sA2Ii5AUbvS/wxj
    YoP64l+g6WhQNjQ5BdkTfoUygDXsrQltcqJT3kybAnxiAj3/oW0Txt95WgBGxO8o
    CGpSHH7BRP0COrZiMR/wB5A6c7HyOAJ9VletjYiBG39o0vYXQQRh+9LxMLZHGT2u
    iTzwOovV0g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-foundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
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
X-CM-Envelope: MS4wfKK8cmbQAj0VkPjBzuJZAHyGSI13ZSozHbTsCQFHroEFyogu7PowLeTa1EG7DDRZyBOUX9hjbyzEz8cQ3LOfJs4LxB/4mOFIQ947GbSG1kinZM9CdF6B
    wKDwIDg/JAoKW6/uPmYfeaZDm+0nPoEJ4lrmXEtN77upucthDhcMvmzABqMqOqsPt6z/aTyp02okGsahamZbpru3KzOjx8Pc0tzPQi5WA6HZMLGNawkniC2h
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=gXLdhW2jAAAA:8
    a=0h-UnUqaR0D1f81tj1UA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Dn9eIPSr_RzuO0KTJioD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751019AbeEUXK3 convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 21 May 2018 19:10:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52220 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeEUXK3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 May 2018 19:10:29 -0400
Date: Mon, 21 May 2018 16:10:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] mm, devm_memremap_pages: handle errors allocating
 final devres action
Message-Id: <20180521161026.709d5f2876e44f151da3d179@linux-foundation.org>
In-Reply-To: <152694212460.5484.13180030631810166467.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com>
        <152694212460.5484.13180030631810166467.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 21 May 2018 15:35:24 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> The last step before devm_memremap_pages() returns success is to
> allocate a release action to tear the entire setup down. However, the
> result from devm_add_action() is not checked.
> 
> Checking the error also means that we need to handle the fact that the
> percpu_ref may not be killed by the time devm_memremap_pages_release()
> runs. Add a new state flag for this case.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: e8d513483300 ("memremap: change devm_memremap_pages interface...")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Why the cc:stable?  The changelog doesn't describe the end-user-visible
impact of the bug (it always should, for this reason).

AFAICT we only go wrong when a small GFP_KERNEL allocation fails
(basically never happens), with undescribed results :(
