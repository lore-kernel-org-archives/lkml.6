Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC51ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76AA020C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="xpWW6oTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76AA020C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbeGQKIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:08:53 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34042 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbeGQKIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:08:52 -0400
Received: by mail-lf0-f68.google.com with SMTP id n96-v6so361358lfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 02:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oqxkWcRxBMfo/zP/kCfOB/czMGRIlqWHAllG89WBNzE=;
        b=xpWW6oTstwopWDBEXmYynYpQMwcACojTiWKVTEmNCZmXeX1yBBiq1+QCxP7ACDeO07
         IWwhZb+3k2UT6//2JExYJuBJk1FPlbvu3r3ncRWbO4t8L52Yvbmydw63Ltb7ONxy4dZz
         lCb9NxpmlmJ8rR5RnAiXc+rKXRQ7oMMWDP9P/FmR3bd2U1DvvTNDvixueSd+7hQqP3f4
         O6VHJOn2FXThN57fOdKv9ZRM2OECkxVaQZhKPmaSTy2Z+9GRGNx8o0g9sx4S2XJEiPuz
         BzzGbpEAm+yB+E66sgpad1S9UawM0aE2e3KokAe58R9PQjmUWDgF1TBNizdMuFgS6o/8
         tH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oqxkWcRxBMfo/zP/kCfOB/czMGRIlqWHAllG89WBNzE=;
        b=XjqXWsCxLe0j/V6IwKM7H53meANGu+0Bo32ptUF9enOc3iK050twoME5Kg7IYVNrI7
         hmGMIIwqzP7DChMOkI0k6IdV7NcuTCCISsTKdFBdqtmWU8vga84IYuFlOQgiJnU8rwdS
         JmTBh2hZer1Tv7I9zeFak69OlP5TatB/coqTr83Iw9B06HWiodWMmZ9+9EP267yMYTvZ
         3D338fGnkI7PO6KS5qUcAVl4Bf/ocTrBH112vLcJVD/BKc6S0h5m2vaKKNK0NiMsc7qe
         VDcOJNlPyh/SVRbHmG2uu4nkagB6VippcneAus47p/45PMCw1ip67jcqCKN2beBukNea
         s1+Q==
X-Gm-Message-State: AOUpUlFM/9bO3yYJOA/fu+wGtq8ozos1irLRD2FRpZzcCZ2mH7n8SJ+q
        6BwbFzlIB8PF0hPqvT/usFjtkq7Qv3A=
X-Google-Smtp-Source: AAOMgpejhhRmD+vCIYsN/erZBmST4gNBfdU1T1bUETf32VAwEqfnJU2uoUUZCTLzmY43wDwKIIi5Hw==
X-Received: by 2002:a19:138b:: with SMTP id 11-v6mr790129lft.74.1531820227536;
        Tue, 17 Jul 2018 02:37:07 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.86.160])
        by smtp.gmail.com with ESMTPSA id q65-v6sm84841lfb.80.2018.07.17.02.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 02:37:06 -0700 (PDT)
Subject: Re: [PATCH net-next 7/9] net: hns3: Fix for reset_level default
 assignment probelm
To:     Salil Mehta <salil.mehta@huawei.com>, davem@davemloft.net
Cc:     yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil@opnsrc.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        Yunsheng Lin <linyunsheng@huawei.com>
References: <20180716153627.476-1-salil.mehta@huawei.com>
 <20180716153627.476-8-salil.mehta@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <5b83ce92-a9bd-df76-4566-f5b2e1cce86e@cogentembedded.com>
Date:   Tue, 17 Jul 2018 12:37:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180716153627.476-8-salil.mehta@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 7/16/2018 6:36 PM, Salil Mehta wrote:

> From: Yunsheng Lin <linyunsheng@huawei.com>
> 
> handle->reset_level is assigned to HNAE3_NONE_RESET when client is
> initialized, if a tx timeout happens right after initialization,
> then handle->reset_level is not resetted to HNAE3_FUNC_RESET in

    s/resetted/reset/.

> hclge_reset_event, which will cause reset event not properly
> handled problem.
> 
> This patch fixes it by setting handle->reset_level properly when
> client is initialized.
> 
> Fixes: 6d4c3981a8d8 ("net: hns3: Changes to make enet watchdog timeout func common for PF/VF")
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Signed-off-by: Peng Li <lipeng321@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
[...]

MBR, Sergei
