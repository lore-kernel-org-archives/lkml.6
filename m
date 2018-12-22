Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7E1C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FDD2192C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 00:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545437092;
	bh=wUh0Qrhvi/bryl/4TtBE8lUbSHOhFAjKLBF6CmD5GdA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=C8u7w8/C7yCUlwkXXSzflR41s84g2wS1c/+Pp+QmaROkgjqAgcvIpp5WBftPoXIrQ
	 pXIb4mcZs46PolplYVC2dnObd0YCQUu3PkupOHO3z09Jq/RVI7VUBwVi0c9w222CpY
	 e8VmBSQohn3kf91R+n/gTTOM84ll3+dFZZ/Zbnr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404124AbeLVAEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 19:04:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbeLVAEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 19:04:50 -0500
Received: from [192.168.1.29] (host92-112-dynamic.25-79-r.retail.telecomitalia.it [79.25.112.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0CF421928;
        Sat, 22 Dec 2018 00:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545437090;
        bh=wUh0Qrhvi/bryl/4TtBE8lUbSHOhFAjKLBF6CmD5GdA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HT0lwhMH3gtBV3v5sTyuKlT6+Nnk3GgmLYROlJqjzAFkCkpjEP0vTK0luZXH8gCNA
         s3YNDozW00o1016oGfBumWyHzY1CAffeH2WxCBqORggrjOrY9fz2jx+0pMOhYaPyHW
         or0My0I6wMgzRXqZvIXHI0CZMHesCxtvqgYrgOcE=
Subject: Re: linux-next: Tree for Dec 21 (acpi without CONFIG_PCI)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
References: <20181221193244.3a6ed685@canb.auug.org.au>
 <6d1dca14-f0e7-7866-cb97-b3bbc57cdc8e@infradead.org>
 <CAK9iUCO_Pk3eYH+hyMuqU6weDsbzC9Sg1Z719fm8u_3Oh7s-iQ@mail.gmail.com>
 <00a8511e-0b8e-13d3-220a-ed979dc3e020@infradead.org>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <8c6c251b-2ec6-93d3-00c3-97387923c5c2@kernel.org>
Date:   Sat, 22 Dec 2018 01:04:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <00a8511e-0b8e-13d3-220a-ed979dc3e020@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/2018 7:28 PM, Randy Dunlap wrote:
>> Any other issues?
> 
> and on i386, there is this additional kconfig warning:
> 
> WARNING: unmet direct dependencies detected for INTEL_SOC_DTS_IOSF_CORE
>    Depends on [n]: THERMAL [=y] && (X86 [=y] || X86_INTEL_QUARK [=n] || COMPILE_TEST [=n]) && X86 [=y] && PCI [=n]
>    Selected by [m]:
>    - INT340X_THERMAL [=m] && THERMAL [=y] && (X86 [=y] || X86_INTEL_QUARK [=n] || COMPILE_TEST [=n]) && X86 [=y] && ACPI [=y]
> 
> 
> The randconfig file for this is attached.

Thanks, I reproduced this. I'm getting ready to post a patch.
