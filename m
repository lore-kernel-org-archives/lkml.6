Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDC0C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F12208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="iX+J+F2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F12208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733058AbeIXXbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:31:12 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42601 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730757AbeIXXbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:31:12 -0400
Received: by mail-lf1-f66.google.com with SMTP id d7-v6so13666327lfj.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ck+Bs5O5KrPMYTrMeKJvm6RRH1RAHraGf2E2IilE4Ck=;
        b=iX+J+F2tBCVZXCHbcSwS/7Y+yurCAACgXnw3AQDe+M5uBKa817OkkOfbpaFhvkk8vT
         WNqSb4O5uV45B0ASHl0+VEgKtPPzhdNjBUh0egiRj2aWlY3osqlgJocIxs3w5853/qgm
         /5Jyik7eUySRpTDeIOiETxZZffhDN9Zt4itlB0BPEU8mapMezxT3+x/bNDvlo6VfNazH
         cRTeCLdb/BnNGm4hF3noDfgHgJUWR/eWnCtvAu71lOkFtb3WU8xYIsm1hvSMPmOD0mTw
         xtDBV5G497JpQUlAk3qtrpFAZ+PUYUS9TtcMFh3HvW1t7LNHCjum74l1K/SO1XbIZfoZ
         N+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ck+Bs5O5KrPMYTrMeKJvm6RRH1RAHraGf2E2IilE4Ck=;
        b=YCDALJtFHIibAWmfex+VDFpBiQkKjmHqXMSkfMqMZNE5lbuRge6jU2O8dguBzK4bYE
         IjBBCl3UNtxJDtP2xnQhq2mqWkjYGgKfy12HO4igPbpZB7Xxi88B75w1X+zXWCvfQS9P
         AJXS87RIAkhBG/UrGVG3uonjMYjjqYOzbeM4R9LNC78SD2YCkUwlRmbdw9pjLgVw1yag
         rd2p/XyN6eo6aY2p/4y4Sag+smaRR8m4R76qpGzYVmN2AcHBc5ALfNk2Wy2Sa1W9P1/P
         Aeic8UQlspobsGpjB2tN3MC8uIh+o3PBf5M0GNt8LnsJjH2+e6vyJXBrE5fbcSRDlWg6
         lDJw==
X-Gm-Message-State: APzg51ClqC5ffboiD/CzMBoe8JhiZx+WllgS7eoLCVjcIvki8UQSujvE
        YDJpwfxI6ZhxaiiUIt21vk1sXNzZXjI=
X-Google-Smtp-Source: ANB0VdZE61eapZZXfgUmNtzQ4zdeCRc0IzkZ6KWQtHJG/tPVSk13WXfGhj/Ie54TAL13DTvBfb6/Tg==
X-Received: by 2002:a19:c396:: with SMTP id t144-v6mr7375338lff.7.1537810077981;
        Mon, 24 Sep 2018 10:27:57 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.87.133])
        by smtp.gmail.com with ESMTPSA id i186-v6sm806153lfe.41.2018.09.24.10.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 10:27:56 -0700 (PDT)
Subject: Re: [PATCH] wimax/i2400m: fix spelling mistake "unitialized" ->
 "uninitialized"
To:     Colin King <colin.king@canonical.com>,
        Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
        linux-wimax@intel.com, "David S . Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180924171853.3294-1-colin.king@canonical.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <db8575a7-a4ab-3234-3e59-06cdeffe0f59@cogentembedded.com>
Date:   Mon, 24 Sep 2018 20:27:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180924171853.3294-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 08:18 PM, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in ms_to_errno array of error messages
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/wimax/i2400m/control.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wimax/i2400m/control.c b/drivers/net/wimax/i2400m/control.c
> index 094cea775d0c..0475ad553707 100644
> --- a/drivers/net/wimax/i2400m/control.c
> +++ b/drivers/net/wimax/i2400m/control.c
> @@ -257,7 +257,7 @@ static const struct
>  	[I2400M_MS_ACCESSIBILITY_ERROR] = { "accesibility error", -EIO },
>  	[I2400M_MS_BUSY] = { "busy", -EBUSY },
>  	[I2400M_MS_CORRUPTED_TLV] = { "corrupted TLV", -EILSEQ },
> -	[I2400M_MS_UNINITIALIZED] = { "not unitialized", -EILSEQ },
> +	[I2400M_MS_UNINITIALIZED] = { "not uninitialized", -EILSEQ },

   I suspect they rather meant "not initialized".

[...]

MBR, Sergei
