Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82DDC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775FA20821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIPOxqOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfBEGVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:21:38 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53229 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbfBEGVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:21:38 -0500
Received: by mail-it1-f196.google.com with SMTP id d11so5707999itf.2;
        Mon, 04 Feb 2019 22:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9w2XowFH+2yP4F7GjYEGhQTaTKfmPbZC8CKgCdEn6ss=;
        b=rIPOxqOqp2s6Q5/wrjDW7/HEsiBqppw2U0FPho92MdEd6Faaw7LmxFIBTnl67BpFgG
         GJUu/vM++DYwaEZQV8OdfNP/ah3V1BZpF+aPA4zgiFEUjtAvdTisfCqKAfIZ6yvyNB0l
         1a7XQM+sS3OgC9AipIK2s4HRqGEQj/z8ouBlL8AsQ9GlJC+sImhTLQA3VWeCEmzaaKIe
         eGzZa1LP6yj/J5GoX6fnRMW7MEYNRoGMy30Y1BggMWyhq5Sb1QRMqtUXtTaPWM/gmUEd
         ajtoKUrMccDZI/V0/1bZWMRUg+amqO/omJzVigRJmech6HEftVV57ClW2FHSljWD+zju
         ocfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9w2XowFH+2yP4F7GjYEGhQTaTKfmPbZC8CKgCdEn6ss=;
        b=I8gxkueKfcb1D2IbCl69faiUmDYFha0MZlSK/FHvF9yzdzBs8kgoAThoey6i2b4ccJ
         ViKYZeoIyf4pKGPHrOGIdU89cjayonpSd5Xvs3mQoH5wPydHRBqHOmbHizY0T4MpDqib
         7ipipv3r/ylAAjxJFqPAP9tVenA/P1LGYfRkQYukl53zuxed2Am52EYblJsr08056Uoj
         ObnGLoxafjsAzp2bcr4mqWU66T02Vk2HTL1823IkVkf0rF9DAyMNG2sttyIqb59whJcB
         tvo4CKvUUnsugQP3cVh9mfHjcCTALdmqgQ4wIMgdzFnkOrl0ay42nBWa7mgKL3Ci4zQm
         mb5A==
X-Gm-Message-State: AHQUAuZRjYkpioJML80vQXCmyUfZ++iVDMIJqhdy1pvgMs5bT06VHNjr
        Cdmz5CyMFkXH/LguylOyqQ89HB7L
X-Google-Smtp-Source: AHgI3IZAy509VAV5yCio//OK9OH3i5VsBXBcZyRgN9n+a2A4MYPpvauAt3AcThg9yUeH4jSAeJ8oBA==
X-Received: by 2002:a6b:fd13:: with SMTP id c19mr1781276ioi.249.1549347696744;
        Mon, 04 Feb 2019 22:21:36 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id e19sm416875iob.70.2019.02.04.22.21.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 22:21:35 -0800 (PST)
Subject: Re: [PATCH V9 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
Cc:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
 <1549040867-18149-3-git-send-email-skomatineni@nvidia.com>
 <467a3ac8-5667-66bf-50eb-7d21a103d901@gmail.com>
 <fa8a64fd-87e5-a70c-5ee7-c6c100b712c1@gmail.com>
 <DM6PR12MB34033CFF789C5115721B5BAEC26E0@DM6PR12MB3403.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1d7cdfc7-c625-940a-14d1-5981cf16cb56@gmail.com>
Date:   Tue, 5 Feb 2019 09:20:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB34033CFF789C5115721B5BAEC26E0@DM6PR12MB3403.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

05.02.2019 4:37, Sowjanya Komatineni пишет:
>> I know that APB DMA driver enables flow control based on the channels spec, but still won't hurt to explicitly show that channels are flow-controlled. Ideally APB DMA driver should respect the device_fc field.
>>
>> 		dma_sconfig.device_fc = true;
> 
> 
> Dmitry,
> Thanks for all feedback. Sent updated patch V10 which has all below V9 feedback changes.
> 
> - Added explicit flow control settings to dma slave config and error check so need to move releasing of dma resources to separate function as I am using it multiple places (when dma slave config failed, on tegra drive remove, tegra_i2c_init_dma).
> As a part of this, moved error handling also inside init_dma as you suggested in earlier feedback.
> - Added apbdma hw support flag to now allow Tegra186 and later use APBDMA driver.
> - Updated to register tegra_i2c_driver from module level rather than subsys level.
> - Fixed timeout for bus clear to 50ms (10ms is enough but considering slaves responding slow). Also added adapter timeout to 6s considering worst case transfer rate.
> - other minor fixes.
> 
> Please review.
> - Sowjanya
> 

Thank you very much for keeping up with the new versions! The v10 is reviewed now. It is very close to final, but there is one new fatal bug there that leaves FIFO control register unconfigured in a case of error. I also pointed at some other minor cases that could be improved, please see my replies.
