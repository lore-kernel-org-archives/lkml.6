Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918BEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427B320846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aolwsCt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427B320846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753619AbeFTF6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:58:44 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37039 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbeFTF6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:58:41 -0400
Received: by mail-pf0-f196.google.com with SMTP id y5-v6so1040626pfn.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 22:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=Bhx7L5vMC8fGosK/O1h3c5Sl9H4w69InS0mqL0AJ44k=;
        b=aolwsCt49CBzqMXveACYT4R+ujFsavct5+UzfaoYbN1kZa0h8YeVl03uNhpTeK5dZi
         9g67jxV/spaWKuiaeMr5c9+yBGQsgxBeIXd5ju/cSQnTgwA9DOWBQmLZ88Qp29it+40M
         mWvsKDA4tIUIdV81aUe5nVVb+jiC0Yne7oDoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=Bhx7L5vMC8fGosK/O1h3c5Sl9H4w69InS0mqL0AJ44k=;
        b=r9V3FUNoyYMDiwGY2WBQs2W1MPpnYVVUS3VkEPn4MqM07zm5ydQi3SLqHc3fOlf+L5
         9leczNnmLuaC/iToC61v5m6muwjmQ+0hK3Vp0VCXkcCL1oB9MMEJ781Qu7at57eRMNU9
         YJIHUYyWVXe6j/V21gyuieyQ19KD7x6TTmQl8Ifb4KJ3BMvPPMM38eji+0U+JKisOH2+
         +LMbroPYbmaD+plwMPZEL66lKVNr4T+krpPxt5/k7ZnfJmL2XJc7zugG55x8FpVEdtdH
         S+Tr0hNN9nNwgg2/zdKqddTePhXej9FBI2XKCb9gaZMFlHVRU4D+/6qCBBK6TSHNiVp6
         Wd0A==
X-Gm-Message-State: APt69E0OGLMPYxEjc2/N8cvoTt3UqzFhuPp1XY3EdaANq6N6gAraat9M
        hRUrbCyyc9v+1YkacvSgI4WGLA==
X-Google-Smtp-Source: ADUXVKJcZVEaT63f3mhAHe+VCsHp6aHaUIkOWAJmInMYXBVvOiUtesmmj8AczGSVu0XpURp0bDNfxQ==
X-Received: by 2002:a63:2581:: with SMTP id l123-v6mr1114438pgl.226.1529474321074;
        Tue, 19 Jun 2018 22:58:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id e68-v6sm2505326pfl.65.2018.06.19.22.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 22:58:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Vinod Koul <vinod.koul@linaro.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180619095430.26358-3-vkoul@kernel.org>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, vinod.koul@linaro.org,
        Vinod Koul <vkoul@kernel.org>
References: <20180619095430.26358-1-vkoul@kernel.org>
 <20180619095430.26358-3-vkoul@kernel.org>
Message-ID: <152947431955.16708.15247307054260887941@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/2] hwrng: msm - Add support for prng v2
Date:   Tue, 19 Jun 2018 22:58:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2018-06-19 02:54:30)
> Qcom 8996 and later chips support prng v2 which requires to
> implement only .read callback for hwrng.
> =

> This version of chip has multiple Execution Environments (EE) and
> secure world is typically responsible for configuring the prng.

Sometimes secure world is not configuring the rng though. I prefer we
have a DT flag for this to indicate if secure world has configured it or
not and then skip the init logic when the bool property is present in
DT. Then the DT property can be set on firmwares that are making things
blow up when we try to read the 'configured' register. I'd also file a
bug to qcom to tell them to unlock that config register for reads so
that things can work simpler, but who knows how that will work out.

It really sounds like the hardware isn't actually different, just the
firmware has decided to be more strict about making reads fail now.

