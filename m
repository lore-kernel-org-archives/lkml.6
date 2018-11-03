Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E99C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 20:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C102082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 20:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Kv/is83i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C102082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeKDFYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 01:24:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43511 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbeKDFYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 01:24:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id g26-v6so4613469lja.10
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 13:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WmZYGdoBX0htGPTNmEvbxtLH6nsRd6LeYy8RCQJstwc=;
        b=Kv/is83iiaWQWixNMszXee5YM6qme1/fHKrGlUnop6vbgsIFizww9z/WpLR2oHleRw
         ulrfmac1Uz7IRKaIAPSQeSOSvDcS+B5qy7mVOvy1TCYMQUfUry0Huef9Ft4CB1Nmwjxr
         qUv5t+jOzZhULmuUc3+LM8Zi9urU2KoeTuXc5IwDdPewJ8LOukzTGZgUBiTW0iR6gvdD
         DZp5M/KBuWZhNYmxgTjS+YAizluW5rjro2BKKnRjEzroN97yzWP1ofqQom2o14HN74mi
         lqBR52NRUkh0vPTlrhqEZ4yw89fOLfQlZeEKX2Nqe4sXod4d5G5gnwC4xltu+iBE1QRW
         IU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WmZYGdoBX0htGPTNmEvbxtLH6nsRd6LeYy8RCQJstwc=;
        b=OQfkJ5xreZCcR3775AYW0Uw5vjnSxMyP62bGUO4BfGIPo1qtOR9z/K1fOFoVCK3+9F
         vuUokjtTrNZpLkayzwkowNmKe8t4TXlP2GmcYJ7Zbvsi54klC9OnmfhAnua2EXOXDqxe
         PR5Mk2qkbkZMlvJebi1tnH+50Kl5ZVsZ4A1LrI0DM3tg3b4dZ7o5T+em1miFhHOTjCeL
         nzlzlhuH/F48aj51R1XBFixWrZoT6wIEjl85EaDs5S0Os8IpwEta8xTCwKtq8KIXFpJZ
         o42f36WLl2qwmowps5sYj3efoiz6ePn+O+1rX7lzYDM2Zsrte7AtCuEcbuw5GgJPQY+u
         1u+Q==
X-Gm-Message-State: AGRZ1gLfgoduFBNws3lb4N2MDp8N6/RZYI3quElK2lQehtpCsf0BmjGH
        08NIxDs0K8BjU54fRYhQRP+D7A==
X-Google-Smtp-Source: AJdET5fODjCE4WN48Vc5BUseEIpb10Cgcvs3psWYTGLI7eJiANeo/4p3HYzvrJGlz82IOLlQ3vShEA==
X-Received: by 2002:a2e:874e:: with SMTP id q14-v6mr7736368ljj.120.1541275946440;
        Sat, 03 Nov 2018 13:12:26 -0700 (PDT)
Received: from [10.0.0.145] ([94.72.11.11])
        by smtp.gmail.com with ESMTPSA id v10-v6sm3143052ljh.72.2018.11.03.13.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 13:12:25 -0700 (PDT)
Subject: Re: [PATCH 5/6] dt-bindings: can: can-transceiver: Remove legacy
 binding documentation
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, kishon@ti.com
References: <20181102192616.28291-1-faiz_abbas@ti.com>
 <20181102192616.28291-6-faiz_abbas@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <a923f4a5-5b90-512d-a9e2-af6f72acff8e@cogentembedded.com>
Date:   Sat, 3 Nov 2018 23:12:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181102192616.28291-6-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/2018 10:26 PM, Faiz Abbas wrote:

> With the transceiver node being implemented as a phy, remove the legacy
> dcoumentation. Don't remove the code implementing it to maintain dt

    Documentation.

> compatibility.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
[...]

MBR, Sergei

