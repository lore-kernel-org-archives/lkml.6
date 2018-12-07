Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59555C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3B820882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 02:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="o/dTB9Ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3B820882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbeLGCX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:23:29 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41883 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGCX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 21:23:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so1075404plm.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 18:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=39dDjOtUMVK8S//60tRMq1Q+A1EbvC8r41mT7avVFN4=;
        b=o/dTB9IePIat9xgvYvZd8exj/9xadC4owGYTwgJwjJjhBmwZOIRW6l0D8p9vp6byAe
         5mVfJ6sWxGnA0RkckXuBitEZLoOEnA7cYnPROAOMbHtoUiDaL/my/ijNlPTD3yizc8Ee
         jsTQ1aj1mA8iSkMaF2OrjEX36WjWapFD5jGkgktpQU65sNJCcdgK6rOVHPmI2wL9/Ufm
         w39TIY3pLm1LZdc2rYYxC2le5wmfWOQGSQ3d7jDEvi7CSD/A2fNle3PbLW+LUN4Tl6Wu
         4mxa0wDijxihahAL6lugYVQcDsPktch3PL7pz/QnhJ4SM4C32gbxgqBfxvItGlaKLUum
         c7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=39dDjOtUMVK8S//60tRMq1Q+A1EbvC8r41mT7avVFN4=;
        b=bnnYbWH4wmmbfZ5dtlphtCP4uBL2PuHwFpyocCibMz3z2yGyoIWxm8yPxVR7suRz0S
         sXTxtqdJKx0Cxnmuot/aJHYn8d1RtfSSAsev2IXLGpQ6hcP4YVGzhQ65q3+QPB5SWgaQ
         tRIzZg41Z75YNnXKi89PD820jo37LlHKXz2B+hG3EEfNKCU2MxKmXkK5jahLLFdhwwmB
         BURSXCvzsaqDIyj6MzupflQcaIJxJzBYDxfns8RXb4Gbfq9LCQavbcpDUcDQTkQS8UGe
         XyF1aEe288upCsa1/ZqEjAgXu/eAEtp0ih9y/oYQI/Oz9qn8O1QLyOfZIm44ainiJ4H5
         zo3A==
X-Gm-Message-State: AA+aEWaYxyEb89EU08JzIGGkI+eMh0ZNTRFNa9PJAKKwGjQa6dWaU75n
        FGuLYVBCEGClA1sHij/5DCVJ1w==
X-Google-Smtp-Source: AFSGD/UablN5UYNDKaM5ctfl9ySIllurdPGA2+lUmeZzwFpsFEljOxf94gVhuF3ZGi5nRcLCGCMWHg==
X-Received: by 2002:a17:902:6b0c:: with SMTP id o12mr408744plk.291.1544149407954;
        Thu, 06 Dec 2018 18:23:27 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g70sm3320778pfg.98.2018.12.06.18.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 18:23:26 -0800 (PST)
Subject: Re: [PATCH BUGFIX 0/2] bfq: fix unbalanced decrements causing loss of
 throughput
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, federico@willer.it
References: <20181206181819.11148-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <09393ef1-9559-2042-6c83-75ed3fd529d3@kernel.dk>
Date:   Thu, 6 Dec 2018 19:23:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206181819.11148-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/18 11:18 AM, Paolo Valente wrote:
> Hi Jens,
> the first patch in this series fixes an error in the decrementing of
> the counter of the number of groups with pending I/O. This wrong
> decrement caused loss of throughput or, less likely, of control on
> I/O. The second patch is a fix of some wrong comments, which somehow
> contributed to making the above bug more difficult to find.

Are you fine with this going into 4.21? I can't quite tell what your
intent is. The first patch has a Fixes for something that went into
this series, but then patch 2 is a comment update that would not
normally be something to be applied at this stage.

-- 
Jens Axboe

