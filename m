Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E2DC46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 18:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1307A219C1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 18:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fhFT9bTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1307A219C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeHLVXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 17:23:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33929 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbeHLVXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 17:23:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id l2-v6so5835996wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 11:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=AFdiIw4GLH1xPzJ9leDHn3tNKciBUVFfzfAjXR5sNJk=;
        b=fhFT9bTyUVA+Ouo+ziEg9V0frcEDx0RkjoebarGcox6c4M4JyjyUbSWVZtowdf0xhu
         s2bLYSZn3t+nSSfckiggWIDwyJbmolJd0sIlrRKW05ffEllDmcQ3xo1TvMhBql1RLlU0
         4BjrLcnekOUJdlcj6azgt+rmzQ5yKc36AAPmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=AFdiIw4GLH1xPzJ9leDHn3tNKciBUVFfzfAjXR5sNJk=;
        b=DmuAkrH19uElkrVaB8WSPvcj0vijg61sjbvTk1LdnuZoOjWcTyz6UczTPUIngaWMv4
         ct5xdEnia3Gac5WCKHcgmr9dJEPY1Ea5q3DKI8YGWSYv2WzYxMzosHre/jPBrurJi+Ra
         XagyGiJ8AQGxH7BGlUlXej6uepniVxtgjYF9tKBz88DeriQ90e0CpfY4aD1s/kWycT+r
         IE9o47Nj97E7q4cxPvwV360mTsCZq78alIrvbsKEOXjaPkTnJQ/yBZzy9TLOmwts6kEG
         9TJ0LBgyc9QPS9qqBbnpF/q7MZv6IRW5ZR0NngzIoTf37vwtfaVL+Lo/U6U5mdROPhJi
         Spnw==
X-Gm-Message-State: AOUpUlFCqku+NdHTErrBuQS9011/7CSrKdTulwjsDYwa43dP2lCi1AVS
        jUGSP7GigPI/YkfbVkRjXUhv3esFNHeYIw==
X-Google-Smtp-Source: AA+uWPytraGnjd+N6p2uESDwlgT/VNX55ojAY4+Og/i0xbUtMk0jBV5vTO5GeFBRUvTUwhQDhXbOHA==
X-Received: by 2002:a1c:7015:: with SMTP id l21-v6mr3022572wmc.81.1534099494900;
        Sun, 12 Aug 2018 11:44:54 -0700 (PDT)
Received: from [10.177.251.247] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id j20-v6sm5409712wmh.9.2018.08.12.11.44.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 11:44:54 -0700 (PDT)
Subject: Re: [PATCH] mt76: Enable NL80211_EXT_FEATURE_CQM_RSSI_LIST
To:     Kalle Valo <kvalo@codeaurora.org>,
        Kristian Evensen <kristian.evensen@gmail.com>
References: <20180812145207.11395-1-kristian.evensen@gmail.com>
 <871sb3zc3v.fsf@kamboji.qca.qualcomm.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5B708025.4090906@broadcom.com>
Date:   Sun, 12 Aug 2018 20:44:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <871sb3zc3v.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/2018 8:14 PM, Kalle Valo wrote:
> Kristian Evensen <kristian.evensen@gmail.com> writes:
>
>> Enable the use of CQM with mt76-devices.
>>
>> Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>
>> ---
>>   drivers/net/wireless/mediatek/mt76/mac80211.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
>> index 029d54bc..3eb328ff 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mac80211.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
>> @@ -305,6 +305,8 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
>>
>>   	wiphy->features |= NL80211_FEATURE_ACTIVE_MONITOR;
>>
>> +	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
>
> So have you tested this and with what devices? For example, does it work
> with recently added USB devices?

I was looking into this as it looks suspicious to me. From reading the 
description of this ext_feature flag it seems this is an extention of CQM:

"""
  * @NL80211_EXT_FEATURE_CQM_RSSI_LIST: With this driver the
  *	%NL80211_ATTR_CQM_RSSI_THOLD attribute accepts a list of zero or more
  *	RSSI threshold values to monitor rather than exactly one threshold.
"""

Also looking at mt76x2_bss_info_changed() it does not handle 
BSS_CHANGED_CQM so I doubt it has support for it (yet). The driver does 
not use IEEE80211_VIF_SUPPORTS_CQM_RSSI which is a requirement for it.

Regards,
Arend


https://elixir.bootlin.com/linux/latest/source/drivers/net/wireless/mediatek/mt76/mt76x2_main.c#L223

