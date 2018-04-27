Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-73130-1524829181-2-5606508462375765931
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524829180; b=TUFo2Xgj20SMAj4VIrr6mGxnmDVRjCk9hQpmB5gtf6f9QFlc9c
    wV+bUy+DudpnRXmLL6rsrTRsBMDzNJfMGYUAs9C6jiU7k6kT0txZA+SWfMIyF2d3
    eK/UC8t81ZMrFIEaxxcTYySPlT+C1MM8b1TngHrS8JH+JWsnjgSaQ6x9bijyW96U
    2wqoi4HbfKOLiKav+6D1mdsT/IpLpp2Hj6eOtfIX4CvRTGoC/pzPUIc9d0lKKGuM
    C7TUqv4QSErYQh0m4UmnE1GKz89BhTHIZIRnjvx74D8GEuAs3SfeTNHYnV5A7OGW
    4NhLLbGrurzfOqG7ICSmhFMSHWmsuUMj6IVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524829180; bh=9GuoJpjTEiL0SvkBzLEu+FDGrqb+aK
    jBb27drxlsW74=; b=Ci2aWttrtNcialZaG3l7jHfvULkPG2snsd0uvDkMtm/WGQ
    jRugfMcQy3QSL5GMAYIB6PmsMmNRSYufm3p/vUw70WeaLe+hFgV79BViPVIsLvKT
    sqdivf29ESq39vpbicZKVjwM8fF/Nx7+hXJq1hYXWC2yJNwRx8WJahUarkFt+sRW
    NHoE/xFJtjYtRGm4w5JmtgSHPc7aXcR2iVPygRceLemwZvwqq4hXwo9i6QMkTgV7
    B2/8V1JMU/4vblTWEUIooTYjIpZT9sud+AZJU4wtFP4ahVHS7CPcG9NbBuL4dfRf
    +++CCJaWL0ihMP9P0bUB1XWs7f9Mh0OJgCmNdNIg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBM09VsUFRpkQOz9yZ6x1IAN5Vl6Vzr0cY1wbvdiIN+cUgyLZdN7fuabRb7xhG4OClO9SSJTGSHAoi24iBdYuiQfINKTbW2KG0MvW6M3Vb7WQ9tn5GVa
    X3KxcISMpPu8OFOrLUg7c5mbocC6QKnj8CZAzTkQiJOpv4eWNw/Q/lVQUH4gJ7p7sPQ5/9pW9xNle0+8kPXqwgBtvW81W1jC7Doe7yt1PlBt3bmjioBn8vSq
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=tA7aZXjiAAAA:8 a=xXR-8_Yp-LMu0qM4etoA:9 a=CjuIK1q_8ugA:10
    a=kIIFJ0VLUOy1gFZzwZHL:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757677AbeD0Lj3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 07:39:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:59435 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757545AbeD0Lj1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 07:39:27 -0400
Date: Fri, 27 Apr 2018 13:39:23 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "joro@8bytes.org" <joro@8bytes.org>
Cc: "Kani, Toshi" <toshi.kani@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] x86/mm: implement free pmd/pte page interfaces
Message-ID: <20180427113923.GF17484@dhcp22.suse.cz>
References: <20180314180155.19492-1-toshi.kani@hpe.com>
 <20180314180155.19492-3-toshi.kani@hpe.com>
 <20180426141926.GN15462@8bytes.org>
 <1524759629.2693.465.camel@hpe.com>
 <20180426172327.GQ15462@8bytes.org>
 <1524764948.2693.478.camel@hpe.com>
 <20180426200737.GS15462@8bytes.org>
 <1524781764.2693.503.camel@hpe.com>
 <20180427073719.GT15462@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427073719.GT15462@8bytes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri 27-04-18 09:37:20, joro@8bytes.org wrote:
[...]
> So until we make the generic ioremap code in lib/ioremap.c smarter about
> unmapping/remapping ranges the best solution is making my fix work again
> by reverting your patch.

Could you reuse the same mmu_gather mechanism as we use in the
zap_*_range?
-- 
Michal Hocko
SUSE Labs
