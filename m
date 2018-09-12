Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788F3C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C0720833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C0720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeILUoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:44:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33958 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbeILUoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:44:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72BAC7A9;
        Wed, 12 Sep 2018 08:39:35 -0700 (PDT)
Received: from [192.168.100.242] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 125773F5C0;
        Wed, 12 Sep 2018 08:39:35 -0700 (PDT)
Subject: Re: [PATCH] ACPI/PPTT: Handle architecturally unknown cache types
To:     Jeffrey Hugo <jhugo@codeaurora.org>, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkilari@codeaurora.org,
        Sudeep Holla <sudeep.holla@arm.com>
References: <1536694334-5811-1-git-send-email-jhugo@codeaurora.org>
 <f62f22a6-2dd8-f254-dbaf-b9e224099afd@arm.com>
 <e74f2208-ac0d-6c45-8ddb-5b77d6a42fef@codeaurora.org>
 <c34452c2-d1e8-19d8-45c1-b48ecf14bbd7@arm.com>
 <98e2e6fa-7256-b5ac-7d2e-42c858c6e57c@codeaurora.org>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <f553018d-d27a-68e0-93f7-4f7a0497c68a@arm.com>
Date:   Wed, 12 Sep 2018 10:39:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <98e2e6fa-7256-b5ac-7d2e-42c858c6e57c@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 09/12/2018 09:41 AM, Jeffrey Hugo wrote:
> The HW designers have indicated that there is no sane way to provide 
> sets/ways information to software, even on an informational basis (ie 
> not for cache maintenance, but for performance optimizations). Therefore 
> the firmware will not provide this information because it will be wrong.
> 
> So, therefore, we should still be able to tell the user that a cache 
> exists at the relevant level, and what size it is.  On the concerned 
> system, we cannot do that currently.

Ok, so set the fields to zero in firmware node, and mark them valid.

That logically says that there isn't any set/way information for the 
cache (which implies direct mapped).

