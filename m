Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B28EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AB021871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 06:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY6uJE0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfABG12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 01:27:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42837 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbfABG12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 01:27:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so29441581wrx.9;
        Tue, 01 Jan 2019 22:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OcOjC7YEo9+DYe6xj4Vupdm3WlIbEZgGiT5bP/uH288=;
        b=iY6uJE0hrBYkg4CYP1NNM7XC4ypx+Z4VdARKP2hQzb7a1gTX3efcTCl1CxiS+WiUzi
         e4ccmuUAc5ouUkoKkCvUmD8c7L+IBpHaFvCg3OrOdIz1yw+G77EHW0jH+yFojbXzAWrK
         p2TXa7ur/q7/jSFn1t5KyuQXpqTx5e8NSRETNbeLoIhc8RkgbFSdLLdkiIeCr6C7u3Jx
         5usFE2UyowrmMrrTxyH+IXs1UPkcVcRxp3axzeI9+oGq9+6Kl6aew06CSSGDcjt+7o0s
         4TMRNsWKjw5abSjeFmzppse83j1Va0xfx3uvOgYZ2Rq+qoTx+oidcu+NdD5OPeCC6JDY
         tIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OcOjC7YEo9+DYe6xj4Vupdm3WlIbEZgGiT5bP/uH288=;
        b=YgquFbJzsQITNG4DSYDZ0x0xKaieY3rPV7M12KRXpKznmYXBos6hyaaQf6MepJjba4
         ZYxX4UQr3/l0f52RjrcGe8U1g0c4xjsASh5qwBKdix9mkOkSh3uw909hEwEPyKq3QwBF
         MEmz2Oj382WwulzyVJ4wVRZNZ06fXgNtDx8L9r4clNhJYhziK1oII3qsnGGzni+LQn+w
         Vo8ko4asR0xFlvFdTnJ2mlQnQxUMu9vrr2eyhnQD0BPEwd71LbTWqS4sOlijXS5wwuCE
         eKkIvuwS4WgNpnmZ/T3Ukxtpk3pTw1s9Bh2c67MszfekWPEb1JxnOzmG0BTLqVf2JAdY
         P17Q==
X-Gm-Message-State: AJcUukczMC7dmo/yjtWlSY9BstZooAa9QtlBi0oCbYAE7vJWisqvhc7t
        4DaRos59WULBP0UOeNqN0T9AIM1w
X-Google-Smtp-Source: ALg8bN5esvkaGlwfsICPhAPxH7FhBgRQXJkTOgmtTir35DxDbbzTOWkWS6UvYFcENZEq829bljsFhQ==
X-Received: by 2002:adf:93e2:: with SMTP id 89mr39061290wrp.129.1546410446081;
        Tue, 01 Jan 2019 22:27:26 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:69f4:a4f8:2a0b:9c77? (p200300EA8BCFE30069F4A4F82A0B9C77.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:69f4:a4f8:2a0b:9c77])
        by smtp.googlemail.com with ESMTPSA id l14sm107002552wrp.55.2019.01.01.22.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 22:27:25 -0800 (PST)
Subject: Re: [PATCH] net: core: Fix to store new mtu setting in netdevice.
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Murali Krishna Policharla <murali.policharla@broadcom.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "amritha.nambiar@intel.com" <amritha.nambiar@intel.com>,
        "ecree@solarflare.com" <ecree@solarflare.com>,
        "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1546324934-17555-1-git-send-email-murali.policharla@broadcom.com>
 <b2127534-4e9c-1fef-27f1-72329595c3a3@virtuozzo.com>
 <bef4af12-f5ce-35ec-8d04-395a281e4322@gmail.com>
 <20190101233608.GC22737@lunn.ch>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <7fe3a751-ffac-c46a-44f9-a1659e3c6947@gmail.com>
Date:   Wed, 2 Jan 2019 07:27:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190101233608.GC22737@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.01.2019 00:36, Andrew Lunn wrote:
>>> Is there a .ndo_change_mtu callback, which does not assign a new mtu itself?
>>>
>> So far all drivers have to do it themselves. But IMO this is more a workaround
>> for the core not doing it. It's something the core should do.
>> Now we can remove this from drivers.
> 
> Hi Heiner
> 
> I think somebody first needs to review all the ndo_change_mtu
> implementations and check that none do something funny like round to
> multiple of 2 or 4 to satisfy DMA restrictions, etc. If there is such
> a thing, we cannot easily move this into the core.
> 
>     Andrew
> .
> 
Good point. I briefly grepped over all drivers and it's not that many
drivers not using the standard assignment dev->mtu = new_mtu.
Some are doing things like dev->mtu = max(new_mtu, xx) what could be
achieved easier with an appropriate max_mtu setting. But that's a
different story.
And I was under the impression that such things had been checked
because the patch had a "Reviewed-by" from Florian (although he
wasn't on cc).

Heiner
