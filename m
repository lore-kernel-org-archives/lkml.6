Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29988C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D000520837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 02:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMGTdi+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D000520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754627AbeFUCoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 22:44:09 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46994 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754554AbeFUCoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 22:44:05 -0400
Received: by mail-oi0-f67.google.com with SMTP id h79-v6so1501966oig.13;
        Wed, 20 Jun 2018 19:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iGvfTXFwpSosnitWqOZlp6XktYqdR/VOheW+JNRD6cA=;
        b=QMGTdi+mVtQJFTeF491ERYezdnSMVMsT+U59yB+QVm0yQZp8JJrp+3Gs+iVSdwe2aN
         RoaOCkpSKhbpM4jIs4u6+Eae5oO6eWHb9Nhspv4q5MQU8opuFf3numCd80R7TelWwbND
         x0Vaoxv1m9a1zgioa/DjHvl+gg8v0fFWTBpaDs5GVPNNQOSS1n0t9/kz35RGAMPniAK2
         W7z66mFHJMhIjHMYX8E3ikqfvAg8bg7pRPzfqZLQpJNVfSD3qA9TXnckoFyiywPavzwC
         gCoolvGP7tE26iNkv+ejxRnhVONC5eyO5fUhAwRQPlPLESzbqIaIeLeKLypleGK/pYaa
         /+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iGvfTXFwpSosnitWqOZlp6XktYqdR/VOheW+JNRD6cA=;
        b=lmKMJHneoI3Cn0hg1RX4c4GZC0k/vjjp5WJRuJEiTPQxNLPRpMwUyqU1/4lsbJ+JlT
         IOJjHnsP9f/U+W0vl4JX7AOqMIUjDGhDJY4AlK7g1s2eAEWGhYhthzuB/bDEWk8iw1p5
         Q456ZjbIWlCSXtOMEkrdKw7FtRaMdlHx5JsjdzngHxkP5FrzM51aUfJ6L6RQ+RRruMBu
         0GvAa1H8pTLhLNKc6qZXy2la2IId/IFTJz8jKmt/BK5GeQ095SurPpm5ba+9omfpGNFX
         B59oPey7tcdpHkjnKXqD6Nif1nPdYUYYnNe5Lf1v0m3yeMc9bG78Q2kTk77fShdSM5tL
         BWhg==
X-Gm-Message-State: APt69E1JNy+Syt+bzHVd12OA72L6LDDaaNR/EB7kEloQT+pZGSZNfEp2
        od73Q/IdT80B9sN8ZCsGRK4=
X-Google-Smtp-Source: ADUXVKLGTCwLvO0lADICG1MRHfOMqE+o4vhbt1ooNFkD9UT9ZhUaT8skZKJiUSNaQSdM/psV+KYqHQ==
X-Received: by 2002:aca:57d6:: with SMTP id l205-v6mr14111476oib.167.1529549045074;
        Wed, 20 Jun 2018 19:44:05 -0700 (PDT)
Received: from [192.168.1.3] (ip68-109-195-31.pv.oc.cox.net. [68.109.195.31])
        by smtp.gmail.com with ESMTPSA id k133-v6sm1889484oia.36.2018.06.20.19.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 19:44:03 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] net: davinci_emac: fix suspend/resume (both a
 regression and a common clk problem)
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180620080356.11900-1-brgl@bgdev.pl>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <d8ef484b-af29-f25c-fbeb-abf6105e34f7@gmail.com>
Date:   Wed, 20 Jun 2018 19:44:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620080356.11900-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/20/2018 01:03 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Earlier I sent the first patch as a solution to a regression introduced
> during the v4.16 merge window, but after testing David's common clock
> series on top of 4.18-rc1 + this patch it turned out that the problem
> persisted.
> 
> This is a follow-up containing the regression fix and an additional
> patche that makes suspend/resume work with David's changes.
> 
> v1 -> v2:
> - dropped patch 2/3
> - in patch 2/2: check the device's parent's compatible

Much better:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

> 
> Bartosz Golaszewski (2):
>   net: ethernet: fix suspend/resume in davinci_emac
>   net: davinci_emac: match the mdio device against its compatible if
>     possible
> 
>  drivers/net/ethernet/ti/davinci_emac.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 

-- 
Florian
