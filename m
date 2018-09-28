Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C1FC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCBC20676
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VT3gWMlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BCBC20676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbeI1XyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:54:10 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36261 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729282AbeI1XyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:54:10 -0400
Received: by mail-it1-f193.google.com with SMTP id c85-v6so3566736itd.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QK6iQK0c12gCRFM3pzTUsm9jFyvxVoGxUVQQzuNIfjk=;
        b=VT3gWMlkrDG5TagEfhYHRisQ711D4roN1YuuRzx1AE9Ed/Jxd+x0EuYsss7neunzjk
         n8Eq8Lp7p1YUAHebvO2iOO0VZQJgFCl6a0emO80TdRm+bgS2qcSye6OTrzJgDoGFzJc0
         LZFjptURDuBlEU56RyEbPthYwMpqTfw9/KAsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QK6iQK0c12gCRFM3pzTUsm9jFyvxVoGxUVQQzuNIfjk=;
        b=nnCc3Ly/gKHeUhiXymyy3CHaEM+N7zQ1UU9Qsuc3cXn4qylIS8tAWK2LSaU2kKV2lI
         MnJUlMr7TBX4+HVb8dbu1qN/YqOTCKez+0Oh8DspZCN5z+2EFkj6RUvkIabk7PtUh0Bk
         tBXuyYClCASMNeWDMvhDWqDU2BcIO2nDbSGqUCrhzzA+t2R3dtYf+Ru/ANV1qbAjR9lq
         wYsHZCCBptxtZlqjqAKB6oUKqNKMP+/RzoLJDuZ8/tguYyzDQsW69+UiAd05o9Cpslpg
         LmW1qHrGHctWg6LISAykuRyPMhNjd/Ud15jPZAUGNfMCXM5D4BeoHiOtFhgy/SOXylBw
         3JOQ==
X-Gm-Message-State: ABuFfog9K6S8Iek53k191gYXHof8Kbj5g4qglF/J00LixXBFhETJscvR
        cgB7P/gDQJ9RL66eZBVyHWlgTIrjk8U=
X-Google-Smtp-Source: ACcGV61mOcHueuGzWfk33mX29tXLXvYcy8KwEgvfVu7ubukcAAJdyW81tvZd4CrSTi9U3fZ7WqAFDA==
X-Received: by 2002:a02:3f2f:: with SMTP id d47-v6mr1616765jaa.142.1538155762621;
        Fri, 28 Sep 2018 10:29:22 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id e78-v6sm467919itc.4.2018.09.28.10.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 10:29:21 -0700 (PDT)
Subject: Re: [PATCH] soc: qcom: qmi: add a prompt to QCOM_QMI_HELPERS
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180427140358.30839-1-elder@linaro.org>
 <ec0e7861-4bf0-f135-a881-1a1de4579277@linaro.org>
 <20180928122616.GA5249@centauri.lan>
 <4025f206-631a-55e9-9b7a-89dcf3370284@linaro.org>
 <20180928172145.GA5008@tuxbook-pro>
From:   Alex Elder <elder@linaro.org>
Message-ID: <c56c556d-e9f4-16f6-b4b6-a073e2443346@linaro.org>
Date:   Fri, 28 Sep 2018 12:29:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928172145.GA5008@tuxbook-pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/2018 12:21 PM, Bjorn Andersson wrote:
>> I have CONFIG_IPA dependent on CONFIG_QCOM_QMI_HELPERS.  I could
>> change that to select it instead but I still think this entry
>> should be changed.

I was thinking one of two changes:
- Add the prompt string (which I suggested)
- Don't add the prompt, but remove the help and/or add a comment to
  indicate that the lack of prompt is intentional (because it really
  looked like an oversight to me)

I don't really care though; I'll change my code to select it
rather than depend on it.

> Why do you say it needs to change? I tested this by just adding a
> "select QCOM_QMI_HELPERS" in my client drivers.
> 
>> I'll mention that SLIM_QCOM_NGD_CTRL in drivers/slimbus/Kconfig
>> also depends on--rather than selects--QCOM_QMI_HELPERS.
>>
> That's wrong.

Maybe someone else should fix this, but I can do it if you like (and
if that's the case, say so).

					-Alex
