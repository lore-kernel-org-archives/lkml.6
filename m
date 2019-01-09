Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FA2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2B2214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Cht7Uqex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfAII2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:28:24 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46185 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729721AbfAII2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:28:23 -0500
Received: by mail-ed1-f68.google.com with SMTP id o10so6530282edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 00:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5TgjE5Tc//Ey4KRCrEBUNKc5Zm2Bcs7gVi6WSkJCjlM=;
        b=Cht7UqexD8T1Ka5UqjIPEExH8jDEJdt+6WqGaCt7wd0tx8F3omd62OLajdOA+fygHi
         1AoEMBPRJS+F14CqC58JIojNT37koybR+fxB/a7LpPLzRINIy6Kr+gMx5xH6gfzJWS2X
         m3leW76t8dImgfa3O7UMV0DUG7YRnGUZHziCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5TgjE5Tc//Ey4KRCrEBUNKc5Zm2Bcs7gVi6WSkJCjlM=;
        b=bh3XEWBzETTcg/HZcsF9ZqP1x1unbezwMZHdyLbxleCWYk0EJqkOluxJmag/5IbutO
         xzs81m3bcpe/tJd4r/hMhZeMVA+IEPJR30lnxbnzb2uDC2GnUNv11a+SR27tLBfC/GEe
         ADmv1kif/H+1OnxcFkg/D6iCukwB1WIA5c2OFIMJI47DF1mqSI9qCvad2Z2RXWmwW2gN
         Dy67EtHAIBNFRh1d6jf0CBru2CC1ouF6iaW04IQj5FrQzTyyErGCkpU2YGC4RS54SEVU
         9creLBA0RH3Qk7OnBs0KBckhnrVQLjODj2HP7f6aVEsHmXxfsOLVBEdnPMeGdOZvMWyT
         Cemg==
X-Gm-Message-State: AJcUukeXNrxzvl7xkS2WK6xSOvTHoi0gGgi6BfbGmYwJlN9xvvmY5Rwu
        yRc2VRc+cKl/9Rf7d5vQDp3vwpq5cB5huF7cypfHbYskqYlWbGjoiHYMWMZpl+6gE8tlruahR6k
        g72DQ6fl1sRX0KzvX/cGrTuUn4iXaXHtKFME4EXeophrsRFtVGGUmmqBLXWgIgx9IyztLFx/SQx
        1C/UIAB7Zedpk=
X-Google-Smtp-Source: ALg8bN7+k2O9XM4kCB+oiCi5orsFwjtbszL49mNzTdP5SbKI4HJqszbhMS7M9WGL7+1U3KS8OgdbVg==
X-Received: by 2002:a50:cc04:: with SMTP id m4mr5229995edi.171.1547022501849;
        Wed, 09 Jan 2019 00:28:21 -0800 (PST)
Received: from [10.176.68.125] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id j31sm833826eda.46.2019.01.09.00.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 00:28:21 -0800 (PST)
Subject: Re: [PATCH] net: brcm80211: add a check for the status of
 usb_register
To:     Kalle Valo <kvalo@codeaurora.org>, Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181226012227.70524-1-kjlu@umn.edu>
 <87zhsbqeuu.fsf@kamboji.qca.qualcomm.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <7ddb04d4-f45f-2b41-12da-d17e8f8c1173@broadcom.com>
Date:   Wed, 9 Jan 2019 09:28:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87zhsbqeuu.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/2019 5:43 PM, Kalle Valo wrote:
> Kangjie Lu <kjlu@umn.edu> writes:
> 
>> usb_register() may fail, so let's check its status and issue an error
>> message if it fails.
>>
>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>> ---
>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 6 +++++-
> 
> The title prefix should be "brcmfmac: " but I can fix that.

Hi Kalle,

I wanted to ack this patch, but can not locate it in my email not in 
linux-wireless patchwork. Was it posted to the networking list only?

Using scripts/get_maintainer.pl with the patch would reveal the lists to 
post to in order of preference. For wireless driver changes I refrain to 
linux-wireless only, but that is a personal choice I guess.

Regards,
Arend

> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#commit_title_is_wrong
> 
