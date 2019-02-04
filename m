Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D391C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588FE2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ATBHK+hW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfBDXJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 18:09:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41059 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbfBDXJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 18:09:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id k15so634691pls.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 15:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y2om6UT/l9LBxzHzTDDkIIcT7sSkp/nQCgPs5IVDnHw=;
        b=ATBHK+hW5j9xEY1CB64aXDioHleepLiYMqSqSCmmLglCK1CDrpsqZ0Rl5mCQftNSU6
         KGhkOU+wfUzyj+Vu62o92+lqyquoMEzaNiJsE+3dmV3XEFNor1iHt+iunWqQ8jE4xWGS
         NFUCYsziIGjJinvh3eC0fTSxSfHSJlO6G7JMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y2om6UT/l9LBxzHzTDDkIIcT7sSkp/nQCgPs5IVDnHw=;
        b=gOl1a1Yau9yTrS09IIIoJu4ulk1Sq0jH2bOROaSH1uN584wsR06vj1oxJR1aIMz3qs
         ehRI3rBuIc7LTlg+Hc2OmzbbEJ7fFpfkJDVvId/tn6ShYqMG7YOFy2R4bskt9PAn6HhO
         S0fEMPexMKWRAj9M6HhZbDav2w++9N6rK1322KtcTsj6YfE0onHR3tSWEsSOso7xjit4
         /M8pX4M7+EaitFlVtD4Eun2T6s60HwPXwFkY72/vwI+pEzXtamCnmT/bkO28w7WlND6L
         qiJIKjZf7hKMcE1LUtszobkbJ9Bt6FlIIxS05dmTVRkifqPJoleNSvNhoY4GP3Gxv+8F
         7Mpg==
X-Gm-Message-State: AHQUAuaLikFp4nwjfRM7XQE/ymEzTqxefXhTYgUyFmBJLCKXB6Nw43Nt
        ZSXZ6xOyk2cdw5mqQdNL/HdseA==
X-Google-Smtp-Source: AHgI3IaQNOT/SNT606HAwVugKeo4ZqvDQboF13nwdkFCEkbCkT4uw28sOoM/PcDfVDcTLAmGzZBpnA==
X-Received: by 2002:a17:902:e307:: with SMTP id cg7mr1880274plb.255.1549321793964;
        Mon, 04 Feb 2019 15:09:53 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l85sm1794783pfg.161.2019.02.04.15.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 15:09:52 -0800 (PST)
Subject: Re: [PATCH v3 0/8] Add IPROC I2C slave mode and NIC I2C support
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        rjui@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        shreesha.rajashekar@broadcom.com, sbranden@broadcom.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ccheng@broadcom.com, heikki.krogerus@linux.intel.com,
        geert@linux-m68k.org, arnd@arndb.de,
        manivannan.sadhasivam@linaro.org, ajayg@nvidia.com,
        ard.biesheuvel@linaro.org, eajames@linux.vnet.ibm.com,
        kramasub@codeaurora.org, vigneshr@ti.com,
        mika.westerberg@linux.intel.com, pierre-yves.mordret@st.com,
        f.fainelli@gmail.com, aaron.wu@analog.com, jdelvare@suse.de,
        andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        rayagonoda.kokatanur@braodcom.com
References: <1547791464-3540-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <e658ce66-98e3-3ca6-5786-56bfea6d176e@broadcom.com>
 <746cf074-69e0-7bd1-034e-c8d3156b5506@broadcom.com>
 <20190204111205.GA2068@kunai>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <f00f179b-9824-2211-1456-57fb53ec482f@broadcom.com>
Date:   Mon, 4 Feb 2019 15:09:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190204111205.GA2068@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On 2/4/2019 3:12 AM, Wolfram Sang wrote:
> Hi,
> 
>> Just want to check if you had a chance to review the following patch series?
> 
> I am sorry, but for some reason they are not listed in my patchwork
> instance, so they fell through the cracks :( Can you please resend them?
> 
> I will double check they show up in patchwork then.

Thanks. I think the issue might have something to do with Rayagonda's
email client configuration. I will be helping to send out v4 of the
patch series.

Regards,

Ray

> 
> Thanks,
> 
>    Wolfram
> 
