Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88DAC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 09:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F602080D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 09:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1nWbXyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfAAJka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 04:40:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45903 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfAAJka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 04:40:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so27915341wrr.12;
        Tue, 01 Jan 2019 01:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xf3CTR0gT69tNF6bg9dPmwgzymImjOrmxmrvRbOESL8=;
        b=h1nWbXyQE+AjdOWjC+h0WXjrbVHGJlVaFtu63rgudsRlVPsbL21ujpji5DbJzgiNvP
         ws9e1ALdkUnx5igJ0Ae+y9+HQferhSj0ujSy0sJ1zI3uH6xdjfn5i9hatLBP7bJr3/GU
         npoTMTI5gnN4qCzlT5zlds7gqtqemFKwK+Q0FSMQFEwQ0o6Ih/bzImnsY3m47bFhnHjo
         VvK9O9dqu3b/f4mWTGISWNdsPzDq+ejwa3ZEkYEMIiJVhgkb0M5zmQzYOT3ttlyRA+ar
         HZACCgXKUDkdOjVpQjnXnkQZ3/g/5eK5jc3g/8LqbpAAOvihtQFnNhl2lst7XUtKhM/Y
         6naQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xf3CTR0gT69tNF6bg9dPmwgzymImjOrmxmrvRbOESL8=;
        b=gEj76Wc6kv3XYIDr7/UgQT6jPjgE9RajeTV9NQgIntfFxt9XYm0jRn8KVDwFSrLoYC
         MeIgd5FbWN0dDMPyqNp2UePQFgnYTHE/dLoBtJeGF695cunZL94Refg3f8AyDnU/gWnJ
         o5GqPpXUsNLONjXJyBV4FqDuD/3+w9oT8srzMm1k/mB5x9y3jyxA7uiDPWlrgMfy9zLh
         jVDELJhRexaaPqYyknnBPMj+6jBfSizbh90xxpHacqzPKii2Bx1QkLT4A7rmRla5CHob
         k9JUJlFi7gDTnuM3f07Kp+vNjGeS7A4jgrXrQofVGk9ng68eSXaOPVq2i8zxpNKSCBvI
         LOXw==
X-Gm-Message-State: AJcUukfuqkDbn5O3QX9Z6a6FTZ1Cvc4O3s3OYF4m3OUubB38NO6VQNWN
        q2sKNyfRgahfoBpmxhH7ngImPJ4b
X-Google-Smtp-Source: ALg8bN4oJCC4uTwwH/mG3df2iKvqWjT8GVvYxnoqiQPcGCd5Lsy+Bxa5z0DiQwENU3xsOTMqq1de2w==
X-Received: by 2002:a5d:40c1:: with SMTP id b1mr37007332wrq.133.1546335627032;
        Tue, 01 Jan 2019 01:40:27 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:4822:3f9a:2eec:6a82? (p200300EA8BCFE30048223F9A2EEC6A82.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:4822:3f9a:2eec:6a82])
        by smtp.googlemail.com with ESMTPSA id j8sm92080415wmd.0.2019.01.01.01.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 01:40:26 -0800 (PST)
Subject: Re: [PATCH] net: core: Fix to store new mtu setting in netdevice.
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Murali Krishna Policharla <murali.policharla@broadcom.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "amritha.nambiar@intel.com" <amritha.nambiar@intel.com>,
        "ecree@solarflare.com" <ecree@solarflare.com>,
        "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1546324934-17555-1-git-send-email-murali.policharla@broadcom.com>
 <b2127534-4e9c-1fef-27f1-72329595c3a3@virtuozzo.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <bef4af12-f5ce-35ec-8d04-395a281e4322@gmail.com>
Date:   Tue, 1 Jan 2019 10:40:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b2127534-4e9c-1fef-27f1-72329595c3a3@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.01.2019 08:54, Kirill Tkhai wrote:
> On 01.01.2019 09:42, Murali Krishna Policharla wrote:
>> Store newly configured mtu settings in the netdevice after mtu
>> configuration is successful to the dsa switch.
>>
>> Fixes: 2315dc91a5 ("net: make dev_set_mtu() honor notification return code")
>> Signed-off-by: Murali Krishna Policharla <murali.policharla@broadcom.com>
>> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>>  net/core/dev.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 722d50d..58617aa 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -7586,12 +7586,15 @@ int dev_change_flags(struct net_device *dev, unsigned int flags)
>>  int __dev_set_mtu(struct net_device *dev, int new_mtu)
>>  {
>>  	const struct net_device_ops *ops = dev->netdev_ops;
>> +	int ret = 0;
>>  
>>  	if (ops->ndo_change_mtu)
>> -		return ops->ndo_change_mtu(dev, new_mtu);
> 
> Is there a .ndo_change_mtu callback, which does not assign a new mtu itself?
> 
So far all drivers have to do it themselves. But IMO this is more a workaround
for the core not doing it. It's something the core should do.
Now we can remove this from drivers.

>> +		ret = ops->ndo_change_mtu(dev, new_mtu);
>>  
>> -	dev->mtu = new_mtu;
>> -	return 0;
>> +	if (ret >= 0)
>> +		dev->mtu = new_mtu;
>> +
>> +	return ret;
>>  }
>>  EXPORT_SYMBOL(__dev_set_mtu);
>>  
>>
> 

