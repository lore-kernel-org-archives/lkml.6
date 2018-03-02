Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-901181-1519977953-2-17863784957394502914
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519977952; b=AwWsZ25ijBIvOzFtfQGg+8CAt1zJS+SH7qJtZCk9i6uWA3v
    TtS6Fd6924061t+aqRO5MieJP11J5lVBvC+Fm51AF4ttd02ML466C0/BTikqXyN+
    3o+KmWdrQjMhhBK1JesZK5wtT6J/FyRd0ADOWUCWHnDXcU8ysmEcA8Pvi0PKqZ87
    W9u7dBJgEbWaP6LP/q6eHNq8yM0P9mrxSU3R+boYL1wXTKpw6AgDBEMlFHxsi+jj
    8je3oEb5lI9+ZYCnXYpbHtlk25SGzDcmVunffs9K10buX8VLskjQ1Y7kItuXhXzr
    VAzNK1jsDDdMmeq+92hh5FH826ypITwPUWTp5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :references:sender:list-id; s=arctest; t=1519977952; bh=yaK5h89K
    9BY+pwa2J8R5taymXhEMi3INND0bHj3Ajx0=; b=DDPLXJDNZ4ZM4ZhCQWLjjY2y
    Ui5Ypxstso2OqPKH8KKkuzun80gHF/uTCzEkwalEKXME4If0yqp/Ix5U9MQCmYmm
    O7q/z6a8a4dhukixmnU68G/zEZe77KUWHR0Ho9xeZFBqMEEHvGsda9my4oEHSRgl
    GgBJvGj7Z2Uv85d+hdk1dbTqzZ1TBm2CRo6MZCPWpE7OQyupcW2CiWQ+EqG62Gaw
    MbNqyvGXtJA0JpLRLLdh1qQBuJtsDCG6g3pMHulWYuAnfIGAeOXAXagtFSF1yQJo
    wG39NXPCK+zcOmuzK/7fhSibvACi67utUHTcomAEbbBD853Nc1mFJVTTOcJxiQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=TZFklF/0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=TZFklF/0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936176AbeCBIFt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:05:49 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:10391 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936005AbeCBIFr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:05:47 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180302080544epoutp02be57671867b7585c864729350e5e7b86~YC_MhKUvP1468814688epoutp02h
X-AuditID: b6c32a39-467ff70000000fc5-0d-5a9905d78356
Subject: Re: [PATCH v4] mmc: dw_mmc: Fix the DTO/CTO timeout overflow
 calculation for 32-bit systems
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Cc: linux-mmc@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        stable@vger.kernel.org
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <1112b6b6-4bb9-6cbf-24e5-e082f7ce04df@samsung.com>
Date: Fri, 02 Mar 2018 17:05:42 +0900
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101
        Thunderbird/52.5.0
MIME-version: 1.0
In-reply-to: <20180301135755.7e26f12e@xhacker.debian>
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e3ebXfS6jpNDxZmF/oj07W7trxmRpHUpfxjJWQYZjd3U8s9
        2N2id+thiRktK9Fly1IyLCszTE2UTLMHGvZEMyUJK8UQe9KD2vUa+N+Xcz7fw/keDoFpbijC
        iCyrk3dYuWxKEYDX3psbHf1KXpyie1QRx1z7+lrGfPTcQ0zHpbsKJreiRM48L3MjprC7Amee
        NZQomNa/JxCT01slY3rfXZczpdUDiGmvSmYODFVhS9XsWXcXztZ73yjZ3peNCramfD/7x9uM
        swXPOzH2VvNnxH6+GW4iUvjFmTxn5h0RvDXdZs6yZsRTq5PSlqcZF+roaDqWiaEirJyFj6cS
        Ek3RK7Ky/RtTEdu5bJe/ZOIEgZq/ZLHD5nLyEZk2wRlPbaBpvZbWxWj1er3WsCB1kd7oRzbx
        mSM1jZi9fsaO6vxBzI2qQ/KQigDSAO6mhygPBRAasg6B75tHITY05HcEPZ5deYgYh362zJaY
        OwiqupomDH0IyrzfFSIURG6Bhg8y0RtMpsLI+TG5yGDkdQwK+w+OD1WQUXD7W/s4pCaXgGfM
        i4tenJwDDbVJYnk6uQ7aiseQhATCj1N9uKhVpBFuNA5josbIufDhSwEu6VA4lNM9oWdBzdUR
        TAp2Qgmv7zCSToCO2jNySQfBUPstpZRrBjxti5fKRxF0nA0SVwbyNILLRcdkUmMBDF7Ik0nz
        p8Knr/lyyauG3CMaCWHhQdNjpaSXwZDvysR5mhD8endE5kHh3klxvJMieCdF8E6KUIrwShTC
        2wVLBi/QdqNW4CyCy5qhTbdZbqLxb42MrUP3OxNbEEkgaoq6TlWUopFz24WdlhYEBEYFqw+P
        +ktqM7dzF++wpTlc2bzQgoz+a5/Ewqan2/y/b3Wm0YZYnWGh3v9osTRNhapNpoQUDZnBOflt
        PG/nHf99MkIV5kbnulRw0bdyYJVpYPi3uXJrvc8VFL5P97I7OaejWHixN+BMatz89bPWbHnS
        16/82/PAZ1h7YHSse0//RpqKIwOx0Nb8wrbRzRtKpu3YVPAnt1WXWDptEG+OCas93uNWRh08
        XvcqtNH8/m3IzEAsqWH3k8709uB59hhbWfnpq/sTCwIoXMjk6EjMIXD/ADSBp5bDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t9jAd3rrDOjDDrn8lms+3qbyeLlhMOM
        FmeXHWSz6Fg+h9XiyuIGRotpN5ezWFzeNYfN4sj/fkaL1jtrmSzuPFnParFg4yNGi+Nrwy0a
        X61lduD1mN1wkcVj56y77B53ru1h89i8pN7j76z9LB6Trpxj9tiy/zOjx+dNcgEcUVw2Kak5
        mWWpRfp2CVwZbzfvYS7YKV2xsecZcwPjRrEuRg4OCQETiV+HFLsYOTmEBHYySszsMexi5AKy
        HzBKnH4+gQmkRlggTWLXCyaQGhGBWIlda2cygdQwC2xklmhrfsAK0bCPUWLHojUsIFVsAjoS
        278dB+vgFbCTmPBpFgvIIBYBVYld24JBwqICYRI9my4zQpQISvyYfA+slVPAVGLDntfMIOXM
        AuoSU6bkgoSZBcQlmltvskDY8hKb17xlnsAoMAtJ9yyEjllIOmYh6VjAyLKKUTK1oDg3PbfY
        qMAwL7Vcrzgxt7g0L10vOT93EyMwqrYd1urbwXh/SfwhRgEORiUe3h2cM6KEWBPLiitzDzFK
        cDArifC2fAAK8aYkVlalFuXHF5XmpBYfYpTmYFES572ddyxSSCA9sSQ1OzW1ILUIJsvEwSnV
        wOh2RW15v8Fh+5YN5ZGn277b1l3jmOhv9/pz4vYy7kC5aNVtZ+rumRfdun3uq/T9n1dqXOqM
        DjqURq+Ok5od23dKvWXq/vR/1mprzQ6s/V2smhfwJEZazPZ9Ve8t7hNc33U61AyTYtPlOZtt
        lpso+zKkBHT9mSZ+KCsv6JXZhqpnHiLKFrYLlFiKMxINtZiLihMBcwRnA6YCAAA=
X-CMS-MailID: 20180302080543epcas1p4304bba2730ee0c10e944ed32ead62f73
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180301055819epcas1p4de351fc93e2226e0b0ae5c9647610fc4
X-RootMTR: 20180301055819epcas1p4de351fc93e2226e0b0ae5c9647610fc4
References: <20180228115318.20154-1-Evgeniy.Didin@synopsys.com>
        <CGME20180301055819epcas1p4de351fc93e2226e0b0ae5c9647610fc4@epcas1p4.samsung.com>
        <20180301135755.7e26f12e@xhacker.debian>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/01/2018 02:57 PM, Jisheng Zhang wrote:
> On Wed, 28 Feb 2018 14:53:18 +0300 Evgeniy Didin wrote:
> 
>> In commit 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation") and
>> commit 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation") 
>> have been made changes which cause multiply overflow for 32-bit systems.
>> The broken timeout calculations leads to unexpected ETIMEDOUT errors and 
>> causes stacktrace splat (such as below) during normal data exchange 
>> with SD-card.
>>
>> | Running :  4M-check-reassembly-tcp-cmykw2-rotatew2.out -v0 -w1
>> | -  Info: Finished target initialization.
>> | mmcblk0: error -110 transferring data, sector 320544, nr 2048, cmd response
>> |  0x900, card status 0x0
>>
>> DIV_ROUND_UP_ULL helps to escape usage of __udivdi3() from libgcc and so
>> code gets compiled on all 32-bit platforms as opposed to usage
>> of DIV_ROUND_UP when we may only compile stuff on a very few arches.
>>
>> Lets cast this multiply to u64 type which prevents overflow.
> 
> Reviewed-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> 
>>
>> Tested-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
>> Reported-by: Vineet Gupta <Vineet.Gupta1@synopsys.com> # ARC STAR 9001306872 HSDK, sdio: board crashes when copying big files
>> Fixes: 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation")
>> Fixes: 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
>>
>> Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
>>
>> CC: Alexey Brodkin <abrodkin@synopsys.com>
>> CC: Eugeniy Paltsev <paltsev@synopsys.com>
>> CC: Douglas Anderson <dianders@chromium.org>
>> CC: Ulf Hansson <ulf.hansson@linaro.org>
>> CC: Andy Shevchenko <andy.shevchenko@gmail.com>
>> CC: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>> CC: Shawn Lin <shawn.lin@rock-chips.com>
>> CC: Vineet Gupta <Vineet.Gupta1@synopsys.com>
>> CC: linux-kernel@vger.kernel.org
>> CC: linux-snps-arc@lists.infradead.org
>> Cc: <stable@vger.kernel.org> 
>> ---
>> Changes since v3:
>> -Switch DIV_ROUND_UP macro to DIV_ROUND_UP_ULL
>> -Make one patch from two patches
>> -Modify commit message
>>
>> Changes sinve v2:
>> -add fix for cto_ms
>>
>> Changes since v1:
>> -uint64_t switched to u64
>>
>>  drivers/mmc/host/dw_mmc.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 0aa39975f33b..cba534d4c81b 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -409,7 +409,9 @@ static inline void dw_mci_set_cto(struct dw_mci *host)
>>  	cto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
>>  	if (cto_div == 0)
>>  		cto_div = 1;
>> -	cto_ms = DIV_ROUND_UP(MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
>> +
>> +	cto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * cto_clks * cto_div,
>> +				  host->bus_hz);
>>  
>>  	/* add a bit spare time */
>>  	cto_ms += 10;
>> @@ -1944,8 +1946,9 @@ static void dw_mci_set_drto(struct dw_mci *host)
>>  	drto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
>>  	if (drto_div == 0)
>>  		drto_div = 1;
>> -	drto_ms = DIV_ROUND_UP(MSEC_PER_SEC * drto_clks * drto_div,
>> -			       host->bus_hz);
>> +
>> +	drto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * drto_clks * drto_div,
>> +				   host->bus_hz);
>>  
>>  	/* add a bit spare time */
>>  	drto_ms += 10;
> 
> 
> 
> 
