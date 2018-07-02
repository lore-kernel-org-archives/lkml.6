Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851D6C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384B320C48
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GUyODOid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384B320C48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752730AbeGBPZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:25:15 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42080 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752326AbeGBPZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:25:12 -0400
Received: by mail-wr0-f194.google.com with SMTP id p1-v6so15976331wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yjztGT3g5D1e7/ZMryypwbd9V/47rJLyb2HVKolYaw8=;
        b=GUyODOidgQDxjYfDYV6MWYb4jqqPmW+r+iuJoSZU8vwwLI+b4Fd462FJH1iONuxjvE
         rTVGkOM+xfjOX0xFUWSLftn5rupnQhOwzHH0w0/2FzeiUH4LNdD+W0wcuT9c7FLYdqW0
         2GQPKTU3cyHw6nqcjJUtpUky6lRUJitw9bU0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yjztGT3g5D1e7/ZMryypwbd9V/47rJLyb2HVKolYaw8=;
        b=AdyMsvcpcwgORl/9yw3pjkIO/u1bgGPH1VHXgdaXfjAsGIUwARtYUGdn1919nTKm71
         KVSkaAzySFlhGWdTAXW5tXIQ47dCL882Nb3pUNcc84jwU6DkF4udZ8Ro795U+dDspIvi
         x7+VWwCWTKQGOYdV4+va2A3IvUjN0SvIzRuQoVb7RGeKrsjeHLPIHKheN8AmQqP6Y2yY
         XHZ79k3TlM/C1UU+mM9SXZhPt6GNVy4wRV/EbkJa5tVSdC0CjsQ9e+yrvLFiz2fywTmS
         Fv7Qx2fXo+EVMqB0GzUWEE+DykkjrH8C0KtWAnmgdMsfv2aGFUcL3lUc6zhF2dfJK6zM
         VrXA==
X-Gm-Message-State: APt69E2s+hNPQM34+V0n5rnNrqEkVTL1OUKUPkioc5FEuxeybX0tyIa3
        0yL5Erty2UaJ5jFcCJ2G3cMJZw==
X-Google-Smtp-Source: AAOMgpcoQ3U7cTZPDBclFj6R70ScERifeZps4jyjz10U1foNlB+Z3+Q5A/0r6Q77tFlj7IFfA86B4A==
X-Received: by 2002:adf:b964:: with SMTP id b33-v6mr21054659wrg.265.1530545111063;
        Mon, 02 Jul 2018 08:25:11 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id g15-v6sm15364135wrs.13.2018.07.02.08.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 08:25:10 -0700 (PDT)
Subject: Re: [PATCH v4 00/27] Venus updates
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, vgarodia@codeaurora.org,
        Tomasz Figa <tfiga@chromium.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
 <CAPBb6MXH7BpOXW++TxgsdRBr5C7PsHLO8jZtysGiNwUbkNW+BQ@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <6172d0e7-5557-7e2d-6ee7-e3d84050279b@linaro.org>
Date:   Mon, 2 Jul 2018 18:25:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPBb6MXH7BpOXW++TxgsdRBr5C7PsHLO8jZtysGiNwUbkNW+BQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Thanks for review comments!

On 07/02/2018 11:45 AM, Alexandre Courbot wrote:
> Hi Stanimir,
> 
> Thanks for this very well organized series and sorry for not giving
> feedback earlier.
> 
> I have tested this version against the 4.14 Chrome OS kernel tree (+ a
> few extra changes to comply with the codec API) and it was working
> flawlessly.
> 
> Therefore,
> 
> Tested-by: Alexandre Courbot <acourbot@chromium.org>

Thanks for testing!

> 
> For the whole series.
> 
> I have a few comments/questions on some patches, would be great if you
> could take a look. Also wondering what is your plan regarding codec
> API compliance? Do you plan to integrate it into the current series,
> or work on it after merging this initial work? Both ways would be ok
> as far as I am concerned.

Unfortunately I'm not ready with codec API compliance (at least for
Venus v1 & v3). I'm working on that intensively these days and I'd say
with a good progress but I still have few issues/details which needs
more attention and time.

So I guess the plan minimum is to merge this series first.

-- 
regards,
Stan
