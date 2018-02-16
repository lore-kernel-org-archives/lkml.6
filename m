Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-268172-1518791294-2-7895034947194190956
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518791294; b=QPVSn27Lok/mVKzI4tWFapuLyZ4lkFh+jcDkEg/02kMFpxW
    t2O2dhtHB6x8sUmcrVZerylSGRSGeqpvb4kHXpYKhaMWw+plw6oGUhDhCyxr8TK5
    73/BUPoJR68iyrc8K4H/cZw8EkTeS5yk/1qvk4+YAHLMaQsxYeelp9Klz8oVMLeT
    ldsxUG4nKbkVZzPq4RA91agmO3Gimy5if9lKxMMigyWzOOnJCvUoba1FSR4oSGrO
    Kro2NpJ8onwR1UhNn/B/aTXc2dYNsGGUOzXGxtgRHfXVOHrq+jLtw78hiFCpn2mT
    Qr5lX0hzLpxOTQhSh+QL0eet4FugHesearoB8Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518791294; bh=KInnMT1aB8P+O6GlBi7HRl+kCd
    0e5dCORmY4v6H9H2c=; b=d3pg5vU8oulWh/aqzEv+D7qicIcsJXiR5kBGaojjlZ
    UQL5kQWT6J1ajQmNErFCTT+1/oAuHq5DsJ2eAM3RG/U5MHwXckpBp1rUyhsiccto
    lW4kGknXGUUTfHKSwvclCeRRNeh7bB23rBxxliizpcToD9hAmbh/P4sVkjvR6Kf+
    VaFP/w4HRNkw8zDUPb1N4y6VV9XyiNKP9tAX3ogk3nyS/Iuf0wvElAu14pT/vdvq
    8MtI8h5L/ZY8qOudcF4tYn6hrzDTqzORe7pVnE63C28BHFV67cnX/7I8mAoV/l76
    YMhkFMd1Z6q/fGSIZgToODsaJRU2VPWfwJjNQhR7rxXw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034365AbeBPO2L (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 09:28:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:58556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034273AbeBPO2L (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 16 Feb 2018 09:28:11 -0500
Date: Fri, 16 Feb 2018 15:28:08 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, akpm@linux-foundation.org,
        stable@vger.kernel.org, Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: Re: [PATCH] mm: don't defer struct page initialization for Xen pv
 guests
Message-ID: <20180216142808.GS7275@dhcp22.suse.cz>
References: <20180216133726.30813-1-jgross@suse.com>
 <20180216135940.GQ7275@dhcp22.suse.cz>
 <1424bb25-7d6a-ee21-83b4-0e90369d6132@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1424bb25-7d6a-ee21-83b4-0e90369d6132@suse.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 16-02-18 15:02:17, Juergen Gross wrote:
> On 16/02/18 14:59, Michal Hocko wrote:
> > [CC Pavel]
> > 
> > On Fri 16-02-18 14:37:26, Juergen Gross wrote:
> >> Commit f7f99100d8d95dbcf09e0216a143211e79418b9f ("mm: stop zeroing
> >> memory during allocation in vmemmap") broke Xen pv domains in some
> >> configurations, as the "Pinned" information in struct page of early
> >> page tables could get lost.
> > 
> > Could you be more specific please?
> 
> In which way? Do you want to see the resulting crash in the commit
> message or some more background information?

ideally both.
-- 
Michal Hocko
SUSE Labs
