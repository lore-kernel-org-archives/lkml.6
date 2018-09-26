Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F252EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B203A2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsIU1OGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B203A2151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbeI0AtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:49:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33533 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbeI0AtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:49:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id g26-v6so2812039edp.0;
        Wed, 26 Sep 2018 11:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=osZNGbkoYbBHDkaMnAJEYQLWoNE/pZ25pmaatfVD5gE=;
        b=tsIU1OGlYN3QpbC+gNoqwUVwASfTxqd7iaaqGv/jWgHCIHgROzwaRJgtFJMIeDVjRE
         w0gh8hgWsoheA47LgHSyIlszjuzT/S+/aUZ9YaIXdMqpHVE4/9Af7WVPgecJh4cmuM0N
         y45TjB5AsiKx2q67GlhWBWs5LPL7dPUAY4RhGhe2E+ng4FA/K5DiRQPzDtM5URtVEPvl
         N30WB5GGBPqurCEACFIsdz3U2Y3NAKe4GUTuJGxt6pHVPNb5PP4UcVeXWMusxndZh0JU
         61G4i7PDmKGpPrIeOvoLgPY7hzKH0UpWR13pO2fhkOPx6S/wDRVjFPVthcZqrJnhshtY
         4xnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=osZNGbkoYbBHDkaMnAJEYQLWoNE/pZ25pmaatfVD5gE=;
        b=XTMfjS1K+9MLCvFy6PWMpTzd7Nh1l6psWCd3SJv+xbOpJSmOJCrJ133pzc249XiGdV
         BOiwmeXlxH/9ecTwvFu1fChjderX/yg5B36qHzuUpJjdoSWd2Q/Q7i3C2R3XoLMY5TAg
         pPw3XQjE5ca5n6dPoLvDyjMI8aNjLFmvdInmxpdv2wi45U2lAjVvrYtxge7/wVqwqy1g
         mRzGX6GQ+bkhEI14GYY2GYYW7UQ46FupwWbEwTnLWzD7lGB++7C/TX90Ry2xIayWaR/l
         nCdW5FxrCuLeO97o9FiHd70TWWxVmPJislA3+6VIh4KvTY5f+cyXg9QQiJ/RgjnoOzpT
         hbDQ==
X-Gm-Message-State: ABuFfohUiWWzdsDA6QKHy7zhOq9KMjtLyad7sVNS75X189nUv25a54JC
        VYc9Ce4tW+TId3eQMf9guAo=
X-Google-Smtp-Source: ACcGV62KGJgE68iFokCegCwCA7Xp22GdHz4Oo910Hb6v86A+c4AJBjbZvGCZ+zkO+jVldbvTd5ZVfQ==
X-Received: by 2002:a50:d79e:: with SMTP id w30-v6mr12246741edi.19.1537986901732;
        Wed, 26 Sep 2018 11:35:01 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id c15-v6sm152144edm.21.2018.09.26.11.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 11:35:00 -0700 (PDT)
Subject: Re: [PATCH net] net: phy: micrel: add Microchip KSZ9131 inital driver
To:     Yuiko Oshino <yuiko.oshino@microchip.com>, andrew@lunn.ch,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     UNGLinuxDriver@microchip.com
References: <1537986141-22832-1-git-send-email-yuiko.oshino@microchip.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <3b1aab2e-ed4c-dc36-4035-ce817df467e9@gmail.com>
Date:   Wed, 26 Sep 2018 11:34:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537986141-22832-1-git-send-email-yuiko.oshino@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/2018 11:22 AM, Yuiko Oshino wrote:
> Add support for Microchip Technology KSZ9131 10/100/1000 Ethernet phy
> 
> Signed-off-by: Yuiko Oshino <yuiko.oshino@microchip.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Same as the previous patch, targeting the "net" tree is not appropriate
here.

Since the two patches are obviously linked, you might consider adding a
cover letter to introduce them.

Thanks!
-- 
Florian
