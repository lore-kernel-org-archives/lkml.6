Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4692CECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F47208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QFCqgVlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F47208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeGPOJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:09:08 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33031 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeGPOJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:09:08 -0400
Received: by mail-it0-f66.google.com with SMTP id y124-v6so11591766itc.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 06:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=5EuMM+nh2sYZWNgZ2JY0oKWN3/CasCJWb7aGdQ2pmVc=;
        b=QFCqgVlOB96oa0QHL9amde0xYCayMlJwYL4drPWY6CbekKaUrzVA67QDtBym9lSxUK
         5DQJC6Z7X8gWc1wLrFi/Ecf4wsQ50fQIz4pmh3wnSfOQ1RRrylRrZgexDsQB6pkOWJdw
         9ddqFr4V3I5wss7k89/EOmgr9KHqq84/1ax7HUn/ZZuQsSS/fqeouXeEFegfIL/44TYc
         qUZ0hsSCPQFi/wwT2MvTHIVHdmqqFgAOwKIn3ikZDiKUbijIX2k9uRR9mLsejHG6GaKT
         Z9lwfSJPxhD4FXCoPs2ilaEGVrYkq9pHDLECjNFDHKzWiJOnkP1P3uGm6ssnoNsrUrTi
         ZmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5EuMM+nh2sYZWNgZ2JY0oKWN3/CasCJWb7aGdQ2pmVc=;
        b=mokqWi5ve637+4d77I2dMJ8kjPcoJfX+FKNm0Wx1E+Lj/3vAaluIQYqxcydXGrsV9x
         3kOGX5jQ50gSmNE8mBNmHNQIvzmiie379m7MptV0X2Qjq9PSSt4QzBUIg9FQIJfsC/VQ
         jqM76Y3Ei88j9K0ATz2ewh+ZWgLp2bJ2Fm9WF39IjAJ+J1Fo/sb/JURBf5a81/Q6v8oq
         owqNGZQ75hzYhiq7XqxXA/6Dh4fpEqYMon85w5yN9ZRN2P976PngYk8GHGilXcvSVaxl
         Qm9uSwI2HuZGkAqWFzOmOVLa+F4mI0zdvm4Necj43hau2wXbRM808nPypxRckJqitVkh
         3cFw==
X-Gm-Message-State: AOUpUlEmN9M3aRpwHUJkB0KKUqoObEu1VUydPgGiPBEEQVN9AMetsyqA
        LsKRPGibYjzNiHd1EqKjLmH5iw==
X-Google-Smtp-Source: AAOMgpeofl7aW/C4ZXYIyHWqK091lS7k1zbVdSAKeZKY1JFyRf1sIdx9MgLwRQ+7OK9Mf7yF+AOI/A==
X-Received: by 2002:a02:5c07:: with SMTP id q7-v6mr13734565jab.124.1531748496698;
        Mon, 16 Jul 2018 06:41:36 -0700 (PDT)
Received: from localhost (c-24-118-241-30.hsd1.mn.comcast.net. [24.118.241.30])
        by smtp.googlemail.com with ESMTPSA id w193-v6sm8428308ita.35.2018.07.16.06.41.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 06:41:36 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jian Hu <jian.hu@amlogic.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <jbrunet@baylibre.com>, Neil Armstrong <narmstrong@baylibre.com>,
        <qianggui.song@amlogic.com>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>, <yixun.lan@amlogic.com>,
        <linux-kernel@vger.kernel.org>, <bo.yang@amlogic.com>,
        <qiufang.dai@amlogic.com>, <linux-arm-kernel@lists.infradead.org>,
        <carlo@caione.org>, <linux-amlogic@lists.infradead.org>,
        <sunny.luo@amlogic.com>, <linux-clk@vger.kernel.org>,
        <xingyu.chen@amlogic.com>
Subject: Re: [PATCH 3/3] clk: meson-g12a: Add EE Clock controller driver
Organization: BayLibre
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
        <1531134767-29927-4-git-send-email-jian.hu@amlogic.com>
        <CAFBinCBB9N_p6S_-dfiV=zDCf-RYnA3C-ir6oNLC7JAfdOqqiw@mail.gmail.com>
        <be3c7332-3a7d-f8b0-efe4-e2a319273c42@amlogic.com>
Date:   Mon, 16 Jul 2018 08:41:35 -0500
In-Reply-To: <be3c7332-3a7d-f8b0-efe4-e2a319273c42@amlogic.com> (Jian Hu's
        message of "Wed, 11 Jul 2018 16:05:54 +0800")
Message-ID: <7hbmb7mh68.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jian Hu <jian.hu@amlogic.com> writes:

> On 2018/7/10 5:53, Martin Blumenstingl wrote:
>> On Mon, Jul 9, 2018 at 1:14 PM Jian Hu <jian.hu@amlogic.com> wrote:

[...]

>>> +static const struct of_device_id clkc_match_table[] = {
>>> +       { .compatible = "amlogic,g12a-clkc" },
>> I wonder if that should be "amlogic,meson-g12a-clkc" (I know that AXG
>> and GXBB/GXL/GXM omit the "meson-" prefix, but I am not sure if that's
>> correct - I'll CC Rob Herring on the dt-bindings patch)
>>
> For clock drivers,they omit the "meson-" prefix, But for common
> amlogic drivers use "amlogic.meson-<chip>-<ip>".
> So which type should we choose? .compatible = "amlogic,g12a-clkc or
>
> .compatible = "amlogic,meson-g12a-clkc

Please follow the existing pattern for clock drivers, omitting the
"meson-" prefix.

Kevin
