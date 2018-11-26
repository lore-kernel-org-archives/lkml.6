Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7280C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B179820862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="gjzFMxen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B179820862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeK0DkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:40:01 -0500
Received: from vern.gendns.com ([98.142.107.122]:44898 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbeK0DkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:40:00 -0500
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Nov 2018 22:40:00 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=plAKvNBc8A/TfkDJGjSjtLkCbsmRxx1yRB9FE1YseDQ=; b=gjzFMxenDjJjiYFSjmP2tMbs8o
        79i+RH6EcZ6FSUMMudgvVsHiIED2Q9wSOZ8jF//9rVnUOvpK5V4keQuF+ghEb7TjXwyyYz4tFvx6R
        yeAuJBJQOrqoKYFweNIr0mqBwkSYWHJhOWflc7g+AxON4nswQKgJfeSmNqd3TlYeNi4PoUWBMT2VS
        NDvrB13b1Dkiaupq/4HJZPVZTVRjLAXxtDbzOIzJX3CfBsnQsmRtmiR94GpwV2ApHqFxy+9t7GGXD
        v9KykgemW8xaU6tVRM/VckxgcBnpTYzhzhvufVml59GZQ7OSJmA1dUoDHpO1H9ESzRQmkmtFAbvvx
        IecjpUag==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:41774 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gRJzp-00012T-1B; Mon, 26 Nov 2018 11:44:29 -0500
Subject: Re: [PATCH 17/17] ARM: dts: am335x-*: Enable PRU-ICSS nodes
To:     Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc:     robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org,
        ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com,
        nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-18-git-send-email-rogerq@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <05cbdb2a-d561-0691-d5c3-ee787bb6d02e@lechnology.com>
Date:   Mon, 26 Nov 2018 10:45:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542886753-17625-18-git-send-email-rogerq@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/18 5:39 AM, Roger Quadros wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> The PRU-ICSS processor bus node and subsystem nodes were left in
> disabled state in the base am33xx.dtsi file. PRU-ICSS is supported
> on these AM335x boards so enable the PRUSS node.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---

This does not apply cleanly to next-20181126. It looks like you
could be missing "ARM: dts: am33xx: convert to use new clkctrl
layout" from your development branch.
