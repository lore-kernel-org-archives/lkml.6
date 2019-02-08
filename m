Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CEDC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89C020857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dv5DSh15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfBHOBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:01:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51779 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfBHOBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:01:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so3554095wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 06:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BM3OSI7XT+WQwhQ6Ckq9ZONwL9lY+3XqG8eHDrPB9gg=;
        b=Dv5DSh15bBcOYfkiF3lDKJYHzXDXWkjFsGhMyIZFhHOgqDL+3K1wblfcrBMxInd5K0
         4xoTmk1TvJ43pNpyUhqysYnQPm/Eks5DqJ16BZ+2Onq4rdez6YzVg02rS7YfnmwozwXg
         KjfEpc7eK7UQOgGABKuQOmKBKEWB6R1d20wLfTKB6IS0ptLEG6OTgmVXT/tJexRs90EA
         qXmvaNoQOdwV9wc/4pqbyr8xfGn8ukAi7Df7DiQlqS1SBeEWInTOXaASTRGe7gRsjoM2
         LlahHD8Cboq4pE0yInXT8NjpUC/ImMo5GedleCpYrhjXCCkY54GRYoGRCqZHl4WC9Zmh
         S1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BM3OSI7XT+WQwhQ6Ckq9ZONwL9lY+3XqG8eHDrPB9gg=;
        b=mjBomPvp9VpWtQhP/8s/+U47x2hIs1ULWq4ohrqyTO3TQ/7Bq8p/ffRVpJDbCrFPSq
         BGi0k6IKy0ZNsUSHduy2kT2O/NMkzjnL1JQPG1XW3KEOIpZLob1+urNBSH5QCr18Dhqx
         Sv6eTfDV7dC6RhFW44THir3Gbl6mRSSMkBO0NAJsPwPGSZXXJfeieRskKIIcsTLNht3Y
         RUUh153p5Pg+bRLdtH5xKQ9UQ6e2vpQFCNi+xu2vp1BVlH5vWQz2xiyEQ5vuOXPvX4ot
         L4uZbkXsJd88TNnarlJAdiJ7YzpSFSCdQY1UlU/h+haw20Et7xk14O86L1kFaBrXTD6T
         GVIw==
X-Gm-Message-State: AHQUAuapiuncjlc2wl73aXL+qgKv+g3aFcLbB8QJZdanY1/E4bwRd7RN
        uwCADvfVU+Lwxi6Yq8B6Xx4lLw==
X-Google-Smtp-Source: AHgI3Ia/4zRdBtn7PSN8Iu7AeDVDKUFCRD+av2wch5+HpetFTJAiVwWHQRdbtIFxL8+e/MEdodP5ZA==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr12026485wme.73.1549634495955;
        Fri, 08 Feb 2019 06:01:35 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y20sm4599540wra.51.2019.02.08.06.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 06:01:34 -0800 (PST)
Subject: Re: [PATCH v6 3/5] misc: fastrpc: Add support for context Invoke
 method
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        Thierry Escande <thierry.escande@linaro.org>
References: <20190208132306.12571-1-srinivas.kandagatla@linaro.org>
 <20190208132306.12571-4-srinivas.kandagatla@linaro.org>
 <20190208135514.GA23406@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b60a0c35-6e5a-4166-9dd8-3891fce1cd0b@linaro.org>
Date:   Fri, 8 Feb 2019 14:01:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190208135514.GA23406@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review,

On 08/02/2019 13:55, Greg KH wrote:
>> +
>> +		/* Make sure reserved field is set to 0 */
>> +		if (args->reserved) {
>> +			kfree(args);
>> +			return -EINVAL;
> Am I wrong in that you are only checking the first reserved field in
> this array of args?  Don't you have a whole bunch of them here (nscalars
> of them)?  Don't you need to check them all and not just the first one?
My Bad, there should be a loop here!
I will fix this in next version!

--srini
