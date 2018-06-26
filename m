Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B1DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F00126DA1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="vGBxDLuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F00126DA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752949AbeFZQvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:51:04 -0400
Received: from vern.gendns.com ([206.190.152.46]:47517 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752491AbeFZQvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X4CsMyc1i3+4RCtZ9dLTGa1nXBwdo+2HePqHCWTFG7A=; b=vGBxDLuJpgCjjXvfAWSGEhEALQ
        jaXUez6XZSpL5xVTwdGiLA/sDb6QrkqaMZGervw38ta6wtTzQmtd/fo3Sqz9aX5p8wLSnkWRwXoQJ
        FBJynirojs2j0W/rHmdH1Rwd+1U4U5+blx7+FfSmyuRpk9AxX06DkiER0pxWJ8YRdeWhDKyK6iyj7
        GwRuAzfd8wTEMHXV0W/FEmxq+/QvAqvZ0DOjX+61OodwfSY1jmGFjrvqd29kc16+kzUxiSvlBflTa
        e5agcOM6FGKdMJW1faWgAhnhHHQjeWZhdoQ3z+dzN4sXIAIvHqiiJ3R0kpkqDp9EU7B+JbUNOPnBD
        kEjKmOnw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:50056 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fXrBF-005cBz-QX; Tue, 26 Jun 2018 12:51:02 -0400
Subject: Re: [PATCH 0/2] ARM: LEGO MINDSTORMS EV3 Bluetooth support
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180531202549.11255-1-david@lechnology.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <a448b752-e32c-d5a8-7f11-57a14b63ba8a@lechnology.com>
Date:   Tue, 26 Jun 2018 11:51:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531202549.11255-1-david@lechnology.com>
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

Hi Sekhar,

On 05/31/2018 03:25 PM, David Lechner wrote:
> This series adds Bluetooth support to LEGO MINDSTORMS EV3.
> 
> The pwm-clock depends on the common clock framework, so this requires the
> recent davinci common clock series to switch to the common clock framework
> before it will actually work.
> 
> David Lechner (2):
>    ARM: dts: da850-lego-ev3: Add Bluetooth nodes
>    ARM: davinci_all_defconfig: Enable Bluetooth
> 
>   arch/arm/boot/dts/da850-lego-ev3.dts   | 82 ++++++++++++++++++++++++++
>   arch/arm/configs/davinci_all_defconfig |  9 +++
>   2 files changed, 91 insertions(+)
> 

After "ARM: dts: da850: Add power-domains to PWM nodes", this is ready to
apply.
