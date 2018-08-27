Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AF5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30882082B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Abdv9Y+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A30882082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbeH1A5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:57:49 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38705 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeH1A5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:57:49 -0400
Received: by mail-qk0-f195.google.com with SMTP id g197-v6so312503qke.5;
        Mon, 27 Aug 2018 14:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BVMpPlwaCbsCtbp0Ia/CsGe6ytHKXsAFvAz+jg2W6fM=;
        b=Abdv9Y+CRSO4PVPTKggoxG5wqs+WE+5gfazh6dl8cMJ9mE3GCBBJ/8zDlDuH3bYqmu
         BwbC5FRbuE2/uyvaA4u4DY3pBX3teogHiwd525xx0WQ2dSXDyFysUEvUngZHe1v6swkD
         /tGH6fcKZYViLcUHlBDRyI27RkCqloGodNmtAp2cIJ+0WjCqhUIc9yHdjxdicnHdRKLe
         F1JPM2EZRnZDIsK+YeC9fq3kUB8Qdw08Y1TYzp1RupXHrIJZX0C8cQp/J2RF23NJlJbL
         wAP2EkyeZCbxYMj7sWYf95j7600JoHCdrhTdMVppLj/1NUusTT8mVwBvkCFR0TmJB3vV
         ppfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BVMpPlwaCbsCtbp0Ia/CsGe6ytHKXsAFvAz+jg2W6fM=;
        b=PWEmAcVdZm8+cYegUEpRJR7ediZlUfUu/Q2J0qf1SapTnSHEW+Une6VRl2DZJmyJGq
         brNt55zgS9RFfNyrfd3Cvt7Rh9sZcdcjpwyOHrxlxLuxVWJFu8NLXdJ60n0bIHhbQTIx
         0g01uuYpCS5qd25OENuugXWQHM8xzJUguIb5bfnSqhEZVAEtp8WcKyru5cK151qPpK23
         W5jk+lmweHAI6cMsjM4/nklVIRympP02QDEvrr6HD83xMafYMMaJrfdCePehxtPmE41K
         j57XNxmO3jGifn202i8mLRd5hu0UGIgNQ/iA0h9sKxNih5TJfVyKV97gC0LeQEQx4MWX
         s5Ig==
X-Gm-Message-State: APzg51Duh7E/jXg8vs359snUMgKd62K7eJa/TIMjwuLBj19xEx3R0/9U
        HUOKK/Y/GbgePa5Pxg9zHpg=
X-Google-Smtp-Source: ANB0VdYJWF6KADngwrbkQ5CQjMc5c2H9YvOvNFTSVKfE3M80km/exFl6SFWML/488PDHz44ZOpI+ww==
X-Received: by 2002:a37:3492:: with SMTP id b140-v6mr102199qka.355.1535404168972;
        Mon, 27 Aug 2018 14:09:28 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id j88-v6sm203387qte.49.2018.08.27.14.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 14:09:27 -0700 (PDT)
Subject: Re: [PATCH 1/3] ARM: dts: NSP: Enable SFP on bcm958625hr
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        rmk+kernel@armlinux.org.uk
References: <20180827200344.16158-1-f.fainelli@gmail.com>
 <20180827200344.16158-2-f.fainelli@gmail.com>
 <20180827203500.GN27483@lunn.ch>
 <4a0e7b46-f7b6-3e9a-5f67-8160537482c8@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <455621d9-5021-5d54-12d6-661dfe152bde@gmail.com>
Date:   Mon, 27 Aug 2018 14:09:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4a0e7b46-f7b6-3e9a-5f67-8160537482c8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/2018 01:52 PM, Florian Fainelli wrote:
> On 08/27/2018 01:35 PM, Andrew Lunn wrote:
>>> @@ -210,6 +228,17 @@
>>>  			reg = <4>;
>>>  		};
>>>  
>>> +		port@5 {
>>> +			label = "sfp";
>>> +			phy-mode = "sgmii";
>>> +			reg = <5>;
>>> +			sfp = <&sfp>;
>>> +			fixed-link {
>>> +				speed = <1000>;
>>> +				full-duplex;
>>> +			};
>>
>> Hi Florian
>>
>> You might want to add a comment about why you are using fixed-link and
>> sgmii, which seems very odd. Is it even correct?
> 
> Probably not, this is kind of left over from before adding the sfp
> phandle, but if I do remove it, and I can see the DSA slave network
> device fail to initialize, likely because we destroy the PHYLINK instance.
> 
> AFAIR, when we talked about this with Russell, I did not see why we had
> to comment out the following:
> 
> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
> index 962c4fd338ba..f3ae16dbf8d8 100644
> --- a/net/dsa/slave.c
> +++ b/net/dsa/slave.c
> @@ -1227,7 +1227,7 @@ static int dsa_slave_phy_setup(struct net_device
> *slave_dev)
>                         netdev_err(slave_dev,
>                                    "failed to connect to port %d: %d\n",
>                                    dp->index, ret);
> -                       phylink_destroy(dp->pl);
> +                       //phylink_destroy(dp->pl);
>                         return ret;
>                 }
>         }
> 
> maybe you know?

Stupid question, if we have a "sfp" phandle, must one also specify a
managed = "in-band-status" property? Under what circumstances are not
these two things implying one another (SFF maybe)?

That would explain why the code path taken from phylink_of_phy_connect()
would not return 0 and we would indeed fail to connect to the built-in
DSA MDIO bus.
-- 
Florian
