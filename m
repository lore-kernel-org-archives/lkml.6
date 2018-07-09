Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA75DC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4871420873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W6ccEgs/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4871420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754527AbeGIMrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:47:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37805 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754490AbeGIMrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:47:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id n17-v6so20635103wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 05:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m7MjXCDGUstU0fOkEUd4AQp+r+46FYONXGYFA8I3V8g=;
        b=W6ccEgs/bQok7BUy9Li6w4koHv9FpY1xObxadQRety4nm8XoBcKfVsMkmqKeqAjvrm
         ZXEAZahhUZfdV7Y2SJnYEIehpehGGFhCtPFCJRiyZqImXx3+eGDet5M17vFrMvRNwEPz
         HPeehsK/HO1GzvXhbs4y0Pw6gWEPs7O/x2ow8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m7MjXCDGUstU0fOkEUd4AQp+r+46FYONXGYFA8I3V8g=;
        b=E/9updkzY7eAgEv4Lm3NhnXPs6hL7qu3bbMHQbyaWGRAwzw6/4f/CG4deYK0DrBT7x
         oVGefMlZfwGK0xJmXs2fqYO0St8Hra+pSNiQvVnG5yoZ2I5jqdYpw28ZMmgUb1rID/8W
         XO9m8huaqg3lD5IdfNGFKgsnVtGCIuA7P6+Oz5c5cQhIzgyLm72F5KVH7Wb7Td8BoVh3
         vsZ8DolR5y+3AwGvT8kgfzNBKTGD8uywNm3chTbMmJtXR0UNZZa8X20fc+ezg6iY/2k8
         uzMjtEQu56t7cFxIXGMLOiTVa8PCwB5EgCWKvxW+q6sfaPDAiGryIqvSqJFo9zNoR/2L
         WbNw==
X-Gm-Message-State: APt69E3Vxh+ghpW5fh1hsDlNBOhIBgnzX8wxBLrRnSPB65lLEM5aLX3X
        /Ha1GN4wWZBJCfHDcyfPPkXImB2lU1E=
X-Google-Smtp-Source: AAOMgpfzYbhMsd8DPtGouGVbyWm7CeJvtG8EqwcdmjityIxQvRUB3oWJgLC7mvEpt1lqIbtEZho6FQ==
X-Received: by 2002:a1c:ea9c:: with SMTP id g28-v6mr12039874wmi.65.1531140427830;
        Mon, 09 Jul 2018 05:47:07 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id y191-v6sm20389269wme.21.2018.07.09.05.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 05:47:07 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card support
To:     Mark Brown <broonie@kernel.org>
Cc:     Rohit kumar <rohitkr@codeaurora.org>, lgirdwood@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
 <20180709111437.GB16082@sirena.org.uk>
 <b5a3f0e2-d420-603d-f9a0-f93bdbd2619f@linaro.org>
 <20180709124117.GG16082@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2c1539d7-d1de-f6d2-f30c-f79819ba7f2b@linaro.org>
Date:   Mon, 9 Jul 2018 13:47:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180709124117.GG16082@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/07/18 13:41, Mark Brown wrote:
> This is not the case, the card will be unbound at the ASoC level when
> any of the components are removed and then probed again when they
> reappear.
> 
I will give that a try now!

--srini
