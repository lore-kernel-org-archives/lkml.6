Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66A2C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C83E208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLnewOo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C83E208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933709AbeGJPMJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:12:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45086 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933508AbeGJPMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:12:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id c4-v6so2340371wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 08:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y5bw82GwtUG3RzvMIzaUtl5Ar7G2YUK8ipJJdTQVbhw=;
        b=JLnewOo9xn4QdfBX03nCkB6OioDtLxZrfU1YkZ8kCDL3H2pG6Y/sUwsYNT25F/CBxb
         Xt1SQBhlcyDidyGzIbv+2Fn2ppY2jd3/JNV9oe7fMVr20MdhxM38bqVGR50svCAxsXvk
         h2sMgSl8xdE8GDYnSI5jo7eEqQwFr802q4mf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y5bw82GwtUG3RzvMIzaUtl5Ar7G2YUK8ipJJdTQVbhw=;
        b=mrbUb37I4Co5/FmrmyJpa4vWXs29XvtGer30E9WhPRv1CwfTxDgNPgMeh+gP/4JXTJ
         ONpZBRc7siH8BZdS2RzmUNvP5YduSDxp3KOyKsEsF/V5+/7H1a2BqtwDpBS+qQeLPdot
         aIh5ax5nOzXGw5prv61XBa+gLeq1Vth62JXMrzngUpKgeOF4DifkksrEtNdgn2AFqSI3
         iYtkWOgHhis+B71nUUZRmX4HVzVeM16zhoQOn9W+b0RhdLo56KkMmTfU069EJRq7L9Nl
         WGi6iRJmckX2pb7GbQzlmxKffqBmnAbWp0IqQM8eIt2w1wLAZaUpS/2o2LxIXOCVLnh5
         5vmw==
X-Gm-Message-State: AOUpUlGyJUOfS3HyL5/rfMuW0CTbxgLFPawIkQNwDoSfdd+5n6qiB7MT
        YBanNeFmgqkwxaSZ3JrM7ah8cA==
X-Google-Smtp-Source: AAOMgpdO0yO0W5PHrJkSpOtxqgGG+BoCRUFTT5oH/aKF8K0UpApi+YNdZaljUVjxwWQQKS9S2XhAQA==
X-Received: by 2002:adf:a599:: with SMTP id g25-v6mr7264548wrc.88.1531235526744;
        Tue, 10 Jul 2018 08:12:06 -0700 (PDT)
Received: from [192.168.8.101] ([37.173.242.72])
        by smtp.googlemail.com with ESMTPSA id o10-v6sm12413555wrw.79.2018.07.10.08.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:12:05 -0700 (PDT)
Subject: Re: [PATCH v7 0/5] Reintroduce i.MX EPIT Timer
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Agner <stefan@agner.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?Q?Cl=c3=a9ment_Peron?= <clement.peron@devialet.com>
References: <20180611155001.3506-1-peron.clem@gmail.com>
 <CAJiuCcf3g2fzrR2_4mthjwKRcyZ8KVPX+EZ5_Uifh2E6TkzusQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <52591c2d-e9df-7078-7cdf-0fd8d06c9ee0@linaro.org>
Date:   Tue, 10 Jul 2018 17:12:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJiuCcf3g2fzrR2_4mthjwKRcyZ8KVPX+EZ5_Uifh2E6TkzusQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2018 16:55, Clément Péron wrote:
> Hi,
> 
> Is there still some remark against merging this ?

How do you want this to be merged ?

Shall I take the two patches related to the timer ? Or Ack them ?

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

