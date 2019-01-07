Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5602C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A676206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSs5/uDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfAGTMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:12:48 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36214 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfAGTMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:12:48 -0500
Received: by mail-ot1-f67.google.com with SMTP id k98so1334203otk.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 11:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4H9Ani97mWB8KOxzQ5Zy8V+Ms75Hvre4Xp0yMIUU3RQ=;
        b=bSs5/uDTg+EeQ82OFnSFLkkUfiQwYKlRTegf/dNuNkiM4XVRyVdHi0b9lYoJoAaBpn
         +LONZjv8BVvzmr/Avz10jyIY4eOVjE3exRYCQBop9U6smg6BWYDIgl1TP1814vi/HA+m
         AyjMSAeZep4AzI47bGRODFd7EAu6P/kwVRoNH38/YKTjuMi4sLmcROQJ12UV2oAs7WEM
         4QbEYxOvUi1pJ+fw5+8LeamZUQg1BH3PcXiwTs05f/BlQ24rYkRljWWhiT/K56io+5AH
         IJL1TdYAjMyza1YxR2SDJ7Pgi37+mtYbrA2Ftr8DbJ69KiIMyFV6aZkfKO++qQLKL3Xx
         yD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4H9Ani97mWB8KOxzQ5Zy8V+Ms75Hvre4Xp0yMIUU3RQ=;
        b=a26KQAkH5wMW87X0ftGfmF4GFYnJDgBwaxa3/SMnovkurQUWRm6lz0q7G4fMXyni0p
         /hxOEo2im46toW0ITBGll0ZXlchbBhkEDfvI0fOsOg1OO6Z/XVcksCEVKXX+QrXSsxfv
         B4MCKTkHbP42qTEoysiD5BUIqW9+/01UP85/wsu0K+4dyL6tsmqHRoW9tKLBvCAa0XbD
         rWSJ+9EY2m6zNms+OEDuSqOLtmVbNMfx+agqon8VTskzMZyiTdb6OscrcrtrJSbBsLA1
         O5ifCfK88GJfGFSjl6c0HaS6dRFDAALkWjhAW0ud0zw2y3uyiCz249H9QmlV5Djb7WCz
         t1uQ==
X-Gm-Message-State: AJcUukeN2LRNS5X2LveMM2f/WCJ8tW02zS+Chg++l1zDU5h2SyrCOHgE
        BYb9oMmmtFBuzQLsz2pH1Ziqa9a5
X-Google-Smtp-Source: ALg8bN5E5syW5PQsKz9erKTF/LaNvFfoTJaFcmveiAyLNupTDX4uDIDA8clYcRcEGM61HfjZJbXJhw==
X-Received: by 2002:a9d:5d14:: with SMTP id b20mr45395553oti.136.1546888367202;
        Mon, 07 Jan 2019 11:12:47 -0800 (PST)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id t2sm30030205otl.4.2019.01.07.11.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 11:12:46 -0800 (PST)
Subject: Re: [PATCH] staging: rtl8188eu: Add device code for D-Link DWA-121
 rev B1
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190107172858.12110-1-straube.linux@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <f414f616-188b-a22f-e7ea-d7835a52eda1@lwfinger.net>
Date:   Mon, 7 Jan 2019 13:12:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190107172858.12110-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/19 11:28 AM, Michael Straube wrote:
> This device was added to the stand-alone driver on github.
> Add it to the staging driver as well.
> 
> Link: https://github.com/lwfinger/rtl8188eu/commit/a0619a07cd1e
> Signed-off-by: Michael Straube <straube.linux@gmail.com>

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks,

Larry
