Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B1AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D0C20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="XL4RBstb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D0C20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeH2NJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:09:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46736 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbeH2NJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:09:02 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so3719025ljj.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 02:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0/ZaK8tC0ooopusEMYPsc+DPiIIUnqdOeWdN8qaMNXo=;
        b=XL4RBstbNl2aGncG/5q8yojFMGCy1a2Dx5r7QbAadL09VpXsNk2gxVNVs4PGZv4ws6
         tC1bHO8eVtBFunPaN0bi2TiFk95fPPrivTyUAOUnNDii1PTS7yylsLM0HCd0mGgcz8Ir
         DdmtBlj4fuVfU7+H1i3JX4x29BGJFwaNml7lD294mDJhTEqc7sX14WATbc0ue8XOWRdH
         rv5FM2/mM8LlC5LJaxyBiA0uNsc0CHTvPPhCG4nDJ7xA89VlZl5FzJ6YxycY0Qjg/89H
         zUEYV+leaOryUKDBOI7oUlrjJg8C1u5AFVxjT1Q33rnytiLVpJnEKaEILUkr5oYJdXoM
         g6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0/ZaK8tC0ooopusEMYPsc+DPiIIUnqdOeWdN8qaMNXo=;
        b=L+Vs8uRpU8X0GNCJAAgmZNm4C7OSrUkE6Rzm6KGzsL64xFkzmzlOmJvzg1Qs36lUui
         ZulFRWMCMsM51Lxh8I2lDfaBy/V6R6yKX8KjY7dS736vWP9jI+shq04lFk/jttzkG+Ws
         90unZetcq8Oj921QULTsFORu1tk39uR9fZJzFZjtbilYBgbBOrak8JgowU+yPPYYYHot
         0+J6gZsrx7QZyOVTl2eT0oEBUb+zHqLPRjnqHtanJihQPrVrqj0gv6s1uma8s2dQML4y
         n96ht7C8YsPpglehKQ6kmaBtN9pBABBJqqfCqfNen4V+Ncp4Wip7s6Q3OF0Toydr9w2B
         HA0g==
X-Gm-Message-State: APzg51DUdOifzk7Ux/1ePCg3Z0/cRr0McQ3U2ATTFq0aE2Ixi8aMLoU2
        cK+KxWM+JAI0Qe3UuuY6Ph959w==
X-Google-Smtp-Source: ANB0VdZ8Xvh4GfuwHgXcZRrAOWNqa0aprLKtwShoylgrFMbbOuc9OAw7s8TxW2dv1kov1ZmIrBuwAQ==
X-Received: by 2002:a2e:1248:: with SMTP id t69-v6mr3484173lje.129.1535533983771;
        Wed, 29 Aug 2018 02:13:03 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.83.85])
        by smtp.gmail.com with ESMTPSA id y16-v6sm626325lje.30.2018.08.29.02.13.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 02:13:02 -0700 (PDT)
Subject: Re: [PATCH 1/6] usb: xhci-mtk: resume USB3 roothub first
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <3bcc220aa54bfebc39cea54cd736388ad37ee0c5.1535510898.git.chunfeng.yun@mediatek.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <f144173b-6131-21cf-1ead-60d938ac289a@cogentembedded.com>
Date:   Wed, 29 Aug 2018 12:13:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3bcc220aa54bfebc39cea54cd736388ad37ee0c5.1535510898.git.chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/2018 5:55 AM, Chunfeng Yun wrote:

> Give USB3 devices a better chance to enumerate at USB3 speeds if
> they are connected to a suspended host.
> Porting from "671ffdf xhci: resume USB 3 roothub first"

    From commit 671ffdff5b13 ("xhci: resume USB 3 roothub first").
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
[...]

MBR, Sergei

