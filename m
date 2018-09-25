Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA4AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D142920833
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV0wvMia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D142920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeIZAoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:44:55 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46507 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeIZAoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:44:54 -0400
Received: by mail-qt1-f193.google.com with SMTP id h22-v6so6526387qtr.13;
        Tue, 25 Sep 2018 11:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sIymD2BjEhizhi5wZeVprBHUSOmvXZPMBlG5GHeyqQY=;
        b=kV0wvMiaOWhGlTmmgNJ46urkPjzq3s1yadEFehMBDsQ5xRtD4vdcHV2ucWZaMMEosM
         MMh1zWE9XVf8nX5SPmG5cqYsMaU7i/johSSYjIijISObQMFHYC9U2RdJ9yZjiu/sEew/
         Ovd0CZq5utbz3K8QxZha+IAjMouBjp6A8uMSeSO9hi8YKbzBbZmd4g82smYZ/K1xEpZk
         pZTaS1TclSeOC7m9j4Oq2+zyfQryyj0BVXtE9Rrx7TVUu8W/pr6X8PDE8yIaiR/hLZSu
         d7FWSIbYBCq505zM4V2LmjYnWJy77QIihWiTN6IEzR4AvrJ1pNo1HUzpsLkL+esrgswC
         QWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sIymD2BjEhizhi5wZeVprBHUSOmvXZPMBlG5GHeyqQY=;
        b=UgxwEHviNd/4Ql7p9E1v3yA3YXuTzvNweyuxLsSM4p5GDxUMPDlfvhTnCRQb80UKRC
         Dhe2QHP1SWOhN+CBE0p+EZrY7lqdGTag4IwknGO4jdu7DeRqXVlw8YGl0anyxe76seig
         3N1f//ZDZYmTjrzSjOaVA3o2CC8jrrZZXV5Ifm43franBMjih3o99TIZpmhn0z2ETTIW
         ze6kbqf21yobke84sL+dxbAVxFkXWqCG72yzsCslkgyMXsCiT4nhUwVsins/3dymyfmu
         7jHVtLuyHHk5Iq1xSfUdDU0/7d55jvMKAdyImjBx0OjE7i7ou3fQfHq1D1gql7unm7iO
         JCtA==
X-Gm-Message-State: ABuFfohP6smd90O3kmSwZNupmfs8tNyx0ZNy2tj1R2ugVBZKaT7SFX1H
        wy6YyVfJuFjmAT/lfxDiRZgcRjXV
X-Google-Smtp-Source: ACcGV63eJmO1JiMiboFAcmzj1RBeseS9DkeeyZz6puo4blGvrycfi5goZQNxfi+OWAZMqEaIvQX0Gg==
X-Received: by 2002:a0c:aa81:: with SMTP id f1-v6mr1813623qvb.80.1537900563722;
        Tue, 25 Sep 2018 11:36:03 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id f90-v6sm257116qkf.49.2018.09.25.11.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:36:02 -0700 (PDT)
Subject: Re: [PATCH net 3/7] lan78xx: Check for supported Wake-on-LAN modes
To:     Woojung.Huh@microchip.com, netdev@vger.kernel.org
Cc:     davem@davemloft.net, UNGLinuxDriver@microchip.com,
        steve.glendinning@shawell.net, keescook@chromium.org,
        akurz@blala.de, hayeswang@realtek.com, kai.heng.feng@canonical.com,
        grundler@chromium.org, zhongjiang@huawei.com,
        bigeasy@linutronix.de, ran.wang_1@nxp.com, edumazet@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180924205420.31309-1-f.fainelli@gmail.com>
 <20180924205420.31309-4-f.fainelli@gmail.com>
 <BN6PR1101MB2130115311A87CCF7D712B0FE7160@BN6PR1101MB2130.namprd11.prod.outlook.com>
 <f791e4b6-7493-b54b-a88f-47d0ef4a3409@gmail.com>
 <BN6PR1101MB2130D18F03C79BC1E54C9FBAE7160@BN6PR1101MB2130.namprd11.prod.outlook.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <8de18c23-d846-cbb4-c852-9b7d97a95c11@gmail.com>
Date:   Tue, 25 Sep 2018 11:35:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <BN6PR1101MB2130D18F03C79BC1E54C9FBAE7160@BN6PR1101MB2130.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/2018 10:32 AM, Woojung.Huh@microchip.com wrote:
> Hi Florian,
> 
>>>> +	if (pdata->wol == 0)
>>>> +		return -EINVAL;
>>>> +
>>> It will make function return when disabling WOL.
>>
>> Huh, yes, good point.
>>
>>> Is there other place handling this scenario?
>>
>> How do you mean?
>>
> I meant there is another path I might miss when disabling WOL 
> than this xxx_set_wol().

I don't think so, at least not from the ethtool perspective, this should
fix the issue before, and simplifying the code, since all we are doing
it taking a bitmask, checking each bit we support, and again, make it
the same bitmask in pdata->wol, can you test that? If you have a new
enough version of ethtool, try using: ethtool -s <iface> wol f, which
was added recently and which this driver does not support:

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index a9991c5f4736..2e37028ef6ca 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1401,19 +1401,10 @@ static int lan78xx_set_wol(struct net_device
*netdev,
        if (ret < 0)
                return ret;

-       pdata->wol = 0;
-       if (wol->wolopts & WAKE_UCAST)
-               pdata->wol |= WAKE_UCAST;
-       if (wol->wolopts & WAKE_MCAST)
-               pdata->wol |= WAKE_MCAST;
-       if (wol->wolopts & WAKE_BCAST)
-               pdata->wol |= WAKE_BCAST;
-       if (wol->wolopts & WAKE_MAGIC)
-               pdata->wol |= WAKE_MAGIC;
-       if (wol->wolopts & WAKE_PHY)
-               pdata->wol |= WAKE_PHY;
-       if (wol->wolopts & WAKE_ARP)
-               pdata->wol |= WAKE_ARP;
+       if (pdata->wol & ~WAKE_ALL)
+               return -EINVAL;
+
+       pdata->wol = wol->wolopts;

        device_set_wakeup_enable(&dev->udev->dev, (bool)wol->wolopts);


-- 
Florian
