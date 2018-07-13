Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C93ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B4A20870
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 22:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ELe66GmC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ELe66GmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B4A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbeGMWhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 18:37:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53488 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeGMWhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 18:37:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8506260B72; Fri, 13 Jul 2018 22:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531520445;
        bh=klkLLKra+mFHbFEHbzQlscuQw4ncCY03czvUAEc9Bps=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ELe66GmC9z7uhHie0WSxceJfEuPfqw9zEhLeHJUQTb+vTNLEjzN34vsOu3cKkBlbO
         60qh5j6to6sYKCjZUNDIls7KA8BwKweaMLh0CoU0yL3qD5LwuYpCv+a+DOXAaWdoGf
         s0Q35LUzGSYO+B7rRjd3objUMh+hsMRupRZFBq4o=
Received: from [10.226.58.143] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pprakash@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8EA1560541;
        Fri, 13 Jul 2018 22:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531520445;
        bh=klkLLKra+mFHbFEHbzQlscuQw4ncCY03czvUAEc9Bps=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ELe66GmC9z7uhHie0WSxceJfEuPfqw9zEhLeHJUQTb+vTNLEjzN34vsOu3cKkBlbO
         60qh5j6to6sYKCjZUNDIls7KA8BwKweaMLh0CoU0yL3qD5LwuYpCv+a+DOXAaWdoGf
         s0Q35LUzGSYO+B7rRjd3objUMh+hsMRupRZFBq4o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EA1560541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pprakash@codeaurora.org
Subject: Re: [PATCH v4] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
To:     George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net
References: <1531375675-52623-1-git-send-email-george.cherian@cavium.com>
From:   "Prakash, Prashanth" <pprakash@codeaurora.org>
Message-ID: <41a6e3c7-db85-9ff1-daf4-07569c11fc8c@codeaurora.org>
Date:   Fri, 13 Jul 2018 16:20:43 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1531375675-52623-1-git-send-email-george.cherian@cavium.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

This version looks good. Thanks!

On 7/12/2018 12:07 AM, George Cherian wrote:
> Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
> feedback via set of performance counters. To determine the actual
> performance level delivered over time, OSPM may read a set of
> performance counters from the Reference Performance Counter Register
> and the Delivered Performance Counter Register.
>
> OSPM calculates the delivered performance over a given time period by
> taking a beginning and ending snapshot of both the reference and
> delivered performance counters, and calculating:
>
> delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).
>
> Implement the above and hook this to the cpufreq->get method.
>
> Signed-off-by: George Cherian <george.cherian@cavium.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Prashanth Prakash <pprakash@codeaurora.org>
