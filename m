Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF528C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05532085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbfAaQTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:19:40 -0500
Received: from foss.arm.com ([217.140.101.70]:47142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731284AbfAaQTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:19:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22C3A80D;
        Thu, 31 Jan 2019 08:19:39 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 759CB3F557;
        Thu, 31 Jan 2019 08:19:37 -0800 (PST)
Subject: Re: [PATCH v4 3/6] arm64/kvm: add a userspace option to enable
 pointer authentication
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     LAK <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
References: <1545119810-12182-1-git-send-email-amit.kachhap@arm.com>
 <1545119810-12182-4-git-send-email-amit.kachhap@arm.com>
 <49474d5f-6f4e-b57d-4b45-94c16d85136c@arm.com>
 <CADGdYn7t7-vXNmQxBUxnCWq5UxG8uGJraCnRxjDgwvC0V6y8jA@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <3936d9fd-1e3f-0437-e866-edf2d9cbf797@arm.com>
Date:   Thu, 31 Jan 2019 16:19:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CADGdYn7t7-vXNmQxBUxnCWq5UxG8uGJraCnRxjDgwvC0V6y8jA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On 09/01/2019 10:13, Amit Daniel Kachhap wrote:
> On Sat, Jan 5, 2019 at 12:05 AM James Morse <james.morse@arm.com> wrote:
>> On 18/12/2018 07:56, Amit Daniel Kachhap wrote:
>>> This feature will allow the KVM guest to allow the handling of
>>> pointer authentication instructions or to treat them as undefined
>>> if not set. It uses the existing vcpu API KVM_ARM_VCPU_INIT to
>>> supply this parameter instead of creating a new API.
>>>
>>> A new register is not created to pass this parameter via
>>> SET/GET_ONE_REG interface as just a flag (KVM_ARM_VCPU_PTRAUTH)
>>> supplied is enough to select this feature.
>>
>> What is the motivation for doing this? Doesn't ptrauth 'just' need turning on?
>> It doesn't need additional setup to be useable, or rely on some qemu support to
>> work properly. There isn't any hidden state that can't be migrated in the usual way.
>> Is it just because we don't want to commit to the ABI?

> This allows migration of guest to non pointer authenticated supported
> systems and hides the extra ptrauth registers.

The MIDR already has to match, so the hardware must be the same. I guess this
lets us hide the new feature so old-guests can migrate to a new-kernel without a
write to the id registers failing.


> Basically this suggestion was given by Christoffer
> (https://lore.kernel.org/lkml/20180206123847.GY21802@cbox/).

Ah, Christoffer asked for it, that's reason enough!


Thanks,

James
