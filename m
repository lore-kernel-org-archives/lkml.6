Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBA9ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 04:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFEF020C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 04:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="XeQpDNr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFEF020C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=castello.eng.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbeIRJf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 05:35:58 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.251]:36060 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbeIRJf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 05:35:58 -0400
X-Greylist: delayed 1209 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Sep 2018 05:35:58 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 21A955203
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 22:45:13 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id 26wrgSyCdRPoj26wrgpNpN; Mon, 17 Sep 2018 22:45:13 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=emZAYGiQOfL0vgU01oc8cAYoWFMpKSfG1Tgbir6IhbA=; b=XeQpDNr1qwYZ7iMhUK0Vo53yaF
        EpuGrTB0IfjX/DOteFhMY3IYNBXc1G/8wMQ9XNuZT4b/oLCu/xk2Pw8wybkn87aMM7NkcJO9zo5wX
        lQo9GPDthzcnm1ZEPE1EWY25lexlpp00cUGNPoyT+0S9whNg5oCGXj37PV1vx8try9pZ/8L8EqvLO
        P+t3qlWZXSNtUNAPu6/rfilEQRbUGBj8qSZFTQcC1ZKMYZyslVb0wIxc3HWxlbuQ4XrD41VfTmsip
        Pbe+g19d9ZVsDGavE2TFyE9LWNBKqRoppAWbvj8KweEK+NnmxCcwYxZEhIN84sTkoHqiA2wN74EoU
        LHO3cfrg==;
Received: from [152.254.171.190] (port=55108 helo=[192.168.15.10])
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <matheus@castello.eng.br>)
        id 1g26wq-002gMX-Me; Tue, 18 Sep 2018 00:45:12 -0300
Subject: Re: [PATCH 0/4] power: supply: MAX17040: Add IRQ for low level and
 alert SOC changes
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        sebastian.reichel@collabora.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180723040816.19455-1-matheus@castello.eng.br>
 <20180916114520.4375nr2gv3y4ghzv@earth.universe>
 <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
From:   Matheus Castello <matheus@castello.eng.br>
Message-ID: <473eb21a-d08d-63c2-93c1-7a445e6fd4bc@castello.eng.br>
Date:   Tue, 18 Sep 2018 00:45:09 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 152.254.171.190
X-Source-L: No
X-Exim-ID: 1g26wq-002gMX-Me
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [152.254.171.190]:55108
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 7
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof and Sebastian,

please forgive me for the delay in working with this patch.
I've been having some personal issues these months, but leaving the 
excuses I still intend to send a v2 for this.

Thanks Krzysztof for review and tips I'll work on it.

Best Regards,
Matheus Castello

On 09/17/2018 08:32 AM, Krzysztof Kozlowski wrote:
> On Sun, 16 Sep 2018 at 22:03, Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
>>
>> Hi Matheus,
>>
>> Did I miss a v2 of this patchset, that solves the issues
>> found by Krzysztof?
> 
> I did not see v2. This patchset brings nice feature so it would be a
> pity if it were discontinued.
> 
> Best regards,
> Krzysztof
> 
