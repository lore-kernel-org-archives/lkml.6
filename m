Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D718CC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0528218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="S2enUptv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfAYPER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 10:04:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40027 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfAYPER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 10:04:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so10638443wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 07:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aZKhIPdPw2yYoT5SlMDsEV19W5oUZuKYPIeJu7ViOlc=;
        b=S2enUptvZmBgnq/Tuu51hpTsZlrTXneKcxkoSgdsPF0AaKMqfmstz7Lk+zqL0mvWgq
         dYFT61v/xhCXuvmiU4mfEHImEp/DL8o/xG2o0GV36rz66L+dtI70ha1Jr1wBWtvu83cB
         7qh4Fcn4Twripdkxd1aFEb1JtDGVMG2EIwgtrthGDASUC6njHD4CE309qvRBSErm6jSn
         hfjZ2j2XjZFmqAQmVnRR3IrmwJgER0rsVviXVbd5XZRs4R1U6rAhYe1cjhAkKB5+8k7r
         j2xXZvS7LB65Xj/pP3c3HAtNEhIlHmWN2snQwBxoA2EfxPqBDLYPBCoJCsVBFsiPDCqY
         UmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aZKhIPdPw2yYoT5SlMDsEV19W5oUZuKYPIeJu7ViOlc=;
        b=rZ1SXJ6eDi60JAmp9FvlFljU6ITSeVUM0t/9RFMhVMVmxc4X+1QwXso/YvxNZn3MSX
         aq/TCYHJlfSR34iiHplTn0UJ+0suea6cPbgEK8ahLUQXhEf24ImLCHcDG777/iTshemd
         VRExD/uO474gnezvGPwUR4CCYbnq8nqegWqdbpFyAGxCcdQ0fGeR451ueuRXuikcKkY9
         b9zA7icoNGxTbmmeGV9JeWfqYvq8rqgRUzb6RdzVdkYxMS7Lz4QzwWhdcozp/9ViviMv
         SPTmQx5v39TIIAe3EGN37OzYBLzjh38/Rt4EnT9OZT5mxRIBEaceJWGtlieGeNW0/JXZ
         fZ2g==
X-Gm-Message-State: AJcUukfa5V9n7GcVnIe4I8VhS/cNzYuF7mHacEeuozyErJMR4IWwgm9B
        P+yh9NxB6AZK5Y0KcCdZWxdgabHroDY=
X-Google-Smtp-Source: ALg8bN72QBnkwhq0zMYMVJ8MyE0L5C8VD12GuKjNBnAszWAr+4KQFg0y1miFbb90QN49c7yDIPsYLg==
X-Received: by 2002:adf:c042:: with SMTP id c2mr12210369wrf.158.1548428655356;
        Fri, 25 Jan 2019 07:04:15 -0800 (PST)
Received: from ?IPv6:2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6? ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
        by smtp.gmail.com with ESMTPSA id d2sm87574874wrs.97.2019.01.25.07.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 07:03:42 -0800 (PST)
Subject: Re: [PATCH] net: phy: at803x: Use helpers to access MMD PHY registers
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190125123510.20511-1-ccaione@baylibre.com>
 <20190125150013.GG12962@lunn.ch>
From:   Carlo Caione <ccaione@baylibre.com>
Message-ID: <74bc08fe-9edd-2b70-4b63-781e6f023efc@baylibre.com>
Date:   Fri, 25 Jan 2019 15:03:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125150013.GG12962@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2019 15:00, Andrew Lunn wrote:
> On Fri, Jan 25, 2019 at 12:35:10PM +0000, Carlo Caione wrote:
>> Libphy provides a standard set of helpers to access the MMD PHY
>> registers. Use those instead of relying on custom driver-specific
>> functions.
> 
> Hi Carlo

Hey Andrew,

> Maybe deja vu, but i thought a similar patch went by recently?

uhm, not from me for sure. There is a discussion going on about similar 
stuff on the U-Boot ml, maybe you saw that?

Anyway, feel free to drop this if someone already fixed this.

Thanks,

--
Carlo Caione
