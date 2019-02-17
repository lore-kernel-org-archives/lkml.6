Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE2CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B236D21900
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="em+fbkL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfBQJ40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 04:56:26 -0500
Received: from vern.gendns.com ([98.142.107.122]:54210 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfBQJ4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 04:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OhZ9FVRRbRsgWnD9EZmBkcctr5w3lkWvOMQSyxG4rOA=; b=em+fbkL1HwaGnBh53nkUv79WQP
        4Qr09frukJzYYU14fbVI4pkFZPDRtH/jJoTaNTyB8wqdGI/paV8KGPm4nLWE66KXRHEFYnJBoPCF9
        zlYLzm8kcWbnBpFAdkRDZy9z1pavKsgfrQu3YlYc6gntnusD3yzlO0CZFi6AC0WoM/IFL7no1/xiA
        68W7HWt6I8a6CTAFyS7ygx2dhFPxI6W7qstXTdqPv6KBEgW1OAKfJ8PFpHSy+bJ9zb+hEPKDkSDTl
        RTYvCsygX3Ll90NOo2cSgewrCIaSl8wjsQHMpOnFebfLkLJLIMH8o+9L8xSZfUgKYo9OUXiCOb7KY
        Td/YvX1Q==;
Received: from [185.122.190.68] (port=58375 helo=gerda-5.local)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gvJBF-0008Vb-Vc; Sun, 17 Feb 2019 04:56:14 -0500
Subject: Re: [PATCH v4 29/37] ARM: davinci: cp-intc: use the new-style config
 structure
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
 <20190214145231.8750-30-brgl@bgdev.pl>
From:   David Lechner <david@lechnology.com>
Message-ID: <685e9c7b-39f2-e42a-86b6-fd903830e8e4@lechnology.com>
Date:   Sun, 17 Feb 2019 10:56:21 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214145231.8750-30-brgl@bgdev.pl>
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
> Modify the cp-intc driver to take all its configuration from the new
> config structure. Stop referencing davinci_soc_info in any way.
> Move the declaration for davinci_cp_intc_init() to
> irq-davinci-cp-intc.h and make it take the new config structure as
> parameter. Convert all users to the new version.
> 
> Also: since the two da8xx SoCs default all irq priorities to 7, just
> drop the priority configuration at all and hardcode the channels to 7.
> 
> It will simplify the driver code and make our lives easier when it
> comes to device-tree support.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

