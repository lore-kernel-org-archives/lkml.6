Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF00BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F944214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VyNe58f2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F944214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbeIZVQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:16:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33532 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeIZVQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:16:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id r1-v6so15345211wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 08:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bi9XAZLyaE++Jim4rZ0U1DGpPcs7buVR3JryX9bbFmI=;
        b=VyNe58f2vrk/qECeNzj5X7yLo8d97KU33NL+c/j5xIekbW11SLUKaZ//nn//4kECXi
         4jr2IsoFVkQjsDFTKnD4G4Q/ZAmbC2sD9OrXgMVq1ildS8TbVWBWh/h7zXMfFMNqyZ+z
         bzFwrTd+WxzuWuU2jGShGjw7NJ5lA3ndf7h6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bi9XAZLyaE++Jim4rZ0U1DGpPcs7buVR3JryX9bbFmI=;
        b=rZK5HFn0KQJ9vmvuS+3XkjNufuTr6qagIzzPg9Mh2XuSg9lnf8t7jcslEnLeokRRjR
         VrmikXHSgyatNfZS7rupOMnKS0MsllOPn+GhtTdoWbNwPmbfnPH6SOXAtkdAGZlvr/Iq
         BHj45cqDuc6/6WSPEcGGf9WD+715W2r7Q7Sk009hzZ8sLTmzBsvEQ9F6/qPy4mL2tY/T
         9iKa4RFz/DDjEWSCw8kRl0rLy5YmNDVK5d5CYQgTYtFW5bAXoOaq9EHmWBhykieq8E7t
         BYj4nCSp8eSfURtoOlmKwDVGu/XdHX/TeDBbxIY4Hr59ShmU7kx8mpnGMAoy/+OaYw1K
         Ji3g==
X-Gm-Message-State: ABuFfohR5l3uUhpeUWHmuxMamhkiF81ufY1oj7GyehYMK304gw5yepHl
        6BcbHRvQUDbYhWH7NlRRuFk1UA==
X-Google-Smtp-Source: ACcGV61z9QTekFECNn5PIUUEjHX9ab6ishPNMC9Z2J1fTjHxMp+3IKW5+nJPHqrEpZgppXJq1/Gvtw==
X-Received: by 2002:a1c:dac7:: with SMTP id r190-v6mr4785027wmg.137.1537974201103;
        Wed, 26 Sep 2018 08:03:21 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id u23-v6sm3349970wrc.42.2018.09.26.08.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 08:03:20 -0700 (PDT)
Subject: Re: [PATCH v9 2/8] dt-bindings: Introduce interconnect binding
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, rjw@rjwysocki.net,
        mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-3-georgi.djakov@linaro.org>
 <20180925180215.GA12435@bogus>
 <b67253fb-d86d-2ddd-6c30-0833d6ed62ad@linaro.org>
 <20180926144830.GB25838@e107155-lin>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <0fd425c0-733b-825e-69ad-96294e5c911a@linaro.org>
Date:   Wed, 26 Sep 2018 18:03:16 +0300
MIME-Version: 1.0
In-Reply-To: <20180926144830.GB25838@e107155-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On 09/26/2018 05:48 PM, Sudeep Holla wrote:
> On Wed, Sep 26, 2018 at 05:42:15PM +0300, Georgi Djakov wrote:
>> Hi Rob,
>>
>> Thanks for the comments!
>>
>> On 09/25/2018 09:02 PM, Rob Herring wrote:
>>> On Fri, Aug 31, 2018 at 05:01:45PM +0300, Georgi Djakov wrote:
>>>> This binding is intended to represent the relations between the interconnect
>>>> controllers (providers) and consumer device nodes. It will allow creating links
>>>> between consumers and interconnect paths (exposed by interconnect providers).
>>>
>>> As I mentioned in person, I want to see other SoC families using this 
>>> before accepting. They don't have to be ready for upstream, but WIP 
>>> patches or even just a "yes, this works for us and we're going to use 
>>> this binding on X".
>>
>> Other than the 3 Qualcomm SoCs (msm8916, msm8996, sdm845) that are
>> currently using this binding, there is ongoing work from at least two
>> other vendors that would be using this same binding. I will check on
>> what is their progress so far.
>>
>>> Also, I think the QCom GPU use of this should be fully sorted out. Or 
>>> more generically how this fits into OPP binding which seems to be never 
>>> ending extended...
>>
>> I see this as a further step. It could be OPP binding which include
>> bandwidth values or some separate DT property. Jordan has already
>> proposed something, do you have any initial comments on that?
> 
> I am curious as how this fits into new systems which have firmware driven
> CPUFreq and other DVFS. I would like to avoid using this in such systems
> and leave it upto the firmware to scale the bus/interconnect based on the
> other components that are connected to it and active.

This can be used with firmware driven systems too. In this case the
interconnect platform driver will not manage the interconnects directly,
but will collect data and provide hints to the firmware. Then the
firmware can take into account these hints and do the scaling.

Thanks,
Georgi
