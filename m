Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C34AC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BA72086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMgdYgL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BA72086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeIHTqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:46:36 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39177 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeIHTqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:46:36 -0400
Received: by mail-lf1-f67.google.com with SMTP id v77-v6so14234029lfa.6;
        Sat, 08 Sep 2018 08:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pj7Kd1/gqF+ugIbZp65oBUSCAa5JDmldtMrmra3C/Es=;
        b=RMgdYgL7yJMX/JIkQxOTae9LJ9/3elBVeKVAU1zvnTWqCnSbkFxKUO9Fu+YyFjJtkc
         Z8rvD1IeUUtci3a+Meo+YWp+WTw74osmvkHfbLB8OhN+Ji7w0TyCZ+WJnV7GHEtaZRIX
         i0NkRi5NaJur1svBQC5XP957Ir//MjsJgisFym0QRuVgadATbfFJ8TqMo682/3EF9APg
         MUmlWuXQHyvyKcbIhgPRq6I+MTK+6PY+YNNpd05HmaelO1eAoljfWNfEeL5r2iVMnPXN
         Z3Y8y4EIe6PCBhICoe2zGFSuu3/8WCPBRSOHUZrHv3R8EFT3Nv6S6b9sHneCi5tKClK+
         +RTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pj7Kd1/gqF+ugIbZp65oBUSCAa5JDmldtMrmra3C/Es=;
        b=soyNtMqn9VU2oT0EWjuOfy5eRip63O4/ODbrJdR8gTkhVQI3OaL18u2Rh2ppvYeidt
         rzuYzFVdKkQroOdeKiazdO3NrZSEDJTooS6hzw5SRsaI2ZtqL1IUZUyT1AcCYI4riaKj
         eRnbQRtj37VPABPz+yrKQETgAx80foNqWN3c71YzZiuw4t5cqIPx9rbtI3MnxcX7Q5yV
         3T5/tJtqlPZs12ZqEH1PuRZH9ubdKnWlxqpgY2DGBhbEfKjFbmFZK4HrSxkz1WUOyvB+
         XGJSseGAwma6wkXMMu+zJcwjgPIDX50lCfRZLydCTTFoa7enFlyTGIPcvShSchCdcDO7
         oCmA==
X-Gm-Message-State: APzg51BClfmHxvBxJbxZpp7J5cnJL/tMDOhywIKhTBfV/x3mneaYq2mZ
        xhXARmd9fW/yWK4mfxvNn3Q7YaB9K30=
X-Google-Smtp-Source: ANB0VdYs6vVPq358jcPmMpxTdK7KWrvvLtdBA+HMQnQboxveu9H1Ii5UtN1WzSxm1icQwpgAS963ZQ==
X-Received: by 2002:a19:d78d:: with SMTP id q13-v6mr8034718lfi.27.1536418829657;
        Sat, 08 Sep 2018 08:00:29 -0700 (PDT)
Received: from [192.168.10.160] (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id n22-v6sm1775053lfh.59.2018.09.08.08.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 08:00:28 -0700 (PDT)
Subject: Re: [PATCH] ethernet: hnae: add unlikely() to assert()
To:     David Miller <davem@davemloft.net>
Cc:     huangdaode@hisilicon.com, igor.stoppa@huawei.com,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180907172650.29408-1-igor.stoppa@huawei.com>
 <20180907.144659.284526279757617907.davem@davemloft.net>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <aaa1a5f7-6809-794b-f6e6-b5b2ae34b046@gmail.com>
Date:   Sat, 8 Sep 2018 18:00:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907.144659.284526279757617907.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/09/18 00:46, David Miller wrote:
> From: Igor Stoppa <igor.stoppa@gmail.com>
> Date: Fri,  7 Sep 2018 20:26:50 +0300
> 
>> The assert() condition is likely to be true.
> 
> Worse than that is that drivers should not be definiting their own
> private "assert()" macro.
> 
> I'd rather have that fixed instead.  We have tons of standard kernel
> facilities that do what they are trying to do here, without overloading
> the standard C namespace in this way.

I've converted into WARN() what passed the compile test.
In one case it didn't even compile :-(

I could only compile-test.

--
igor



