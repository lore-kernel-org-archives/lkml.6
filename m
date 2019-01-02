Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25080C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4239208E3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 01:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6SQMiS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfABBGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 20:06:33 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42678 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfABBGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 20:06:33 -0500
Received: by mail-oi1-f193.google.com with SMTP id w13so24031691oiw.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 17:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eP53HkUfnJbMbDOqdwOiE8PUSZcdELMYr35RkAZBE5U=;
        b=q6SQMiS2Gtxvu6tTicHfl5cE/WMuZyRri6YSMqrD5k55/AY8pI3ZyJ1jHNUkkAp5t/
         BgITSku8ayBEq0f01aio4RWzk0fPbaW8glPZRaxIyckfLEwh/lkc3jp801vxTNNpqe30
         VWP98OgFXcQUxzC+FztAq2t//mDWYfx459VBwVVCU91GBKbr9GX5KkHXVXtZySAiSms6
         OVYHSSeiLgjVCNLhFk4PTi3E16xwVC7IgmckmixbfOe3v83Ly707HreAujJ6ZFfooaeI
         mBQFiR0UUTB93y2oiADVypJkLXGdpBdPw6Fso7zU6nT8BJ7FXOJTR4k9Jakm20nMJol1
         4oOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eP53HkUfnJbMbDOqdwOiE8PUSZcdELMYr35RkAZBE5U=;
        b=bMsDG1I/2UnCkd06GKPziVpX2kZDDF1gG/eRln0gZVzEBaZov/2XsBxebWjeGOy7Tc
         A/wWAdLa7ymZ4cN4QTJ/vtqzZIzw/D1yROlbBeWvNQ86h5V32CB+iSe9MWx6QB84kFxN
         f6nkzMbDB75OZrHmWCD43EH8dBst8rCNVe35oZPBxXx+x46bbfAyVzNjgdZm29Sx7sqo
         EmQYXn23wXFSViRKrcd99pReNIJFZw9IBEGg3Y76s+Z/gDpW3ehaZWgo69ltGFRGm443
         vyq2IlvVMeUsOeu+lHb6GjC6ptdAs/UkV3brD8GZXJBpPL7KZbt9Wwy5wqTWDrKo0FNL
         5nNw==
X-Gm-Message-State: AJcUukeYMgE808xrbGyQS+wunTCy9CeICDbX3oT6QOYVM7+bzvVInU3G
        xffJyInOnWkbrrbB+ALUo04FAlvk
X-Google-Smtp-Source: AFSGD/WK9raquBMfpCC7RvXOcmg5ry1tCxudZeYMyozNYyRftO3mlOMLaWlyr8ehAp79oxoV7tmlyg==
X-Received: by 2002:aca:1b13:: with SMTP id b19mr27500855oib.215.1546391192453;
        Tue, 01 Jan 2019 17:06:32 -0800 (PST)
Received: from [192.168.1.102] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id i7sm5674933oto.70.2019.01.01.17.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 17:06:31 -0800 (PST)
Subject: Re: [PATCH] Revert "staging:r8188eu: use lib80211 CCMP decrypt"
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     insafonov@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20181230183918.3888-1-straube.linux@gmail.com>
 <efbc3a4a-ce31-8785-73c0-3d89edc66977@lwfinger.net>
 <59368aca-c3d9-0563-aa83-118842834fb1@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <2aab932b-b4ba-2601-06de-ca095a549fb7@lwfinger.net>
Date:   Tue, 1 Jan 2019 19:06:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <59368aca-c3d9-0563-aa83-118842834fb1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/1/19 1:31 PM, Michael Straube wrote:
> 
> I've tested your patch and it solved the issue. No freezes and dmesg looks good.
> 
> I noticed that try_then_request_module() is also used in rtw_wep_encrypt() and
> rtw_wep_decrypt(). I guess that also could cause problems?

Yes, I believe it would if anyone is still using WEP. My plan is to get rid of 
the try_then_request_module() there as well, and for completeness, I plan to 
restore usage of the lib80211 routines for TKIP as well.

Once I get a chance to test the TKIP and WEP changes, I plan to have a set of 4 
patches to switch the driver to using lib80211 routines for all 
decryption/encryption.

Larry


