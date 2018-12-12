Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CB6C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F1B20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F1B20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeLLAAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:00:13 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:48146 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeLLAAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:00:13 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992965AbeLLAAK4WVit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 01:00:10 +0100
Date:   Wed, 12 Dec 2018 00:00:10 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Shawn Rutledge <s@ecloud.org>
cc:     linux-kernel@vger.kernel.org
Subject: Re: Can we drop upstream Linux x32 support?
In-Reply-To: <20181211203812.GA14983@i7.vpn>
Message-ID: <alpine.LFD.2.21.1812112343580.11202@eddie.linux-mips.org>
References: <20181211203812.GA14983@i7.vpn>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018, Shawn Rutledge wrote:

> I like the idea of x32 in theory: any machine with 4GB or less of memory
> for sure does not really need to waste any precious space storing 64-bit
> pointers; and even if more memory is available, software that needs to
> access more than 4GB per process is somewhat rare (as it should be).

 You can't mmap(2) files the size of which exceeds the size of the 32-bit 
user address space with an ILP32 ABI though, regardless of how much 
physical memory a given system supports or has actually installed.

 Also you can have a process's VM size exceed the 32-bit user address 
space where swap files are used, e.g. I have a system with 3GiB of DRAM 
installed and as much swap space available, where the amount of memory 
consumed by a process sometimes exceeds 4GiB -- it's enough to open a 
couple of web pages at once in a browser these days to get there (don't 
ask me what it uses all that memory for).

 So there are still use cases for an LP64 ABI even for systems the whole
physical memory of which can be handled with 32-bit addressing.

  Maciej
