Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF0DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAC620651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KMrclHk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfAOMQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:16:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40410 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfAOMQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:16:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so2693123wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 04:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wHRapNx175n57XR0cREAyYtk2k0G5aBMMiVeZPiLcMM=;
        b=KMrclHk7Ri9mr0Ys/EIYO7EsDAFlP6EP1MzK1n7lHix/VLPCYLpa6mcsumKOa4f0we
         R6kWL+Vwmg5iLKU272xM1Dcypabf02zTKskJaH2+H02USud8PSaRVUEopvSjNmz8BKDz
         MyuohPzEzLi6eb0/40TwYMRa/OMS5dMTWf7pE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wHRapNx175n57XR0cREAyYtk2k0G5aBMMiVeZPiLcMM=;
        b=I73vtMETDBe9URm78KmLOFE8h7UQgtwkjxS0F/BOTRxWIjtMU+OU0b4fLuPFPG73t8
         X93m9+skRmy3krnDAIj+Es0KSU/t5NyodjBVFirUI9k32vqda1BzatdoVmwCJJ1iiFbr
         ZDC7QiV45PLsIphj2b3iYd9PDXhtcMQCzh+Unz6IbumXyJ+H51JwfY3lJBAdHUdGOs2t
         l9N33Xd3xKKQwyfcWc2gPaNyx37oPFOQQNueFXxOOQb+heBV0BAvquYKu+unk9KyMMw4
         vg98uhTPE5LM6fk6MJ0AxfeB8g5Nh6yLG4c0jZYZaSlgg5f2MfK5bAdhuIpUeg0AK/Ds
         s+OA==
X-Gm-Message-State: AJcUukddk4XNTMl9WI/Ptf5sUpy6aEvSxbXCxjT6y22MGPuMli6P8qzU
        7WW/6g6z6V7rE6nGhpuaweOTCYUG2Hw=
X-Google-Smtp-Source: ALg8bN6DiB9/kuWodjPc9nrw5wwh70RHPDAZfy1BQ5rX91rEvmhHR+xoKbPEkJaUnj5vg/L2N4A0hg==
X-Received: by 2002:adf:fb4c:: with SMTP id c12mr2825212wrs.297.1547554573277;
        Tue, 15 Jan 2019 04:16:13 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id n82sm31445333wma.42.2019.01.15.04.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 04:16:12 -0800 (PST)
Subject: Re: [PATCH] nvmem: bcm-ocotp: Add ACPI support to BCM OCOTP
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
References: <1545881941-19986-1-git-send-email-srinath.mannam@broadcom.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <373ea97c-5594-0258-7617-4d662b07ca9a@linaro.org>
Date:   Tue, 15 Jan 2019 12:16:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545881941-19986-1-git-send-email-srinath.mannam@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/12/2018 03:39, Srinath Mannam wrote:
> Add ACPI support to bcm ocotp driver
> 
> This patch is based on Linux-4.20-rc7.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
Applied!

Thanks,
srini
