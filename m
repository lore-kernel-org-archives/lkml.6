Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE990C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F26A20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F26A20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbeLJUai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:30:38 -0500
Received: from foss.arm.com ([217.140.101.70]:34138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729057AbeLJUai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:30:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0DEDEBD;
        Mon, 10 Dec 2018 12:30:37 -0800 (PST)
Received: from [10.1.197.21] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7D433F59C;
        Mon, 10 Dec 2018 12:30:34 -0800 (PST)
Subject: Re: [PATCH v6 04/13] arm64/kvm: hide ptrauth from guests
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave P Martin <dave.martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-5-kristina.martsenko@arm.com>
 <57966497-d21c-5439-e4ba-d75f5552282f@linaro.org>
 <a2eb07e5-6663-aede-fb75-cc91cf3fffa5@arm.com>
 <1f179017-4237-0d36-7adc-0a1470b5fd46@linaro.org>
From:   Kristina Martsenko <kristina.martsenko@arm.com>
Message-ID: <60a6ca4b-cfe9-1ed3-dce6-9f58575240ba@arm.com>
Date:   Mon, 10 Dec 2018 20:30:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1f179017-4237-0d36-7adc-0a1470b5fd46@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2018 20:22, Richard Henderson wrote:
> On 12/10/18 2:12 PM, Kristina Martsenko wrote:
>> The plan was to disable trapping, yes. However, after that thread there
>> was a retrospective change applied to the architecture, such that the
>> XPACLRI (and XPACD/XPACI) instructions are no longer trapped by
>> HCR_EL2.API. (The public documentation on this has not been updated
>> yet.) This means that no HINT-space instructions should trap anymore.
> 
> Ah, thanks for the update.  I'll update my QEMU patch set.
> 
>>> It seems like the header comment here, and
>> Sorry, which header comment?
> 
> Sorry, the patch commit message.

Ah ok. Still seems correct.

Kristina
