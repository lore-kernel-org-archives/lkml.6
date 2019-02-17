Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E7AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2A22192C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="Im2qsK9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfBQJZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 04:25:02 -0500
Received: from vern.gendns.com ([98.142.107.122]:51368 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfBQJZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 04:25:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9D0vDs8zpCOFsGv0bn/E+pWXy79DwmOoD1oDq9oBe94=; b=Im2qsK9NAXr+fvkgTc1dcCJCvj
        soHdfpKs7XYP+4lqY0ZkEhqTVYytSsbvGhvgFaeY/DvQeHTKlIbbgWCx4brM7JhysKdX5+fb63NPq
        FPe3L/FxuWAu7PZNCyKSI2NkVye7D4m3wQogFBMd7KDLgAVslUgoTPky8b9KXFH09iL/U9NmbOKq2
        uy5e/JCu2aL9qp8Qpepbb4Iew6wq+/3ncuhHKDD9BiTarxOx+WUUMACReESya9RntTCn6bvOjFIYh
        eKikRb4sg3gXs+aMi4gFYdRJAFefCpzgSuqy8wl3gQhF6aHVUU7VHfwNhAaEmxIxCNr7LERJu7hEz
        61bibqUw==;
Received: from [185.122.190.68] (port=56265 helo=gerda-5.local)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gvIgr-0003lE-F4; Sun, 17 Feb 2019 04:24:49 -0500
Subject: Re: [PATCH v4 03/37] ARM: davinci: aintc: use irq domain
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
 <20190214145231.8750-4-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <1146c248-5143-ae59-1b2a-4f8f4179745b@lechnology.com>
Date:   Sun, 17 Feb 2019 10:24:56 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214145231.8750-4-brgl@bgdev.pl>
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



On 2/14/19 8:51 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We need to create an irq domain if we want to select SPARSE_IRQ. The
> cp-intc driver already supports it, but aintc doesn't. Use the helpers
> provided by the generic irq chip abstraction.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

