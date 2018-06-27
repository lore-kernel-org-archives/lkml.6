Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA74C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3CA208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJUsLzwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3CA208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965224AbeF0OtE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:49:04 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43718 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964862AbeF0OtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:49:02 -0400
Received: by mail-ot0-f193.google.com with SMTP id b10-v6so519964otl.10;
        Wed, 27 Jun 2018 07:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d755QWMpcC/icjLW4b1ijpc0JfxVe3B2djSJ2d0K9z4=;
        b=tJUsLzwlkBn7V7eOuIHosNYJnNC6NYn0Im7JxqAHpsTnHwESzdLBRmCMwF0lW9m1G5
         FcnQu1oqYyKDCHbgZL1768ncQdBYmKkZjI+kUYeZScZiyp1Mi/IGGaWXRl8kXg33OdKs
         qXl8oNqqsqmY4EhZTcoWaDkg+vZDIy2FUqjkJhRymrLplU2Bmw0sijuF8JWWix94pNQE
         vrcQC7efoqaw1QlaW/jdt7hdi4vLCVQu821v3y6rq/YDeSTasNo3/aJq0aEw2Pk02G0D
         u+kwLBfo9NxNY9v20EX7ZgXu79yrSbyb3zARcDF03eFaL0ovA2dnScve1eq/l93rrhfX
         vAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d755QWMpcC/icjLW4b1ijpc0JfxVe3B2djSJ2d0K9z4=;
        b=mbY3nFleYFPMAEnH7vbwaeul9cSzq+lxXcEV+XUFBb7FIrTGptL7xz4mLMvBJW5nKM
         fsYQLwm3PSn6aAzBi5VhPDvVlN7Ps0Gz6J04YDojFfZ4sfNPWXi5ryIawgbq4lBbBY+G
         R0oZT/vNQWc3hTCRek4mLdOVk8wmiJDIquWhRCMB2niUDUiZB/axd550pffsbgqtRk3v
         jIfw+3M9XjqBbEhQOQKxA/WH+dkDPHLpWDoVifcA1kWAYCeu14cLxG6KslohPoKFMZE9
         LkXVGN5Yif+aB8j7ioaeuYmce2zygi4I6KmytejbaP1xJTPiiQTMUWbaYA7M3fsYYueU
         mo0A==
X-Gm-Message-State: APt69E3G8ErXFkG41BstcqBkH/k4/Sz1QFLVUQlUG3zvuVU4gfYbpjbF
        JxwZRTE6s/EOJXcddLXoXhZVocLl
X-Google-Smtp-Source: AAOMgpeLjIbkYQdCofaR2jcCrvXFrw5CHEHo1/9e7zFO8ocMgsOogYAqSIcuBonxzvtpPjbrl7TZrw==
X-Received: by 2002:a9d:1ec8:: with SMTP id n66-v6mr3830557otn.351.1530110941831;
        Wed, 27 Jun 2018 07:49:01 -0700 (PDT)
Received: from [192.168.88.42] (m3c12fa48.tmodns.net. [72.250.18.60])
        by smtp.gmail.com with ESMTPSA id w21-v6sm937134ota.43.2018.06.27.07.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 07:49:00 -0700 (PDT)
Subject: Re: [PATCH net-next] tcp: replace LINUX_MIB_TCPOFODROP with
 LINUX_MIB_TCPRMEMFULLDROP for drops due to receive buffer full
To:     Yafang Shao <laoar.shao@gmail.com>, edumazet@google.com,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1530100216-13070-1-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <c89b70f9-e70d-35a5-b9a7-7e3ed7d34edf@gmail.com>
Date:   Wed, 27 Jun 2018 07:48:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1530100216-13070-1-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/27/2018 04:50 AM, Yafang Shao wrote:
> When sk_rmem_alloc is larger than the receive buffer and we can't
> schedule more memory for it, the skb will be dropped.
> 
> In above situation, if this skb is put into the ofo queue,
> LINUX_MIB_TCPOFODROP is incremented to track it,
> while if this skb is put into the receive queue, there's no record.
> 
> So LINUX_MIB_TCPOFODROP is replaced with LINUX_MIB_TCPRMEMFULLDROP to track
> this behavior.


Hi Yafang

I do not want to remove TCPOFODrop and mix multiple causes in one single counter.

Please take a look at commit a6df1ae9383697c to have the reasoning.

Thanks.
