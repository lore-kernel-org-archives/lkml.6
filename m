Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A85C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E432081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cy3Jf0I/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E432081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeKGS5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:57:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46980 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeKGS5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:57:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id 74-v6so16566910wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 01:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kzsHEXKCSz9oNSAslPbuQ6wO0DAVEJ2lqzxFjGs5m9Y=;
        b=cy3Jf0I/37E+GlRzLcsDbMNjytuuuZBDFn09CKheFMqy87IK+3gCuSybTAu5KRdj79
         rJhu21eTyDdtroVFegfGTVcsKAhzOpe5jb/jXwe81DyLrGPti0+NPMNLKySU93ShlJGi
         O4KIQrPSLC6s3sdq1X4yES/sIPH43d8UcTeBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kzsHEXKCSz9oNSAslPbuQ6wO0DAVEJ2lqzxFjGs5m9Y=;
        b=I3XolYCsRh42LWD1as+Xlf6QjAqIrfXXDiSqTNgbVy+sg3KmBwUzWFYV//bdggsiBW
         2md3y4rVJpdd5BTt11uZwHEytsAEAek0Sa7aC5gbnAiGatPqi9ZqhzK6lCkxBD7jMbgA
         46I773EusnOccUv/4v/xT9WqoKQayrThiemcpVhK37CSUEVzBjfFN+GdCb0E2M0Id2FW
         Nx/1/WtnbV6dPKsXrJvZslz3hAnHmSJeT3S8dD0nji1tOEyfVrZ9AxP3dG+1VgxNN0PG
         PuF4K8Mgp7NX855CnKFCTHgpV/2QMUUBHYgGYJM+5AGcsE//1h6qJQTsobn0FSoG1Km/
         9xIA==
X-Gm-Message-State: AGRZ1gLbDeqZliWZ8DsPdABIQEE6QxVVfLW3v1Yfm06a736wiJw4svcI
        uMMD70wrXmiI2uEW5NBbdtgV3EwEZx4=
X-Google-Smtp-Source: AJdET5e/DG2TpvyDE2JjKqJkSRIp2DGps+Ab06qbRc9ql2O/HQ9g9BMMSZEHutngsDXrom+JLiuyqA==
X-Received: by 2002:adf:800b:: with SMTP id 11-v6mr1093830wrk.106.1541582880045;
        Wed, 07 Nov 2018 01:28:00 -0800 (PST)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id r76-v6sm749718wmb.21.2018.11.07.01.27.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 01:27:59 -0800 (PST)
Subject: Re: [PATCH 1/1] slimbus: qcom-ctrl: simplify getting .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org
References: <20181021200045.2053-1-wsa+renesas@sang-engineering.com>
 <20181021200045.2053-2-wsa+renesas@sang-engineering.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <40978484-383a-6cd8-9d4d-9b3185583b69@linaro.org>
Date:   Wed, 7 Nov 2018 09:27:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181021200045.2053-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/10/18 21:00, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang<wsa+renesas@sang-engineering.com>
> ---
Applied to slimbus tree!
