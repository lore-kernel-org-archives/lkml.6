Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932969AbeBLXw3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 18:52:29 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47742 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932735AbeBLXw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 18:52:28 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E8ED60A4E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH] arm64: Make L1_CACHE_SHIFT configurable
To: Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc: tchalamarla@cavium.com, rrichter@cavium.com, opendmb@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1518479125-14428-1-git-send-email-f.fainelli@gmail.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <ca6c47f9-86df-bcdb-bbe1-eac9db68ec33@codeaurora.org>
Date: Mon, 12 Feb 2018 17:52:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518479125-14428-1-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 05:45 PM, Florian Fainelli wrote:
> +config ARM64_L1_CACHE_SHIFT
> +	int
> +	default 7 if ARM64_L1_CACHE_SHIFT_7
> +	default 6

Shouldn't this be the other way around?  Everyone is used to 7 now, so 
you're changing the default back to 6.  I would think that it should be 
7 by default, and platforms like Brahma-B53 should force it to 6.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
