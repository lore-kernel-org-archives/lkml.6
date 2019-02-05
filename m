Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A65C282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A5520844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="iqRzfOQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfBEBSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 20:18:17 -0500
Received: from vern.gendns.com ([98.142.107.122]:40168 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbfBEBSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 20:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3LmSdDP8ewwWIpdIRpCF/dZcat8JTdo1nV6JDm1go2o=; b=iqRzfOQ1cYIbjaYHYExridkvfa
        A0kjdgTYmnI+YmSHaTCvlE9C/d9eXuWuKYCyDtFpDj8inzgoZyA4IRf0l1zpncDTMQ6E4tvRGsnpr
        BsND3nLEmPkIqsKlYUJVSZ93k3LV2y3H9moLjaA7I09B9Cb8yxBdDEfDSws69Vm+kDifL28L4EwkL
        NLMbg+PQkhsXHIoqTjsMhWldqucrVd32rZcGBR7UgfP92oQcKh1XVRHy2sWGkrdEKGH9TazAgjOrL
        XNuH/rE3CyInHriwtUGKbKN2INWZCWuP+tnaLjeHZqBOhV8cg3OuxgVEktrN8copccUJI3xB25VbI
        5RJi1pfg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:33180 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gqpJv-0007Kx-0A; Mon, 04 Feb 2019 20:14:39 -0500
Subject: Re: [PATCH v2 01/12] ARM: dts: da850: fix interrupt numbers for
 clocksource
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     devicetree@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190204171757.32073-1-brgl@bgdev.pl>
 <20190204171757.32073-2-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <ce4c305e-7d76-6028-07e4-4922f3c700bf@lechnology.com>
Date:   Mon, 4 Feb 2019 19:18:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204171757.32073-2-brgl@bgdev.pl>
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

On 2/4/19 11:17 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The timer interrupts specified in commit 3652e2741f42 ("ARM: dts:
> da850: Add clocks") are wrong but since the current timer code
> hard-codes them, the bug was never spotted.
> 
> This patch must go into stable since, once we introduce a proper
> clocksource driver, devices with buggy device tree will stop booting.
> 
> Fixes: 3652e2741f42 ("ARM: dts: da850: Add clocks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

