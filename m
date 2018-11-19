Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9931BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0F22080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeNmUkdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0F22080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbeKTIfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:35:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39846 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731273AbeKTIfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:35:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id u13-v6so252311wmc.4;
        Mon, 19 Nov 2018 14:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b+zuIv7l9TT3YJiQGVNrsFlOdf3xmq/Rg2jzgeSGEm0=;
        b=GeNmUkdU3YXV+c/mZJ/2KNr0wuWTIH/HbQpNJGHBd9o5uwuTPIYiS79LjlTPa+J4hD
         Rmjmm6YL5ipKbe6dXREQN+sCskwTTfcZ9cTIVB7FwmftUGSvS/FiRQRqmNWIsZaqa0Gv
         x9sbhOZGK9pG/qMGW8nvjVVktUDgQtOf6lE5X8fe80fI1I0vCbTZB3d7IYzW/4loW3E2
         6Ei8vRv+mcrHG2pEYXkBdjDUr5cHSuGaxhcaFKPAEa5ixaPqCuvAuP+0GcTiwfU6gsKr
         B5L3oRGK0iOC5YqVo9l2yF3PowtbJ93XAtxws2rRwJn7r2qGzbwx8RE0TYNNl6lWvIE8
         Jq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b+zuIv7l9TT3YJiQGVNrsFlOdf3xmq/Rg2jzgeSGEm0=;
        b=EnUwYPjaz2H8VTNjA9TIuq473MZcwt6azb2jJRuJobXUtyKU/OWRqo/dQMDHVxRmtk
         DIyxAgR9ZNJzG1UcoB5o/V3LIs4PSB27VP6N9mGa1XNoupZmIl2kE2eEd5nQjzR74T9e
         cjRFqaLycUuK1p5+bKHD5CM+Xx3Hg/LvwppZ0rNWThVVzIrZW75xS2UO6ISNdixz0iUp
         /oUo8Rgs80wVfa2tGGxTdqeG5tUKWg7Y+eMDZWXVIw1oRp6BqMFNd37aUvMgLQHU18RQ
         wzT14Ew2Tdqfq3OV4rYOr4bZKlL3ZMuaWI/Loo9EJrpkdKQOJTL2/RaAF6UigXXl6VFu
         yMEw==
X-Gm-Message-State: AA+aEWZoRQ36Da6sbpmM729Js138ayMnuJYixczUBs98+tG8XCEp+Ni/
        gNrZWC34zbSFU/QlujMPKsk=
X-Google-Smtp-Source: AFSGD/Xx7Y9/7nyeE+bKIt/Cxlf7fZgZ1F2vBChF/wu+73kw6SAqBpWAEQ22uLaO7UqwOS75TjjPyQ==
X-Received: by 2002:a1c:c701:: with SMTP id x1-v6mr8970317wmf.116.1542665406405;
        Mon, 19 Nov 2018 14:10:06 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id b7sm9898161wrs.47.2018.11.19.14.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 14:10:05 -0800 (PST)
Subject: Re: [PATCH 1/2] spi: Add Renesas R-Car RPC SPI controller driver
To:     Mark Brown <broonie@kernel.org>
Cc:     Mason Yang <masonccyang@mxic.com.tw>, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>, boris.brezillon@bootlin.com,
        juliensu@mxic.com.tw, Geert Uytterhoeven <geert+renesas@glider.be>,
        zhengxunli@mxic.com.tw
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
 <1542621690-10229-2-git-send-email-masonccyang@mxic.com.tw>
 <0223f43b-c6a6-eade-49af-4e7b7ef7f022@gmail.com>
 <20181119152735.GB3535@sirena.org.uk>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <cbbc3dba-7f85-c6a3-525f-01eb23e50592@gmail.com>
Date:   Mon, 19 Nov 2018 23:10:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181119152735.GB3535@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/2018 04:27 PM, Mark Brown wrote:
> On Mon, Nov 19, 2018 at 03:12:00PM +0100, Marek Vasut wrote:
>> On 11/19/2018 11:01 AM, Mason Yang wrote:
> 
>>> +++ b/drivers/spi/spi-renesas-rpc.c
>>> @@ -0,0 +1,750 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +//
>>> +// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
>>> +// Copyright (C) 2018 Macronix International Co., Ltd.
>>> +//
>>> +// R-Car D3 RPC SPI/QSPI/Octa driver
>>> +//
>>> +// Authors:
>>> +//	Mason Yang <masonccyang@mxic.com.tw>
>>> +//
> 
>> Fix multiline comment please.
> 
> The SPDX header needs to be C++ style so I push people to make the whole
> block C++ otherwise it looks messy.

OK, I'm not gonna wrestle you on this, but I think it looks horrible ;-)

-- 
Best regards,
Marek Vasut
