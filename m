Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DB5C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7AF20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/X/Sg6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7AF20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeKIMBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:01:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37883 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbeKIMBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:01:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id u13-v6so205441pfm.4;
        Thu, 08 Nov 2018 18:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g3QhBtf6jNvkA2GmYOUwsZB+KOpJk6PTtBMaxwVft6Q=;
        b=H/X/Sg6g06H2WW07LAu9Iew1lT/ZM3HKevP1ZQaTyf04+5dqNsG4cPv4YCdwGoQAwg
         TuRbTeT2nK5UnSafIe/ko2ZHApFrAylaMFQEV59zJkeKJE/OjaIf1WjgWlHKdODkoznz
         Ugpr6NpWHhG5iVBpJRzZ2WiVQykcYKA0EqnOZBXfOxIDbFPl5+giHDVI+ZJJ9i/KwPwP
         zQcQ9D7KnjJ0xK9+wnaSPJT+dO+SBr31hZEpEeU2olkD4faDaX5kVkueIw9oGMLPpigR
         Y2xKKkFyz7V7guQn//vpY0otk2qu/qTRVn3BNc1Paf37E2PIrGl/fuzjoGtMbVf/Uqoq
         NFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g3QhBtf6jNvkA2GmYOUwsZB+KOpJk6PTtBMaxwVft6Q=;
        b=E33f4yzlGWKL/JtXyTIkL3Iazm0PiAndrFwnNcBze30IpRLriv9ZZEhNJaVIUDGnH8
         365pmXJ6WL0ibihFvXktOlrjbpDbc4JPJpvMSdniEhv4dagphjDzVQew4ICjDjjhvcxA
         VGzvZced+K+A89I8I9z8iO/XcA1LEhB4CDP/puDCw3p+YI6J7H/LmawwU41/rn737ZCh
         yC3hGFUQmI8bC1qMsqLwZsRSzzcsCuoGTyqhB797I1AE9YvG4Uot2dwqaisKnUPJ7NWK
         ADhcGj9XsOo6uMK57BT+ELcek7iqi0g4Swcl4Zv4TK9f8XUC04rNm3uRTTfntxOagK4h
         QC3g==
X-Gm-Message-State: AGRZ1gJ2RLWVyxEKWdq3qTtoSd/4wmmuNU8yMt8QmrDIMspXieSMCsIk
        8bjE/k7/HZ2uG1GGZonwd3E=
X-Google-Smtp-Source: AJdET5ekUOkJTeuW3KPyGr7PH5GFvJVbgefOJodVPWkRntpU/40ISo/WDO8PBP3ycFCuG/69qQvWwA==
X-Received: by 2002:a62:9f42:: with SMTP id g63-v6mr6997765pfe.144.1541730154355;
        Thu, 08 Nov 2018 18:22:34 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id 67-v6sm5835334pfk.134.2018.11.08.18.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 18:22:33 -0800 (PST)
Subject: Re: [PATCH 0/2] sony-cxd2880: add optional vcc regulator
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Yasunari.Takiguchi@sony.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1541681410-8187-1-git-send-email-narmstrong@baylibre.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <5328b351-e768-6c4a-66c4-c5f6d5894244@gmail.com>
Date:   Thu, 8 Nov 2018 18:22:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541681410-8187-1-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On 11/8/18 4:50 AM, Neil Armstrong wrote:
> This patchset adds an optional VCC regulator to the bindings and driver to
> make sure power is enabled to the module before starting attaching to
> the device.
> 
> Neil Armstrong (2):
>   media: cxd2880-spi: Add optional vcc regulator
>   media: sony-cxd2880: add optional vcc regulator to bindings
> 
>  .../devicetree/bindings/media/spi/sony-cxd2880.txt       |  4 ++++
>  drivers/media/spi/cxd2880-spi.c                          | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)
> 

Please see Documentation/devicetree/bindings/submitting-patches.txt
for some helpful information about submitting a series that includes
a bindings patch.

You will want to add 'dt-bindings:' into the subject line, along with the
current 'media:'.  And getmaintainer will give you Rob's and Mark's
emails.

Thanks,

Frank
