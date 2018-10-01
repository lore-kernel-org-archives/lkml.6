Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6B0C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86D62145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReirUECs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86D62145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbeJAXFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:05:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42334 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeJAXFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:05:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so9219597pgq.9;
        Mon, 01 Oct 2018 09:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CnAutBO2tBOSiYCjgeIpXNJNb7vzRST0LoY0asIuAZw=;
        b=ReirUECsLIFYAVYwnLT93iZPbMufxcIxKuozr1DfBtUFFsBL2D1p8BqAJRpHpkfdQ9
         uYZrtPqNzQbxg28cXwpLmPQQEWFLWQWm/dGBHgLPvTCQQ17UThYwUT9EiqDfJpkot/7Z
         W9bjyOLwzrGEOSGNxwUPFfd3FOIP/+MQh1KrM/07HyDiSseP82Z3GAMJ3jh/SgwnXlju
         X8hqI530bDmrw595obeGiU8EzNGdZa1rhKrZiRzd2OP6l3DeOBEZZIWXfcqc4ikX12Tt
         dPLq7xTnshig92ytNOvql3eBO1xViyxHQlj0TyTwOixo1SfoZICT+znDQnaiEu+SPlKT
         iVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CnAutBO2tBOSiYCjgeIpXNJNb7vzRST0LoY0asIuAZw=;
        b=cJ2cklTiI4zI6yWSb9z7jcTS4JJQJnig3W9GkRX+69Dlt75U3Jaa6+YUkJxp0uZvb3
         04qLhhIgVwIrwqqxiwWztfQEkdO001qo8XNJEBCDKAbLC4La66d7xWHLv5yyzi4DIoSr
         eRUp9fMtpn/C34OQh/JkVLIBx5Kg7rDTaUKj06YxFIS7kqFeWcwLU3TGlat+jq8bW82R
         rndzi0x77cpCYWpK/eGkRIcXTmYBxDdoDpELeNnMjHVOpLT7MwRabxOmBNuG48Dtt0bx
         7S9sG04++x0mzwvR53PxD2/vxS/qg2DtYX+Be0eesYm+fPNZ0zW2WAyzdrrwr+HCpCPf
         xrUQ==
X-Gm-Message-State: ABuFfojs9vwTP84GHtJOiRgPBjNzBQ5Jm0t7cOHvMa9nBiU1T2auMf1i
        1Gg9L/gAKV+bHCBHc+BZgmU=
X-Google-Smtp-Source: ACcGV617URAqILQhHO2o9m4ibh/AgS9DN7aGGxbE/vTeTjG5MNzzyxDiXPVcaTFcCF2rBQtFQ529vA==
X-Received: by 2002:a17:902:7682:: with SMTP id m2-v6mr7119986pll.281.1538411232999;
        Mon, 01 Oct 2018 09:27:12 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id i21-v6sm22202490pgj.55.2018.10.01.09.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 09:27:11 -0700 (PDT)
Subject: Re: [PATCH net-next 2/5] net: phy: mscc: Add EEE init sequence
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     davem@davemloft.net, andrew@lunn.ch, allan.nielsen@microchip.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
 <64809c5f01f3c6407257553a286b82949cef1ac0.1536913944.git-series.quentin.schulz@bootlin.com>
 <1321f1a0-57af-a059-f78a-a699da94c064@gmail.com>
 <20181001085136.qebnqu5kr3d5rgej@qschulz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <224c73b0-f2b7-0d38-7018-9dbf566b89bb@gmail.com>
Date:   Mon, 1 Oct 2018 09:27:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181001085136.qebnqu5kr3d5rgej@qschulz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2018 01:51 AM, Quentin Schulz wrote:
> Hi Florian,
> 
> On Fri, Sep 14, 2018 at 07:21:09PM -0700, Florian Fainelli wrote:
>>
>>
>> On 09/14/18 01:33, Quentin Schulz wrote:
>>> From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
>>>
>>> Microsemi PHYs (VSC 8530/31/40/41) need to update the Energy Efficient
>>> Ethernet initialization sequence.
>>> In order to avoid certain link state errors that could result in link
>>> drops and packet loss, the physical coding sublayer (PCS) must be
>>> updated with settings related to EEE in order to improve performance.
>>>
>>> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
>>> ---
>>
>> [snip]
>>
>>> +	vsc85xx_tr_write(phydev, 0x0f82, 0x0012b00a);
>>
>> Can you just make this an array of register + value pair? That would be
> 
> Sure, I'll.
> 
>> less error prone in case you need to update that sequence in the future.
>>
> 
> I'm curious about the kind of errors you're worrying about or have
> experienced. Do you have any particular example or thought in mind?

Since this is just a completely non documented sequence likely given
as-is by the vendor, there could be in the future an arbitrary number of
changes made to that sequence because reasons. It seems to me that
putting that sequence in an array, instead of having to produce the
right sequence of calls, inlined in the source, is more manageable, and
will lead to an easier process if back porting/forward porting is necessary.
-- 
Florian
