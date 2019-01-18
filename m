Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F68C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D76F2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfARTMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:12:33 -0500
Received: from foss.arm.com ([217.140.101.70]:36766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729115AbfARTMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:12:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C2B6EBD;
        Fri, 18 Jan 2019 11:12:32 -0800 (PST)
Received: from [10.1.25.172] (DESKTOP-VLO843J.cambridge.arm.com [10.1.25.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CF603F6A8;
        Fri, 18 Jan 2019 11:12:30 -0800 (PST)
Subject: Re: kmemleak panic
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Qian Cai <cai@lca.pw>, LKML <linux-kernel@vger.kernel.org>
References: <f6fbf528-8213-e3b8-6990-9fcf9dec04d6@free.fr>
 <20190118143434.GE118707@arrakis.emea.arm.com>
 <b7629ecf-757c-f8b5-df83-ba83d7036b2f@free.fr>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a2e474ec-51f4-c006-b64a-8851d852621d@arm.com>
Date:   Fri, 18 Jan 2019 19:12:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b7629ecf-757c-f8b5-df83-ba83d7036b2f@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-18 3:36 pm, Marc Gonzalez wrote:
> Unable to handle kernel paging request at virtual address ffffffc021e00000

I can't help but notice that you seem to get the same address in 4 
different logs - if it really is that deterministic then that's quite 
the boon for debugging (FWIW my first thought is that it looks a lot 
like a phys_to_virt() of something bogus). I've never used kmemleak 
myself, but looking at where it's crashing it appears to think that that 
address is a valid object - if I'm reading the docs correctly then I 
guess the "dump" command ought to be able to tell you where it thinks 
that object came from.

Robin.
