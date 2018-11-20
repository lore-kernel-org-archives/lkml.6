Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5249C32788
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E6B20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JAIvCevJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JAIvCevJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E6B20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbeKUB6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:58:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57330 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKUB6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:58:01 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E428D60B0D; Tue, 20 Nov 2018 15:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542727700;
        bh=m0p22JJsxKd1q1uJL2YmVOjRbHzUu7zoN5ew8++y+/4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JAIvCevJmrHjMXj8BdPXVHS/bVRpbtJsXKq1GVCKoHj4mn/j+ow3kWXvVLl4nfohk
         nGxgN4NtSQMLluzPLxiVLNcMe7raLg2wijZ0uq0sGAZ2eI9uAQyznjaL+A9AJiOLXx
         O9OVQEDPAxpaxlCTo3hlI4Dq7+brXM1EyGbPsi4E=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D04B6020B;
        Tue, 20 Nov 2018 15:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542727700;
        bh=m0p22JJsxKd1q1uJL2YmVOjRbHzUu7zoN5ew8++y+/4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JAIvCevJmrHjMXj8BdPXVHS/bVRpbtJsXKq1GVCKoHj4mn/j+ow3kWXvVLl4nfohk
         nGxgN4NtSQMLluzPLxiVLNcMe7raLg2wijZ0uq0sGAZ2eI9uAQyznjaL+A9AJiOLXx
         O9OVQEDPAxpaxlCTo3hlI4Dq7+brXM1EyGbPsi4E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D04B6020B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [RFC 0/3] Unify CPU topology across ARM64 & RISC-V
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        Damien.LeMoal@wdc.com, juri.lelli@arm.com, anup@brainfault.org,
        palmer@sifive.com, jeremy.linton@arm.com, robh+dt@kernel.org,
        mick@ics.forth.gr, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1541728209-3224-1-git-send-email-atish.patra@wdc.com>
 <07d92dd4-f943-47ee-e168-46bfaf4ed755@codeaurora.org>
 <20181120111146.GA6497@e107155-lin>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <35b92f83-dbbf-fad2-561f-49b0933ffe19@codeaurora.org>
Date:   Tue, 20 Nov 2018 08:28:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181120111146.GA6497@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/2018 4:11 AM, Sudeep Holla wrote:
> On Thu, Nov 15, 2018 at 11:31:33AM -0700, Jeffrey Hugo wrote:
> 
> [...]
> 
>>
>> I was interested in testing these on QDF2400, an ARM64 platform, since this
>> series touches core ARM64 code and I'd hate to see a regression. However, I
>> can't figure out what baseline to use to apply these. Different patches
>> cause different conflicts of a variety of baselines I attempted.
>>
> 
> Good to know that we can test DT configuration on QDF2400. I always assumed
> it's ACPI only.

It is ACPI only in the production configuration.  I suppose we could 
hack things up to do basic DT sanity, but I expect it would be nasty and 
non-trivial.

> 
>> What are these intended to apply to?
>>
> 
> The series alone may not get the package/socket ids correct on QDF2400.
> I have not yet added support for the same as I wanted to get the initial
> feedback on DT bindings. The movement of DT binding and corresponding
> code should not regress and you should be able to validate only that
> part.
> 

On a cursory glance, it looks like some of the reorganized code would 
also be used in the ACPI path (things that are common between DT and 
ACPI).  I do not expect problems, but I still feel its prudent to do a 
sanity check on actual hardware.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
