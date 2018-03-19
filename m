Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2720678-1521461675-2-2312697124982798894
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521461674; b=TSGXvzMKsFBF41kW2zpChcbFoVQEFV+fz/zYt8KKEYfwqfa
    2lIQ3qiqTkfaaJJ/JHXXsaea665LsTofRaoDlMoWi+X1LwrO+1GM4Okk0XLRkLEl
    o0FOHOmXkIrsqtu5+PVyDQ713b7P2H7E0/OyIMnknf4W6EzBFIn8MSFCe5yzOtQF
    JxEVOEqHSNLB5ABMJMTTTyE/1RWOIwIDfCHaFAE8G0ZcMbAza9nsQzzRdHyoNX5F
    ncatALAorAmXz+la0us+px8MST/kjUDyVMBHGS+2b+xV7BMoc5Aw1/8jqYTtT3PT
    oOLqntUqVg7HzOYqam4laiGyCkOUr/ZyoWVuHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521461674; bh=rIMfxNuVxbtPhi7lIAO2iN2pTi1sD86z/9kiSrlaBPc=; b=n
    YjGJVx0kH/eHSjIdsnRov8hWXjw3vA/Nke01y9hzNwWONHIrCleMaU6frtSvYguj
    9o+SWNWgLEm/SEbrltR1eeGX7Y5l+X8m7ftSkDpdzzulLyGhC2Lo+TRuL54qrycm
    UtaxHzp5t8J6uoerO5jqL/W7gcn0+g6tZ4fOwetUshHt7kvxG/90Ia25VL8asBi5
    IozvSxFmG2p5GLA9RdgRCqv60FRk+EcVaX3yx0wVQ8orr1nV2Lx3DcuLnIidmHP6
    ALrMtLyUVS4CPZTJ9W4vRcpuUL/h1WimuE+mUQqp1wudpk6Cm9BaD2Z+o6RN4ZXV
    sHQvRGeVFrWKwyIn205Yg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdefheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgshhpjeesthejredttdefjeenucfhrhhomheplfgrrhhkkhhoucfpihhkuhhlrgcuoehjrghrkhhkohdrnhhikhhulhgrsehlihhnuhigrdhinhhtvghlrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpudefgedrudefgedrudefiedrvdegnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepvddtfeeinecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdefheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgshhpjeesthejredttdefjeenucfhrhhomheplfgrrhhkkhhoucfpihhkuhhlrgcuoehjrghrkhhkohdrnhhikhhulhgrsehlihhnuhigrdhinhhtvghlrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpudefgedrudefgedrudefiedrvdegnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepvddtfeeinecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755327AbeCSMO3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 08:14:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:34224 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755299AbeCSMO3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 08:14:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,330,1517904000";
   d="scan'208";a="25197979"
Subject: Re: Applied "spi: Fix unregistration of controller with fixed SPI bus
 number" to the regulator tree
To: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <E1etZqo-0001cw-Ee@debutante>
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <f224119b-f038-3e39-dd91-887f2c1b401c@linux.intel.com>
Date: Mon, 19 Mar 2018 14:14:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <E1etZqo-0001cw-Ee@debutante>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi

On 03/07/2018 04:15 PM, Mark Brown wrote:
> The patch
> 
>     spi: Fix unregistration of controller with fixed SPI bus number
> 
> has been applied to the regulator tree at
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
> 
Was this lost in the regulator tree? I noticed my patch isn't in linux-next.

-- 
Jarkko
