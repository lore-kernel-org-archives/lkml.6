Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B2BC64EBD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C2F20877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YyFezQDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C2F20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeJDWm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:42:28 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35438 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeJDWm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:42:27 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w94FmQKb094805;
        Thu, 4 Oct 2018 10:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538668107;
        bh=icasrgGLVwgW1MQukarVQTIZMrfZjmrtVYtk3QGZ1Hs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YyFezQDpZztbNxGHIWZW3fTR6MnNAlA70GjxuQsXTJjJ27IgNYpMbmed4jkrC3Z8p
         WEsYANtozCYzRWQsmBwV1GqWAQGZDO6KSb0iXit5ZwYUbR4xdYiTf2jPxzW41aD0OG
         NuKpL1L2A6wI0GEjVoTUucYS96mpDgET7Wifmpps=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94FmQxI015972;
        Thu, 4 Oct 2018 10:48:26 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 4 Oct
 2018 10:48:24 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 4 Oct 2018 10:48:24 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94FmK6F012406;
        Thu, 4 Oct 2018 10:48:21 -0500
Subject: Re: [PATCH RFC 0/2] mach-omap2: handle autoidle denial
To:     Tony Lindgren <tony@atomide.com>
CC:     Andreas Kemnade <andreas@kemnade.info>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <paul@pwsan.com>, <letux-kernel@openphoenux.org>,
        Suman Anna <s-anna@ti.com>
References: <20181004055147.23048-1-andreas@kemnade.info>
 <20181004142558.GB5662@atomide.com>
 <013b01a1-2593-bdc0-dd9a-e5a114388067@ti.com>
 <20181004150751.GF5662@atomide.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <5373dfa1-4134-6d3f-0b66-46eef723d43f@ti.com>
Date:   Thu, 4 Oct 2018 18:48:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181004150751.GF5662@atomide.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/18 18:07, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [181004 14:47]:
>> On 04/10/18 17:25, Tony Lindgren wrote:
>>> It seems we should just provide a generic interface for
>>> clk_allow_autoidle() and clk_deny_autoidle()? Otherwise we'll
>>> be forever stuck with pdata callbacks it seems.
>>
>> The TI clock driver is actually providing these APIs, so that should be
>> fine. I don't think there is any use / need for pdata callbacks atm, it just
>> happens hwmod core is calling these at the moment which might have confused
>> you.
> 
> Hmm OK. So do we already have some way to deny autoidle for a
> clock from ti-sysc.c driver without pdata callbacks?
> 
> Suman pointed out few days ago that for a reset driver to work
> we must do clkdm_deny_idle() and clkdm_allow_idle() as the hwmod
> code does. I gues that really just boils down to doing clk deny
> idle and allow idle on the clockdomain clkctrl clock?

Clkdm handling is done via pdata callbacks, that is a separate topic 
from iclk autoidle. Iclk:s are effectively only for omap3, clkdm 
autoidle / deny_idle etc. are a generic mechanism that must be used on 
omap4+ if you want to prevent autoidle of certain domains/IPs.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
