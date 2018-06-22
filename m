Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD39CC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538B923EF5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Njr913zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538B923EF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbeFVI2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:28:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38178 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbeFVI2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:28:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so1491746wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PT231azWRuPzo+zSXHscLO9gPu0qaceK8Sdl3gWpJiE=;
        b=Njr913zcUVVLhUAlaP+AtVz3enlPzVd90zZbvIbHThfRAdZ0YDLw0uWR2u0S5qNRoY
         Uq2+BIPaQNDha6/0gT1TWRKr8Bp9EPzzwifwdPNRViDSrX3pModi1jd/XHzh32EyRqkd
         Rb4nA8GXIfEXBtrs3D0MCOP01pUbqLYxcHpc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PT231azWRuPzo+zSXHscLO9gPu0qaceK8Sdl3gWpJiE=;
        b=a67DDbhX406sYqGzI5cS2JkHcbfPRRsxDs+GkIRm2cpvpFWyOhrS6Rfd4u9nxOcqCL
         DsvNSthHUZ6Eam0pI+U88XkfMYrdLGvIifo/6XQevjjk1+3grgyB57gW0VRUAv5gZ/Vu
         9CmmbcuTt8zEcM7jTUX2fI/tRLcu0crMTshf4G4+3kkSAlKmGIafvHweNUROyD/5USRU
         U4SNp/jJS2h74+g6xkaCV3NovqPcTMkXhGsq2be6xVHZlm6UVZRJgB8ceHRmdvfHwEP4
         jeThwlngppdpluUMheIuXA5xPWQ2VvBiLJNtmZCzl1lNgAuE6g9tttY0d8NkSQsNqo9p
         FU4Q==
X-Gm-Message-State: APt69E3RoinLN8mOq+munlFwUr0IJhxHbsbe8snNnnJV0e62Txp9r1tI
        kygbjvIdc0eRqYUp5yILoQZsBg==
X-Google-Smtp-Source: AAOMgpfvcWJVHMj12ru/Y6q34UsrIDoBSCe/qDyx9beM94084SxglZwhbf9JH3gqtQs0xGzOwC7slA==
X-Received: by 2002:a1c:bf0c:: with SMTP id p12-v6mr860920wmf.120.1529656080898;
        Fri, 22 Jun 2018 01:28:00 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id c18-v6sm10923908wrq.17.2018.06.22.01.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 01:28:00 -0700 (PDT)
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Vinod Koul <vinod.koul@linaro.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
References: <20180618141259.23141-1-vkoul@kernel.org>
 <20180618141259.23141-4-vkoul@kernel.org>
 <20180619142853.wgi5easw4zv6ttrb@gondor.apana.org.au>
 <966e9cd4-70a3-8d54-df0f-16df3df45fb5@linaro.org>
 <20180621101506.rnklbtapvfdev4xb@gondor.apana.org.au>
 <e39deb02-8fa4-84ac-b33e-d692402189a1@linaro.org>
 <20180621115312.rfmbitrhqi44wu5w@gondor.apana.org.au>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <6782b1c0-ea94-b07c-2fae-3fe3223bb22a@linaro.org>
Date:   Fri, 22 Jun 2018 11:27:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180621115312.rfmbitrhqi44wu5w@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On 06/21/2018 02:53 PM, Herbert Xu wrote:
> On Thu, Jun 21, 2018 at 02:27:10PM +0300, Stanimir Varbanov wrote:
>>
>> OK, I just wanted to say that it is _not_ PRNG and the register names
>> gives us wrong impression.
> 
> So does it generate one bit of output for each bit of hardware-
> generated entropy like /dev/random? Or does it use a hardware-
> generated seed to power a PRNG?

I believe it is the second one. Isn't the second one SP 800-90A?

-- 
regards,
Stan
