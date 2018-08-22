Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AA0C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EA9208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="gE7U0bCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EA9208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbeHVM6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:58:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46056 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbeHVM6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:58:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id r4-v6so904446lff.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yZy3cUyBSlqZE46bUFRxVlIhSq+j28zsXdV9nRQOntI=;
        b=gE7U0bCZ2lFFkLZ0ux1hn7ul5UGjuyKNOkCTexLcGHuQYunHrXJbteyXP/CaRYh1SV
         o+bKcdcTArUl9NU2ju3FmfDCXE556aPWj+75dJs74KsiAmPfnm0DNCi4s3dU/sTFXsKA
         CfyDKd1mLhgXjqcAwWU4UYNEiCMmmqI/BbbxrZ17fmrmphGx7exKs+2DdH/11fEiW6Jj
         zNX0Y6TGxhgxPNKH4R3wtU9988xujdW75tcKhhVkfpVwJR1GyAPJMscQo1lu7weTLqSd
         Kg8nBGBJgJsge0eE+Dv5bqPxm4WqrZEEUhkODlmz8ueP83cE0jvyNxqxtmnAl0mw/72Q
         KAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yZy3cUyBSlqZE46bUFRxVlIhSq+j28zsXdV9nRQOntI=;
        b=hc3QYkhDxfedP5n1HG6iovfL0Az32ZNaZOBQx12cE4YHZt1FuUgT759kNYnYoaIAH5
         JVqtsUzwDmfXDvhRq0bdVF8pQAz25zdFPkhBBjpgSu3v7KTJJw3nuOlnadm9p3peQic7
         eC9p8EDz+m7pwKdS3f51Ai6teHbjN6TyyHQnLr48MSjzeJ2xUrMkaVTxxsf5hIqkX1ux
         93t4RKAx32wEsWw6M2CjPooedKTazWyKv1yQfmUzvZMupyyZSSn95QsrW8k3rA5i7tV3
         J7WWkrg7tfu7CSaXJCD0D+h/zbvgUPtB/eJx/O29LE0REThS9rlafzPY4IyiuCM0HGnd
         DrdQ==
X-Gm-Message-State: AOUpUlH2nOHJry2+Wso/MRAduYmdlxE4Ab153y4NMElFu9AcJYJJ6L5i
        pLLODwhGlWW+IJ0bL6tJA5QsoQ==
X-Google-Smtp-Source: AA+uWPxztMZk/a2Z755ypiJkQEJd2LVxa9k1ui47HaBhpowcejjcle8UHPVZf7xBLuuRXwPxIIX3tw==
X-Received: by 2002:a19:2a91:: with SMTP id q17-v6mr11680584lfq.74.1534930472790;
        Wed, 22 Aug 2018 02:34:32 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.82.136])
        by smtp.gmail.com with ESMTPSA id 101-v6sm227323lfs.44.2018.08.22.02.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 02:34:31 -0700 (PDT)
Subject: Re: [PATCH 01/14] ata: ahci-platform: add reset control support and
 the flag to specify using reset
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
References: <1534923430-9692-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1534923430-9692-2-git-send-email-hayashi.kunihiko@socionext.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <1d221236-636e-962e-2e4e-3db228689c5e@cogentembedded.com>
Date:   Wed, 22 Aug 2018 12:34:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534923430-9692-2-git-send-email-hayashi.kunihiko@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 8/22/2018 10:36 AM, Kunihiko Hayashi wrote:

> Add support to get and control a list of resets for the device
> as optional and shared. These resets must be kept de-asserted until
> the device is enabled.
> 
> This is specified as shared because some SoCs like UniPhier series
> have common reset controls with all ahci controller instances.
> 
> However, according to Thierry's view,
> https://www.spinics.net/lists/linux-ide/msg55357.html
> some hardware-specific drivers already use their own resets,
> and the common reset make a path to occur double controls of resets.
> 
> Now this add the flag to ahci_platform_get_resources() indicating
> whether to use the resources, currently resets only, and existing
> drivers set 0 to this flags.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
[...]

> diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> index 1b0a17b..eaedca5f 100644
> --- a/include/linux/ahci_platform.h
> +++ b/include/linux/ahci_platform.h
> @@ -30,7 +30,7 @@ void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv);
>   int ahci_platform_enable_resources(struct ahci_host_priv *hpriv);
>   void ahci_platform_disable_resources(struct ahci_host_priv *hpriv);
>   struct ahci_host_priv *ahci_platform_get_resources(
> -	struct platform_device *pdev);
> +	struct platform_device *pdev, unsigned int flags);

    That breaks all the users of this API. You should fix the callers in this 
same patch to avoid breakage.

[...]

MBR, Sergei
