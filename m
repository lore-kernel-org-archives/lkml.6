Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6079DECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 21:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F32820658
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 21:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiPpYayd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F32820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbeJVFtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 01:49:11 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39461 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeJVFtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 01:49:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id p11-v6so2409331lfc.6;
        Sun, 21 Oct 2018 14:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hNNIQlOdkfVuGGYNuZ47Sl2snITvmmMNJxTWFyvrz2w=;
        b=aiPpYayd95RhQPY/f48i1OlEaCgTQHghpoG6/QeEwMG1qe33yWKU3KJbarIfQ83GzV
         T5AZuVyF+T6bElgMvAX8Pm275Rw1e3nMv78w3TRQy0t5dlH1yyrCBMkwHGw4JUt33BEp
         mQizFUX6FApu33Q+MbvSv81fLtM6Eq5xYmptMn+xt9wIvCcCPbr4/P+n1xz4oRivtzSK
         6QBdp8fN9FyU6n5/LGwPRvozYft2uN6gxTxQXN4TA5X4FolbdlLi+DNVapiN1DdS8yEE
         APzbcNl32ebRtTx16qDR67rjM2xOsmOqWiqBK6Q6r4MeYIAbi/J0RfsytX8OGnXDNkjw
         l+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hNNIQlOdkfVuGGYNuZ47Sl2snITvmmMNJxTWFyvrz2w=;
        b=FSRUwZMTjVzzdEZRWMB9nhQJ30Q8xj8ltV0DEmUwfVK7bBkJj6Z7k1+BI4HaeEWcqD
         u+Fv5OaGIwknENvN7NCpkuvb3z7D+/4Kh2Fot+jkP6g7/paXbuIe0OPdmGpy0Ne3Tlt5
         8VFUhlT0AnHuAGiZTb1ujuR5K9vrYwA8Zda/MfcWkgq+yM3hd62/Are7/vTUfXgBjolv
         lDPUIPjigx1h6LW0bsdARLsNBS/TwwSkHVKGsxO4hKSclEumvXaMzKpLby/H2lt/4PFf
         +BhsCvjGslOcg1Ck+sPd9T388onazHNkwdfIe5fzA/pgniAY9dosDLXnVuwKymiBQjbi
         Wz4Q==
X-Gm-Message-State: ABuFfohhdUZCnbQdfRS4Er3eZ1dtK9f3ycUlQXDYkI/IRWPGPJKVWY/i
        xHg4xappBv4WB5b+SgfaSlzkpSIx
X-Google-Smtp-Source: ACcGV63pKwVyX9WOgQQQ1nweWDVQ+BYqN0htxw1lCqqSPlJp04WiHEeeeIhxpn7eweacb9MOZ0rbHg==
X-Received: by 2002:a19:1b14:: with SMTP id b20-v6mr7771354lfb.12.1540157604863;
        Sun, 21 Oct 2018 14:33:24 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id h87-v6sm6696241lji.9.2018.10.21.14.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 14:33:24 -0700 (PDT)
Subject: Re: [RFC PATCH v2 02/17] soc/tegra: fuse: Export tegra_get_chip_id()
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181021205501.23943-1-digetx@gmail.com>
 <20181021205501.23943-3-digetx@gmail.com>
Message-ID: <23d8d451-ec25-d557-660b-bdce90fcefb0@gmail.com>
Date:   Mon, 22 Oct 2018 00:33:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181021205501.23943-3-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/18 11:54 PM, Dmitry Osipenko wrote:
> This function is used by tegra20-cpufreq driver which can be built as a
> kernel module.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/soc/tegra/fuse/tegra-apbmisc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
> index e5a4d8f98b10..c94dccf3eb30 100644
> --- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
> +++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
> @@ -51,6 +51,7 @@ u8 tegra_get_chip_id(void)
>  {
>  	return (tegra_read_chipid() >> 8) & 0xff;
>  }
> +EXPORT_SYMBOL_GPL(tegra_get_chip_id);
>  
>  u32 tegra_read_straps(void)
>  {
> 

A quick note.. I just recalled about existence of the of_machine_is_compatible() which will be more appropriate to use in the driver, hence this patch won't be needed.
