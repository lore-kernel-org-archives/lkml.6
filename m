Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8D2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD5720657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547659390;
	bh=BSXW7FwdBmgfPkS/wsjM3VU2bZrKt0W20afTiBebkwo=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=fg+/YSU2hrnuO8+kSzJINcwnRwwY6GerTA8ODEF9o+Vb3AEn8qWOm+0AWF5zmvpMq
	 ujQ3ANKXGgoX4wYecoFm7f+Wuk3xW94Wmb0ZiaEaN3vtergxI4kTfW+3IXfnFDop8U
	 VfSsesfyBicvmDz6OE2fglOWpTxBo64FuwYNOvmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394067AbfAPRXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:23:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:58718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390864AbfAPRXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:23:08 -0500
Received: from [10.84.151.19] (unknown [167.220.149.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C500020578;
        Wed, 16 Jan 2019 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547659387;
        bh=BSXW7FwdBmgfPkS/wsjM3VU2bZrKt0W20afTiBebkwo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=k5giw0faH2P8ouI5EnrBUn5kiwHVeb9CyRw0m8HZz0lfrUsZ2JSqPkZQAeNzYAlGt
         08mLkZi6CEQbpV4BViFhueU/JV5W8NmRUvCUQ6tW7Va+CYTKb6l/xuCm3ElrH8Wl/l
         DBrNxUenKHhWKPYzjQX24ScFKDKYJCwIgSmO1beI=
Subject: Re: linux-next: Tree for Jan 16 (PCI config warning?)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, X86 ML <x86@kernel.org>
References: <20190116173838.042db659@canb.auug.org.au>
 <bc18898a-8619-fc46-7c42-3d51969ee7f7@infradead.org>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <0acd12dd-b281-446e-60c9-141732d0299b@kernel.org>
Date:   Wed, 16 Jan 2019 12:23:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <bc18898a-8619-fc46-7c42-3d51969ee7f7@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/16/2019 12:00 PM, Randy Dunlap wrote:
> On 1/15/19 10:38 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20190115:
>>
> 
> on x86_64:
> 
> when CONFIG_PCI is not enabled (via randconfig):
> 
> WARNING: unmet direct dependencies detected for PCI_LOCKLESS_CONFIG
>    Depends on [n]: PCI [=n]
>    Selected by [y]:
>    - X86 [=y]
> 
> 

It looks like we'll have to continue peeling the onion some more time.
Can you please attach the kernel configuration file used?

Can I assume that this tree includes Rafael's latest pm pull?

Sinan
