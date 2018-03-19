Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521497135-2-17947436224665778070
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521497134; b=nJDfrIOgzhrf5gEgqZdc8vq1dRGH9fd4hONuz2KyZX/jPxr
    vzZf6qJ+2QgCBH/hN5B+P6QKQIJ3Xee+J2g/x8YcIJEWHQn3Q485lckjyM02Bt3r
    bRZCKFQP4eQn0BvQT65ZSrCNZA0br0M2/vQ59jIuruHZHkPJtmSubsHhmSGTueAq
    5pNlY4r+BbNKShGRzQlzk5Fc1Iby9rTcYGlboRYXIThApMRcHe8yTB69Tyrsb26C
    iqpeFB9MRjSWHZuKNsXY8kGa7Lcqg2jZuMk3OmOckTl0x9uJ833jBHLx+In0a3t2
    C/SixOkxREq12q3XYo0jkWgXVY/Ych34MkH5j7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521497134; bh=vJ2TonIRoJT3L4KNpRSn/1QIDsbLxVquiaVXym+5+9k=; b=K
    ODnO7VwbX1hCGC6l5cLfbkEGu9i6bcqEY1L0Ljwrn9U/z/eF6VbYN5AZkUEX9IAH
    u6GukhzlA/6N+5GSNC9WfYLjdr37ftqtsMdR7li98+Y3Y/uHwOp4PfVR1hV21Wvi
    vqsx30JZbfDj4pJkXu1DVYkKC5VZsAJ/fKEDobhKPLjpduiC6d7suOWv8YRXWtus
    iEW+j33vNq0+zDnkT+zQXntpJ+BOmm4jjtlFAK2g3Rlwoys9aX0QD+cJioNSgGMc
    Z7bVXxr2MLayCW1ITztfEdmXcd3NzNZesVu3Ya7Gk4OhbmN+IynVDZffb/8ltER7
    vb2KcKL6aFMi3ceqs1r1Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=lechnology.com header.i=@lechnology.com header.b=xH5xwFlx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lechnology.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgshhpjeesthejredttdefjeenucfhrhhomhepffgrvhhiugcunfgvtghhnhgvrhcuoegurghvihgusehlvggthhhnohhlohhghidrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedpuddtkedrudelkedrhedrudegjeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeggedtudenucevlhhushhtvghrufhiiigvpeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lechnology.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=lechnology.com header.i=@lechnology.com header.b=xH5xwFlx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lechnology.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgshhpjeesthejredttdefjeenucfhrhhomhepffgrvhhiugcunfgvtghhnhgvrhcuoegurghvihgusehlvggthhhnohhlohhghidrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedpuddtkedrudelkedrhedrudegjeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeggedtudenucevlhhushhtvghrufhiiigvpeei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lechnology.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934238AbeCSPzm (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:55:42 -0400
Received: from vern.gendns.com ([206.190.152.46]:39298 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934117AbeCSPzP (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:55:15 -0400
Subject: Re: [PATCH AUTOSEL for 4.15 104/124] clk: fix reentrancy of
 clk_enable() on UP systems
To: Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
 <20180319154645.11350-104-alexander.levin@microsoft.com>
From: David Lechner <david@lechnology.com>
Message-ID: <6a944b80-c86c-ca23-5ada-f088d84c9a80@lechnology.com>
Date: Mon, 19 Mar 2018 10:55:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319154645.11350-104-alexander.levin@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/19/2018 10:48 AM, Sasha Levin wrote:
> From: David Lechner <david@lechnology.com>
> 
> [ Upstream commit a12aa8a68dfef5de181f2e555aa950a0ab05411f ]
> 
> Reentrant calls to clk_enable() are not working on UP systems. This is
> caused by the fact spin_trylock_irqsave() always returns true when
> CONFIG_SMP=n (and CONFIG_DEBUG_SPINLOCK=n) which causes the reference
> counting to not work correctly when clk_enable_lock() is called twice
> before clk_enable_unlock() is called (this happens when clk_enable()
> is called from within another clk_enable()).
> 
> This fixes the problem by skipping the call to spin_trylock_irqsave() on UP
> systems and relying solely on reference counting. We also make sure to set
> flags in this case so that we are not returning an uninitialized value.
> 
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: David Lechner <david@lechnology.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---

I don't know of any existing bugs in v4.15 that this fixes, so I don't
think this really fits the criteria for stable.
