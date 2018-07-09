Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6365C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B0D2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LnCdeoCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B0D2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932938AbeGIOCV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:02:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42585 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754518AbeGIOCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:02:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id p1-v6so11123076wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 07:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q24IJngrAfQQ7NWQlCBlt1kZm1yK1YjEusqtYyRzwNE=;
        b=LnCdeoCvTfEmvYyrw3qg6/7kcmFxwHzQq72jrzLAnEnZjS3MoYgbPdm79hjIqQCXJW
         Wolb9bk+kpi2oi4k1I/t9oNLD4Rka64DW/X47BbZaZM0yo1azOAEdtUcueyCwoO8OvJ0
         XlS//UEmUasDf3o+w8ae0oxa6HOs0IxUsEVas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q24IJngrAfQQ7NWQlCBlt1kZm1yK1YjEusqtYyRzwNE=;
        b=cx67oYiCk2yNrTvTnD4Cg8Q+2Eg3jPzZE/GGLN1kpsD0VM9v6ZScm1lifbTa7Cp9Pm
         RsfVP1IbM8IgZ4Cos7cSDE+80iBwUU4iGNa2r4sanq0+FGEtF5tYshk62lUiMvKfypbG
         FYqiKPDN9SZ56Y5YvEPxDHMBz3TJWDb5WmwIvHf/BsR1PCrKlqKR743Fs2fczUzZ6/lz
         pf24OkAF1BmMGyJqOCJECkOV26xaoMbQfUxqzrOE2NJi0zYv7w96EKDgVH4WrT3nIbkm
         3Hu3d9hosw6TdJT2HOArXVMk6Xl36LaCYeuSuUbwiupmp3bBErDpLvZHOoMc6P31SRHJ
         ns8g==
X-Gm-Message-State: APt69E2RM7Fxi+uQcqYXlAsqPHcq/w8P9j/wFDuVylmd2LDxl8HXINH5
        Ds6EO+P+W96SChvfLW4j7LO7vmDwtZg=
X-Google-Smtp-Source: AAOMgpe78jZd8KhJPwiqEzMGdi72zbwz9/aR54A/JK0Dqnk3qy3J/kQD6iwaPytnKkAbSvurqAbH2w==
X-Received: by 2002:adf:c74e:: with SMTP id b14-v6mr13855247wrh.16.1531144933733;
        Mon, 09 Jul 2018 07:02:13 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id q200-v6sm7564883wmg.8.2018.07.09.07.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 07:02:13 -0700 (PDT)
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
Message-ID: <887331ff-8892-66a7-20bc-0fce447c792f@linaro.org>
Date:   Mon, 9 Jul 2018 15:02:11 +0100
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
>> AFAIU, The issue with that mechanism or EPROBEDEFER is that it works only
>> for first time.. for the second time(restart usecase) there are no hooks
>> like bind/unbind.
> This is not the case, the card will be unbound at the ASoC level when
> any of the components are removed and then probed again when they
> reappear.
> 
I did try this and It works only for first time! May be am missing 
something!

snd_soc_component_del_unlocked() unregisters the sound card totally. so 
for the second time (After DSP stop) there is no registered sound card 
in place.. Am not sure how this is supposed to work?

The reason I think it works for the first time is because of EPROBEDEFER 
from the machine driver.

Here are the steps I do with DSP:

Step1: Start DSP, can see sound card after all the services are ON.
Step2: Stop DSP, there is no audio card.
Step3: Start DSP, I can see all the components in debugfs but not the 
sound card.

This is what I do w.r.t code:
 From machine driver in snd_soc_register_card() in probe()
 From Audio services driver snd_soc_register_component() in probe() and
snd_soc_unregister_component() in remove()

When DSP is stopped the audio services disappear and 
snd_soc_unregister_component() is invoked.


thanks,
srini
