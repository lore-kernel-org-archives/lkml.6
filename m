Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017D0C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 19:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8952077C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 19:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnexxeL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8952077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeKRGJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 01:09:55 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39049 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeKRGJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 01:09:55 -0500
Received: by mail-oi1-f193.google.com with SMTP id 192-v6so22341931oii.6;
        Sat, 17 Nov 2018 11:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8UsKU1UzzomdZoCSkezXZJgt9DyXpkSJUTgC3kj2L/Y=;
        b=LnexxeL6LOLPwdIwE1h31YBOpPJ0A6I0XwMU/GPlwiD41gnvsmCxpwTiy4C0U7P5yA
         XJ/PmFaIj8SsAsM2iIC72jtzlIhrih/Lg7r7jX39iELZXXRmQQhnAG+Kw0qyWXm+oUmG
         bjtV1Zyj0BuiHB6N7JXJN2McQZP2+NMRdkownpunA26vjIyXdJqaD4xGd7BcA8hoNmau
         d67Kw4NIkgJVAzMNiL9R6V5QpNF2F/4gkSOnxgRhOezRWOQCtdIe8DgtNTYIl6F+TZ7r
         gyMBf9G48lYvyuw3/5FmIDcRxIM33AEIw9M9Ca8iHeGPwMGcRmsl3tjVeRFA/z97CaOM
         SOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8UsKU1UzzomdZoCSkezXZJgt9DyXpkSJUTgC3kj2L/Y=;
        b=FY60ozADNBurVDJfYBOo8amToOcYyBh7mbS3hrEAa8zb64ivg68aU3UfZ/ZJ2VCi8i
         uiSr1EyXsUQfut7adO6W9UK83MR7JAtBTFyI76GYE+JcNSECRaQPQ5oo8fj9k0iuxwie
         K/lAytmh7ySICQ5+ON4ROTddp+PW7cxxuoTJnXV426Ir/+9V0X6Q1jFCync9S4r9uIcG
         u/GgBIGDKcXX14hndnfFf1ctT1NKOegyOG2C+544NX1eW8SHiauinJ+iZUEwamg5gPdO
         kKwpZZoAiCdb4oYW+YK4OYQ1CdFIsoUE9rixKCWOtu4ev/ztwNIvI1HWYOiZKvIzRsYE
         UD3w==
X-Gm-Message-State: AGRZ1gKNzmpy6N4t91ygZ64eXP6UWYDEhW5MhjU+UtArdcE0KI1paQ4D
        LfyukUAX1aodtoAHWBP4SDE=
X-Google-Smtp-Source: AJdET5e1TkkCjWuskwOugoEp96qbqIjLKWZ08Dt7/8oowQmOm0dO9Z/riYmBmGb6zkOtaGzwq7SeBQ==
X-Received: by 2002:aca:f5d4:: with SMTP id t203-v6mr3905714oih.98.1542484330722;
        Sat, 17 Nov 2018 11:52:10 -0800 (PST)
Received: from [192.168.1.2] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.googlemail.com with ESMTPSA id s187-v6sm11329137oie.13.2018.11.17.11.52.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 11:52:09 -0800 (PST)
Subject: Re: [PATCH net-next 2/2] net: bcmgenet: abort suspend on error
To:     Doug Berger <opendmb@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
References: <1542420022-30251-1-git-send-email-opendmb@gmail.com>
 <1542420022-30251-3-git-send-email-opendmb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6d4d25e0-df8f-37ce-50a2-fb42797ea812@gmail.com>
Date:   Sat, 17 Nov 2018 11:52:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1542420022-30251-3-git-send-email-opendmb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2018 18:00, Doug Berger wrote:
> If an error occurs during suspension of the driver the driver should
> restore the hardware configuration and return an error to force the
> system to resume.
> 
> Fixes: 0db55093b566 ("net: bcmgenet: return correct value 'ret' from bcmgenet_power_down")
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
