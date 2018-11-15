Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEFEC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95844224E0
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1ExdV+ZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95844224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388649AbeKPDsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:48:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388329AbeKPDsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:48:04 -0500
Received: from localhost (unknown [64.114.255.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96DE42089D;
        Thu, 15 Nov 2018 17:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542303558;
        bh=pzA7bgHJEyME3FlChOZsjMkaGXvp3uVNLHqMXAMmkmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1ExdV+ZKV2Nzhn3u3he3FYuRSdhaoU1LQQJDv+VH5vslFa8tV1GIUmClmP9WPKdV5
         ekRQbJrQ792b8sZWuLmhmKd49V5Ddi0UyGVq6tXtuUKBBB/3/cRGGnP3hWAIV3wuly
         dO3iEZrEMhPMpO0jvHeuZPAVqA1a7cDgVSQmid2Q=
Date:   Thu, 15 Nov 2018 12:39:18 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: meson: axg: mark fdiv2 and fdiv3 as critical
Message-ID: <20181115173918.GI95254@sasha-vm>
References: <20181108093123.21498-1-jbrunet@baylibre.com>
 <5BEAFF2D.9080105@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5BEAFF2D.9080105@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 05:43:25PM +0100, Neil Armstrong wrote:
>Hi Stable team,
>
>Le 08/11/2018 10:31, Jerome Brunet a écrit :
>> Similar to gxbb and gxl platforms, axg SCPI Cortex-M co-processor
>> uses the fdiv2 and fdiv3 to, among other things, provide the cpu
>> clock.
>>
>> Until clock hand-off mechanism makes its way to CCF and the generic
>> SCPI claims platform specific clocks, these clocks must be marked as
>> critical to make sure they are never disabled when needed by the
>> co-processor.
>>
>> Fixes: 05f814402d61 ("clk: meson: add fdiv clock gates")
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>
>Could this fix go into the next 4.18 and 4.19 stable releases since it hit linus master with commit id d6ee1e7e9004d3d246cdfa14196989e0a9466c16 ?

Queued for 4.19 and 4.18, thank you.

--
Thanks,
Sasha
