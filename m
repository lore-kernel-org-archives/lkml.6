Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AA3C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3A32081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwQBnEXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3A32081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeLEM55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:57:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40323 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbeLEM5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:57:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id q26so12727913wmf.5;
        Wed, 05 Dec 2018 04:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RKdwNK2b8mJnvFHXU6qTocHfZAw0ZSH4k1OSJ01iJfQ=;
        b=JwQBnEXguiEtToqcIQloi8j1rNI3cY1hL/PLq9Jh5w3saNCw0gnBmpPvdYkRLUa4HS
         s+lzMvfWH65bJX7pruLriUuk+zc0TOSyT6Ac9b1LikBpN18g2rJkoa6jLkaOKEEvFumD
         6q/C6/MtjXyYOTBi8CEOpFZegkGtSMRszlkAxMysjC6L9MMO8sc+4RTlgY3LYgOlXxNr
         U23/lWvgrZgDwrvBBAIq6siqFXAPnhwJlEPyHyERBJV8ObGa6gEEZA4wRVRN83Z8+HNY
         464Par3cM2iuOvc1UNJx+MgZ76MIJ/3s4WxVtiSLr33nemWPCHD6aUBTx8OgHUwD3MDf
         Cucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RKdwNK2b8mJnvFHXU6qTocHfZAw0ZSH4k1OSJ01iJfQ=;
        b=GPEESh/Q9Ri6CrkDg/Z2PplcvHdpM/wosAKZlzLVvba1Zl4kbYoaIv9tVMXHEPhjeD
         mDPZBVlniM6PDnT4c1345dqeoz295BwYcGrgiCfOSym9D1xqhp/Jz4RQ2gZxVXPv91cW
         xiTTBOAnEJddEVAqMn9cbKIGWv43xpt+0I5+4sejnYlKb7tYP+PDHoqOd+u4XQ9QNvIK
         +EN/vCiWvPLdNNJSWYUWdopSbUtEpW90H+bn8+lXwMT86NM6JbQC85ZfwWKwkP5BoU6M
         mwIv+0A1hYEFibJ4FAGlGJPohd4RskQyuu6Bcavdrjah4UgTjlG4oBZiqF3cMKY5bfAq
         cnrQ==
X-Gm-Message-State: AA+aEWYLFn5jic0tUzvEM0QRV6nObsqDVKSoyEj+uU9BoAmBVnlR8pSE
        0m0y/RBHo2U7e5hkVWgqNphQVCKl
X-Google-Smtp-Source: AFSGD/V2G2eD/GDRHf/2vRtG4f11RmyU8fmpzz2xOL160LKSERzo4msiN2vNfwXPTvz2W3pTlfEKhA==
X-Received: by 2002:a1c:f518:: with SMTP id t24mr16330839wmh.118.1544014672198;
        Wed, 05 Dec 2018 04:57:52 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id j6sm20543909wrw.30.2018.12.05.04.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 04:57:51 -0800 (PST)
Subject: Re: [PATCH v2 2/2] dt-binding: spi: Document Renesas R-Car Gen3 RPC
 controller bindings
To:     masonccyang@mxic.com.tw
Cc:     boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, zhengxunli@mxic.com.tw
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-3-git-send-email-masonccyang@mxic.com.tw>
 <2e719883-4cfd-b456-b894-853e99515092@gmail.com>
 <OF71F19EC8.23C369C1-ON4825835A.002EB699-4825835A.002F949D@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <4976dae8-222f-b7a1-ca5b-4abf3c5f26db@gmail.com>
Date:   Wed, 5 Dec 2018 13:53:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <OF71F19EC8.23C369C1-ON4825835A.002EB699-4825835A.002F949D@mxic.com.tw>
Content-Type: text/plain; charset=big5
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2018 09:39 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> "Marek Vasut" <marek.vasut@gmail.com>
>> 2018/12/05 ¤W¤È 10:04
>>
>> To
>>
>> "Mason Yang" <masonccyang@mxic.com.tw>, broonie@kernel.org, linux-
>> kernel@vger.kernel.org, linux-spi@vger.kernel.org,
>> boris.brezillon@bootlin.com, linux-renesas-soc@vger.kernel.org,
>> "Geert Uytterhoeven" <geert+renesas@glider.be>,
>>
>> cc
>>
>> juliensu@mxic.com.tw, "Simon Horman" <horms@verge.net.au>,
>> zhengxunli@mxic.com.tw
>>
>> Subject
>>
>> Re: [PATCH v2 2/2] dt-binding: spi: Document Renesas R-Car Gen3 RPC
>> controller bindings
>>
>> On 12/03/2018 10:18 AM, Mason Yang wrote:
>> > Document the bindings used by the Renesas R-Car Gen3 RPC SPI controller.
>>
>> RPC is SPI and HF controller, it is not a pure SPI controller.
>>
>> How does this deal with the HF part ? Keep in mind the bindings are ABI
>> and it will be difficult to redo them later.
> 
> After checking HF datasheet,
> 512_MBIT_256_MBIT_128_MBIT_HYPERFLASH_FAMILY_Datasheet.pdf.
> 
> 
> 
> From my point of view,
> HyperFlash is a kind of standard NOR Flash with high-speed SPI interface.
> But I might be wrong.
It behaves as a Parallel CFI NOR internally, and so it fits and works
with the CFI NOR drivers (see the U-Boot driver), except the interface
between the HF controller and the chip is custom. It's not SPI per-se.

-- 
Best regards,
Marek Vasut
