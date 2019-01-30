Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D520BC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A774D218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hLjlHbVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbfA3Kf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:35:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38043 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730394AbfA3Kf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:35:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so21142921wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 02:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZFJINRnvRiZX6jz//vRVRyvCkB+8htjpB1+oo+t/RnI=;
        b=hLjlHbVqmRv9OPWJ1rbNFjjlBJlxo5iGhC1clvjVhp5z8sSlIiaAiDuqLbscexrIQB
         LSuqnUpqHZrzSi4QQqdVKtTZvknHDbv0RcU4l4y5o1BHi3sREJt/z98xM/0+fyrpubDZ
         qJXd3kBpgxqRfXpxmFoKyN0Q1tCo4THk4GtNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZFJINRnvRiZX6jz//vRVRyvCkB+8htjpB1+oo+t/RnI=;
        b=Khg6eWJaXBspQAH9mCRYzQEBla9HVw26wSU2lRzlWkb0mz/SkzJ62NluvRQlEb4JSj
         /tgjD5xwsZPNEKkaBMq36L/1yC05nyamSEdCS1RZXp+z5WMR4H7ZUS/5MuGetPIZBV0n
         PLNBqIJl/MsL3Iohg7z4EddmaN6sOfZRyU6WoHfmASYPTzlVc4K1F6+DRmfk5fYVRiAL
         hw2eILQNuYKkqdzpYGS7XuQLPjikH4MPNbUQyeTssCDQskkfeKuzSBBeew/v5K0so9+S
         RHRoBCCd0ewryay2T26v0MuWHgyjXe89D4uZmoy1Zbs/dT5JpBF2w73956cJVAbLtXmL
         yAOQ==
X-Gm-Message-State: AJcUukdI7OgRZkhv6p/6SULSm7irb9oF7mek2cnW/xyR6iMnw2jRI7hJ
        HvV6NSR6RieohplRvLUxCzeQ6BhhL18=
X-Google-Smtp-Source: ALg8bN4mpUeb8C5ls4myWN2TbMKuil2Cc4HdVH+y/bpBsw+GlEV+yAwIIVAYrV86Bm6TnW3NgdUnuA==
X-Received: by 2002:a1c:a104:: with SMTP id k4mr24386330wme.54.1548844555718;
        Wed, 30 Jan 2019 02:35:55 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id d4sm1611373wrp.89.2019.01.30.02.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 02:35:55 -0800 (PST)
Subject: Re: [PATCH v2] venus: enc: fix enum_frameintervals
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190122105322.22096-1-stanimir.varbanov@linaro.org>
 <9651c01bf3f2adcc405963bfab48b7e7a5656494.camel@ndufresne.ca>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <3062ef17-ad35-68ba-5cad-be9de037e637@linaro.org>
Date:   Wed, 30 Jan 2019 12:35:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9651c01bf3f2adcc405963bfab48b7e7a5656494.camel@ndufresne.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 1/30/19 5:28 AM, Nicolas Dufresne wrote:
> Le mardi 22 janvier 2019 à 12:53 +0200, Stanimir Varbanov a écrit :
>> This ixes an issue when setting the encoder framerate because of
> 
> ixes -> fixes
> 
>> missing precision. Now the frameinterval type is changed to
>> TYPE_CONTINUOUS and step = 1. Also the math is changed when
>> framerate property is called - the firmware side expects that
>> the framerate one is 1 << 16 units.
> 
> Note sure, maybe you didn't mean to add 'one' here ? Why not just say
> that that firmware expect values in Q16 ?

yes, thanks for the suggestion.

> 
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> 
> Looking toward testing it, but I had the bad luck of using an USB
> storage rootfs, and apparently USB no longer works on 5.0rc+, if you
> have a baseline tree to suggest, I'll take it. Thanks for this patch.

try qcomlt-4.14 release branch at [1].

-- 
regards,
Stan

[1]
https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/log/?h=release/qcomlt-4.14
