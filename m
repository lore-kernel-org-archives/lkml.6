Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01222C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE1C223B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lJdHUacK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE1C223B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934959AbeGFTfU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:35:20 -0400
Received: from mail.efficios.com ([167.114.142.138]:46390 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934801AbeGFTfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:35:07 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C49171C13E8;
        Fri,  6 Jul 2018 15:35:06 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id sxGY9X379LW2; Fri,  6 Jul 2018 15:35:06 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 561CC1C13E5;
        Fri,  6 Jul 2018 15:35:06 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 561CC1C13E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530905706;
        bh=XjeL9gAWxSE/DGTxSc4PNBaGAkOIBiUoyIje1Di830g=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=lJdHUacKauvy4I9Ej2mlYbQJwtm7jNx9EdPWvWeW1PlR7XB34l20TgArhrBlDUzmv
         uhACPOQeaJbilzW0+SSRYZFvmmis/43G26RD1oJ+rexO2A88tlF/IFB7fnKTA6oXk0
         /XVj/vWJIh/ztPrstW/ZzTqN99F/VF1wcHNskCLQEeaO7WK4NKKjEWYSIEqMFv6YLw
         /CI7eQMNp3CNTUoGMJFC1rxTRhHEHUMQNzWFKW2fsSVxgo6DMJuKUUFyGUUbk/5dzk
         LFdz3gEeTuw2q9Al49X7VvpK3yOIpfFr/ESJW7u4gxeE0WVm/j+GHU4lForRTsgC0e
         HrYShTRnj4rVg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id mpyW_H1Hg8bh; Fri,  6 Jul 2018 15:35:06 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 411D61C13DC;
        Fri,  6 Jul 2018 15:35:06 -0400 (EDT)
Date:   Fri, 6 Jul 2018 15:35:06 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        maxime ripard <maxime.ripard@bootlin.com>
Message-ID: <1518490673.1365.1530905706162.JavaMail.zimbra@efficios.com>
In-Reply-To: <436511d7-34f7-e980-2a99-c2b216c6669b@arm.com>
References: <1879608911.1296.1530896362007.JavaMail.zimbra@efficios.com> <20180706170400.GA4961@arm.com> <436511d7-34f7-e980-2a99-c2b216c6669b@arm.com>
Subject: Re: [REGRESSION] arm32 Cubietruck defconfig does not boot anymore
 since 4.18-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: arm32 Cubietruck defconfig does not boot anymore since 4.18-rc1
Thread-Index: Q94J78zLpfcn9aPYB74a7CYDwKhPRA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 6, 2018, at 1:09 PM, Marc Zyngier marc.zyngier@arm.com wrote:

> On 06/07/18 18:04, Will Deacon wrote:
>> Hi Mathieu,
>> 
>> On Fri, Jul 06, 2018 at 12:59:22PM -0400, Mathieu Desnoyers wrote:
>>> The 4.18-rc3 arm32 kernel defconfig fails to boot on my Cubietruck.
>>> This issue appeared with 4.18-rc1.
>>>
>>> It worked fine on 4.17.
>>>
>>> Any ideas ?
>> 
>> CC'ing linux-arm-kernel would be a good place to start :) [I've added it
>> here, as well as Maxime and Marc].
>> 
>> With the right people on cc, I suspect this is a known issue and might
>> even have a patch. (he says hopefully...)
> 
> I have had issues as well. With this patch[1] applied, my board works
> well enough.

I confirm that the patches makes it boot.

Thanks!

Mathieu

> 
> Thanks,
> 
>	M.
> 
> [1] https://lkml.org/lkml/2018/7/4/73
> --
> Jazz is not dead. It just smells funny...

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
