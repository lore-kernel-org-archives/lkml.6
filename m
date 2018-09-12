Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD87DC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D9E20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EPCBpvsd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EPCBpvsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D9E20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeILVMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:12:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46462 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeILVMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:12:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E278B60213; Wed, 12 Sep 2018 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536768410;
        bh=COg5yNwK9l6WMzDgBUv666+XNSHLD+lUODU21aQrYUM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EPCBpvsda4LwJnR2PcVXxfrh9PTNj0tZ1vAgge9qgvKrBqlCW5AOZqdJIg4Z0MEdJ
         QntTx1/ZprOxTkNhKGhvKrAzErd035ogqRA5Y5oHweBwbGn6dnvC2U35ghKgJCJvHK
         ilnRYoofCej4BlSJ3yjNgBL64lLFznL5D5piStbU=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E728F602A7;
        Wed, 12 Sep 2018 16:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536768410;
        bh=COg5yNwK9l6WMzDgBUv666+XNSHLD+lUODU21aQrYUM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EPCBpvsda4LwJnR2PcVXxfrh9PTNj0tZ1vAgge9qgvKrBqlCW5AOZqdJIg4Z0MEdJ
         QntTx1/ZprOxTkNhKGhvKrAzErd035ogqRA5Y5oHweBwbGn6dnvC2U35ghKgJCJvHK
         ilnRYoofCej4BlSJ3yjNgBL64lLFznL5D5piStbU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E728F602A7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
To:     Jeremy Linton <jeremy.linton@arm.com>, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkilari@codeaurora.org,
        Sudeep Holla <sudeep.holla@arm.com>
References: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
 <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
 <e74f2208-ac0d-6c45-8ddb-5b77d6a42fef@codeaurora.org>
 <c34452c2-d1e8-19d8-45c1-b48ecf14bbd7@arm.com>
 <98e2e6fa-7256-b5ac-7d2e-42c858c6e57c@codeaurora.org>
 <f553018d-d27a-68e0-93f7-4f7a0497c68a@arm.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <bc0f43e3-c373-8be1-b1a9-0b10303a8683@codeaurora.org>
Date:   Wed, 12 Sep 2018 10:06:49 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f553018d-d27a-68e0-93f7-4f7a0497c68a@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2018 9:39 AM, Jeremy Linton wrote:
> Hi,
> 
> 
> On 09/12/2018 09:41 AM, Jeffrey Hugo wrote:
>> The HW designers have indicated that there is no sane way to provide 
>> sets/ways information to software, even on an informational basis (ie 
>> not for cache maintenance, but for performance optimizations). 
>> Therefore the firmware will not provide this information because it 
>> will be wrong.
>>
>> So, therefore, we should still be able to tell the user that a cache 
>> exists at the relevant level, and what size it is.  On the concerned 
>> system, we cannot do that currently.
> 
> Ok, so set the fields to zero in firmware node, and mark them valid.

Is that what the PPTT spec says to do?

> That logically says that there isn't any set/way information for the 
> cache (which implies direct mapped).

Making inferences such as that have gotten folks into trouble when 
interpreting other specs.  Unfortunately I am not allowed to detail more 
about this specific system, however implying that the affected cache(s) 
are direct mapped is incorrect.  Officially, what you have is a cache or 
multiple caches at certain levels that have a specified size.  You can 
make no inferences about the exact behavior or implementation of the 
cache beyond what FW explicitly provides.  I'm not particularly a fan of 
it, but its what I have to deal with.

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
