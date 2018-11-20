Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D901AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990B620671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAq0YMJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990B620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeKTUr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:47:27 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33220 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeKTUr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:47:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id r27so1446044eda.0;
        Tue, 20 Nov 2018 02:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q9extQQX2l+qVyozJE80R9sZWYftKswR06FON0tN78c=;
        b=YAq0YMJqW4MVq9btG0AWWaUr+v1HtdqoHivhpLmMA8KQTdIiFG9tUhj8inWXo80wqP
         QUSC7/ylk8UJeYEBy3ywnnX7bY69uhF3IW6ouXdhb0xncBsZVPx34O2fW9IrljhLMqwR
         B+dZUJ4WuP1tu1IQePcznCRl6M6IIZPB63ufx9FJGSWj+Vp1Oe6OQCWhG64/5v9DcsUL
         cGRPKGLFD1UYeUAnAyAtKs79UJyg/n6uJTo7unQrIucCCA6vbbFL4QPye4/IY2pI4MlF
         YPWrLNxzHHu3EJnMROz3GtEX/whkGB9bF9AWd6SIEvwFG0xHZ7ue1Sza9PR5up5R9yPX
         gMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=q9extQQX2l+qVyozJE80R9sZWYftKswR06FON0tN78c=;
        b=qv3u039qnNSoMj562IM8xDHEPCfaGeOkwA2StkifKLORbNhaiaFaYVKaOWyA6C5bAk
         HZaQY3PmM8fuEbNy5Hy9EU/niWnYTKJC5/U9wY2tnd2SO7cptGdtHv6JW5auVPHeuwPF
         Kq8go1OB/rTMKoUgyFTC3Mp1pes234d5qPGF0fEaCj0+WcLuF22VWHUn40nBANCMrinn
         mDCTUE5HkZrwjrMybZYFd+Yyo1nY/1+zqZEKjw0ntJh4pbl4NMxJ1rl3QHwa99sqndQQ
         qhvlCJcbXyJk6HFd1xJwzMW3ZvoSMJY2CQ0ua5M24gUS7o3nOH8YxKWss2eSYVudwZOA
         fShg==
X-Gm-Message-State: AA+aEWasYb5dkvPaSdV2LZzSnQeIER3KnfiA84gReZ8llMb8UCOM7LiS
        L8u9Tod4YTaUJGkXwS235AQ=
X-Google-Smtp-Source: AFSGD/XhuUf6Ohs8qNEFbPx+EAxrACcf/FBl/Pz0RWP+1N4ZGzyX6I9h3pkjnlRqcNiKblBFxsyUIQ==
X-Received: by 2002:a50:b222:: with SMTP id o31-v6mr1834215edd.11.1542709142453;
        Tue, 20 Nov 2018 02:19:02 -0800 (PST)
Received: from ziggy.stardust ([37.223.147.230])
        by smtp.gmail.com with ESMTPSA id w56sm2160548edb.72.2018.11.20.02.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 02:19:01 -0800 (PST)
Subject: Re: [PATCH v5 05/12] drm: mediatek: Omit warning on probe defers
To:     CK Hu <ck.hu@mediatek.com>
Cc:     matthias.bgg@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        p.zabel@pengutronix.de, airlied@linux.ie, mturquette@baylibre.com,
        sboyd@codeaurora.org, ulrich.hecht+renesas@gmail.com,
        laurent.pinchart@ideasonboard.com, sean.wang@mediatek.com,
        sean.wang@kernel.org, rdunlap@infradead.org, wens@csie.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-6-matthias.bgg@kernel.org>
 <1542605939.32082.12.camel@mtksdaap41>
 <0a02edf9-78da-dde9-4b69-38c4719b711b@gmail.com>
 <1542686700.9073.15.camel@mtksdaap41>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <9a445746-b07d-73e1-68c9-10eb9d5bf771@gmail.com>
Date:   Tue, 20 Nov 2018 11:19:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1542686700.9073.15.camel@mtksdaap41>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/11/2018 05:05, CK Hu wrote:
> Hi, Matthias:
> 
> On Mon, 2018-11-19 at 10:26 +0100, Matthias Brugger wrote:
>>
>> On 19/11/2018 06:38, CK Hu wrote:
>>> Hi, Matthias:
>>>
>>> On Fri, 2018-11-16 at 13:54 +0100, matthias.bgg@kernel.org wrote:
>>>> From: Matthias Brugger <mbrugger@suse.com>
>>>>
>>>> It can happen that the mmsys clock drivers aren't probed before the
>>>> platform driver gets invoked. The platform driver used to print a warning
>>>> that the driver failed to get the clocks. Omit this error on
>>>> the defered probe path.
>>>
>>> This patch looks good to me, but you have not modified the sub driver in
>>> HDMI path. We could let HDMI path print the warning and someone send
>>> another patch later, or you modify for HDMI path in this patch.
>>
>> Sure, I'll add this in v6. After inspecting the code, I think we will need to
>> also check for not initialized clocks in mtk_mdp_comp_init, as the driver for
>> now does not even check if the clocks are present. What do you think?
> 
> Yes, we do really need to consider mdp driver because mmsys clock
> include mdp clock. You remind me that mmsys control 4 major function:
> drm routing, drm clock, mdp routing, and mdp clock. Your design let the
> mmsys device as drm device (control drm routing) and create a sub device
> as clock device (control drm clock, mdp clock). If one day mdp device
> (may need control drm routing) need to control the register of mdp
> routing, would mdp device be a sub device? Or we need not to consider
> this because it need not to access mmsys register now?
> 

I think we should for now concentrate to fix the clock probing issue. If in the
future we will need to access drm routing from the mdp device, we can have a
look into this.

Sounds good?
Regards,
Matthias
