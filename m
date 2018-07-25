Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5679EC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF2B20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kzLURPZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF2B20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbeGYOOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:14:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37037 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbeGYOOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:14:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id q10-v6so7338020wrd.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 06:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z7ROy7xdIdPah1kTMmidVYAanE4QWBdp+HfElnZwYhM=;
        b=kzLURPZgN/Kch9p6rsjfsuDUAaX8C6oDBYJlBqBh+I1gasveC/ySEb4LUcTWCcGVal
         fIo2A6cF7DyQbv2GJipxgfGDFkovSI+kF6GWIt9GArcT+MgJR7CYHvkJIf0ohSMYu51w
         JbO5s5WDNU7neAg8XfbG97cIJN6nKx5DOrAIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z7ROy7xdIdPah1kTMmidVYAanE4QWBdp+HfElnZwYhM=;
        b=ilAqiRtl00ECCXOqvg87g6sMx3PxNg/EGZA6KZlfo4gdtJRKQG70USzNwQppVGnZp+
         MXDjkhFS0q1Nfo2b6NrgjtdfQAv+SKEzbEKXUNcMWqHvrU7+UVvPjJLIOGNQtdu/0dzD
         yRZ18qfAbacsRufXiGQYP7tRcN0CbKint8mpx/8HfMnuZ8NfnED2g7UZapPJU0QtUpGJ
         /BslNOAkxCpCo2bOB97kiJtCEm/AL1MI89KY0ZapEiB4ob2xtvjAkWB/ylsbisNDRnOD
         Uzcrxtaw+ronhHBJvQi932IRVG2nkqJNkv/zGe9Tv77zFP/Bpf9wYNtEU0XF+iu1juyc
         7bxg==
X-Gm-Message-State: AOUpUlHs1PeSIaJrHa0oR4oNB6F4dcTPOXNYB2C/1Nn5taKDiE6AolaX
        JHXFD4ITU0tJJ+iKJyDqezTk838BkD4=
X-Google-Smtp-Source: AAOMgpezCX0jlLXLeqos7DI9jA313HzHiHMmaV/N6mvcSyrbEtX1TZtApr0HCi5E7CDBzw48TjIX/w==
X-Received: by 2002:adf:9b11:: with SMTP id b17-v6mr14411245wrc.119.1532523781484;
        Wed, 25 Jul 2018 06:03:01 -0700 (PDT)
Received: from [192.168.27.197] ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o4-v6sm3433876wmo.20.2018.07.25.06.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 06:03:00 -0700 (PDT)
Subject: Re: [PATCH v3 17/35] media: camss: Add 8x96 resources
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     mchehab@kernel.org, hans.verkuil@cisco.com,
        laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1532343772-27382-1-git-send-email-todor.tomov@linaro.org>
 <1532343772-27382-18-git-send-email-todor.tomov@linaro.org>
 <20180724122154.nkb3px4tlzalhfit@paasikivi.fi.intel.com>
From:   Todor Tomov <todor.tomov@linaro.org>
Message-ID: <6914034b-9871-eca6-fa4c-86f97e76b8b8@linaro.org>
Date:   Wed, 25 Jul 2018 16:02:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180724122154.nkb3px4tlzalhfit@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.07.2018 15:21, Sakari Ailus wrote:
> Hi Todor,
> 
> On Mon, Jul 23, 2018 at 02:02:34PM +0300, Todor Tomov wrote:
> ...
>> @@ -61,7 +59,8 @@ struct ispif_device {
>>  	struct mutex power_lock;
>>  	struct ispif_intf_cmd_reg intf_cmd[MSM_ISPIF_VFE_NUM];
>>  	struct mutex config_lock;
>> -	struct ispif_line line[MSM_ISPIF_LINE_NUM];
>> +	int line_num;
> 
> unsigned int?

Yes, thanks :)

> 
> I guess if there are only such changes then a patch on top of the current
> set might be more practical than a new version of the entire set.
> 

-- 
Best regards,
Todor Tomov
