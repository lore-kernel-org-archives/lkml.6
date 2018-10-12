Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459F6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AE92086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AE92086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbeJLTHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:07:53 -0400
Received: from foss.arm.com ([217.140.101.70]:50204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbeJLTHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:07:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB471ED1;
        Fri, 12 Oct 2018 04:35:51 -0700 (PDT)
Received: from [10.1.196.46] (melchizedek.cambridge.arm.com [10.1.196.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA39C3F5D3;
        Fri, 12 Oct 2018 04:35:49 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] arm/arm64: KVM: enable 32 bits kvm vcpu events
 support
To:     Dongjiu Geng <gengdongjiu@huawei.com>
References: <1539284855-4035-1-git-send-email-gengdongjiu@huawei.com>
 <1539284855-4035-3-git-send-email-gengdongjiu@huawei.com>
Cc:     christoffer.dall@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, peter.maydell@linaro.org,
        drjones@redhat.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
From:   James Morse <james.morse@arm.com>
Message-ID: <51a366e2-1e40-8aac-4fe3-604b74542f29@arm.com>
Date:   Fri, 12 Oct 2018 12:35:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1539284855-4035-3-git-send-email-gengdongjiu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongjiu Geng,

On 11/10/2018 20:07, Dongjiu Geng wrote:
> The commit 539aee0edb9f ("KVM: arm64: Share the parts of
> get/set events useful to 32bit") shares the get/set events
> helper for arm64 and arm32, 

Oops. I evidently didn't test this bit. Looks like I just depended on the symbol
to be defined, I didn't check the CAP was exposed.


> it is better also share the check
> for vcpu events capability to enable 32 bit kvm vcpu events
> support.

not just better, necessary for correctly-written user-space to know the feature
is supported. This last bit would be clearer as: "but forgot to share the cap
extension code."


Thanks for catching this!

Acked-by: James Morse <james.morse@arm.com>


Thanks,

James

