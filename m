Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F984C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D2A206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D2A206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeILPlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:41:35 -0400
Received: from foss.arm.com ([217.140.101.70]:57352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbeILPlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:41:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0A267A9;
        Wed, 12 Sep 2018 03:37:38 -0700 (PDT)
Received: from [10.4.12.116] (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 700BA3F614;
        Wed, 12 Sep 2018 03:37:37 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        vkilari@codeaurora.org
Subject: Re: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
To:     Jeremy Linton <jeremy.linton@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org
References: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
 <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <3eef4199-f99e-2d1d-0d1f-98b30cafb5bf@arm.com>
Date:   Wed, 12 Sep 2018 11:37:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/09/18 21:16, Jeremy Linton wrote:
> Hi Jeffrey,
> 
> (+Sudeep)
> 

Thanks for looping me in.

> 
> If you look at the next line of code following this comment its going to
> update the cache type for fully populated PPTT nodes. Although with the
> suggested change its only going to activate if someone completely fills
> out the node and fails to set the valid flag on the cache type.
> 
> What I suspect is happening in the reported case is that the nodes in
> the PPTT table are missing fields we consider to be important. Since
> that data isn't being filled out anywhere else, so we leave the cache
> type alone too. This has the effect of hiding sysfs nodes with
> incomplete information.
> 
> Also, the lack of the DATA/INST fields is based on the assumption that
> the only nodes which need their type field updated are outside of the
> CPU core itself so they are pretty much guaranteed to be UNIFIED. Are
> you hitting this case?
> 

Completely agree with you.

-- 
Regards,
Sudeep
