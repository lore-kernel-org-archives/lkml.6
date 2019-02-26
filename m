Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39458C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A5320863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4k/UyXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfBZOdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:33:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44769 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfBZOdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:33:11 -0500
Received: by mail-lf1-f66.google.com with SMTP id g2so9761500lfh.11;
        Tue, 26 Feb 2019 06:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uw9bd8eQ+dHr0d1TDSrbgdtLqzEzcdKxnUBAvUjAJUI=;
        b=J4k/UyXRHttSTpBfRpkLDSkyKbgGbJcw/D4P0nE3tROJcltho0LRyLMQz7O7jduy2F
         4A1kyXzN4UY2aZ5PNrPZEnZ4kDyVOlrNGSPYLdYLwJX5mRUxNeypfSdQeulmlPlhb+/J
         0dNXXF/G5puSarsPDGqZHpJuUWHU/d4gLKKig8nDGYMcLphyADVeY8yzNn/x8KldbpaP
         X3V2zwVlpYdvLfAtYUi//L6DlAixoKLNy7LT9fV8D0nvNSXMWVJjZz3aM+RHGoD9WotA
         iz2NuFryGq8Fr3pd1qfNlCYoo8rVkdQeEV1el2pG8YqN60pdngiwpgLlEn7wX/6HoSi0
         hIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uw9bd8eQ+dHr0d1TDSrbgdtLqzEzcdKxnUBAvUjAJUI=;
        b=SVfFlQSoSneGiEb0K9SeNLzgi5XIvXN3viBT/wIPXtTa0dxjtsO+v42KhZVRcKHTet
         gHeIhtcOCPQrP2sLkTboGgwvrjDfqarMS7FehP9uYn8q6t/Zf6lo8KGw6uN7absxQy0d
         ihidXuOuSzEe8z5DBpO+K5w9lnGL74lDC1zhxTrqsboq26mc8R2NO5c3pEaAX/mLt5nk
         uuTvhKObiQsNtyFXgAzCnjldo7ZOcowPqnV5ZXyZEF08YbPKkqvhGsecClQOckAuot0a
         6obECrpX5FmkScj/QvdIUxaXsSpx2WS3R6F9AdiQZPpdjj8/7Jvajpjl+qeOwX7iSIC9
         atZQ==
X-Gm-Message-State: AHQUAubCVArtOeTLZSQ/Zvu/TBBigXEy1kS4oswxUaO6cWBKFVFqdI+h
        at23VqUUxYl+zweczZqRlgXOjXOa
X-Google-Smtp-Source: AHgI3IZOrEMgRzNMG+kIVQZ/Mmy14a8IYc/49nSPlbdNCNSBQFxdPNRLgykNxAv83n2Lv55v9CpMAw==
X-Received: by 2002:a19:aacc:: with SMTP id t195mr2948817lfe.153.1551191588292;
        Tue, 26 Feb 2019 06:33:08 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id 5sm2471728lje.18.2019.02.26.06.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 06:33:07 -0800 (PST)
Subject: Re: [PATCH v1] usb: chipidea: tegra: Fix missed
 ci_hdrc_remove_device()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Peter Chen <peter.chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190224153622.8877-1-digetx@gmail.com>
 <VI1PR04MB5327FE97DC8C68B4D56DE0A98B7A0@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <20190225080715.4965810a@dimatab> <20190226105615.GA12397@kroah.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e7693387-9ac5-b2d8-0a0f-d507dfe05830@gmail.com>
Date:   Tue, 26 Feb 2019 17:33:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226105615.GA12397@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.02.2019 13:56, Greg Kroah-Hartman пишет:
> On Mon, Feb 25, 2019 at 08:07:15AM +0300, Dmitry Osipenko wrote:
>> В Mon, 25 Feb 2019 02:27:19 +0000
>> Peter Chen <peter.chen@nxp.com> пишет:
>>
>>>  
>>>>
>>>> Fixes: dfebb5f43a78827a ("usb: chipidea: Add support for
>>>> Tegra20/30/114/124")  
>>>
>>> I suppose you need to apply at stable tree too, right?
>>>
>>
>> It is enough to have the "Fixes" tag to get patch backported into all
>> relevant kernel versions.
> 
> No it is not.  My scripts do NOT trigger off of the fixes: tag, please
> read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.

Okay, my bad then. Maybe this is something that could warned by checkpatch.. adding Joe and Andy to the thread.
