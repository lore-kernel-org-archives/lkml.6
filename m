Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28A3C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74290208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74290208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbeJPRvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:51:13 -0400
Received: from foss.arm.com ([217.140.101.70]:33504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbeJPRvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:51:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40076341;
        Tue, 16 Oct 2018 03:01:33 -0700 (PDT)
Received: from [10.1.194.37] (unknown [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E32B03F71C;
        Tue, 16 Oct 2018 03:01:31 -0700 (PDT)
Subject: Re: [BUG] hikey960: psci: Failure to boot CPU after hotplug
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, lorenzo.pieralisi@arm.com,
        John Stultz <john.stultz@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>
References: <cf313cf7-c416-2693-8a9d-0d6f122f2018@arm.com>
Message-ID: <e842855e-e99a-378e-49ec-187384e1418c@arm.com>
Date:   Tue, 16 Oct 2018 11:01:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cf313cf7-c416-2693-8a9d-0d6f122f2018@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2018 19:00, Valentin Schneider wrote:
> [...]

This was initially sent on Sunday but only got delivered today. In the
meantime I dug a bit deeper and I think it has to do with the firmware
implementation of PSCI. I raised a ticket for ATF ([1]).

[1]: https://github.com/ARM-software/tf-issues/issues/638
