Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55702ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB4E2156F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB4E2156F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbeIVERH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:17:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:43601 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbeIVERH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:17:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 15:26:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,286,1534834800"; 
   d="scan'208";a="71938764"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.151]) ([10.7.153.151])
  by fmsmga007.fm.intel.com with ESMTP; 21 Sep 2018 15:26:14 -0700
Subject: Re: [PATCH v2] i2c: aspeed: fix invalid clock parameters for very
 large divisors
To:     Brendan Higgins <brendanhiggins@google.com>,
        benh@kernel.crashing.org, joel@jms.id.au, andrew@aj.id.au
Cc:     openbmc@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20180921221025.75003-1-brendanhiggins@google.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <f5943177-6f1b-9344-3821-2aac001ff45d@linux.intel.com>
Date:   Fri, 21 Sep 2018 15:26:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921221025.75003-1-brendanhiggins@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/21/2018 3:10 PM, Brendan Higgins wrote:
> The function that computes clock parameters from divisors did not
> respect the maximum size of the bitfields that the parameters were
> written to. This fixes the bug.
> 
> This bug can be reproduced with (and this fix verified with) the test
> at: https://kunit-review.googlesource.com/c/linux/+/1035/
> 
> Discovered-by-KUnit: https://kunit-review.googlesource.com/c/linux/+/1035/
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>   - v2 updates the title of the patch, renames a local variable, and
>     prints an error when the clock divider is clamped.
> ---

[....]

> +	if (base_clk_divisor > ASPEED_I2CD_TIME_BASE_DIVISOR_MASK) {
> +		base_clk_divisor = ASPEED_I2CD_TIME_BASE_DIVISOR_MASK;
> +		clk_low = clk_high_low_mask;
> +		clk_high = clk_high_low_mask;
> +		dev_err(dev,
> +			"clamping clock divider: divider requested, %u, is greater than largest possible divider, %u.",

Please put a newline character at the end of the string.

Thanks,
Jae

[....]
