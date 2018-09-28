Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EF9C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B332168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNxYrkqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B332168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbeI1SEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:04:37 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37704 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbeI1SEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:04:36 -0400
Received: by mail-io1-f68.google.com with SMTP id v14-v6so3984297iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 04:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z7BibJw0pQrhYlajhYZHEMJxLA3Ahi739UVnA+J3jO8=;
        b=SNxYrkqKYJG8/qAyO6MpafwbLbHuS4cgP22VhBvrQ8n9tij3k8vUxBCfoJyH+0SDbA
         FvRiAN/MVpHwFKRJ3n/dF8lejgWq6I3lx4+4gTCpeNnIQK+WRR/1Z4zgtZ0B7dEBNmJ6
         nQevbrfa0sonA9JIhgT2t5RSH+qAmFyN1wFE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z7BibJw0pQrhYlajhYZHEMJxLA3Ahi739UVnA+J3jO8=;
        b=aPQ9SWoPhR8NPaMn1U/kOAyRTz40VU3OoZTc0rSqMEyXOJWNnNbRZ+/TVjm92eico0
         rYPgnQ3U9IyGeY44q+yLlbnI/il21Ojh+Ep5JIPQgqSTVRbdbIz4AmZ7q0QKv5jqTdGM
         qEy1ywWze3Htb+BPuHf3YW5LI/xUsjvg5d9rdDPXxX6umksHk+EqxHxFvA9saWRHpKpa
         K+hrw6Hhopjm8hLS5EzZBS2sq4kMpzBvSwGCVDozJp77rx7y/EhAyfRX0hRBCPl4LTz4
         nrsNGgaij8XlEm6MINGxqEt3StFv4TArxv8IqyZsHUkTmdo+Zq6gqhhng6qO10pB981Y
         Vp2Q==
X-Gm-Message-State: ABuFfoh9AKiXsxPz88aC7lX/FllHlC/dHbO5WyrjRkhPKF3VZ6GRfX34
        x/CLmXOeOXscrRebIxxoz0IhJkXGPWU=
X-Google-Smtp-Source: ACcGV61bHdyko0/e5OOdnG2nCGIj+Fshj151rjGQ7suXR66PlEdi5o7PoeTnA8W+yzgtOS500alBsw==
X-Received: by 2002:a6b:1505:: with SMTP id 5-v6mr11901330iov.56.1538134872989;
        Fri, 28 Sep 2018 04:41:12 -0700 (PDT)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id e15-v6sm1429612ioh.18.2018.09.28.04.41.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 04:41:12 -0700 (PDT)
Subject: Re: [PATCH] soc: qcom: qmi: add a prompt to QCOM_QMI_HELPERS
From:   Alex Elder <elder@linaro.org>
To:     andy.gross@linaro.org, david.brown@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180427140358.30839-1-elder@linaro.org>
Message-ID: <ec0e7861-4bf0-f135-a881-1a1de4579277@linaro.org>
Date:   Fri, 28 Sep 2018 06:41:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180427140358.30839-1-elder@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Was there something wrong with this patch?  I sent it a long time
ago but it still applies cleanly.  I can re-send if you like.

					-Alex

On 04/27/2018 09:03 AM, Alex Elder wrote:
> Add a prompt to the "tristate" attribute in the Kconfig file in
> which QCOM_QMI_HELPERS is defined; I find it doesn't get selected
> without it.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 5c4535b545cc..81a501765cd9 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -36,7 +36,7 @@ config QCOM_PM
>  	  low power modes.
>  
>  config QCOM_QMI_HELPERS
> -	tristate
> +	tristate "Qualcomm QMI Helpers"
>  	depends on ARCH_QCOM && NET
>  	help
>  	  Helper library for handling QMI encoded messages.  QMI encoded
> 

