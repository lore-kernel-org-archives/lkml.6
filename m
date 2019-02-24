Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3B3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 16:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216EB205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 16:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnPQMOTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfBXQrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 11:47:31 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45525 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbfBXQrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 11:47:31 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so5850066ota.12;
        Sun, 24 Feb 2019 08:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FXeSM/hYhtBw4Ou/zgFhI0RI1TbISbLzRsAnqreHMwY=;
        b=AnPQMOTmrIVEp4Vt5Liuh6Qz/ZyJCRlXz9guaPfyL4FJDsrJKJd4D+70eVKjX5J1hb
         m+hEx66fb8zZzfKGK5MgyM37MIuHW4eNVF1daXkl5V3ikUQAuycswlbRFpFWAhQkifkN
         7rstnpBXGo9vyMw6reR5eDNjf/G1XJGX6LfR4kOYY2H+hMqqRegCNfYuDM4Ji7knMlaC
         pItkp/P51pqEWtULsZc6N+IpCPEK1w5pFYz3Wx7JXwjgKb6azkJJmO6S+xX8yyaNzkyb
         rf2nKlRWsXuj398sHqgp56x27Vq2u1jE7S5/pNmDg695IaF9QD5dv4iAcFFOxLn8cCU3
         6TZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FXeSM/hYhtBw4Ou/zgFhI0RI1TbISbLzRsAnqreHMwY=;
        b=sBraPr2VX7mtBMWbLxDXte1IlQx1JzTiBtcPmWM1UgdrC0GQxMVx5q0kU6LR6cniuP
         n8Jv4tN9D7fF2BdilZz15416tL1dfOtKYGcfLBHDWwIDomn00ZoCli5sbCdv+U4fG7IZ
         ni07Uqnc8/d1LXddBb+Hp8mLSeJMlk+rNxDm8tx9R48A6atER9tmlKRvUVGDqZoZb4SV
         hew67kwf/SoScJGHOSWwh0piz/NshAEFnbDwR+M1hrN4tm2fxV6hX6z9CjSloNK8dg7j
         rybyYz0FDzUpIGe5jzwNfrTPi0tWP9SOwaf58DKV1Jy8HMtYuKJjRgH3ljzSellp3ySK
         364g==
X-Gm-Message-State: AHQUAubij4sYfQXugU9MvbwionK6e58vl6CadZnQVSsyuN4S0zju4wAe
        NVwJ/NrByrQsGt7KdkNnxNU=
X-Google-Smtp-Source: AHgI3IZqgvv9cbg1fUcbH+3Lm/lxQY/yb0Ud7ZBbCDzXut9OBy9mIzin2tpZO8F/u5x41hXniA+7Vw==
X-Received: by 2002:a9d:6755:: with SMTP id w21mr8685648otm.87.1551026849753;
        Sun, 24 Feb 2019 08:47:29 -0800 (PST)
Received: from [192.168.1.2] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.googlemail.com with ESMTPSA id 97sm3443098otn.39.2019.02.24.08.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 08:47:28 -0800 (PST)
To:     Ido Schimmel <idosch@mellanox.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        Jiri Pirko <jiri@mellanox.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
 <20190222235927.10295-8-f.fainelli@gmail.com>
 <20190223103207.GA13070@splinter>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 a9BQwACgnzGuH1BVeT2J0Ra+ZYgkx7DaPR0=
Subject: Re: [PATCH net-next 7/8] net: switchdev: Replace port attr set SDO
 with a notification
Message-ID: <daaa3bb6-78b1-7c19-e2fd-6ec03d56201d@gmail.com>
Date:   Sun, 24 Feb 2019 08:47:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190223103207.GA13070@splinter>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 2/23/19 à 2:32 AM, Ido Schimmel a écrit :
> On Fri, Feb 22, 2019 at 03:59:25PM -0800, Florian Fainelli wrote:
>> Drop switchdev_ops.switchdev_port_attr_set. Drop the uses of this field
>> from all clients, which were migrated to use switchdev notification in
>> the previous patches.
>>
>> Add a new function switchdev_port_attr_notify() that sends the switchdev
>> notifications SWITCHDEV_PORT_ATTR_SET and takes care, depending on
>> SWITCHDEV_F_DEFER to call the blocking (process) or non-blocking
>> (atomic) notifier chain accordingly.
>>
>> Drop __switchdev_port_attr_set() and update switchdev_port_attr_set()
>> likewise.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  net/switchdev/switchdev.c | 96 +++++++++++----------------------------
>>  1 file changed, 26 insertions(+), 70 deletions(-)
>>
>> diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
>> index 94400f5b8e07..a1f16836ef89 100644
>> --- a/net/switchdev/switchdev.c
>> +++ b/net/switchdev/switchdev.c
>> @@ -174,81 +174,35 @@ static int switchdev_deferred_enqueue(struct net_device *dev,
>>  	return 0;
>>  }
>>  
>> -/**
>> - *	switchdev_port_attr_get - Get port attribute
> 
> Hmm, why do you remove it here? Can't you remove it in a separate patch?
> I thought we already got rid of it :p

Yes it should have been removed, looks like my previous series did not
that, I will send that separately.

> 
>> - *
>> - *	@dev: port device
>> - *	@attr: attribute to get
>> - */
>> -int switchdev_port_attr_get(struct net_device *dev, struct switchdev_attr *attr)
>> +static int switchdev_port_attr_notify(enum switchdev_notifier_type nt,
>> +				      struct net_device *dev,
>> +				      const struct switchdev_attr *attr,
>> +				      struct switchdev_trans *trans)
>>  {
>> -	const struct switchdev_ops *ops = dev->switchdev_ops;
>> -	struct net_device *lower_dev;
>> -	struct list_head *iter;
>> -	struct switchdev_attr first = {
>> -		.id = SWITCHDEV_ATTR_ID_UNDEFINED
>> -	};
>> -	int err = -EOPNOTSUPP;
>> +	int err;
>> +	int rc;
>>  
>> -	if (ops && ops->switchdev_port_attr_get)
>> -		return ops->switchdev_port_attr_get(dev, attr);
>> +	struct switchdev_notifier_port_attr_info attr_info = {
>> +		.attr = attr,
>> +		.trans = trans,
>> +		.handled = false,
>> +	};
>>  
>> -	if (attr->flags & SWITCHDEV_F_NO_RECURSE)
>> +	if (attr & SWITCHDEV_F_DEFER)
>> +		rc = call_switchdev_blocking_notifiers(nt, dev,
>> +						       &attr_info.info, NULL);
>> +	else
>> +		rc = call_switchdev_notifiers(nt, dev, &attr_info.info, NULL);
> 
> I don't believe this is needed. You're calling this function from
> switchdev_port_attr_set_now() which is always called from process
> context. switchdev_port_attr_set() takes care of that. Similar to
> switchdev_port_obj_add().

Except for net/bridge/br_switchdev.c when we check the bridge port's
flags support with PRE_BRIDGE_FLAGS. In that case we are executing from
the caller (atomic) context and we can't defer otherwise that trumps the
whole idea of being able to do a quick check and return that to the
caller that we cannot support specific flags. How would you recommend
approaching that?
-- 
Florian
