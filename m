Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2684C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D87253C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LjwXvYd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D87253C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbeGBPsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:48:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48062 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752197AbeGBPsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=J/ib1VD9nWWlrbFW+ZjHPKgt7VvRdSD6Mi/LYYLT8NU=; b=LjwXvYd5F3bnQhychLBBZSsREY
        jf7XZymc/fpejdRjRGnymXEbB9mPEAniS5Lkz3sPdXUvOx04H7/dEN+xGscg0ZUS8VTuOvi+tqG+x
        sYsYqJLoZty2oLBN4oawPlvvt7dVsS1ziU93BujgC7anykSdcR1xsY1dUTnqNfq9GlmB/psmw8Epd
        9WHqb3lGLY1pXmXkL6VeZ5IzMVrJv09viJumLm9F4CqS2fgvwHjW/fhcGloPlG3f1eNpxlaqu41zh
        62DL78OsMcojsqWCBK4M8ezr+fuF/k6JxnVU8YruYlVMVz0F6iVJTthNF+DZNu7nuun15xNe7AfyY
        CxKREq1g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fa13j-0000oT-RW; Mon, 02 Jul 2018 15:48:12 +0000
Subject: Re: [PATCH] x86: make Memory Management options more visible
To:     Christoph Hellwig <hch@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        X86 ML <x86@kernel.org>
References: <af12c83d-2533-ae00-b53c-1fc1a9d8e9ce@infradead.org>
 <20180702140612.GA7333@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <afcb4a42-891a-d732-f072-79c0a1fc49f0@infradead.org>
Date:   Mon, 2 Jul 2018 08:48:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702140612.GA7333@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 07:06 AM, Christoph Hellwig wrote:
> On Sun, Jul 01, 2018 at 07:48:38PM -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Currently for x86, the "Memory Management" kconfig options are
>> displayed under "Processor type and features."  This tends to
>> make them hidden or difficult to find.
>>
>> This patch makes Memory Managment options a first-class menu by moving
>> it away from "Processor type and features" and into the main menu.
>>
>> Also clarify "endmenu" lines with '#' comments of their respective
>> menu names, just to help people who are reading or editing the
>> Kconfig file.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Hmm, can you take off from this for now and/or rebase it on top of
> this series:
> 
> 	http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/kconfig-cleanups
> 

Sure, no problem.

-- 
~Randy
