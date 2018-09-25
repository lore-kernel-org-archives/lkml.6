Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6827C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FFD20842
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3UCHTDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48FFD20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeIYXfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:35:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37864 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbeIYXfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:35:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id e15-v6so2211748edr.4;
        Tue, 25 Sep 2018 10:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YtcIu783nbL+ius0S1sxLbx/lTyfBkY8J1Uav+shJX8=;
        b=e3UCHTDdMOPZ2DqrmHKA4QDdYjXuz1V+Qsknk8PS1RDnVkSBpbmSLTvadu8f5sPWhb
         spSfT2ytA2tWJClAkBO6K1Ovos5GSpViaFlQBN0cclcy5APGLevnZdiVIsNehcDeryRs
         k2amlr7sOUojzYuVaAsY3ca2wYSWr2Y0JqfAMsstkWkJTGo8FZdmDDa2fKHxKYHy8cXI
         mbix9rTCV3yv14W8EzctIrVDPdOweBGh9vvmWBvJ40kftGkr735AFAwlZuvC7mAM992Z
         6VdEe2hgg618xW1ifMhiaY7KG/TZHNTnPFhqadNVIilKbO8WL9aLuGhhi9dlwFR09GG4
         mrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YtcIu783nbL+ius0S1sxLbx/lTyfBkY8J1Uav+shJX8=;
        b=k7psbiwRcHPBpcG+NwGMZJVZ6KJGyowxQjfj55O031NF31VgEO/HvZD02UtHUr9OTF
         1qPCY5KZfCEW6Nmb0icGWRt5D4RJMjdy2BTdWvd3DQcCSvUeE3pn8wGgBkoEUMUo4xst
         aqJd9CoshauCSUyRC7HFliq+K0KBlgLyUjCyMLy4qo6Q50Hn53T0xAsSpn0fH4JTGSRe
         D53G6cOobjVeZj97W1O4XVa2mmYZdKJFhXmwKfmDX1NUt7tdcHDZNGJSlNYdb31c3tLp
         NzzryKXx/tY8Z8VHQjMXKar4O11E6qAOvBpDH5Zhkt8P230vq/8wYK7s1AJgvdsLMQdb
         c7Wg==
X-Gm-Message-State: ABuFfogyS/1VkyHB7/KmWgva8dSUFsxkNh1yVgYFY+vV4YhmFdrHzE18
        Z3D7JlxBqkATu/zlpqIT03uqOGnp
X-Google-Smtp-Source: ACcGV63h00mP4/xFX2PaVC5P5R+3TSNDl39CPRw4428rOU9DDRnbZRuwUDZp52KjV7qu4qOp0ZBOXw==
X-Received: by 2002:a50:ed1a:: with SMTP id j26-v6mr2925101eds.29.1537896407066;
        Tue, 25 Sep 2018 10:26:47 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id m35-v6sm6835084ede.14.2018.09.25.10.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 10:26:46 -0700 (PDT)
Subject: Re: [PATCH net 3/7] lan78xx: Check for supported Wake-on-LAN modes
To:     Woojung.Huh@microchip.com, netdev@vger.kernel.org
Cc:     davem@davemloft.net, UNGLinuxDriver@microchip.com,
        steve.glendinning@shawell.net, keescook@chromium.org,
        akurz@blala.de, hayeswang@realtek.com, kai.heng.feng@canonical.com,
        grundler@chromium.org, zhongjiang@huawei.com,
        bigeasy@linutronix.de, ran.wang_1@nxp.com, edumazet@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180924205420.31309-1-f.fainelli@gmail.com>
 <20180924205420.31309-4-f.fainelli@gmail.com>
 <BN6PR1101MB2130115311A87CCF7D712B0FE7160@BN6PR1101MB2130.namprd11.prod.outlook.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
Message-ID: <f791e4b6-7493-b54b-a88f-47d0ef4a3409@gmail.com>
Date:   Tue, 25 Sep 2018 10:26:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <BN6PR1101MB2130115311A87CCF7D712B0FE7160@BN6PR1101MB2130.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/2018 10:19 AM, Woojung.Huh@microchip.com wrote:
> Hi Florian,
> 
>> @@ -1415,6 +1415,9 @@ static int lan78xx_set_wol(struct net_device *netdev,
>>  	if (wol->wolopts & WAKE_ARP)
>>  		pdata->wol |= WAKE_ARP;
>>
>> +	if (pdata->wol == 0)
>> +		return -EINVAL;
>> +
> It will make function return when disabling WOL.

Huh, yes, good point.

> Is there other place handling this scenario?

How do you mean?

> 
>>  	device_set_wakeup_enable(&dev->udev->dev, (bool)wol->wolopts);
>>
>>  	phy_ethtool_set_wol(netdev->phydev, wol);
> 
> 
> Thanks.
> Woojung
> 


-- 
Florian
