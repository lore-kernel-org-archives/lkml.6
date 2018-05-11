Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3414749-1526021325-2-16294379714285566330
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
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526021324; b=lLq9+qVRkND93eiiiXNO2dpL0PMTs0qoR0qFqXh3SkV7IN98Vw
    nmdPUpozclhYUHN6MTbXzqSoByfom/9VlzpqN9NGBk9f3wTmACCFPW6trsrudp3U
    UPUnM7+VGjYSwoJDv4BHgwZwYD5YAqhSbgetN8eg4z6P7gIsRZRHlyPellfh+Jat
    kULTfvcv2mrU+zl//KgBzpiqL9qVFr95pC1wVbbyM2ISrmrWqaZBeI66kk2DxBjv
    S96x1wxsWr848ZbBQ4xlqTeWuWFlJvRHtHg7QIzKJxY69GtYxd4ycAYv6QaasUEM
    LI1OrGwl0WUD6b87vFfjtvvnLnm9mdZQ0tDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526021324; bh=q1Z8uZkI2EpcByNYr1/9SMzuKeOAxG
    5HHSl+rg/XNgo=; b=PYNevAseNdSa5a3gqd3hJJRTOnzSG4CTFXmxXJFwtMfvN5
    +cm3ZfdSeJoxQNgoPQX1wHLI2DrUPV1AL8oeQ9Y4hDgmNqRR7cq7M6Avn9n6h+8t
    HQGU0PAE1NHuZ29y3MNEwZJ785rO518+YEQq0sP9RtzvuNFH7tERd+8aTiLvNoUl
    mhRv2MTKiSNnM8JdnXTrBchBE43WmzU6c6YZOJ1pmzMC0TkkhL4ZpeV266CqGogN
    AQqeNoOKm9TgcHuxuf5Jeh0Y1Nf7iI1G8wBkoYlbJSwip4I9Iz6feVRrbqucXtu2
    2wKq/24oCuFltcS96Fq2qRxkQef+9XM2NNTz/qSg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCTxYnF10yqza5C7KKZqA6m2lcst5zlGE95X+HSle8hIpEXR4s4ic1C4Rqh1XLOxSBsTcLcbjxQEh+Rztb0ujOJnbUsZTPeSAUD8ApFXk/shU3fnVNvY
    97lXmbIGihk7aTWU8KY4wCGIBC8Tv/ty/1eml1lVdGqBxc5+H8TreZJdCdocfZI/bGzsCDlgpmbCSDQCBqnm6b5kIrVlIKdLoqDIwOu9m7Mvit7Bc96cuo87
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=MvuuwTCpAAAA:8 a=y7pJ_hJlBaDsDb4nDBYA:9 a=CjuIK1q_8ugA:10
    a=dVHiktpip_riXrfdqayU:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeEKGsl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 02:48:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:49636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752294AbeEKGsl (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 11 May 2018 02:48:41 -0400
Date: Fri, 11 May 2018 08:48:37 +0200
From: Michal Hocko <mhocko@kernel.org>
To: mike.travis@hpe.com
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Andrew Banman <andrew.banman@hpe.com>, jgross@suse.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 0/3] x86/platform/UV: Update Memory Block Size Setting
Message-ID: <20180511064837.GB23231@dhcp22.suse.cz>
References: <20180510231832.035433756@stormcage.americas.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510231832.035433756@stormcage.americas.sgi.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 10-05-18 18:18:32, mike.travis@hpe.com wrote:
> 
> Update support for the UV kernel to accommodate Intel BIOS changes in
> NVDIMM alignment, which caused UV BIOS to align the memory boundaries
> on different blocks than the previous UV standard of 2GB.

Please elaborate (much) more. What is the actual problem and how is the
patchset addressing it.
-- 
Michal Hocko
SUSE Labs
