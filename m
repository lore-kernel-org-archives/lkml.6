Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76836C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A73F20873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="ZUEVW1ZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A73F20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeK0IOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:14:06 -0500
Received: from vern.gendns.com ([98.142.107.122]:44276 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbeK0IOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aZxd+KtiYrmC87XOrKvvc9l+mg7cNZJ5IVJfQqxARGI=; b=ZUEVW1ZJ+SEbVc9zW6RtBYxsGS
        rN9JLe+hRLO50QaOSKu1baCGkxxUom3z/FFujSWYQ+s8QG1IkB/ej/wjcuZfy0KybmlqFdk4PohCD
        eGvPRiQjf1DvILEuCw/zOQ7SEDWlF7iA+hFsNsMg/VaJhtTFfx1gDZmMBEMkVQ5wXnOoq95V8LfQR
        sYAsrnkE+2KsKjkSdCYbtj+00AoYPLrJsVzqV3VoVCmu+4lPxgfRkCp6aOLf64sqft4oVgsHXCZ4h
        5BeS8Y6Lru59Yp5q/LPwjZDFcP91+Vhr1b01/d7qk/eDvQNtSS1kOz7+lVQ5fGZyGuQSGRqCPp/Z4
        fOtqha2g==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:44848 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gROGJ-0002Wp-AM; Mon, 26 Nov 2018 16:17:47 -0500
Subject: Re: [PATCH 11/17] soc: ti: pruss: add pruss_get()/put() API
To:     Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc:     robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org,
        ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com,
        nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-12-git-send-email-rogerq@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <376717d4-3c89-2b19-ca38-c75e30c8f772@lechnology.com>
Date:   Mon, 26 Nov 2018 15:18:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542886753-17625-12-git-send-email-rogerq@ti.com>
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

> +	pruss = platform_get_drvdata(ppdev);
> +	if (pruss)
> +		get_device(pruss->dev);
> +
> +	return pruss ? pruss : ERR_PTR(-ENODEV);
> +}

This might be a bit easier to follow if we handle the error
path first:

	if (!pruss)
		return ERR_PTR(-ENODEV);

	get_device(pruss->dev);

	return pruss;


