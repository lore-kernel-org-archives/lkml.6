Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E5DC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A41520890
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkVOfKB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A41520890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeGYNRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:17:45 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:39318 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728809AbeGYNRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:17:45 -0400
Received: by mail-qt0-f180.google.com with SMTP id q12-v6so7300854qtp.6;
        Wed, 25 Jul 2018 05:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1fpctmhOG1PBN4E3WLjM0dDVj9M/ye0cwiaY7XcaBbU=;
        b=hkVOfKB/31PS2giZb5CjYcT3Q79dVGHCGCROo/IbgFw99Bu25s2iscGVYIqKEGhUS9
         KA/DJlad1yfXqvdlDc/COoCyHnaEGNaJYR4v8zrCqwDDpyIk4yFTiwLMhgQtYvhvYt2G
         KKDb2CeUShKbu4F5gf4F1vbhWnWRLteSjzwk1YLX23Iqf7rPpAaaOjGhfCLPCnD2mn6T
         DPlBSZAEwjs8QnsHR4x7dX2XJ5aKo4RZX0JX8vTWcWkG+fboUmhTXUa4178JSLIxcnQj
         NO9872UgDyD+CLmzlThGHYMXMJ8ZUJyAIz0engEKxJHsf98Lkrt1IEx43h8mdI0Y1/6m
         5NWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1fpctmhOG1PBN4E3WLjM0dDVj9M/ye0cwiaY7XcaBbU=;
        b=r1UZzrFzBqZDDjVYkBly35ciG8a5RYwzSkeK3fOhJbNnQQddycE1YSCE+/frg9FP6o
         kxHKSs3L0UoW8+eTmKDSB203MNfxIpfn2LQSELVZ1heTMJd4BLkL7BeldZfmro/IoHpO
         zd5HpWIVPocz3+BEcc/uUf9vuu5pLyB/4c9Yc0nZdGOBpo55h3yDD1lAEQ7ME6YPOQUB
         +BzTTGrrMpxT/DRNgW3S8QuSrIO1Yiu+7t4jJOUi8o35Rm5RQfyR+UgKaMjTD13JhHHj
         sXMQUH/vdflp+f2FGyA3vXjvPqZUYDzVIDU2RGsb2hXu6U2CzswiiTLZyiHyEfeaycnK
         46IA==
X-Gm-Message-State: AOUpUlE9cwGG6iSsYxp1LImFcj89Lgaz7tpXQM24MeA2eRlg4/DH9Y5w
        LT7nCy6hLzO6ERGrlwZIKNpISKKiHDg=
X-Google-Smtp-Source: AAOMgpe1JOozOZZuXJ3SrLG58IPrhKHlB8n/AeY+RsmyWHfRV73Aezd1I7e+CnB3LEZmEROVCosD3w==
X-Received: by 2002:a0c:d44a:: with SMTP id r10-v6mr18555068qvh.248.1532520381214;
        Wed, 25 Jul 2018 05:06:21 -0700 (PDT)
Received: from [192.168.44.96] (144.sub-174-226-12.myvzw.com. [174.226.12.144])
        by smtp.gmail.com with ESMTPSA id q51-v6sm10019530qta.92.2018.07.25.05.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 05:06:20 -0700 (PDT)
Subject: Re: [PATCH 00/10] Update the pad autocal procedure
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1532442591-5640-1-git-send-email-avienamo@nvidia.com>
From:   Peter Geis <pgwipeout@gmail.com>
Message-ID: <f41a905c-5364-14a5-122b-09cbd1efa2f9@gmail.com>
Date:   Wed, 25 Jul 2018 08:06:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532442591-5640-1-git-send-email-avienamo@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 10:29 AM, Aapo Vienamo wrote:
> Aapo Vienamo (10):
> 
>    mmc: tegra: Enable pad calibration on Tegra210 and Tegra186

Good Morning,

You seem to be missing patch 10/10.
Checked 
https://lore.kernel.org/patchwork/project/lkml/list/?series=360525 to be 
sure.
