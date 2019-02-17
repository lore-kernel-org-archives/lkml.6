Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EA1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515F92192D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="YCOQl/O8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfBQJ3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 04:29:55 -0500
Received: from vern.gendns.com ([98.142.107.122]:51788 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfBQJ3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 04:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HF3uzgw0eKAfgvObD56OZ4VPiHuV5vNFVEVo1wPQY8c=; b=YCOQl/O8tvEszhcuMNQCDUn74F
        7iAF8D1mIsIuV4XYBTHsxXI0Lq3AeZs5CIX/MyJItgCKzI+eW9vi+TXTMJiUN7ORLJMVPpuKA0SvZ
        462yQNyusoxoMeFBTMPGiipdtyKgIxdtOVtCP0g+E6xy923CPJKYupEoPeP3LuEiF+F0xqTE5bdRl
        lCHgik4tjioTU/kvHOjXZ2244j+P7ZKlML1W9PBowZfa7mTtelWZG9/5liQqtP+PjrftCml8LFUUt
        KkpMBh4js4yzC8OOmrrjiHCv/NU6U859Q2iSHZfqyk9NuHF8yd1kTHFqRN8Gw5wJ2O5/Lsg1G1VlD
        N5EdKsEA==;
Received: from [185.122.190.68] (port=50662 helo=gerda-5.local)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gvIlb-0004Wa-GQ; Sun, 17 Feb 2019 04:29:43 -0500
Subject: Re: [PATCH v4 07/37] ARM: davinci: wrap HW interrupt numbers with a
 macro
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190214145231.8750-1-brgl@bgdev.pl>
 <20190214145231.8750-8-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <e61980f7-af9a-90ba-3e82-9540b05fcf5d@lechnology.com>
Date:   Sun, 17 Feb 2019 10:29:50 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214145231.8750-8-brgl@bgdev.pl>
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

On 2/14/19 8:52 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Once we select SPARSE_IRQ, the interrupt numbers defined in mach/irqs.h
> will only signify the hardware interrupt offsets, not the interrupt
> numbers seen by linux. Introduce a wrapper macro that translates the
> hwirq number to virtual numbers. For now it's just a dummy. Use that
> macro when specifying the interrupts in resources for platform devices.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>
