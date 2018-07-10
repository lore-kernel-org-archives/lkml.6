Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9816AC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6A7208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vw4PdAuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6A7208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934272AbeGJPhc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:37:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41248 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934205AbeGJPh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:37:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so8581449wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iB3NQWhNtvhrYaPl+I86BSep0jrycQY/IplfPd7Cyh8=;
        b=Vw4PdAuAX8t1iqM8+V+FZe2+waTvy1cHI5m/ShGplYWGTXNsBvgl4jeTzXrtRGLdpr
         nCrBdkTffabL+RbI+hrhzsHS3YtLNqaOTBzRA46SiwfYNuMp4gufTR0pehWkHXVrCbV6
         qxEdIKoixAupoBC/jzQxpwBdCG5BI8ni+7SPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iB3NQWhNtvhrYaPl+I86BSep0jrycQY/IplfPd7Cyh8=;
        b=jyGEOHwjDMwCsMcUTW6NoUMSP11LEgVOa00P+ry0GOgG2ud7+tIULHTS8qKKGiCQd7
         oMS01b5sj3xpV3o2DDuXcUaElu3Ahlt+3HmYqIU9C3XDScgz9RvQoVSSp0TUyUbcGQPy
         WNA9vO/uLzou2e9jb+4aexfUWAa5NUPh41F0/6zHRMW4uB5Prh/82D2E9u5IlT4kTWbo
         9fI+Z2oEQKxjdyf3D1ESM8pS0kfy/0LVhy6D1ZDgoi1YzeVMAkKfzULEhL6MGG7R4hv9
         0hvEaEWU/0VBEU6ZzKOPie8uyh8TRxf3wVMfg7/bmKGQlREnsT2esBj3vx3514U8huB0
         JOtg==
X-Gm-Message-State: APt69E3Oxs7EcMkfT38eNldDbSa+8iERPk4uQNVgZML+knxFlalEwauG
        qaOPA1hYu2xV5MiYWKqCtfbOLQ==
X-Google-Smtp-Source: AAOMgpd9ZB6vlVvoqltTqcHiFO7+ubLm//QTyVufCNHfXUhqeuf3mJM2hL/iX0CK77moYii1fmlI9w==
X-Received: by 2002:adf:e14a:: with SMTP id f10-v6mr17244218wri.42.1531237046278;
        Tue, 10 Jul 2018 08:37:26 -0700 (PDT)
Received: from [192.168.8.101] ([37.173.242.72])
        by smtp.googlemail.com with ESMTPSA id i9-v6sm14561089wrs.92.2018.07.10.08.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:37:25 -0700 (PDT)
Subject: Re: [PATCH v7 0/5] Reintroduce i.MX EPIT Timer
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
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
 <52591c2d-e9df-7078-7cdf-0fd8d06c9ee0@linaro.org>
 <CAJiuCcc-eGRr_RT01dNfhQso5PbXfWy+YZS4PHHcL=_yhA-3Sw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c9db3848-378f-8e1e-c194-53d878894716@linaro.org>
Date:   Tue, 10 Jul 2018 17:37:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJiuCcc-eGRr_RT01dNfhQso5PbXfWy+YZS4PHHcL=_yhA-3Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2018 17:22, Clément Péron wrote:
> Hi Daniel,
> 
> On Tue, 10 Jul 2018 at 17:12, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 10/07/2018 16:55, Clément Péron wrote:
>>> Hi,
>>>
>>> Is there still some remark against merging this ?
>>
>> How do you want this to be merged ?
>>
>> Shall I take the two patches related to the timer ? Or Ack them ?
> 
> I'm not an expert on how submitting patches works, it's the first
> driver I submit.

Ok, so usually this is what happens when there is a set of changes:

 1.  they all touch the same subsystem (eg. drivers/clocksource), you
just send all the patches to the maintainer(s) + mailing list + related
people

 2. they touch different subsystems:

   2.1) the changes are not connected (not related together), you have
to split in smaller parts and send the patches to the right subsystem
maintainer (so falling back to 1.)

   2.2) the changes are connected:

      2.2.1) Ask all the different subsystem maintainers to acknowledge
the changes and submit the patches to arm-soc@

      2.2.2) Ask each maintainer to take their part if the changes are
connected but not interdependent (patches individually won't break the
system)


You are in the 2.2) situation. My question is do you want 2.2.1) or 2.2.2) ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

