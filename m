Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FF4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4F2206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXcKbxBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfANUR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:17:58 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44396 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfANUR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:17:57 -0500
Received: by mail-io1-f65.google.com with SMTP id r200so236688iod.11;
        Mon, 14 Jan 2019 12:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=F29jFLdAuPQ8chk11jDxup2570edwRGoQbpMM9uafmA=;
        b=hXcKbxBYn2I0epxMdLz7AeHF9MBW4wP4rWWlGoq8cwqolwSVjxQCjbhPiOBUBA3d/S
         S6/Gj/CTNyzlB1chcG64rpVtu49vk89vOwGaF8P+Iwl8szCJRIhhc1m39NRglC1uCma5
         9VNMyETtRGfnk/Ht0ps25teaOZAcpIhMwJ0eYv9Ew2I1pAx62tqNpuAPZa+NtwSGAK9t
         gapSaUSR9uP1tK3A/PgJF3JrARXw4SSnFqxp5/Scx2bqNa8U33pgfMgRKxN738nO5UDY
         +sg6wsYCk5ZlmT2Pym2ZB98/6T1jpYT3jfWNtPHLYFE2Hn5RmQfmT48QtdEgXmRiLdr8
         XT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=F29jFLdAuPQ8chk11jDxup2570edwRGoQbpMM9uafmA=;
        b=GQCuYy+rCdUxO1srOjsd72wGI8EoMtVxUK1dNGi0EDIIlejX31VkTVIZtySj0upi7A
         n5LmmFQJmcIjrhAo7JnJNiYzDyraCgn0oAtOvFzNl8M37vQ5fn719mzt3F7z90NtrwxH
         CYiFlFMEEW8FPE9+i0eFFfz6dIST3904r/Icve71dcUSheTsNW5DTJmq/rfXh8s5AiPT
         OkJGQGIqWxnydXySgUCB/B+NBXfMtJyl0jZXMKxzLu57pydoE8PE0QETnW1r+1fpYEdb
         zv3OTAH/imB781cVq2SlVecqOR721hmqwNtJLOTdru5xAmuTRvp3TY3RvJ9QGaeUIFsH
         6tOw==
X-Gm-Message-State: AJcUukcoa2Lgw2596U3ef6qfb+tegW1EK7973gJSoZZrVUyKeYBMIr7e
        IH4+wYCqCARQyD3AONVwjN0=
X-Google-Smtp-Source: ALg8bN7PXz+XCuBZxtjgoPKKZQJsqZW+zuoADBpn0tccsZaVe0zONo2EXILZTBr6sMQdcyjkP3O6Iw==
X-Received: by 2002:a5e:c00c:: with SMTP id u12mr157226iol.152.1547497076534;
        Mon, 14 Jan 2019 12:17:56 -0800 (PST)
Received: from [192.168.1.133] ([67.218.223.154])
        by smtp.gmail.com with ESMTPSA id g21sm662855itg.44.2019.01.14.12.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 12:17:55 -0800 (PST)
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: chemical: Add bindings for
 bme680
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, himanshujha199640@gmail.com,
        mark.rutland@arm.com, robh+dt@kernel.org, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de
References: <20190111205359.14158-1-sebastien.bourdelin@gmail.com>
 <20190111205359.14158-2-sebastien.bourdelin@gmail.com>
 <20190112182837.4cc42743@archlinux>
From:   sebastien bourdelin <sebastien.bourdelin@gmail.com>
Message-ID: <4768d945-61aa-a8ab-3e41-68b4f861cc69@gmail.com>
Date:   Mon, 14 Jan 2019 15:17:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190112182837.4cc42743@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/12/19 1:28 PM, Jonathan Cameron wrote:
> On Fri, 11 Jan 2019 15:53:59 -0500
> Sebastien Bourdelin <sebastien.bourdelin@gmail.com> wrote:
>
>> BME680 is a pressure/temperature/humidity/voc sensor.
>>
>> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
> Hmm. We could add the VDD and VDIO regulators perhaps.
> Driver assumes they are on currently but we'll get a board where control
> is needed sooner or later.  I'm not that fussed about this though.

If that's fine with you, i prefer to leave it as it is right now as i 
don't feel

confident enough to correctly explain it in the Documentation.

But if you have more input, you are more then welcome!

> Jonathan
>
>> ---
>>   .../devicetree/bindings/iio/chemical/bme680.txt       | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/chemical/bme680.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/chemical/bme680.txt b/Documentation/devicetree/bindings/iio/chemical/bme680.txt
>> new file mode 100644
>> index 000000000000..885a1b918340
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/chemical/bme680.txt
>> @@ -0,0 +1,11 @@
>> +Bosch Sensortec BME680 pressure/temperature/humidity/voc sensors
>> +
>> +Required properties:
>> +- compatible: must be "bosch,bme680"
>> +
>> +Example:
>> +
>> +bme680@77 {
>> +          compatible = "bosch,bme680";
>> +          reg = <0x77>;
>> +};
