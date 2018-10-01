Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE757C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A857A2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hAZyxob5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A857A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbeJASrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:47:55 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36164 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbeJASry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:47:54 -0400
Received: by mail-it1-f193.google.com with SMTP id c85-v6so11026260itd.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 05:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gt7wpriVv1hAqsbSyuh9exoEHLlcGLUh4yeTAxyN0eY=;
        b=hAZyxob53QMOFOQgtmaJBzMbpUadC/MY7PyNeSBTuFDbTcVgU4uu8wKhgVX6sVQCUp
         wOd5ruDKgL34ZbYamn7x6/YPhPL+pjtyCrC6xjB7JBCkrHIb0IM2DGjHqAmNjb9gvAmC
         72d/60MODY2LVBpFfDM5gZSNjWUl3SQGjenvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gt7wpriVv1hAqsbSyuh9exoEHLlcGLUh4yeTAxyN0eY=;
        b=I8fdddfEN9YLdXbyYhnXTEdgT4syFmWL87SKpXul1G8Un/S5P9BGxK2GAEkh4JuhP1
         nluSBi4HKbakNLOX7aP8I6DgTFt5ccSKX4nvw5jTHb0aMtUXoUa3Zc6HOawlD5/T8dFz
         TANNRt2e3cwngyuZQZVlyACPR6ZqV5aTLIGSIUkdSD3DFHlT96AyvxQy1LV2ynr2E20I
         J/2qHjsg1bAAmTC8lYitlwaC6iFi2AXHdsak0/zYtAGR8z51zo4HMJwqYRGy4EXMUq+K
         T5u8Jpo4qcg7K+k00V8dh7IQcc9uMgMthoqTMbl8rlgwEIZhU7eQz6CGvlRbhMZpoGSz
         S/+w==
X-Gm-Message-State: ABuFfohfeiD8bndF/LbMixQyn+EljhwqHx9XjPtdVH5kfMCHLQYcNrgL
        IA4SdYBkMlVN1pvmedxhh+GQ6B0MHB4=
X-Google-Smtp-Source: ACcGV61ThM2NLF5A5sAwKpUkkxTl5fk7PkBNATK1dBO5IpLuwXB3IFUh1XBD8TRC9T/K5T0VB1nDuQ==
X-Received: by 2002:a24:ddd4:: with SMTP id t203-v6mr320106itf.128.1538395823999;
        Mon, 01 Oct 2018 05:10:23 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id g19-v6sm257295ioh.30.2018.10.01.05.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 05:10:23 -0700 (PDT)
Subject: Re: [PATCH] soc: qcom: Drop help text for QCOM_QMI_HELPERS
To:     Niklas Cassel <niklas.cassel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181001095554.23815-1-niklas.cassel@linaro.org>
From:   Alex Elder <elder@linaro.org>
Message-ID: <35cd9295-17fd-bb83-138d-0fe6c4323e07@linaro.org>
Date:   Mon, 1 Oct 2018 07:10:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181001095554.23815-1-niklas.cassel@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2018 04:55 AM, Niklas Cassel wrote:
> The help text is visible in menuconfig, however QCOM_QMI_HELPERS is a
> hidden kconfig, so it is not selectable in menuconfig.
> 
> Remove the help text so that it is more clear that this is intentionally
> a hidden kconfig.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Looks good to me.  If someone needs it, they know what it's for.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/soc/qcom/Kconfig | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 684cb51694d1..fcbf8a2e4080 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -75,11 +75,6 @@ config QCOM_QMI_HELPERS
>  	tristate
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on NET
> -	help
> -	  Helper library for handling QMI encoded messages.  QMI encoded
> -	  messages are used in communication between the majority of QRTR
> -	  clients and this helpers provide the common functionality needed for
> -	  doing this from a kernel driver.
>  
>  config QCOM_RMTFS_MEM
>  	tristate "Qualcomm Remote Filesystem memory driver"
> 

