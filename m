Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3317868-1523886573-2-16944168261006238964
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523886573; b=NwvDMHgAnRt6clX4/V6gSCH4u7wjwtuWz9XnNULjupPxv3H9d8
    z9Ez1NPjavLg/XzJ3Sve5IApeGEClTY/tzdbJ+U36EhQmMLCjVvwhDz7lNxamAJe
    JC9Wp8YzkQxwCC00lZRxYioNgvKdYiQ/SPBrpX+hdJ1JadYmCDb/TvzN6zcI4jsT
    fmOCCqliQQsEF5mKDTAydfscLuC/4O2ZLX4xhL/8qJ3j6TYU6AdwNL6dS9NTN78h
    QZ0q+GCiRL8k1laM4fe60EYznL4Va8Iwz8tHLX8L935TrkkzPAbqnXTjIdjE+sAv
    SMeF9jx0avuJtPAutS0Nd1Qaf/hVx1N0Kt7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523886573; bh=bXmGwXX+B3ftMgmAE4civ2pIVb++IG
    f+rPN7zPWFQgk=; b=KbD0JwKM7i+VCf5hcqvw/kXHXr2EyCUcsLWzm3bEvWFp08
    584sLvRsbx/ivTpXPzduXgmtv+mFCXs/nuSe/CSF1++ULdP2pwz2Y/Icxaludre6
    F16H0qS9Yo2iFhkuELTu3gEX/OZr8rQRMmZXxBqJbT4vezd3MmJe79D5n8r5hXEu
    x/mcI7k4oMGhlzsexGZ7AdkHlzlLZ5Pjv4kv6esNAHSIk06l7hOZgBNClMYLm+0K
    xCOPZ90TDP8a8CGeoZyUIWSHnnwkde+d8T2RbpmH/8lcG0Z64zvGAIomKJ7BUcwH
    go2T0CRMypy6w3IlN6YMhIENMGQj8Ca1t/K1gG4w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO9CGGYguoqDar1YyFksyrvYFOlvSdTOrdUbbAFLbaxGfwQsfcSNMhYnMzluzaeqMuK0+NpjqWSQJc/YxOmEWYriyg+HLzOz62yxgsQufNTcR3xImkmQ
    e8v5S4sTBKa7Y+2/pPjUCvsalDfE3k1+DPuyIXP/GfdbrMfPTmwv1l4zC01uAwLzW/kSHUgwH56xGJUbR/0/r2Jrsd9lGYNtBfPX0rX/JjU5Lw6LeqPxglzA
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=iPpPYwvxTw25J7tBAzAA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755008AbeDPNta (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 09:49:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44935 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754834AbeDPNta (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 09:49:30 -0400
Date: Mon, 16 Apr 2018 09:49:26 -0400
From: "J. Bruce Fields" <bfields@redhat.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.15 168/189] nfsd: return RESOURCE not
 GARBAGE_ARGS on too many ops
Message-ID: <20180416134925.GA12104@parsley.fieldses.org>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
 <20180409001637.162453-168-alexander.levin@microsoft.com>
 <20180409152746.GA25317@parsley.fieldses.org>
 <20180415143737.GN2341@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180415143737.GN2341@sasha-vm>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 15, 2018 at 02:37:39PM +0000, Sasha Levin wrote:
> On Mon, Apr 09, 2018 at 11:27:47AM -0400, J. Bruce Fields wrote:
> >What's your default on these patches on these AUTOSEL patches if you
> >don't get an ACK or NACK?  Do you apply them anyway?
> 
> Right now it's opt-out, so it'll get merged unless you NACK it.
> 
> In general, these patches get higher visibility as a notice will be sent
> a few times for each of these, when:
> 
> 1. I added it to my queue
> 2. When Greg sends his review cycle
> 3. Once a stable kernel is released

OK, thanks for the explanation!

--b.
