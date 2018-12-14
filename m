Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC7FC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EA6206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgpSHsyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EA6206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbeLNFMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 00:12:00 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46829 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNFL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 00:11:59 -0500
Received: by mail-ot1-f67.google.com with SMTP id w25so4256417otm.13;
        Thu, 13 Dec 2018 21:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n8doylIzi8abXLgg/31g00Bs9s7hcD79O8dvOGYekzs=;
        b=RgpSHsyNSHGxp5yz+L4KTekjL0kvkx42OSw+5GZJs7hmsZ3xgY11Mcq8KgLzGMDzpe
         2TbgMwKR3XhRleSLa8qKFp9wRFsAiLn/xHEyQKeJ1wMcFA9m70QsM27PStP7N5dyVjRA
         YGwCijfDJu6lE+Z+qRk48KsV6syyjduGmuOmr9wTzhNNbIwnuRMVOx5KvJyzosjcCHQv
         liR07ELm2v60LyBiM0APNV/rpsHYbTiGVf1k4or74xIIzTTTFRlqZSghOhvfSkXRMr03
         Z6BraFFgCXm9RYUPYBE3pxu4Ty3JJ7JijcZD+weC+4SHxEPUQ30w8NAtasW5fRgPuTe/
         9IhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=n8doylIzi8abXLgg/31g00Bs9s7hcD79O8dvOGYekzs=;
        b=g0rERZFpl5B9voIGRlMuoKxywL4aytKO2FV4xrIFGNr4XRyrVX1pTZEUlwx+lOjgQb
         L8nx+PG/8LHyK15ig1y2G95mdTKbmq/e6cUgKxUYuZTmghTA7v2YhPmnsybIBmnBpHHK
         VMDfSSg8yAA6vGhlCDXGHrcqERC6q/jW14eo5vaeOGqpofN8Oo6QA2PnstYu44mAt9Yc
         aNxBLEH4/OiWdGzt+dRWiiGD4TG2J6/ySvjxMw9sMbJG2BIDrcVCvKpTUwlRo0RzrvJF
         KcmIKXX2vSvLlJ7iYKJt611nT+K4CiW58HOAWJcT2cGTb0TE995IgT13BcG3IoPdAjgM
         f2JA==
X-Gm-Message-State: AA+aEWbrVSU/sI+y5ITtKwGhcRR2FRYj2p4H/68ui2Ie58tZUajTw+Fz
        DlG87hlXANjWFkt3ID9KUUk=
X-Google-Smtp-Source: AFSGD/VrtvKCcU1Uw91jr/5thS8AaF5ULQm/x5k3eVsMld/gFAKvJVSFrWdv2GfdUykZQ7rpEXAYSg==
X-Received: by 2002:a9d:1715:: with SMTP id i21mr1080464ota.149.1544764318351;
        Thu, 13 Dec 2018 21:11:58 -0800 (PST)
Received: from [192.168.1.2] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.googlemail.com with ESMTPSA id r184sm1833286oif.56.2018.12.13.21.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 21:11:57 -0800 (PST)
Subject: Re: [v7, PATCH 1/2] net:stmmac: dwmac-mediatek: add support for
 mt2712
To:     biao huang <biao.huang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        nelson.chang@mediatek.com, netdev@vger.kernel.org,
        liguo.zhang@mediatek.com, joabreu@synopsys.com,
        linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
        honghui.zhang@mediatek.com, yt.shen@mediatek.com,
        davem@davemloft.net, linux-arm-kernel@lists.infradead.org
References: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
 <1544666173-5121-2-git-send-email-biao.huang@mediatek.com>
 <20181213123346.GF1605@lunn.ch> <1544756477.24219.164.camel@mhfsdcap03>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 a9BQwACgnzGuH1BVeT2J0Ra+ZYgkx7DaPR0=
Message-ID: <f3427cac-88b2-1464-8f92-4692a7125674@gmail.com>
Date:   Thu, 13 Dec 2018 21:11:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544756477.24219.164.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/13/18 à 7:01 PM, biao huang a écrit :
> Dear Andrew,
> 	Thanks for your comments.
> 
> On Thu, 2018-12-13 at 13:33 +0100, Andrew Lunn wrote:
>> Hi Biao
>>
>>> +	case PHY_INTERFACE_MODE_RGMII:
>>> +		/* the PHY is not responsible for inserting any internal
>>> +		 * delay by itself in PHY_INTERFACE_MODE_RGMII case,
>>> +		 * so Ethernet MAC will insert delays for both transmit
>>> +		 * and receive path here.
>>> +		 */
>>
>> What if the PCB designed has decided to do a kink in the clock to add
>> the delays? I don't think any of these delays should depend on the PHY
>> interface mode. It is up to the device tree writer to set both the PHY
>> delay and the MAC delay, based on knowledge of the board, including
>> any kicks in the tracks. The driver should then do what it is told.
>>
> Originally, we recommend equal trace length on PCB, which means that
> RGMII delay by PCB traces is not recommended. so only PHY/MAC delay is
> taken into account in the transmit/receive path.
> 
> as you described above, maybe the equal PCB trace length assumption is
> not reasonable, and we'll only handle MAC delay-ps in our driver based
> on the device tree information no matter which rgmii is selected.

Expecting identical PCB traces is something that is hard to enforce with
external customers, for internal reference boards, absolutely they
should have those traces of equal length.

> 
> Since David already applied this patch, I'll send another patch to fix
> this issue.
>>> +	if (!of_property_read_u32(plat->np, "mediatek,tx-delay-ps", &tx_delay_ps)) {
>>> +		if (tx_delay_ps < plat->variant->tx_delay_max) {
>>> +			mac_delay->tx_delay = tx_delay_ps;
>>> +		} else {
>>> +			dev_err(plat->dev, "Invalid TX clock delay: %dps\n", tx_delay_ps);
>>> +			return -EINVAL;
>>> +		}
>>> +	}
>>> +
>>> +	if (!of_property_read_u32(plat->np, "mediatek,rx-delay-ps", &rx_delay_ps)) {
>>> +		if (rx_delay_ps < plat->variant->rx_delay_max) {
>>> +			mac_delay->rx_delay = rx_delay_ps;
>>> +		} else {
>>> +			dev_err(plat->dev, "Invalid RX clock delay: %dps\n", rx_delay_ps);
>>> +			return -EINVAL;
>>> +		}
>>> +	}
>>> +
>>> +	mac_delay->tx_inv = of_property_read_bool(plat->np, "mediatek,txc-inverse");
>>> +	mac_delay->rx_inv = of_property_read_bool(plat->np, "mediatek,rxc-inverse");
>>> +	mac_delay->fine_tune = of_property_read_bool(plat->np, "mediatek,fine-tune");
>>
>> Why is fine tune needed? If the requested delay can be done using fine
>> tune, it should use fine tune. If not, it should use rough tune. The
>> driver can work this out itself.
> 
> find tune here represents a more accurate delay circuit than coarse
> tune, and it's a parallel circuit of coarse tune.
> For most delay, both fine and coarse tune can meet the requirement.
> It's up to the user to select which one.
> 
> But only one of them can work at the same time, so we need a switch
> flag(fine_tune here) to indicate which one is valid.
> Driver can hardly work out which one is working according to delay-ps.
> 
> Please correct me if any misunderstanding.

You are giving a lot of options for users of this Ethernet controller to
shoot themselves in the feet and spend a good amount of time debugging
why their RGMII connection is not reliable or have timing violations.
-- 
Florian
