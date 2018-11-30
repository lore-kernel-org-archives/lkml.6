Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89375C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E4820868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q8GMlLne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E4820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeLAD2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:28:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40240 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeLAD2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:28:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so6242005wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 08:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5VYtqk+6Y4GmeXPt95TWj5nRvGbBu+D5KoYYMslz+DA=;
        b=Q8GMlLneu7FsdVxLXZzeJseKvXYTqT37dLIeGkF+eaHNs092GqKzK6a37G15BN4MmY
         BMYuPZVhxvaZEMQIIy+wanpZCL+M4W4gxarwhfhKn+tesZMSgCPfI9PfFsaOaO8fQ2sV
         BkVKdTw9W/HpOkxEMwqs6Wbb8HqceMlpJTHgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5VYtqk+6Y4GmeXPt95TWj5nRvGbBu+D5KoYYMslz+DA=;
        b=rqpLsW7+pwNpIGY90KoU7+eFS2ClEcLMZRFROWjIjvXkf0J9DSbMGgcr5wBQmw/yVB
         7eJ2ELweX8KDG8wO3jZimEyk9cDs39VC5Bl0XhCYGhCUJ4RC/MYUotG0DlKtXojo5Hpk
         Grh0GAu2ocm3lZvHrX7fHjVjZeiS0ulI+qTmnYVnuHPDqbyaG4vjF88esalbSi7u+0uW
         Pzro0qLQDpGpvfNZpSQf4LmomFk9LzjWSdeQnq2Gl/dEQTsrkNi6ulpor8a3MH8Fia2c
         jyFqaSkMN+QcJ3J8T7usr9pXclDL3EryvfKs0Um6DWS+FNhLwt3p1pq0nm1mf6354QO5
         uwRA==
X-Gm-Message-State: AA+aEWYy1KYTEfRdby9M6t+0MQia9UG9B2Cb95VRi9wSTZ4unbrvOMaS
        B9pRBI8c+BFOT8JqFUUUDqunyw==
X-Google-Smtp-Source: AFSGD/XErmnZdzeJReipuTMeDCiARU+oCmpupR5X6n9ebnjENc/jvos+uNBDU2IyObBKWg4fWfh8xA==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr5939847wmc.5.1543594742617;
        Fri, 30 Nov 2018 08:19:02 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id m6sm8967595wrv.24.2018.11.30.08.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:19:01 -0800 (PST)
Subject: Re: [RFC PATCH 2/6] char: fastrpc: Add Qualcomm fastrpc basic driver
 model
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        bkumar@qti.qualcomm.com, thierry.escande@linaro.org
References: <20181130104657.14875-1-srinivas.kandagatla@linaro.org>
 <20181130104657.14875-3-srinivas.kandagatla@linaro.org>
 <20181130161324.GA8031@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f90fa38d-11a6-0767-7e42-b9a6b8ede85a@linaro.org>
Date:   Fri, 30 Nov 2018 16:19:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181130161324.GA8031@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments!

On 30/11/18 16:13, Greg KH wrote:
>> +						"sdsp", "cdsp"};
>> +static dev_t fastrpc_major;
> Why do you need a whole major number for this?  Why not just use the
Not really!
> misc interface instead?

Sure, I will give that a go!
> 

--srini
