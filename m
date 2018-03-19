Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2526322-1521454822-2-3816406868982830602
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521454821; b=P87zTNCPkmeR9F6Y3JtUTz4cHBvv79asHX+t3B/EDJDk/CZ
    A5nHpCk2UcVZvJRB1WMHeWkXHGXblne2pq1cLbE66149kxyRhEOejhT1v5PRE/iu
    ePSqcLz80HGsq37Ow2MX4nZoL5x2inJlJWQuPe0ExZhy4Ws9sl6fKSaAHSHlsw7F
    xYq/k8rxaBTW4tnR3jXUP9cR5Fj+H3Rwl0YlGhhrDhAiAq7KZ5jv6f//CKDUMr2J
    VBwjeu9v56tJMKIbz3+za4Zm9Z8OG2s3e7cu2Uot1m8aILlCn3oKtmcMDnN8wMtJ
    WHRFRzfgCVxFfYmWFvV/vca+om2PiaE9gg2odmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=arctest; t=1521454821; bh=0Xtuk
    TAYsrzYL5V3+cLSOklV0bBMO6y/v0udq6FJRXQ=; b=wCgbO7QK9ixo4ur7dYn5F
    mFVY8JKZWckaLTTnlcp4vKJdeK7KJPCOhoPANxNfrLjxjgTaCV8YAgPNbraUZVnj
    ZQXW9YC4lc+KgFu4EFFpNb2PGQZaqrTlEun9WcAjhmkeYBAFHVXYOjxM9ufCpSXI
    fNPa0i1jw1ilQXD56zALPJxJvQDujuAU5/oVtjqay/44klFx3D0k0GQ5Iv+XJURM
    WGxZlm6Q1ONwiV/Dak5wXMBjoo3Y4f5KHjtSYnoaZz1xEbuAFpszI0wpKT1qdbXr
    JYnZUmq8+FflY/CeYRAIyjtgXjUwU5qBYH02LzGB/8ozFqhBQWPSU8CaCY1mqbJA
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurheptggguffhjgffgffkfhfvofhsphejsehtjehmtdhhtddvnecuhfhrohhmpefmrghiucfjvghnghcuhfgvnhhguceokhgrihdrhhgvnhhgrdhfvghnghestggrnhhonhhitggrlhdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedpudejhedrgedurdegkedrjeejnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepheejfeegnecuvehluhhsthgvrhfuihiivgephe;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UKcgEmrR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurheptggguffhjgffgffkfhfvofhsphejsehtjehmtdhhtddvnecuhfhrohhmpefmrghiucfjvghnghcuhfgvnhhguceokhgrihdrhhgvnhhgrdhfvghnghestggrnhhonhhitggrlhdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedpudejhedrgedurdegkedrjeejnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepheejfeegnecuvehluhhsthgvrhfuihiivgephe;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UKcgEmrR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbeCSKT7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 06:19:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56147 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755291AbeCSKTy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 06:19:54 -0400
X-Google-Smtp-Source: AG47ELukyLqYYWdvOMox5ZPbEb2Lj/CASjxxyJDCss0pTyylAlVUrQH1W9rKOVaD6iTHsWDhvjw1Hg==
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.15\))
Subject: Re: [PATCH] PCI / PM: Always check PME wakeup capability for runtime
 wakeup support
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <2242415.DLYj1vY8hi@aspire.rjw.lan>
Date: Mon, 19 Mar 2018 18:19:45 +0800
Cc: bhelgaas@google.com, rafael.j.wysocki@intel.com,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <48D2ECB8-4A95-4910-912C-67F17CA824EC@canonical.com>
References: <20180318191215.10005-1-kai.heng.feng@canonical.com>
 <2242415.DLYj1vY8hi@aspire.rjw.lan>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3445.6.15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> On Mar 19, 2018, at 6:00 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Sunday, March 18, 2018 8:12:15 PM CET Kai-Heng Feng wrote:
>> USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
>> core: Drop run_wake flag from struct dev_pm_info").
>>
>> The device in question is not power managed by platform firmware,
>> furthermore, it only supports PME# from D3cold:
>> Capabilities: [78] Power Management version 3
>>        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
>>        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>
> That's somewhat unusual, but OK.
>
>> Before the commit, the device never gets runtime suspended. After the
>> commit, the device gets runtime suspended, so it does not respond to any
>> PME#.
>>
>> usb_hcd_pci_probe() mandatorily calls device_wakeup_enable(), hence
>> device_can_wakeup() in pci_dev_run_wake() always returns true.
>>
>> So pci_dev_run_wake() needs to check PME wakeup capability as its first
>> condition.
>>
>> Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct  
>> dev_pm_info")
>> Cc: stable@vger.kernel.org # 4.13+
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  drivers/pci/pci.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index f6a4dd10d9b0..e026d8f313ec 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -2125,16 +2125,13 @@ bool pci_dev_run_wake(struct pci_dev *dev)
>>  {
>>  	struct pci_bus *bus = dev->bus;
>>
>> -	if (device_can_wakeup(&dev->dev))
>> -		return true;
>> -
>> -	if (!dev->pme_support)
>> -		return false;
>
> Why are you removing this check?

Because this is implicitly checked by pci_pme_capable().

But I guess it's better to keep it explicit.

I'll send a v2 to address this.

Kai-Heng

>
>> -
>>  	/* PME-capable in principle, but not from the target power state */
>> -	if (!pci_pme_capable(dev, pci_target_state(dev, false)))
>> +	if (!pci_pme_capable(dev, pci_target_state(dev, true)))
>>  		return false;
>>
>> +	if (device_can_wakeup(&dev->dev))
>> +		return true;
>> +
>>  	while (bus->parent) {
>>  		struct pci_dev *bridge = bus->self;
>
> Thanks,
> Rafael
