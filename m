Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9EDECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D16B208FC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D16B208FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbeGPJnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:43:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55436 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbeGPJnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:43:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBE087A9;
        Mon, 16 Jul 2018 02:17:21 -0700 (PDT)
Received: from [10.1.206.75] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B56D3F589;
        Mon, 16 Jul 2018 02:17:20 -0700 (PDT)
Subject: Re: [PATCH] arm64: cpuinfo: Include cleartext implementer and part
 strings
To:     Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180715035342.11371-1-olof@lixom.net>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <f619f0e9-b8b4-29fb-5ad6-7f5ebc3a4da8@arm.com>
Date:   Mon, 16 Jul 2018 10:17:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180715035342.11371-1-olof@lixom.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

On 15/07/18 04:53, Olof Johansson wrote:
> There's some use in printing out what the implementer and part numbers
> decode to for cases where they're known.
> 
> I filled in the table based on public information; mostly from ARM TRMs
> and other tools (and some of the SSBD tables in the kernel, etc).
> 
> Apple IDs came from
> https://github.com/apple/darwin-xnu/blob/master/osfmk/arm/cpuid.h
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm64/kernel/cpuinfo.c | 79 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 76 insertions(+), 3 deletions(-)

[...]

The same thing pops up every so often. And the answer is the same each time:

- it breaks an existing userspace ABI by changing the format of cpuinfo
- it is unmaintainable in the long run
- userspace already has this information by simply running "lscpu"

What has changed?

	M.
-- 
Jazz is not dead. It just smells funny...
