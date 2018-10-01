Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC24C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573762084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNfmlcox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573762084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbeJAUMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:12:23 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44191 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbeJAUMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:12:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id v6-v6so3061029ljc.11;
        Mon, 01 Oct 2018 06:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uCvlA4frLLPodqDfbT992RReBYbQpZtG057jr7ZEcQY=;
        b=lNfmlcoxykRX02fTAlFzH7SMWg+Ijxa96tFH1Y5E0irJrw3rHGZUlljuHGJeuyKdLf
         ohsLobqLhTTxdzggz9Z8AHGCGYQlUIROkuQlol9LlSTj48ObcvLEyFfb0ECoiVQ6pp9z
         aVLRRjqpC5CGTdGQdYi/8LwC4XdBY9GXfSQ1QYf+6Xm6BOQN+uLe5jiMIHQvMtDae4BN
         3/Tahki4nEF+yaPYpJqCME0MvcwWAweLzHAyVxRZlf/pmsoRTWEYHi2UMLNgMQf6ZjWY
         X6kwhNi9jwXtO4Ucdo2W/JXJRavzcYejA0Aansi2g8teo5sKFjfQkYnmV3T1wR2ErkwN
         lj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uCvlA4frLLPodqDfbT992RReBYbQpZtG057jr7ZEcQY=;
        b=J+9mAOrR5ol7bsTsHlJG36UxEDAK2hChGXyRiK4q7Lq5qjofKxqPo5YV8iymlozIJ7
         ExbDY+UAWRRpH+CErZWDXt9JKndz4/Qt6XdfuTmoVxyQf7lzKVa5rhTtLf50c58T8u+a
         uc4DykJqzUR8pWeaoRqEtzI9yU09L34Ej2F3cnh4Qvy+zQKaQtUnhzm+2ymNLllygxSC
         wjB6uQfbC1hI3Eoue/Hh1/RpAqfRyG4RtnEwvQ63LbFqPNoP+KKpW4K80iZS4jbSKTvZ
         yPDIv+6wc1ps7zrOGLeHRBzAmr+9qAGBTqirjyzM4A4iF/uFCotnPCSWd9GmVmw8MdBq
         f2mQ==
X-Gm-Message-State: ABuFfogx2CZ/1jNgWMYxoOd2NiOpEX+VHUG18A6Ws5D6Jg8LTdFhtfJs
        8dbdm+hdHAJ+4Exi953jwxg=
X-Google-Smtp-Source: ACcGV62M1/6PxjvMsZX9h6UtekQmGPemrObxuK+rihWs+c0DNpN52HNorvdWqe6mXpwp5udBWRalEw==
X-Received: by 2002:a2e:7312:: with SMTP id o18-v6mr6354978ljc.125.1538400870241;
        Mon, 01 Oct 2018 06:34:30 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id 16-v6sm2588688lfs.84.2018.10.01.06.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 06:34:29 -0700 (PDT)
Subject: Re: [PATCH] regulator: core: Pass max_uV value to
 regulator_set_voltage_rdev
To:     Maciej Purski <m.purski@samsung.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Carlos Hernandez <ceh@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20180615112916.GK112168@atomide.com>
 <CGME20180618140856eucas1p281619f9bf003655a3c2eac356216ab25@eucas1p2.samsung.com>
 <1529330913-11152-1-git-send-email-m.purski@samsung.com>
 <20180702080505.GN112168@atomide.com>
 <95655644-ef41-f5bd-7e8e-a257d48cd020@gmail.com>
 <20180928202251.GM5662@atomide.com>
 <2c0132ff-ea0f-f19e-ebfb-a0d077565d2c@gmail.com>
 <20180928224109.GS5662@atomide.com>
 <ea0a59ef-e201-986a-9499-a0638359b1b9@gmail.com>
 <d14cc796-8644-41a3-5135-299bd8820204@gmail.com>
 <20180929002753.GT5662@atomide.com>
 <dbaa721a-9a47-2c6a-46d5-92a7ca13c5aa@gmail.com>
 <20181001072510eucas1p29a6e504d642d2cac67ed7c3b43f9d53c~Za0l11ceE1868218682eucas1p2w@eucas1p2.samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0c279196-1609-89ce-206e-412ae1774fd7@gmail.com>
Date:   Mon, 1 Oct 2018 16:34:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181001072510eucas1p29a6e504d642d2cac67ed7c3b43f9d53c~Za0l11ceE1868218682eucas1p2w@eucas1p2.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/18 10:25 AM, Maciej Purski wrote:
> Hi all,
> unfortunately, I don't work at kernel anymore. That would be great, if you could take over those patches and finish the 
> work.

Hello Maciej,

I'll take care of the patches and try to push them forward, thank you.
