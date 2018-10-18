Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75EBC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764912145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iSQvNaBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764912145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbeJRSuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 14:50:04 -0400
Received: from mail-yb1-f170.google.com ([209.85.219.170]:44540 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeJRSuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 14:50:04 -0400
Received: by mail-yb1-f170.google.com with SMTP id x5-v6so11632747ybl.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 03:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=jijnkuWp50/g8/IAYpDX5zk9M8C8a0cYTsMuMYrlWt4=;
        b=iSQvNaBqO65oOThtpN3urDrhtOKPm3VZg4ndPc25bMNKhOK8VdtP63wu2KmXwfZ5Yh
         J3nMowhD+UurkhlnlM6v6RDXozhKPNQv2NyTephSQSzHFU4AN01srmEZpWTQuxxbkLlN
         u2zS/if9DJ/QMFouPLjP2W8SGllk2ty+7ZvU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=jijnkuWp50/g8/IAYpDX5zk9M8C8a0cYTsMuMYrlWt4=;
        b=g8qLeCOjhaaXjgvWIgRqM8CREj+J+c7Pas0QoZUT56wlCeV4bbVIpsG2H5hqoUPXIk
         Gsui3ngNrG+KnMHdb9wrWDXNlyVus7T6Gtu7YrhKCH02LwhJovsGTrKDU6UVSgSAqjWc
         QaHmBeHsqDM6TN4mKwNKqJymNP2R5BOqPi1fsnVauM0qSPDu6K2f+OJl0SHVYPVShSHD
         K+hqIZ4jcNu2wqUYx/54Wz1X49FbZythEqsRl805Ah0VYCtyT5umllPwcsZpnCNYpz9y
         PTkABE/wOCvZbR1FS+4+LYCQ74/iFYOc1gg5oPKkKLkXmuqcdMLYWdcOtM3vqJEYbJoT
         hWDQ==
X-Gm-Message-State: ABuFfojGqXdVsBr2yCRVVqbEDnQZZypUdVdn3yvAV9DMAf8MULE4MgLS
        nfE1JnNaIWBMcLP6QkJlGRwbHrKcXNE9pw==
X-Google-Smtp-Source: ACcGV60LoxXhdryGbXWDok3dLO/t04oYejXORfXjxCqd9TtKPl4R2CShqWkVfjbpLW4Z5+JN4ZoeBg==
X-Received: by 2002:a25:b3c9:: with SMTP id x9-v6mr17282037ybf.508.1539859778326;
        Thu, 18 Oct 2018 03:49:38 -0700 (PDT)
Received: from [10.177.251.241] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id p185-v6sm5928280ywc.14.2018.10.18.03.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 03:49:37 -0700 (PDT)
Subject: Re: [PATCH] brcmfmac: fix spelling mistake "Retreiving" ->
 "Retrieving"
To:     Colin King <colin.king@canonical.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org
References: <20181016174342.1867-1-colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <22cad1fd-a00a-252a-0c89-f0b7ef558ff1@broadcom.com>
Date:   Thu, 18 Oct 2018 12:49:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20181016174342.1867-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2018 7:43 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fix to spelling mistake in brcmf_err error message.
>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
