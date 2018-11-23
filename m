Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5385AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F1720861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="NrcyMYFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F1720861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408422AbeKWS5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:57:24 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:40505 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408410AbeKWS5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:57:23 -0500
Received: by mail-lf1-f42.google.com with SMTP id v5so8091611lfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 00:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2QezV+2WlvZA7bJuTqObIT46PU7b7NzSVeV2Eg8lo+s=;
        b=NrcyMYFBx/oxHytMcSAPnxKPlubcU27mB9ibSFQ2sPtB9bq0efO3fuTLpbp+C2a7Pg
         FpxVsuZ6DjHn/WJ5DyWV+Wi/GEPVZOeAXtkdr9LnZ0EtHbKPz6NC3vKRm+eZZpuom8DL
         ZAJl0cfV+O95hVjW0gJC3no979WH+YtRrwTiQG5m3MaesrxAcTfLy1q4VWUGiGoH839j
         /Ocb43AeBnP4jEitSoihV2FSO7yf3vWlDHysL7oMrjvYz0yHQz8pP0h+1kxlMk6ZpNmh
         IJNyJh1RpzleVTSFHfojT42hVzS+mnTMt8sLEWJmN2mcoQjLNKeYA6sfZnC8LIpdvsnU
         vMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2QezV+2WlvZA7bJuTqObIT46PU7b7NzSVeV2Eg8lo+s=;
        b=Gg5mbcpGFm5tLddZRqaBlItDNLAhKPgeSwECTP/VWEm9JSo8/qgbLWMQzNuEDCg8H7
         yIsOudDF/eFG2FPeosn0DZtiJtkgt887HCqIreS8xU5RYyGiHWhWQpHJf3swjhB9Kr32
         tQsSxEn4lwy1siXG+foz5xLKGCIabjMohxyjjK+zm6DKw+8frQvZs/hOaF1c305tf0vn
         5TzKL5UhKPTp+0dNRhmaEVfv2JQfg7tYjwMGdEr8a3VyDbS+d5VyQ39AbFgeeJx3uDFi
         i1GyR157d64yvh6QK0XPhcWmbSFpSqKnvWkDkcNCuSQimJt4UD1o2WDSBd5XTiyOh94/
         x09Q==
X-Gm-Message-State: AGRZ1gIDIwVN/4M4UfWcrGlK+dijpXQxydNUdZFbXR60B0cJiW+cHgwr
        AgqnaGDDEah4soSQ9tLGiVlncN55Qv0=
X-Google-Smtp-Source: AJdET5f3dbo4KhmC8FJpstU0/9QaVeCg4aI9vh0NpxB/LBMgT43BcFWZqkDQduljtamQ6vMcQ1C5Wg==
X-Received: by 2002:a19:c18d:: with SMTP id r135mr8041315lff.59.1542960852107;
        Fri, 23 Nov 2018 00:14:12 -0800 (PST)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id x16sm7544156lff.26.2018.11.23.00.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 00:14:11 -0800 (PST)
Subject: Re: lightnvm: pblk: avoid ref warning on cache creation
To:     javier@javigon.com
Cc:     hans.holmberg@cnexlabs.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, javier@cnexlabs.com
References: <1542894410-14047-1-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <2ef4bc58-98cf-fdfc-195d-d6f88e85f4a6@lightnvm.io>
Date:   Fri, 23 Nov 2018 09:14:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1542894410-14047-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/2018 02:46 PM, Javier González wrote:
> Matias,
> 
> Can you pick this up for 4.20? Even though it is not an error per se, it
> does trigger an ugly false positive warning when CONFIG_REFCOUNT_FULL is
> set.
> 
> Thanks,
> Javier
> 
> Javier González (1):
>    lightnvm: pblk: avoid ref warning on cache creation
> 
>   drivers/lightnvm/pblk-init.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
> 

It is too late to get it for 4.20. I'll pull it in for 4.21.

We can put on a Fixes: 1864de94ec9d6 "lightnvm: pblk: stop recreating 
global caches" if you want Greg and friends to pick picked it up for 
stable kernels?

