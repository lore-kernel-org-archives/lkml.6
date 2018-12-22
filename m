Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941EBC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551652192C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545437122;
	bh=E1aRt2wbfWPVEJxdMxxEhEJvM/56gbXQ7N2KWOUqPPU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=sh68aEUQrOoSfeVbQxve0+SUxG9IjAMaOSnTZMWIBKXD0APC0qgtwQ0AyHSWL3Qcx
	 Jx8AiX8zMHqf8k5fnpgVQm31KkRa3m6jmccNiTEQPjLzXaMa+6OyZOFxIQ1k82RWOY
	 qH9zGyVeniyWOj65/i6S2UlAd4AcccGG8iQPvBvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404696AbeLVAFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:05:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729556AbeLVAFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:05:21 -0500
Received: from [192.168.1.29] (host92-112-dynamic.25-79-r.retail.telecomitalia.it [79.25.112.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33AEA21928;
        Sat, 22 Dec 2018 00:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545437120;
        bh=E1aRt2wbfWPVEJxdMxxEhEJvM/56gbXQ7N2KWOUqPPU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qG5epnZ4SifFk6NUJAipRQG/xQ9L6iB528jJUM8hp6TWWeBokAsLmG6WHiN7D4rvs
         yz5Dg4DH6Gs/QuFroMjSJNb2/v9TKn6RCMR5/GrUP1m/DyJ/cz2vSS/BkrQTa8wIRl
         OTDGJgN4K7qN+R4MPhk/xubZ76ANdgBhVPWm1DmE=
Subject: Re: linux-next: Tree for Dec 21 (acpi without CONFIG_PCI)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
References: <20181221193244.3a6ed685@canb.auug.org.au>
 <6d1dca14-f0e7-7866-cb97-b3bbc57cdc8e@infradead.org>
 <CAK9iUCO_Pk3eYH+hyMuqU6weDsbzC9Sg1Z719fm8u_3Oh7s-iQ@mail.gmail.com>
 <46e896b7-426a-2df9-6eae-c851332b4e43@infradead.org>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <783f254d-1301-fe68-bad5-a80a1b9f961b@kernel.org>
Date:   Sat, 22 Dec 2018 01:05:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <46e896b7-426a-2df9-6eae-c851332b4e43@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/2018 6:43 PM, Randy Dunlap wrote:
>> Any other issues?
> There are a few Kconfig dependency issues.  Here are 2 of them:
> 
> 
> WARNING: unmet direct dependencies detected for VGA_ARB
>    Depends on [n]: HAS_IOMEM [=y] && PCI [=n] && !S390
>    Selected by [y]:
>    - VGA_SWITCHEROO [=y] && HAS_IOMEM [=y] && X86 [=y] && ACPI [=y]
> 
> WARNING: unmet direct dependencies detected for IOSF_MBI
>    Depends on [n]: PCI [=n]
>    Selected by [y]:
>    - X86_INTEL_LPSS [=y] && X86 [=y] && ACPI [=y]
>    Selected by [m]:
>    - MMC_SDHCI_ACPI [=m] && MMC [=m] && MMC_SDHCI [=m] && ACPI [=y] && X86 [=y]
> 
> 
> The randconfig file for these is attached.
> 
> (on x86_64; both issues are from the same .config file)

Thanks, I reproduced this. I'm getting ready to post a patch.

