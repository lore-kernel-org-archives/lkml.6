Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B605C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EA22085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfAGR5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:57:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:63915 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfAGR5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:57:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 09:57:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,451,1539673200"; 
   d="scan'208";a="132363093"
Received: from schen9-desk.jf.intel.com (HELO [10.54.74.162]) ([10.54.74.162])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jan 2019 09:57:19 -0800
To:     Ben Greear <greearb@candelatech.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, stable@vger.kernel.org
References: <64efec3fda40c0758601bf9b1480a35d76d3c487.1545413988.git.tim.c.chen@linux.intel.com>
 <1c7923ec-70aa-25d4-3de1-f1b1768bb80b@candelatech.com>
 <fdf4e1cd-9b28-75c7-6846-6d0f5b816936@linux.intel.com>
 <5d45f3ef-a91f-815a-f532-62e75899e697@candelatech.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual; keydata=
 mQINBE6ONugBEAC1c8laQ2QrezbYFetwrzD0v8rOqanj5X1jkySQr3hm/rqVcDJudcfdSMv0
 BNCCjt2dofFxVfRL0G8eQR4qoSgzDGDzoFva3NjTJ/34TlK9MMouLY7X5x3sXdZtrV4zhKGv
 3Rt2osfARdH3QDoTUHujhQxlcPk7cwjTXe4o3aHIFbcIBUmxhqPaz3AMfdCqbhd7uWe9MAZX
 7M9vk6PboyO4PgZRAs5lWRoD4ZfROtSViX49KEkO7BDClacVsODITpiaWtZVDxkYUX/D9OxG
 AkxmqrCxZxxZHDQos1SnS08aKD0QITm/LWQtwx1y0P4GGMXRlIAQE4rK69BDvzSaLB45ppOw
 AO7kw8aR3eu/sW8p016dx34bUFFTwbILJFvazpvRImdjmZGcTcvRd8QgmhNV5INyGwtfA8sn
 L4V13aZNZA9eWd+iuB8qZfoFiyAeHNWzLX/Moi8hB7LxFuEGnvbxYByRS83jsxjH2Bd49bTi
 XOsAY/YyGj6gl8KkjSbKOkj0IRy28nLisFdGBvgeQrvaLaA06VexptmrLjp1Qtyesw6zIJeP
 oHUImJltjPjFvyfkuIPfVIB87kukpB78bhSRA5mC365LsLRl+nrX7SauEo8b7MX0qbW9pg0f
 wsiyCCK0ioTTm4IWL2wiDB7PeiJSsViBORNKoxA093B42BWFJQARAQABtDRUaW0gQ2hlbiAo
 d29yayByZWxhdGVkKSA8dGltLmMuY2hlbkBsaW51eC5pbnRlbC5jb20+iQI+BBMBAgAoAhsD
 BgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUCWfPBPgUJDyfxUQAKCRCiZ7WKota4SReFEACa
 5ruzJM/hXJguHJY8i95rxHfLOgE7QoDgsR2aK2C1BSu84StTcT9BMikndQ0em28mpd1zROCs
 FvJ8Dzpp923699FU7s70+bFG9zIWtAOLWt2QyIMYImILzKkzkyLZo2RTcLNdUWS5fkAtjspQ
 QPg29W+kcbX1NhB6WDdbvk2HNeZoDh4A5ucOzKjEPqbSFIbw2Wt3RUmXxezjH1NzZG3fMkEN
 cT7JezYhUxvi2PrJlD+mo26q2/PQmFgF49tneRJXmYyie5o2+ClfFVO9I6Rd1k7hS9uXQLg3
 udpnDKobNYZ7/+O5+ucp0Y/MwzTfBYmtJ5fBjUTi2L1RMDJee8WqCNY1VU6cQ8MD4KstxUp2
 bxlSRAYaDtNa1Omr61E7BA1Cc2E3cIt/O1mMfudWUjCND8qrAtEnugqKjk5tJJZzmzIKSHPY
 dCiJtOBQaVAYYchXF2hwOKhpFS43V4FdWLlM1CnFXsmbk48hGbiA8XHU85JBCXmG0i4qUlKn
 x2ilChvq4A102ahnlGbEmFaSwxuqR/5lhai6lOkwHXDFUT6jblaSs24L3MTn/vXtvwaLEEKh
 SPzNaj7yFvEhrJoLiZmDm0SZuPbQ+wrmPWUbzyf5te2Oq0JyrHTQJoQqn+CwGqwF/JaUq60f
 VuUD3T0icgsfljsOA4apyH7kyfxXGP0hOLkCDQROjjboARAAx+LxKhznLH0RFvuBEGTcntrC
 3S0tpYmVsuWbdWr2ZL9VqZmXh6UWb0K7w7OpPNW1FiaWtVLnG1nuMmBJhE5jpYsi+yU8sbMA
 5BEiQn2hUo0k5eww5/oiyNI9H7vql9h628JhYd9T1CcDMghTNOKfCPNGzQ8Js33cFnszqL4I
 N9jh+qdg5FnMHs/+oBNtlvNjD1dQdM6gm8WLhFttXNPn7nRUPuLQxTqbuoPgoTmxUxR3/M5A
 KDjntKEdYZziBYfQJkvfLJdnRZnuHvXhO2EU1/7bAhdz7nULZktw9j1Sp9zRYfKRnQdIvXXa
 jHkOn3N41n0zjoKV1J1KpAH3UcVfOmnTj+u6iVMW5dkxLo07CddJDaayXtCBSmmd90OG0Odx
 cq9VaIu/DOQJ8OZU3JORiuuq40jlFsF1fy7nZSvQFsJlSmHkb+cDMZDc1yk0ko65girmNjMF
 hsAdVYfVsqS1TJrnengBgbPgesYO5eY0Tm3+0pa07EkONsxnzyWJDn4fh/eA6IEUo2JrOrex
 O6cRBNv9dwrUfJbMgzFeKdoyq/Zwe9QmdStkFpoh9036iWsj6Nt58NhXP8WDHOfBg9o86z9O
 VMZMC2Q0r6pGm7L0yHmPiixrxWdW0dGKvTHu/DH/ORUrjBYYeMsCc4jWoUt4Xq49LX98KDGN
 dhkZDGwKnAUAEQEAAYkCJQQYAQIADwIbDAUCWfPBJQUJDyfxOAAKCRCiZ7WKota4SZKQD/wL
 u3j8kgATic+wF3ekngjwPcW3JhbQJeHxUZwsb9OgVMHumlrZHGoltKQuFfAhG/sOfuAh5f7Q
 MzzA1M+2JD1Q6lr74vUHNBu+xBFMgZstE6hpkKmn0pNZ5JS3iZRVRLBxdWw63DYr0GM80vmb
 HjAhwxoF2PsO2/PkWTc68+pFyl3Dy0heZSJii81hkzh8FnF8CaMH0VXuMJoWyuYgnC058hHj
 0QqXvlNx9LzMtmrsskTmPvwqXTgG/dTEfTkQ4RfX3enrBy55cg9tMc88BEQ/0/JV1bCDwyWX
 KRpz6FsHbICGQ4G9TTD4pS5QJ+oRQccMjfiDM3rFTcG1RYP2lHXjSm9c0VnimpQBz3LarrdH
 JilmTHbAWf5KLmtWfYXHrlncnhnCtw2nfwBBdy8cQW4tUyniSVRLOwGmeJziyuPJ5SVVZcil
 2oN5/o7js7BYAeAV/WVF2Sk/blnXaaObIYIVqnDhV4N0oUz1KXq1LeemUvjo5rljmmhOBdgl
 6D0scXCWICbuuWN9eW2fZl38hBSI3M0MX0jnV2e+0FY+76iNmKadpTDwgY3OaQAZ/UlJVI+p
 RV4JtRrajtpo9Vb38SBPXwp9moWmwVQyIdFUXjCTQARvxjRsUoPVu9oASCd9W74oOgrqC1ha
 dvVU867d07PlWksfYwCeYP4bs+4GSLzI1w==
Subject: Re: [PATCH] x86/speculation: Add document to describe Spectre and its
 mitigations
Message-ID: <0d89b5a0-01d3-4927-ce59-fd9dc24c53b3@linux.intel.com>
Date:   Mon, 7 Jan 2019 09:57:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <5d45f3ef-a91f-815a-f532-62e75899e697@candelatech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/31/18 8:22 AM, Ben Greear wrote:
> 
> 
> On 12/21/2018 05:17 PM, Tim Chen wrote:
>>
>> If you don't worry about security and performance is paramount, then
>> boot with "nospectre_v2".  That's explained in the document.
> 
> There seem to be lots of different variants of this type of problem.  It was not clear
> to me that just doing nospectre_v2 would be sufficient to get back full performance.

The performance penalty comes from retpoline penalizing indirect branch predictions in kernel.
With nospectre_v2, retpoline is disabled so you should get all the performance
back from spectre mitigation.

This does not disable kernel page table isolation for meltdown mitigation, which also
needs to be turned off if you want to get the full performance back.  That's somewhat
beyond the scope of this doc on Spectre.

> 
> And anyway, I would like to compile the kernel to not need that command-line option,
> so I am still interesting in what compile options need to be set to what values...
> 

If you just want to disable spectre mitigation, setting CONFIG_RETPOLINE=n should do
the  trick.  If you also want to disable meltdown mitigation,
set CONFIG_PAGE_TABLE_ISOLATION=n.

Thanks.

Tim
