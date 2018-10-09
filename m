Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D7BC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261DD2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZ78DhYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261DD2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeJJEWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:22:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53449 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeJJEWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:22:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id y11-v6so3230401wma.3;
        Tue, 09 Oct 2018 14:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aqK5TBC+SjN2bNfZl+kboPs6VvT5lDp3YQMUT/vfH0k=;
        b=oZ78DhYznSAkkPjR6DTjVtbvFZjuCvYbJdQC7zzHAdKjpJx/xnkrR/AGBUSwFfejLo
         IQRDsWF6DBDKqbGK0Nvg1ICvPhOJPc08Y3dKCSAn92vaM9Pl/wt16TpugKy9E7WeDuzN
         4bAPIoXBMJzAs5WgisXDBjUAHjPtAr+q6TENHHzBngaE189aeD9D6AFKvXUyDAD2fleC
         6qvRNDTo4oYPFfwgRiqamh1XiDxWRkoJT6PuLQl8Q+jcbGGIV6rSiSKkZ7ZOJAK05096
         3+Zb0Ch76/Mncpl71cgjmUiML1IoYEl7DwxuxfEmjCqConWEAafLfghc/LpIwGaEXWRk
         V88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aqK5TBC+SjN2bNfZl+kboPs6VvT5lDp3YQMUT/vfH0k=;
        b=X7oyu7S+y1xvmy5CZzp5o2K3hB/FoP35akaYuAz4luanaIVRqsgzxdiC/NTA+oAdze
         uAyxKwoYjvv1EqkIvVCr4vUaNZUN/QrfR/GiXW61yhx1M0BSxt+QSvSSqQ5RyRRcerms
         wCjB7clYPRDOpiNAAp0hAZyfa+74gXpJLLOrHLOCi6eMJt068+id0iJROB1PaR/0QI4A
         OR7oDVVBLRetjk2mhrMA82GJWAOIWmvtPB2ydLXfqG/w4qwdKAUBmiv2fN+zifIHL4As
         XvVlnzENiOG8XcokIApZsRzeak+R/npe7RnSXTNJgD1Yw/Vk5R47vu0WPKqJSlZ0kNOf
         9w7A==
X-Gm-Message-State: ABuFfoimqpVvI5rCCsaS50gqAFoSWlCppeBR+JxhrXRaLD9z8kiw/XLb
        8/1c6Djreiz9uQZ6YzMfqv4=
X-Google-Smtp-Source: ACcGV60o/FsxMIk2t3oS1Tgn8S+jPqeQ6IexkobxixjY4ujLsPswg5Oyb49I6U6GP4TxlE1GWxlF5A==
X-Received: by 2002:a1c:b7c1:: with SMTP id h184-v6mr3319961wmf.33.1539119031326;
        Tue, 09 Oct 2018 14:03:51 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-30-92.net.upcbroadband.cz. [86.49.30.92])
        by smtp.gmail.com with ESMTPSA id 16-v6sm23302288wrb.95.2018.10.09.14.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 14:03:50 -0700 (PDT)
Subject: Re: [PATCH 1/7] dt-bindings: mfd: ds90ux9xx: add description of TI
 DS90Ux9xx ICs
To:     Vladimir Zapolskiy <vz@mleia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sandeep Jain <Sandeep_Jain@mentor.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
References: <20181008211205.2900-1-vz@mleia.com>
 <20181008211205.2900-2-vz@mleia.com>
 <5631ac17-a1c1-af12-8b30-314880af42df@gmail.com>
 <4569f3e3-3812-f423-eda9-51e7a4d56a58@mleia.com>
 <d7536af1-d78f-6d20-81a0-288be1d67f25@mleia.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <c843687c-2897-464a-5ec8-a4f070b8e627@gmail.com>
Date:   Tue, 9 Oct 2018 23:03:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <d7536af1-d78f-6d20-81a0-288be1d67f25@mleia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2018 10:55 PM, Vladimir Zapolskiy wrote:
> On 10/09/2018 02:11 PM, Vladimir Zapolskiy wrote:
>> Hi Marek,
>>
>> On 10/09/2018 03:13 AM, Marek Vasut wrote:
>>> On 10/08/2018 11:11 PM, Vladimir Zapolskiy wrote:
>>>> From: Sandeep Jain <Sandeep_Jain@mentor.com>
>>>>
>>>> The change adds device tree binding description of TI DS90Ux9xx
>>>> series of serializer and deserializer controllers which support video,
>>>> audio and control data transmission over FPD-III Link connection.
>>>>
> 
> [snip]
> 
>>>> +Optional properties:
>>>> +- reg : Specifies the I2C slave address of a local de-/serializer.
>>>> +- power-gpios : GPIO line to control supplied power to the device.
>>>
>>> Shouldn't this be regulator phandle ?
>>
>> It could be, right. I'll ponder upon it.
>>
> 
> No, it can not.
> 
> The property describes PDB "Power-down Mode Input Pin", it is a control
> pin with the predefined voltage, so regulator phandle is not applicable
> here.

Then the DT binding document needs updating, because this is completely
unclear and confusing.

-- 
Best regards,
Marek Vasut
