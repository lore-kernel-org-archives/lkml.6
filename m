Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C916C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DB9218FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEczaGCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfBATGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:06:44 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41617 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfBATGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:06:43 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15-v6so6722496ljc.8;
        Fri, 01 Feb 2019 11:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QyUC6ELg9X4oIBfCTwPWnfdVJQ4lgZTskpCz7PW0qf8=;
        b=fEczaGCUnM0c+jyBdjHfSPoTbSuO3vRPdzYVLzw8FpKn2vscrCqaw9yXDCLbE1roIP
         TSi0MY2Q3Ys81tlGJuGzdh42BUHYiM7Z/skdAj22b0iXBiu+0LthgHTWmz1fW/d4x/1d
         MNg/y0RP8J1FgN32fOf1Joeg1theKuFIXL3OLgNB29Hnd9/4HI3rT1YhiK4Oud4u4P4t
         bz2Gk4PY54HiN08UriUtNmiplDVOxF1Ow0iYVz41GhecyaIh14sqiUQzRaVaP6++qacZ
         3TuwspIquTgwJBu53u4ZAh/YF9dryiBZ4LGIkKP0IXexo6cwSAF90ZRl7FjWWDHDGClc
         2Bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QyUC6ELg9X4oIBfCTwPWnfdVJQ4lgZTskpCz7PW0qf8=;
        b=VVEK9smLrxtAFCv38KgHXep8YrgD/E40ZBcF/PWqIu7vmXjQqpjjeOsX+xd9xSj7kU
         20p5hd2zvT7XT6z87M13H47vxIwNRVbihEz9bn+sDWDn9leTXN7RBwBPHQ8I6f9tT2Ct
         Bhr57N7BmaMp1pOzSPmxyyyhm5HPvAEqLRQV9P+30OCClqATaLMk3Fh/Eig7wNkYngae
         CPLf1bgbt+v+faZcCuwyGQHAe3LZO8m9Zbi8PMXsGxQr03hXuIz7oRkc3c3bdZ8V8hda
         3yF1W5tMoOR4+Lt+air2UQOEtXvkhtrPCktFLNf/OwhaZdnFC6jz/4VernA8VxE67DPi
         +wqw==
X-Gm-Message-State: AJcUukdXcuztw1SxXjd4FAiZX7EDvOTK0FA5cKWSu6n7QMgyrV7QmIcS
        21Qeo/mX7yNQ6QfqRkOiWau/oeMl
X-Google-Smtp-Source: ALg8bN5H0StivNjl1miqpDu5rf5DSUNGSwxH5GuxWKqcxjZyIgbvP4lJXkQX6mz4+Nsyra34IEG63g==
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr32220167ljj.9.1549048000763;
        Fri, 01 Feb 2019 11:06:40 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id s9-v6sm1429118lja.12.2019.02.01.11.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 11:06:40 -0800 (PST)
Subject: Re: [PATCH V9 2/5] i2c: tegra: add bus clear master support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
 <1549040867-18149-2-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f74879c3-4cbe-d59e-ee57-3ebe5bb0a269@gmail.com>
Date:   Fri, 1 Feb 2019 22:06:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549040867-18149-2-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.02.2019 20:07, Sowjanya Komatineni пишет:
> Bus clear feature of Tegra I2C controller helps to recover from
> bus hang when I2C master loses the bus arbitration due to the
> slave device holding SDA LOW continuously for some unknown reasons.
> 
> Per I2C specification, the device that held the bus LOW should
> release it within 9 clock pulses.
> 
> During bus clear operation, Tegra I2C controller sends 9 clock
> pulses and terminates the transaction with STOP condition.
> Upon successful bus clear operation, bus goes to idle state and
> driver retries the transaction.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
>  [V9] : Rebased to 5.0-rc4
>  [V5/V6/V7/V8]: Same as V4
>  [V4]: Added I2C Bus Clear support patch to this version of series.
> 
>  drivers/i2c/busses/i2c-tegra.c | 73 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
