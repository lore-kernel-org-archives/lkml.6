Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B578C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CA9206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BN/zgRaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CA9206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeI2BVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 21:21:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36416 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbeI2BVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 21:21:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id b7-v6so4917803pfo.3;
        Fri, 28 Sep 2018 11:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t8cvk33696EpPlCMFNiCTcIEesbPVe5Es2lfZq4TIX0=;
        b=BN/zgRajG1Qrs8lwBls3rsnhA2sfSY1xaKoMMtSHBca7h/yAHsK9HYWyiueMuntIhE
         CrLdaUf2G8tPuTpXIOesA5VVOcoL6qtkg5eVxYUWNrycpjZLuQStX3rUKiP1m0+7n4SI
         3/S0tRx8dyHIr5u+C+NxTzlbZgFNoOIwAgqoZe2myN5st+C1HIbNM1eCbb/OH9RhOuwy
         t46e4HZg5M8KEqRlhfFh1lh96R+4vC27FNiTFCQfZWvuVbUVcxXZEgtRSsore5A16DNl
         DwVhwKRESC1g5suHItl5ZDLkzy2dufesQGWTugQKHQWC/Nvb55Ct404FI8g9Tg5HmkgB
         BfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t8cvk33696EpPlCMFNiCTcIEesbPVe5Es2lfZq4TIX0=;
        b=Yy1kI3AVpDqkQadCX6wDXMyYqjyn8tlBhXiIoIRNyie0fb7THdUk1Rh+fjc4JEG16w
         KTHybl0achX8AARFO2zyE1lAsrWCuu6x0OtyOwhIbeBrTyqdlO0Wa+lmfzwGqT6mToYP
         cVAgG9hdeca3E72jzpL4KTrE1fxfe0iC++teftngaCJbJBeut4IUiHNrEaDBRWSd413e
         cw8usab2uic4jtOo3H0x2w5z/7Q6Z42nb0ozmRRn0G2yGFIHRZZs8RC9LOVx+d2bbjv4
         pR7hNkpKWaX5c5MkAeGv4X/KKtHnOLYsWxpEet9IHCTwPDqCSla108uC8jBZMatZAc9+
         VJdQ==
X-Gm-Message-State: ABuFfoir8X5WUt22khkh6279gWmAZy70QVDdVgNwT0y2VVz4WgafNBH4
        BXrqE/NKzVxjur/f57/3vuo=
X-Google-Smtp-Source: ACcGV61Pso4hQ55zv+L4Kmjda3WxQhhxDwYyuPF4v7ltAeCpQlQ6Gpe17cXDQ5rA4wPgoe8je+Al1A==
X-Received: by 2002:a63:5a0d:: with SMTP id o13-v6mr16380570pgb.267.1538160974576;
        Fri, 28 Sep 2018 11:56:14 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id o12-v6sm10246436pfh.20.2018.09.28.11.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 11:56:13 -0700 (PDT)
Subject: Re: [PATCH net-next 00/10] Cleanups, minor additions & fixes for HNS3
 driver
To:     David Miller <davem@davemloft.net>, salil.mehta@huawei.com
Cc:     yisen.zhuang@huawei.com, lipeng321@huawei.com,
        mehta.salil@opnsrc.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
References: <20180926182840.28392-1-salil.mehta@huawei.com>
 <20180928.103826.486456665561471777.davem@davemloft.net>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <8cc644da-f6f2-9dd4-8f97-b1fa6d9deae7@gmail.com>
Date:   Fri, 28 Sep 2018 11:56:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180928.103826.486456665561471777.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/28/2018 10:38 AM, David Miller wrote:
> From: Salil Mehta <salil.mehta@huawei.com>
> Date: Wed, 26 Sep 2018 19:28:30 +0100
> 
>> This patch-set contains cleans-ups, minor changes and fixes to the HNS3 driver.
> 
> Series applied, thank you.
> 

Something seems wrong

# git grep -n HNS3_SELF_TEST_TYPE_NUM
drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c:278: int st_param[HNS3_SELF_TEST_TYPE_NUM][2];
drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c:316: for (i = 0; i < HNS3_SELF_TEST_TYPE_NUM; i++) {

drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c: In function 'hns3_self_test':
drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c:278:15: error: 'HNS3_SELF_TEST_TYPE_NUM' undeclared (first use in this function)
drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c:278:15: note: each undeclared identifier is reported only once for each function it appears in
drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c:278:6: error: unused variable 'st_param' [-Werror=unused-variable]
