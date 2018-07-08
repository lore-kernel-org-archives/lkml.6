Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D3EC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5B3208D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 16:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XG26mDFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5B3208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754282AbeGHQaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 12:30:11 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42857 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753825AbeGHQaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 12:30:09 -0400
Received: by mail-oi0-f67.google.com with SMTP id n84-v6so31717709oib.9;
        Sun, 08 Jul 2018 09:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EulQPCwyhY8JVOHCm30l8muTFi8u7pPCpBlmW52nsYk=;
        b=XG26mDFtqU6zveYzPN0R6KdhRhBAosObf30qIDgjpyNtscOVEYDzN+o+9h5uMYGkUv
         VorRR/xdYQUe1d8Ji+tqGYcDZTxGeQdHaE+m3MfcMHnA+Nn5zM1izD8IkwiH9E7f6emz
         MX8iVtKNAyeUFyQyL0ojoYRk22rDSSDUFf81CT2qe7NKclP9dAy1l5cXqwgIEX7hB+KI
         eKCGMb61ICny0ha55wMs87x7gwmsQzRxsnl2XbfqJ84bT3CpzF2EMC45UU2I2I5hZf2m
         uNqGM6MM+RItdKq36noqvToYj+I3JaN3xzXujXWah4GDJjUHUD2Vv7N8/UyXJQUPE+67
         eBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EulQPCwyhY8JVOHCm30l8muTFi8u7pPCpBlmW52nsYk=;
        b=aHs8K3BuIVYym2J3NXy0Bhk9NjB9++/xfNfvdeuDnovmu7vug+shNOZHbJgFsktusN
         K6j4ICvvVMCeQH1GQkSLgENMdnS1nT0eFfGPLavu6I55KGOQLmMFkcjj+m26zEss6SgJ
         pw9k/HpWivHBLjZJAqmfFfGeq6tTEBvIkDEuN+hI9kljOZouzA+x1llNhzYlOro6YdEz
         DXaWitTTnvzL57u40+ece2sCF93MX7G44mBT0kI5D9q3bFQnou0LFkgVbPijYEB/3p3R
         YmtMtTUcrfBZqM29jExCjs46hbx2ujD5nPokdvmtEPwpDSAtUa1dka14oQfaOdhnuikH
         QoDA==
X-Gm-Message-State: AOUpUlFobT+1V6xjHNdtNuE1YNIuRlfHS+OTEClo+o8i6S4bN3HY5STF
        iynHgxbwFCf416Vd6Y0pq6Q=
X-Google-Smtp-Source: AAOMgpewlHoKOjziAT7Mycl9XUKdgEKo5YBAN8WuHPxHtKJHyNsCmd+ty6s8+0jCWtDY2VqjQa1EaQ==
X-Received: by 2002:aca:44c5:: with SMTP id r188-v6mr481407oia.280.1531067409414;
        Sun, 08 Jul 2018 09:30:09 -0700 (PDT)
Received: from [192.168.1.107] (cpe-24-31-253-228.kc.res.rr.com. [24.31.253.228])
        by smtp.gmail.com with ESMTPSA id e19-v6sm3376914oii.56.2018.07.08.09.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 09:30:08 -0700 (PDT)
Subject: Re: [PATCH] staging: r8822be: Fix RTL8822be can't find any wireless
 AP
To:     pkshih@realtek.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        jian-hong@endlessm.com
References: <20180706054435.3732-1-pkshih@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <63971c24-d99d-459e-fb9a-df583c5a89d6@lwfinger.net>
Date:   Sun, 8 Jul 2018 11:30:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180706054435.3732-1-pkshih@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 12:44 AM, pkshih@realtek.com wrote:
> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> RTL8822be can't bring up properly on ASUS X530UN, and dmesg says:
> [ 8.591333] r8822be: module is from the staging directory, the quality
> is unknown, you have been warned.
> [ 8.593122] r8822be 0000:02:00.0: enabling device (0000 -> 0003)
> [ 8.669163] r8822be: Using firmware rtlwifi/rtl8822befw.bin
> [ 9.289939] r8822be: rtlwifi: wireless switch is on
> [ 10.056426] r8822be 0000:02:00.0 wlp2s0: renamed from wlan0
> ...
> [ 11.952534] r8822be: halmac_init_hal failed
> [ 11.955933] r8822be: halmac_init_hal failed
> [ 11.956227] r8822be: halmac_init_hal failed
> [ 22.007942] r8822be: halmac_init_hal failed
> 
> Jian-Hong reported it works if turn off ASPM with module parameter aspm=0.
> In order to fix this problem kindly, this commit don't turn off aspm but
> enlarge ASPM L1 latency to 7.
> 
> Reported-by: Jian-Hong Pan <jian-hong@endlessm.com>
> Tested-by: Jian-Hong Pan <jian-hong@endlessm.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

This patch definitely needs a Cc for stable. Otherwise I ACK it.

Larry
