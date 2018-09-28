Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0FEECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74AF204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c0ccrTsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74AF204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbeI1XNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:13:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36626 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1XNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:13:12 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8SGmU63063585;
        Fri, 28 Sep 2018 11:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538153310;
        bh=51F4s+rYfgscnJDmb47gCLzAjpOkMbn9KwCpoKhcHmE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=c0ccrTscYngpnsYTnqEMGvaRod0ccVTOG4NxV25t8qdWbhDF6GW/UER2FZ4iY/j+X
         VG11KCQUQ4PxriduMrYNG5ZVNrj+Eq0qJcmBXJzzxv1QGWf+UhGZG8ENS5+Y69E9UA
         2T9VQKNo0z7OIkTPXXkSspFwspaK6FO5WJELwxN8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8SGmUwb008587;
        Fri, 28 Sep 2018 11:48:30 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 28
 Sep 2018 11:48:30 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 28 Sep 2018 11:48:29 -0500
Received: from [172.22.149.181] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8SGmTiE003741;
        Fri, 28 Sep 2018 11:48:29 -0500
Subject: Re: [RFC PATCH 7/9] leds: lm3633: Introduce the lm3633 driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee.jones@linaro.org>, <linux-omap@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20180926130921.12329-1-dmurphy@ti.com>
 <20180926130921.12329-8-dmurphy@ti.com> <20180926223612.GA32286@amd>
 <7da01c06-f0f1-9022-54ec-f851d01f86ee@ti.com> <20180927214752.GG17346@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <7fe653e5-a554-fe38-6183-217ebf474d48@ti.com>
Date:   Fri, 28 Sep 2018 11:48:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927214752.GG17346@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 09/27/2018 04:47 PM, Pavel Machek wrote:
> Hi!
> 
>>> Duplicate.
>>>
>>> Can we get some more sharing? One way would be to have struct with
>>> all the constants (instead of #defines) use that...?
>>
>> I will look at the adding common constants to but they should be common across
>> more then just 2 devices.  As you can see the LM3632 code is quite different
>> when you add in the flash/torch support.
> 
> LM3632 is indeed different, I see.
> 
> On the other hand, I'd really like to see the code shared, even if it
> is just for 2 devices. (I believe that family is big enough that we'll
> likely see more sharing in future).
> 

Yes I have been looking at the other drivers I created that support 11 bit and
I plan to move them over to call the common code if the code is accepted.

I just finished debugging and getting the 3632 and 3633 drivers working with
flash/torch and configurable indicator support and there is a lot of code
diff especially around the node parsing and configuration.

Dan

> Thanks,
> 
> 									Pavel
> 


-- 
------------------
Dan Murphy
