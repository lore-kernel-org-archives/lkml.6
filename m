Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C060C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFD42084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aALsZqQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFD42084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeLLLOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:14:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35199 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeLLLOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:14:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id c126so5489701wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 03:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g8SyXQ9COaSxsXx9oFa7PNdwXRs16W6POibOMy+1Ut8=;
        b=aALsZqQETI2ULW+FSgKUFtySVaQHur4w+Qx3u3+Yll0YO6vrUyxNFauzVnuRcQ3y6c
         HobQuCp3rmVfBtHLMSQVbUK2IevCWXF6sKK4SHscbbhXZugiLubFOpmuYj+Ihdl60HNc
         HP+2T7xXxFBL4w0m1yf9h+ji0hhrtYxiqPIvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g8SyXQ9COaSxsXx9oFa7PNdwXRs16W6POibOMy+1Ut8=;
        b=LrLtUAizsF2uC0o5psUe96S/NAL29KQLdQqe+LDjqzcNx5H6ZaqZ1XEpEu3sF780DG
         nM/r/EL/ExqtcqASoZUq1MPvGw2+CRPz9Y6wW70U4h7czF9YxTmFrl9FtwZB9G8o+bC/
         K4G54ivvW0CIH4ixc4KY6Hdz64fjH08bW3JOkxYqYsxzEuTBAfahBe55YClUPbIeq8eG
         CQ9riIM4+0ScXItWOlo1XNDwfNF2f+QSkXEJoW7Xwa/1Xp1ed0BkNpAxQoOZgRhMTMD/
         mWDuMIcHdRWzrbQsySWPB9u/fXxpY8y6uDcXiGRlEuTntZ5MnIGWuBA03jV36YuPLYoc
         RQog==
X-Gm-Message-State: AA+aEWaByQJ3yArlYK31Kaf60hOa7vMEPTpXNsRAxnwl6PCeSTcEYFzq
        PAHr0YhIyyteYWHS6sQC7Jgl8A==
X-Google-Smtp-Source: AFSGD/X/cq771MKukljmBX/QhS5nIEtiAp6g2Ya0ZOaYH6oFDR2JGUHOb1gfKKj0bszGXEE7H5kDHg==
X-Received: by 2002:a1c:e088:: with SMTP id x130mr5560903wmg.23.1544613287348;
        Wed, 12 Dec 2018 03:14:47 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id s81sm3437173wmf.14.2018.12.12.03.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 03:14:46 -0800 (PST)
Subject: Re: [PATCH v2 3/6] misc: fastrpc: Add support for context Invoke
 method
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        bkumar@qti.qualcomm.com, thierry.escande@linaro.org
References: <20181207163513.16412-1-srinivas.kandagatla@linaro.org>
 <20181207163513.16412-4-srinivas.kandagatla@linaro.org>
 <20181212110234.GB1990@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <224ec2f3-7f48-63c3-5e13-27e01fe53e1b@linaro.org>
Date:   Wed, 12 Dec 2018 11:14:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181212110234.GB1990@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/18 11:02, Greg KH wrote:
> On Fri, Dec 07, 2018 at 04:35:10PM +0000, Srinivas Kandagatla wrote:
>> +#define FASTRPC_BUILD_SCALARS(attr, method, in, out, oin, oout) \
>> +		((((uint32_t)  (attr) & 0x07) << 29) | \
>> +		(((uint32_t) (method) & 0x1f) << 24) | \
> 
> Why all of the uint32_t and uint64_t types in this patch, but not the
> previous one?
> 
> Please just stick with u32 and u64, those are the correct kernel types
> to be using everywhere.  uint32_t and friends are userspace things that
> make no sense in kernel space.
> 
> Yes, I know people use them, but we should not be adding to the problem
> by creating new instances of them for no good reason.

Thanks for the feedback, Sure I will revisit and cleanup such instances!

--srini
> 
> thanks,
> 
> greg k-h
> 
