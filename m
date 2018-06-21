Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489EBC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A4520883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="mIJ3x5I5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A4520883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932718AbeFUOMa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:12:30 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42232 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeFUOM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:12:28 -0400
Received: by mail-wr0-f193.google.com with SMTP id w10-v6so3367430wrk.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 07:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tRjXKG2YSsIESE5mCNpsB8Pz7HSn1XtoO1Gd3DnvLeI=;
        b=mIJ3x5I5BJSEHIEB3Ra2RNpWxaRBvd+TNxKUumCWHc6Z6SZfPL0KCtoZ48u2itiCBI
         nQAXr0YjEnRdnqFj68QFQiAnkv2PqvEQNTDRoM0Vj4rsX6sb06d1y85+rZP5fTJp3tL4
         5VC1AR4LpI4b78540iC0gn7ph5mBEntF26VA7yMohOKKsY8CVrIuiC8bSfJzLTDl0pU0
         Hf5HzKOtlcUmNjatcDg1GbyOB+T3uWg27ev5BxGzEO5vl8kHQVtGpdAe/ABFU7iZSJ5d
         nNV4u+GG1peHkIlfaNyt43YenzLfQtWpAXCfDLXs1SWPhJOjSFLlS6OS2CXgdg7NHJkI
         GMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tRjXKG2YSsIESE5mCNpsB8Pz7HSn1XtoO1Gd3DnvLeI=;
        b=f6kuRv9OxBWhI7vtxPGixEW0J/Ak+fHi1dd+stuwtb0V4IuOdh/KD2P0ENaB1gE0mf
         dHQ7TrRvYL8Dr9nnFjnBw1ur69F0fyogKYWASNGTqULBoZck+hWheI44NKWtsKZDuRoX
         l7rJOQc5nar0LFjnuo2N20l9MIIgOxtUdMmFLqqI0LvRsoFW2fktyIHp8bosyAcMYsOR
         5T11asE9zmx227VIdJiPECSfuWiuOZdTVJQGq6KuE2XpCfR/it08IVWzw/w3geRJ95ch
         xoaADJjBX/nG80CeUdW5gS7sjbLVYYtiS6f7m8zQOxTNH8Nt0RM0QjgVEFIe8sN+0HCL
         +s4A==
X-Gm-Message-State: APt69E23Vw6Tw4I2jcTZ8/lJCbR3cevNilUU6w004POaACqs71xkFHRN
        lPwjtsU8Nm/jWWvySTZoT35HOg==
X-Google-Smtp-Source: ADUXVKIRXvCMJiwtFvNLd70nnAaaeE6eUndy8dWiOXqsRwQdcspYJaEIFgcfQgtvU4ueFUXVjlhvVw==
X-Received: by 2002:adf:ebc3:: with SMTP id v3-v6mr21698142wrn.33.1529590347082;
        Thu, 21 Jun 2018 07:12:27 -0700 (PDT)
Received: from [192.168.112.17] ([89.249.64.228])
        by smtp.gmail.com with ESMTPSA id g11-v6sm5641419wrr.46.2018.06.21.07.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 07:12:26 -0700 (PDT)
Subject: Re: [PATCH] usb: chipidea: Fix ULPI on imx51
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>, linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
 <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
 <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <0f31d801-528e-54ee-f385-b7aa3eef414f@cogentembedded.com>
Date:   Thu, 21 Jun 2018 17:12:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> This patches causes a regression on a imx51-babbage running 4.18-rc1:
>>> I get a kernel hang.
>>>
>>> If I revert it on top of 4.18-rc1, then it boots fine and USB host is
>>> functional.
>>>
>>> I understand this patch fixes a kernel hang for you, so which commit
>>> is responsible for the hang you observe?
>>>
> 
> I never assumed it was a regression and that USB worked on RDU1 board
> before, so I never tried to see if this was a regression. I can only
> tell you that it hangs as soon as any PORTSC registers are accessed.

Hang at register access usually means that module that owns the register
is not clocked.
