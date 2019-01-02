Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3BEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33329218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQUSybQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfABTdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:33:35 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35926 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfABTde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:33:34 -0500
Received: by mail-lf1-f68.google.com with SMTP id a16so21721013lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 11:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ykhl4yI0C0z1TnNb528y9cWPzujaQQUM96oyXJXeV+I=;
        b=NQUSybQFbvNiPdZDlGvyz5Vca07eb28gsDJliGANH801XEHB3Hd6eUlcynEr0AftV2
         H8yhbj0rJN2br6ctTreYm/DSP43H8p/OKBTo79+uOAwUUfxUjgNbeFiTsJjzEmBwEnGj
         WKDz5fDIxD4pp2Z6VlYCqEzY27g6NERj4crWx2QDpNkj8AU56JbeiEe2IPGKlbsOIFiJ
         7TvQaeUK2JiO8JmZkE8aYrjcOpoYRKKGhcKFgDrulTUkQZo3T64FiAdwFMoMiE0fIZbP
         xDVwzA+C3Rp6PGCkkNjYI581r5YbVrKxvHfXhumGX8qpHTS28AM3XEY+xeHvQFU/bPQ9
         LBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ykhl4yI0C0z1TnNb528y9cWPzujaQQUM96oyXJXeV+I=;
        b=cXrg4G+7TxtyfYX3yDig1eeQr79XXV1AhVf8ImTshqDuVD36xNTnVVTYWYMdQ6qFka
         3J8DJ4ffnc5TrqhVSk4uwciYnVG0sdIiEOjxJEswzx/gXWJHjvQIxWMbDkrU9qP4UZnt
         re5TSsr1B7umCOsNBJIZBCmD37kvoBLYLkfjgKoK2mSVedLYeEPtLRA/SfwZaT4oNI6b
         qcSJCHKpHO+ho6iraS3JX2FpEcTwwtUJMPoZ481wQDnSPfb2g9Cy6drUNBgBrUD5oyZt
         POZm8p8wybXXLllkJqIfmOKlP3yo5Q+sOkPR5j/TjsGBBejjMFTpaFfgIICExRn+gRSm
         pleQ==
X-Gm-Message-State: AA+aEWZFLl6mM+CW/BLTAvA6kav3hyaslJR6uXNdHk75FRDUqoZ/FhEz
        BT52EHywqUXIJkHjR12hd/fNkVZm
X-Google-Smtp-Source: AFSGD/X+LJxUCaa4sxcSziVPm+wzIGBz/2CBQlpeNZgVC8MVW2ijOm4mf9IeKdyhBhgHfSIBSse2tw==
X-Received: by 2002:a19:ced3:: with SMTP id e202mr21780398lfg.13.1546457612189;
        Wed, 02 Jan 2019 11:33:32 -0800 (PST)
Received: from [192.168.0.160] (ppp89-110-27-163.pppoe.avangarddsl.ru. [89.110.27.163])
        by smtp.gmail.com with ESMTPSA id z64sm10045004lff.39.2019.01.02.11.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 11:33:31 -0800 (PST)
Subject: Re: [PATCH] Revert "staging:r8188eu: use lib80211 CCMP decrypt"
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20181230183918.3888-1-straube.linux@gmail.com>
 <efbc3a4a-ce31-8785-73c0-3d89edc66977@lwfinger.net>
 <59368aca-c3d9-0563-aa83-118842834fb1@gmail.com>
 <2aab932b-b4ba-2601-06de-ca095a549fb7@lwfinger.net>
From:   Ivan Safonov <insafonov@gmail.com>
Message-ID: <721d7c62-5119-f52a-6d5f-c3138654d0ae@gmail.com>
Date:   Wed, 2 Jan 2019 22:35:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2aab932b-b4ba-2601-06de-ca095a549fb7@lwfinger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/19 4:06 AM, Larry Finger wrote:
> On 1/1/19 1:31 PM, Michael Straube wrote:
>>
>> I've tested your patch and it solved the issue. No freezes and dmesg 
>> looks good.
>>
>> I noticed that try_then_request_module() is also used in 
>> rtw_wep_encrypt() and
>> rtw_wep_decrypt(). I guess that also could cause problems?
> 
> Yes, I believe it would if anyone is still using WEP. My plan is to get 
> rid of the try_then_request_module() there as well, and for 
> completeness, I plan to restore usage of the lib80211 routines for TKIP 
> as well.

Patch "load lib80211 crypto ops from interruptible context" ( 
http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-August/124851.html 
) is a preparation to replace
     crypto_ops = try_then_request_module(lib80211_get_crypto_ops(*), 
"lib80211_crypt_*");
with
     (struct crypto_algorithm).ops

> 
> Once I get a chance to test the TKIP and WEP changes, I plan to have a 
> set of 4 patches to switch the driver to using lib80211 routines for all 
> decryption/encryption.


There are four other patches to use lib80211:
use lib80211 CCMP decrypt ( 
http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-February/116533.html 
)
Use lib80211 to encrypt (WEP) tx frames ( 
http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-June/122642.html 
)
Use lib80211 to encrypt (TKIP) tx frames ( 
http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-July/123249.html 
)
Use lib80211 to encrypt (CCMP) tx frames ( 
http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-July/123250.html 
)

They all crash when try_then_request_module() called.

> 
> Larry
> 
> 
