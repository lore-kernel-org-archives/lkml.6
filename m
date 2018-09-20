Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64435ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1202021525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="aVy5Qd9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1202021525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbeITQGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:06:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34247 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeITQGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:06:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so7877378ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 03:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/2igOQrjn5C6Qm8++PiKaPBsfWOA0JdnvxaxELqJHrc=;
        b=aVy5Qd9Ysmdrulvys0me8KuPdIyWZ0kXWuwFbxXP9jBmq+hbVIKIcaAUq69fLW/wcz
         V9Q8r+sHAVXeWbXYghu/bvWfIQOdMwcBuyCP6NeoFlZl1M5WWvSZj8WcyY5je/tiz8Im
         s+hpWqoZFTptl9JqA4Qm222sFW73wl8iL+eLNIXS5OOZVDKsFC2ZXkbXoTuNSYxTDk9V
         IHM51yqhL12n/NgPic/DQ2Igf3EBLEvbstUZEc8WyiqyN/VDQ+xBH9Id7CbjShNMQb7W
         1S7ZxZ2q5Wz8+eCnQtsBMU9EXaQjrXm+Xl5mlYkX4WATB/Qkawtt6c8R2hK8il+oyLwb
         Ayvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/2igOQrjn5C6Qm8++PiKaPBsfWOA0JdnvxaxELqJHrc=;
        b=BRdFS/hZV0ST3wrkt5DYwy2AWp9+Ylg1eqsi6HWhP2yFixOy8djjqe2uiwDfnXysAI
         8GJ2m7rmpQkULY/sZbvSZ0qOYE3PMLrGfFzyB1PHkBqQFODiD4M+JMDqYlT6xaT2K6Bo
         J7mkJZki89Wdp8WI8ZD3LcP+YqeWJqMiARe3bt70TXR7xBG17a1mv/iSOUoGQkkTO8/r
         EEuX0A+YxSPl6u45NY96QJN0DjJZD5GnPhW0QMBdR3I4KqyQEjmH6hqN9RZtwR/qFEC1
         YjNeX7VWC8ysT3ltQvHH9bAZJX1E9K+3Lfq0j+YpSQqUWj4ip7kjd1YgXzyXkDYdl8p+
         bVkQ==
X-Gm-Message-State: APzg51Ct9J7Jyb1Z+tB8Mq99zbF59rnnLv4VaGWvMX1opijvjk+mPd6j
        Oc2LBhJyBnRstRogzf4sVqsfIeBICb0=
X-Google-Smtp-Source: ANB0Vdb2CEF87ALUNgtvFbqNHqd1oGguL0bMPmMYLBiCfjl+gPFlAlZY4UcMS/NhbXzk59TqjBDR2A==
X-Received: by 2002:a2e:5c07:: with SMTP id q7-v6mr20279338ljb.119.1537439014143;
        Thu, 20 Sep 2018 03:23:34 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.87.42])
        by smtp.gmail.com with ESMTPSA id o72-v6sm1650028lfg.31.2018.09.20.03.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 03:23:32 -0700 (PDT)
Subject: Re: [PATCH] net: toshiba: remove a redundant local variable
 'index_specified'
To:     zhong jiang <zhongjiang@huawei.com>, davem@davemloft.net
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1537408565-22315-1-git-send-email-zhongjiang@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <17fba403-b5be-a406-bb25-4a0c2c4f27ca@cogentembedded.com>
Date:   Thu, 20 Sep 2018 13:23:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537408565-22315-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/2018 4:56 AM, zhong jiang wrote:

> The local variable 'index_specified' is never used after being assigned.
> hence it should be redundant adn can be removed.

    s/adn/and/.

> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
[...]

MBR, Sergei

