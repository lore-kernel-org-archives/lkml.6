Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A18C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BF420836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjUGqglb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfBURk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:40:57 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33601 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfBURk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:40:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id h11so11698731pgl.0;
        Thu, 21 Feb 2019 09:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UvMdhonGG0cM4E2rDQd1c7rts+kOKxBnqdDjm+FVDnw=;
        b=KjUGqglbMQbjUkaWvxsOT2pbk0OIkHGdZcpoi24hzHNXp000lZDjz5EBBbk7ZKHtNI
         TryV0tseeaUhvOxEO/3rb61HDSuH7R9DbU44bnBHFG2jFlFcvUsneMHvWF/U0WmVSIDN
         ee083qsH7Y5hQ4TWLkOCwcQzrUHNFu1wj14B3PCozT+LGpnxFIapFNpPYWUtHiRLggym
         KlyUFlmUVwgTuRPuGp7i3kNsP1dC14+6aqoDbV0lHp7tJnUjF0/wg9ABAW72nMjX2GUo
         Ir+q00fzorSeT5h0jvkb7oig+LEcVig+8CqsBWkmjDYZOAmo4fCImdpvHesaHcki/Owl
         mI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UvMdhonGG0cM4E2rDQd1c7rts+kOKxBnqdDjm+FVDnw=;
        b=Rv9NaLAhGcPfv4FykHuSWsvWpunpsQa8jSMzEXPUZEy0APMg3DHg0DJpDVaN4Dr5f+
         AQaZmO/di2gIIcEtBC7SWXReupwwvjQcLPALXz+fgxAsQgzfsVUAmlRgT1AVLgWJTq6W
         UXFZhH/m5I8DcSdIqj+O2tCSmuv4SmtwwXc0qShBAvysf1NO8wT8QEaYcBUfZJn5ib/T
         iT2U1t9xlzHwbWBHikSRrovAfmlEMZdwhOAZXapg+GzdlDe4jaAs+SQhzmFzJoY//9r9
         r4lbDz38AUMzvxRCziX1Trjv/J0dBXhxjzjzNdMKKSLPyKtB85ZEhfSNrgeqpQdvHl8V
         E8Ng==
X-Gm-Message-State: AHQUAub5bNcu9Eocn5QETahGUfjQQzr2wBlnQe2c1NTgruvvDp9goPCP
        zv/8U5u90Cc3bC0qPmj3GJglHqsp
X-Google-Smtp-Source: AHgI3IZDq8vHuzH8xzY1UAUtsV4LvCc8dw/IMgm5C39vAnE/ZJ2RMS0evPKi+n6yWAlUMAOKl+jYwA==
X-Received: by 2002:a63:e952:: with SMTP id q18mr1793605pgj.156.1550770854850;
        Thu, 21 Feb 2019 09:40:54 -0800 (PST)
Received: from [10.67.49.97] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id n10sm38573496pfj.14.2019.02.21.09.40.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 09:40:53 -0800 (PST)
Subject: Re: [RFC PATCH net-next v3 15/21] ethtool: provide link settings and
 link modes in GET_SETTINGS request
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
References: <cover.1550513384.git.mkubecek@suse.cz>
 <00e931c1ecd29bf302a190c7d7a3f2cbd0388542.1550513384.git.mkubecek@suse.cz>
 <f2f8ccdd-c8bb-7f0a-5df7-dd54359e859e@gmail.com>
 <20190221101425.GO23151@unicorn.suse.cz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <4397375c-3a61-e098-80a8-126e9cfeb52e@gmail.com>
Date:   Thu, 21 Feb 2019 09:40:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221101425.GO23151@unicorn.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/19 2:14 AM, Michal Kubecek wrote:
> On Wed, Feb 20, 2019 at 07:14:50PM -0800, Florian Fainelli wrote:
>> On 2/18/2019 10:22 AM, Michal Kubecek wrote:
>>> +#define ETH_SETTINGS_IM_LINKINFO		0x01
>>> +#define ETH_SETTINGS_IM_LINKMODES		0x02
>>> +
>>> +#define ETH_SETTINGS_IM_ALL			0x03
>>
>> You could define ETH_SETTINGS_IM_ALL as:
>>
>> #define ETH_SETTING_IM_ALL		\
>> 		(ETH_SETTINGS_IM_LINKINFO |
>> 		 ETH_SETTINGS_IM_LINMODES)
>>
>> that would scale better IMHO, especially given that you have to keep
>> bumping that mask with new bits in subsequent patches.
> 
> I'm considering going even further and using something similar to what
> is used for NETIF_F_* constants so that the *_ALL value would be
> calculated automatically. But I'm not sure if it's not too fancy for
> a uapi header file.

Adding new netdev features still requires defining two constants: one in
the enumeration, and one that resolves the bit to bitmask constant, so
this would amount to the same possible mistakes/errors being made here
by changing two lines.

> 
>>> +	if (tb[ETHA_SETTINGS_INFOMASK])
>>> +		req_info->req_mask = nla_get_u32(tb[ETHA_SETTINGS_INFOMASK]);
>>> +	if (tb[ETHA_SETTINGS_COMPACT])
>>> +		req_info->compact = true;
>>> +	if (req_info->req_mask == 0)
>>> +		req_info->req_mask = ETH_SETTINGS_IM_ALL;
>>
>> What if userland is newer than the kernel and specifies a req_mask with
>> bits set that you don't support? Should not you always do an &
>> ETH_SETTINGS_IM_ALL here?
> 
> In that case only known bits would be handled and the check at the end
> of prepare_info() would add a warning to extack that part of the
> information couldn't be provided (same as if some of the recognized
> parts didn't have necessary ethtool_ops handlers or if they failed).

I guess that is fair, I was just wondering if it made sense for the
kernel to report that there is one particular bitmask of settings that
it does not support at all and report that through netlink extended ack,
as opposed to silently not processing the bits it does not know.
-- 
Florian
