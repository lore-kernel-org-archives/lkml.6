Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id WsorHTXTG1sWfAAAmS7hNA
	; Sat, 09 Jun 2018 13:17:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 51DEA608B8; Sat,  9 Jun 2018 13:17:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CDE7F6074D;
	Sat,  9 Jun 2018 13:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CDE7F6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=jonmasters.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbeFINRM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 09:17:12 -0400
Received: from edison.jonmasters.org ([173.255.233.168]:36590 "EHLO
        edison.jonmasters.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753175AbeFINRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 09:17:11 -0400
Received: from [104.153.224.165] (helo=washington.bos.jonmasters.org)
        by edison.jonmasters.org with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <jcm@jonmasters.org>)
        id 1fRdjo-0001m3-D8; Sat, 09 Jun 2018 13:17:01 +0000
To: Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Cc: Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Julien Grall <julien.grall@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180529121121.24927-1-marc.zyngier@arm.com>
From: Jon Masters <jcm@jonmasters.org>
Openpgp: preference=signencrypt
Autocrypt: addr=jcm@jonmasters.org; prefer-encrypt=mutual; keydata=
 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
 yrXvw9qg2waGcnb8WuoS+g==
Organization: World Organi{s,z}ation Of Broken Dreams
Message-ID: <3f90aca2-d693-5f3e-4f2b-51e9509af8fe@jonmasters.org>
Date: Sat, 9 Jun 2018 09:16:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180529121121.24927-1-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.153.224.165
X-SA-Exim-Mail-From: jcm@jonmasters.org
Subject: Re: [PATCH v2 00/17] arm64 SSBD (aka Spectre-v4) mitigation
X-SA-Exim-Version: 4.2.1 (built Sun, 08 Nov 2009 07:31:22 +0000)
X-SA-Exim-Scanned: Yes (on edison.jonmasters.org)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/2018 08:11 AM, Marc Zyngier wrote:

> This patch series implements the Linux kernel side of the "Spectre-v4"
> (CVE-2018-3639) mitigation known as "Speculative Store Bypass Disable"
> (SSBD).

Looks good, with the exception of the naming in patch 5, and a question
about how you're handling live migration of VMs (which needs to preserve
mitigation state). Once those are answered I think it's good.

> For all released Arm Cortex-A CPUs that are affected by this issue, then
> the preferred mitigation is simply to set a chicken bit in the firmware
> during CPU initialisation and therefore no change to Linux is required.
> Other CPUs may require the chicken bit to be toggled dynamically (for
> example, when switching between user-mode and kernel-mode) and this is
> achieved by calling into EL3 via an SMC which has been published as part
> of the latest SMCCC specification:

We're asking (server) silicon vendors that can do so inexpensively to
implement both a firmware knob to control the chicken bit and the ATF
interface. This allows some users to disable the mitigation if they want
to, for example in closed lab environments doing CONFIG_BENCHMARKING
comparisons to other arches which might have mitigations disabled. Not
that I like that, but I want Arm to be on an equal footing at least ;)

Jon.
