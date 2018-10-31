Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC15EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845CB2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845CB2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbeKAFQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 01:16:01 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41874 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbeKAFQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 01:16:00 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9VKGBgC052529;
        Wed, 31 Oct 2018 15:16:11 -0500
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9VKGBEv003295
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Oct 2018 15:16:11 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 31
 Oct 2018 15:16:11 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 31 Oct 2018 15:16:11 -0500
Received: from [172.22.181.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9VKGBRC025069;
        Wed, 31 Oct 2018 15:16:11 -0500
Subject: Re: [RFC PATCH 1/3] can: m_can: Create m_can core to leverage common
 code
To:     Wolfgang Grandegger <wg@grandegger.com>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181010142055.25271-1-dmurphy@ti.com>
 <20181010142055.25271-2-dmurphy@ti.com>
 <52811b27-00c0-f5e2-2b18-608ccf846723@grandegger.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <349ef8be-f4c7-25cc-2c33-7ce1fd0b0f40@ti.com>
Date:   Wed, 31 Oct 2018 15:15:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <52811b27-00c0-f5e2-2b18-608ccf846723@grandegger.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang

Thanks for the review

On 10/27/2018 09:19 AM, Wolfgang Grandegger wrote:
> Hello Dan,
> 
> for the RFC, could you please just do the necessary changes to the
> existing code. We can discuss about better names, etc. later. For
> the review if the common code I quickly did:
> 
>   mv m_can.c m_can_platform.c
>   mv m_can_core.c m_can.c
> 
> The file names are similar to what we have for the C_CAN driver.
> 
>   s/classdev/priv/
>   variable name s/m_can_dev/priv/
> 
> Then your patch 1/3 looks as shown below. I'm going to comment on that
> one. The comments start with "***"....
> 

So you would like me to align the names with the c_can driver?

<snip>
> 
> *** I didn't review the rest of the patch for now.
> 

snipped the code to reply to the comment.

> Looking to the generic code, you didn't really change the way
> the driver is accessing the registers. Also the interrupt handling
> and rx polling is as it was before. Does that work properly using
> the SPI interface of the TCAN4x5x?

I don't want to change any of that yet.  Maybe my cover letter was not clear
or did not go through.

But the intention was just to break out the functionality to create a MCAN framework
that can be used by devices that contain the Bosch MCAN core and provider their own protocal to access
the registers in the device.

I don't want to do any functional changes at this time on the IP code itself until we have a framework.
There should be no regression in the io mapped code.

I did comment on the interrupt handling and asked if a threaded work queue would affect CAN timing.
For the original TCAN driver this was the way it was implemented.

> 
> I was also thinking about optimized read/write functions handling
> more than 4 bytes of data, e.g. for the CAN payload data. That
> would speed-up SPI transfers, I think. But that could also be
> introduced later-on.

That would be the plan.

> 
> Wolfgang.
> 
> 
> 
> 


-- 
------------------
Dan Murphy
