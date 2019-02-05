Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D984AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28D52080A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkpe4GaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfBEKdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:33:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38078 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbfBEKdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:33:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so3042987wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 02:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5iYPoJKIWzATmc5t08fYys7G4ZVYqTJ0FmD9tPhO/Qw=;
        b=gkpe4GaFTNEp5N/MiEnhcto4J9ob2MYucmY5GPBeLza0MHVzhaPQopMvzCwLBuLvVX
         Ua7jHkVbh8MI74MjtLnXdw5KsST/3xm64JNzoa0V6oot8CcRzt+C4r58LIVQey5fjZvT
         yLIzpK+FbzHHS5FO1Jwkd937rEn/I1l95/pqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5iYPoJKIWzATmc5t08fYys7G4ZVYqTJ0FmD9tPhO/Qw=;
        b=jMIcZKrFCE2McADfaKFuTusovJEtagYbVg1+NpdEMV5pa8rJbC0E9bCNSDbeNu9WA/
         yMK/YODy/2T8V69wPqIu6PqwpdITKa0YPw3huGzZ510pACZ96kkhB2YAC2rHTs0gOLC/
         3j2B5kbDu+uLYjK+//YM40uBkdAxwzzAomb4ScxK0C1uDMMXGA+WFsI4JN6dwZ+hGBYc
         kGmxaFpsnw4T3ADFNa/1cYL0O60iZbSXyEqERRVSKAGZXIbbNj9lTh/KifOvSprgRfgG
         wlXcnk3uUD6EdsjiHZk0QB81g7nQjIqayaIJ0JT83X0EXJjWP+JgrdaPB+t7trGlSYC0
         xzfw==
X-Gm-Message-State: AHQUAua8V/AmTTmYXXtcCPPF9oiitcGTDl2WhBuPQyh1mS9ySDZk2tX5
        lDynwFY/FaoWSve3ZKDtZhBpsqGpXyY=
X-Google-Smtp-Source: AHgI3IbHv8LsZ8FNKnaf7MGhzsNV/FKIPIfoqWTsMHrTrKg1pucYBNUT004qx0jkB8fewApPQoSP2Q==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr3229446wmi.10.1549362817408;
        Tue, 05 Feb 2019 02:33:37 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id x81sm12296320wmg.17.2019.02.05.02.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 02:33:36 -0800 (PST)
Subject: Re: [PATCH v2 1/3] firmware: xilinx: Add zynqmp_pm_get_chipid() API
To:     Michal Simek <michal.simek@xilinx.com>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, jollys@xilinx.com,
        rajanv@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190204070951.6933-1-nava.manne@xilinx.com>
 <20190204070951.6933-2-nava.manne@xilinx.com>
 <d949520b-452f-9e66-42ae-263959a8c549@linaro.org>
 <f317c341-9706-3a24-6faf-711f2627bcce@xilinx.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <bf3f2ab4-f355-c862-f2bb-2bd579b0cafa@linaro.org>
Date:   Tue, 5 Feb 2019 10:33:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f317c341-9706-3a24-6faf-711f2627bcce@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/02/2019 10:29, Michal Simek wrote:
> Hi,
> 
> On 03. 02. 19 9:50, Srinivas Kandagatla wrote:
>> Hi Kishore,
>>
>> I need ack for this patch from Michal Simek to take this via nvmem tree.
> 
> not sure if my reaction went through. Just for a record. There is high
> chance that there is collision in firmware interface. It means if you
> can ack/review that patches then I would take them via arm-soc trees.
> 

I got the message! There are outstanding comments on the nvmem patch!

--srini
> Thanks,
> Michal
> 
