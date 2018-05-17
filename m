Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1627028-1526539682-2-10676504211814260728
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
    1526539681; b=RoRVSAiBphVrisLyFIA5/2OH0ev7uhi+/2Wu0eOEKV0SHXxujV
    hLHaENMugq2HBUBtKLPU4Ap1lGz8dyBz8gapvdewD2xN738V9cLqJ60/ckmipA3V
    ZDF3jUfn2O78h5s5WNcvSQLpjT8U4TmejxzAibBxQ7ZW2fI+6qjGPdqqlmS+kAnB
    KPwtQB+YC8cUiBlHmZSLvPF4pNhcDpv1Km/99kaxu+l8WiF7iz28xzJaW1WGZtO5
    8wgpa2TSfY+1Vu00M/+dx3qivxISDD4NgRE+wIZo2StXQ0nUfw4Yy1JFFxATw+xO
    Shx3nKXI7B/hzGfxG1Y7mUgkH47ruoGDMfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526539681; bh=Wa+E9kWCxzBMfvsP8V3w0rtnjOpm2a
    ywMF3DdU8f3C8=; b=mpf+YWOQ9aH4VkaR+GG0Xx3jEFDjzfLbQxw6QbP8vFPGeg
    8iljl82DpaZn8v4q0loN4mgaD09XkodQ19oDzUxeOuYaIBj8et5gy48HP/BoqDVl
    g+p11bb7SdH6RIExV4R1+z6nVfmwAbd8AuU1YvOeQaoRJtxvNYG1a3+5qMZOnOJG
    7lROZJ7Q3jM97ogYrv2TAfB/8BXc6PYAxEQafXC6+CkYjCCjBDWMA1chyJAA4YC/
    jKE5JghQSjqdYB1UV4Uk8+tEhtRs6Sr7hFCly9dqsMnbx55BrvwaB/KG0h/+aDKN
    5we8H6GpnNKVWQpid/kstRenOnzZr3hT76je7fFg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfPTEueFu/uS1A+0QG29mfNHKkWHQZNck29aKmIv+sUHuYBWUaLIeNjA03aKd5UVlkQbanePaq5D4E453aF/sb+m7f/RmmYquuUS/NOgWft8cBaKD5dfP
    deTt87jDPRfw7GYMdC2FPN6gyFyrDeBYEu481etWv9xqTlMXcX/nrxYNxzwOZ7yNETpXBbLteUjMEMcaRWvHmoMKS7IwraaOH17EZr2z9ESLkskcGYqYxj6t
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=LpQP-O61AAAA:8 a=VwQbUJbxAAAA:8 a=Pb7CI5Rk1jM2S4FYhvIA:9 a=CjuIK1q_8ugA:10
    a=pioyyrs4ZptJ924tMmac:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbeEQGr7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 02:47:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:58153 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbeEQGr6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 17 May 2018 02:47:58 -0400
Date: Thu, 17 May 2018 08:47:55 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, cpandya@codeaurora.org, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] ioremap: Update pgtable free interfaces with addr
Message-ID: <20180517064755.GP12670@dhcp22.suse.cz>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
 <20180516233207.1580-3-toshi.kani@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516233207.1580-3-toshi.kani@hpe.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed 16-05-18 17:32:06, Kani Toshimitsu wrote:
> From: Chintan Pandya <cpandya@codeaurora.org>
> 
> This patch ("mm/vmalloc: Add interfaces to free unmapped
> page table") adds following 2 interfaces to free the page
> table in case we implement huge mapping.
> 
> pud_free_pmd_page() and pmd_free_pte_page()
> 
> Some architectures (like arm64) needs to do proper TLB
> maintanance after updating pagetable entry even in map.
> Why ? Read this,
> https://patchwork.kernel.org/patch/10134581/

Please add that information to the changelog.
-- 
Michal Hocko
SUSE Labs
