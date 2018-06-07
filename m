Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kpmnMc3mGFuxRAAAmS7hNA
	; Thu, 07 Jun 2018 08:03:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2FA87608B8; Thu,  7 Jun 2018 08:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528358616;
	bh=v/AXUzPgdgd3uuvQFG+Ql6NUcAGHjcS20bagaNqdwF8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=FHMZll6b+AqT3OuMAgvZ+YSmMXZHocb9NuecISm4tBU/I+rHASWzMOIKnhK/9mXdF
	 YrydRMkBJ67He3qEBxuNgVFLIRBc4wg1XQalvvTQK/hzaYM/npeZPL07qz61BPsrzr
	 WwYNE/dcOF5k3PQ+p2qW0YanCJisMQ0E1xK6xDSA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 93E50607E7;
	Thu,  7 Jun 2018 08:03:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oMiEI7r/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oMiEI7r/"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93E50607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeFGIDb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:03:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56566 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753237AbeFGIDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:03:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BFCEE607E7; Thu,  7 Jun 2018 08:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528358604;
        bh=v/AXUzPgdgd3uuvQFG+Ql6NUcAGHjcS20bagaNqdwF8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oMiEI7r//lGHCKvgQ0U73dGbjZBJyyqPE3EeqmWx4UC6uQolB29cfLGjSgNAYOr/W
         JRVdh84BevJFrR8qx1nkuvi9ShjRUXGVJm+2VzSsTIQzj9iu31vpxj6Jkwfdl1fRJi
         0WqV16k3ciKyikVGJr7rktheJn8O9wac0ibiqwVo=
Received: from [10.204.79.109] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cpandya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E94A605A2;
        Thu,  7 Jun 2018 08:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528358604;
        bh=v/AXUzPgdgd3uuvQFG+Ql6NUcAGHjcS20bagaNqdwF8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oMiEI7r//lGHCKvgQ0U73dGbjZBJyyqPE3EeqmWx4UC6uQolB29cfLGjSgNAYOr/W
         JRVdh84BevJFrR8qx1nkuvi9ShjRUXGVJm+2VzSsTIQzj9iu31vpxj6Jkwfdl1fRJi
         0WqV16k3ciKyikVGJr7rktheJn8O9wac0ibiqwVo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E94A605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v13 0/3] Fix issues with huge mapping in ioremap for ARM64
To: Will Deacon <will.deacon@arm.com>
Cc: mark.rutland@arm.com, toshi.kani@hpe.com, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
References: <1528268481-19299-1-git-send-email-cpandya@codeaurora.org>
 <20180606154520.GM6631@arm.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <6aaf3db7-3cbb-f4ba-7983-f235e3bad92e@codeaurora.org>
Date: Thu, 7 Jun 2018 13:33:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606154520.GM6631@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/2018 9:15 PM, Will Deacon wrote:
> Hi Chintan,
Hi Will,

> 
> Thanks for sticking with this. I've reviewed the series now and I'm keen
> for it to land in mainline. Just a couple of things below.
> 

Thanks for all the reviews so far.

> On Wed, Jun 06, 2018 at 12:31:18PM +0530, Chintan Pandya wrote:
>> This series of patches re-bring huge vmap back for arm64.

...

>> These patches can also go into '-stable' branch (if accepted)
>> for 4.6 onwards.
> 
> Not sure we need to target -stable, since we solved the crash by disabling
> the use of huge io mappings.

If disabling of huge io mappings have gone into stable trees, then I
won't push for these changes there.

> 
>>   arch/arm64/include/asm/tlbflush.h |  7 ++++++
>>   arch/arm64/mm/mmu.c               | 48 +++++++++++++++++++++++++++++++++++----
>>   arch/x86/mm/pgtable.c             |  8 ++++---
>>   include/asm-generic/pgtable.h     |  8 +++----
>>   lib/ioremap.c                     |  4 ++--
> 
> If you get an ack from the x86 folks, then I could take all of this via
> arm64. Alternatively, now that I've reviewed the series this could happily
> go via another tree (e.g. akpm).

Sure. I would wait for few days before either of them take notice of
this. If required, I will communicated with them.

> 
> Thanks,
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
