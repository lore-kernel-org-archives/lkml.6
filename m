Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F9FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEB420879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ln4bour8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBEB420879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbeLEVzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:55:20 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41251 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeLEVzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:55:19 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so21249592wrs.8;
        Wed, 05 Dec 2018 13:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sWAV2BQAJuJlzieNWBGgQ81AB58d98Vp91Vvd79XgpM=;
        b=Ln4bour8y1LwcE6mI8hFFj3sPWDC3j4YvGDvjpsfwqhlJ1LIdrEdGaX8IXqHhGA7et
         aNaMk5syRQooW7R6d/aniEq6j0+lzZBWdAeZMDxxxoLjAf8wJWrEUrDEiazVCb6NOtLB
         jsFTjcjABUdSmgU9ZsNktmqHucirN+lenb3CDO/LfWpqr3DjejwfOp5d92WsCcxQPV1C
         3eXJfHrT4zMaw2VTgZ2T6wVLmGRGDntbyYL+IIF4zXjQfFR3lv3b7PGtZ6hZTDioH2m1
         pK2GEl59T+l8AhBpKVZVXBzfY7sCIWONSi6P6H/vYW7cw/0esL5VoKqUy/67Pg4Zj9iZ
         ytMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sWAV2BQAJuJlzieNWBGgQ81AB58d98Vp91Vvd79XgpM=;
        b=DP2UkO6CAUaFwsHNBV95uRJ3SWw4lFbmIJ+K/zaYyZ8QKuzn6AHBR00dbQ562oMFv6
         QWJ78g/0s3IKeyBu91aikK1dV/gOxVbVr6dIBcYNKvPnQ82X8Be9HYcfwnBEQ/JTvjwy
         iHHRsDSREhJh53j/hD8fYcEgvSoK7om4r0eh0upZ3P/97OeqjUUzBkjorsywiUQNahei
         TrjQfdxI3UYxxyg4yl2RpF/eH/Q6+CDfM0K5W+oS5pxnRJvD0rppVuc2qCxrBszWk6c6
         O+Fk1RDfSY+rK137BPK1HsYYUEBdhI4fG+8nC90rsrFkqq6cpMKcwFpBlhkbu9K6o2FL
         NgWQ==
X-Gm-Message-State: AA+aEWa23C68S0uFh8ZeqIleGHyjbTrIoGBteIKuF8yTBmXMp8hdhmB4
        hddqc2jI4yduzKqulbnx/u9Hjoi+
X-Google-Smtp-Source: AFSGD/VRDrQy3Z+kicmaBrikFsvT7MiJLri7MwzBQVb25orYcyGJnW7MHX2XbZQHrX4BSZx+BGj/Nw==
X-Received: by 2002:adf:f5d1:: with SMTP id k17mr24898053wrp.59.1544046917607;
        Wed, 05 Dec 2018 13:55:17 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id j14sm18969742wrv.96.2018.12.05.13.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 13:55:16 -0800 (PST)
Subject: Re: [PATCH v2 2/2] dt-binding: spi: Document Renesas R-Car Gen3 RPC
 controller bindings
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        boris.brezillon@bootlin.com, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-3-git-send-email-masonccyang@mxic.com.tw>
 <2e719883-4cfd-b456-b894-853e99515092@gmail.com>
 <8de55806-ee08-69c6-df1b-45b1eba607a6@cogentembedded.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <c1c8fc5a-3829-01ee-5ac4-cb6ab154bdce@gmail.com>
Date:   Wed, 5 Dec 2018 22:55:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8de55806-ee08-69c6-df1b-45b1eba607a6@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2018 07:56 PM, Sergei Shtylyov wrote:
> On 12/04/2018 09:19 PM, Marek Vasut wrote:
> 
>>> Document the bindings used by the Renesas R-Car Gen3 RPC SPI controller.
>>
>> RPC is SPI and HF controller, it is not a pure SPI controller.
>>
>> How does this deal with the HF part ? Keep in mind the bindings are ABI
>> and it will be difficult to redo them later.
> 
>    Perhaps we need a "mode" prop, maybe w/vendor prefix? 

Or, like I said last time, discern it based on the DT subnode. It can be
either SPI NOR or CFI NOR.

>>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> [...]
> 
> MBR, Sergei
> 


-- 
Best regards,
Marek Vasut
