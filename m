Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03E4C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6673D27D03
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="ysaWfviD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6673D27D03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754938AbeF2KEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:04:15 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39681 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754859AbeF2KEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:04:14 -0400
Received: by mail-wr0-f193.google.com with SMTP id b8-v6so8268906wro.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 03:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uUfGtjlTOAbL4OlvV9cdBZASna7GH/V7wnbnxe6kli8=;
        b=ysaWfviD6n9oqJ9PMkfAmri5YEevia3WEzl3T/enWMQTiJmPRMlDb2P8BSAnoNa8Hs
         D519A3F1v/e6LmhdTnMm3JAtv2XccBEe9CxRTpEM6jKWxdhXWgiG1W1WZia1SjH2Lw0m
         92y2FHXW4gTakNrh1JP0advmTntpcu2sK1wIlt5DjCPacF6rLAEDLCakum+juIR79EDx
         NUx7O9ZYi1iMubemuobHH4xHXxJrXCG2Mp4Fe2m7ErqsP3dRCiGvVFbrhJgVVMMHCcqv
         ljjIAqYrVjnF2ISeMZ1yklqWXwlefC6zLXmLsengBfCbnR895Ot2B/XOiMqKlgDL7ftr
         CU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uUfGtjlTOAbL4OlvV9cdBZASna7GH/V7wnbnxe6kli8=;
        b=AVUuoySQQo84OhNglKkd2uZ3xVN1sZ6fnjuJXLnV7Q4+sMCXQBZhGYVRMgyQGI5vkR
         lV9jeb8mHx+HJsW9dP6Oclqu89TA/4dBPKth0xGz9/zcUMdZUoZT8grTKnJ5yI3oJZzi
         wcDJVsEckIFGI26ONxigkPmLDZKLTT8rYw/Dw55T6kCzFlkjy77ETxArQ4ClAREKo7T5
         qbl+asUw1Jw53m4RvY9uH0sHj8ZFscgLmKQEyiLhp/YGu22dorswBO/Gk5HECUG8o9dy
         4+VWWmd1RzdFRwepcQW7DzA1lhVg2EJ2ssB5nTlWe/Y6uIybHQxS8nIS9DYK4dXhvtQv
         3OHA==
X-Gm-Message-State: APt69E3hNTsqMolLVGgKlkT7NkP8KMPsXs8cgCYeVIpOFail5xpLX36a
        9SF5HM9wSrLsJYLOLFRPlnUFgj87
X-Google-Smtp-Source: AAOMgpeahoe3FT/d9JgiYpNKLDJzB0UQ3X0gNPbmA5XWbjnNmc4pDZlFkipIKQZzsYv4+BIBPNNv6Q==
X-Received: by 2002:adf:e90c:: with SMTP id f12-v6mr3213482wrm.126.1530266652858;
        Fri, 29 Jun 2018 03:04:12 -0700 (PDT)
Received: from [10.96.72.132] (bzq-219-43-106.isdn.bezeqint.net. [62.219.43.106])
        by smtp.gmail.com with ESMTPSA id g14-v6sm8699099wro.86.2018.06.29.03.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 03:04:11 -0700 (PDT)
Subject: Re: [PATCH net v2] net: phy: DP83TC811: Fix diabling interrupts
To:     Dan Murphy <dmurphy@ti.com>, andrew@lunn.ch, f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180628133253.22871-1-dmurphy@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <8197c635-11cb-d722-8bb5-ac94c2f516c2@cogentembedded.com>
Date:   Fri, 29 Jun 2018 13:04:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628133253.22871-1-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 6/28/2018 4:32 PM, Dan Murphy wrote:

> Fix a bug where INT_STAT1 was written twice and
> INT_STAT2 was ignored when disabling interrupts.
                              ^^^^^^^^^
    Correct here, but typo in the subject.

> Fixes: b753a9faaf9a ("net: phy: DP83TC811: Introduce support for the DP83TC811 phy")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
[...]

MBR, Sergei
