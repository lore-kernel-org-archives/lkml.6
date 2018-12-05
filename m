Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D27C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D63D2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D63D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeLEPef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:34:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:36990 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbeLEPee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:34:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 07:34:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,318,1539673200"; 
   d="scan'208";a="299563235"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 05 Dec 2018 07:34:23 -0800
Received: from nhgala-mobl2.amr.corp.intel.com (unknown [10.251.129.101])
        by linux.intel.com (Postfix) with ESMTP id A12F9580433;
        Wed,  5 Dec 2018 07:34:22 -0800 (PST)
Subject: Re: [PATCH AUTOSEL 4.19 031/123] ASoC: Intel: Power down links before
 turning off display audio power
To:     Mark Brown <broonie@kernel.org>, Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20181205093555.5386-1-sashal@kernel.org>
 <20181205093555.5386-31-sashal@kernel.org>
 <20181205114851.GC6205@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <475af06c-bae7-13f4-26fc-8d4a9944e25f@linux.intel.com>
Date:   Wed, 5 Dec 2018 07:34:18 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181205114851.GC6205@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/18 3:48 AM, Mark Brown wrote:
> On Wed, Dec 05, 2018 at 04:34:23AM -0500, Sasha Levin wrote:
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> [ Upstream commit 4c10473d6ddf12ec124c9ff71a5d23bb5388478b ]
>>
>> On certain platforms, Display HDMI HDA codec was not going to sleep state
>> after the use when links are powered down after turning off the display
>> power. As per the HW recommendation, links are powered down before turning
>> off the display power to ensure that the codec goes to sleep state.
> 
> Are we sure there's no dependencies here?

If you are referring to dependencies to other patches, not that I can 
think of. Based on timelines there isn't a strong link with 4.19: the 
patch was initially submitted in August (and missed), before v4.19 came 
out, and has also been used in 4.14 backports.

