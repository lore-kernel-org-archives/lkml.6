Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C3CC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC5D2083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 07:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="ln1Wz5u1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfBCHm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 02:42:28 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42466 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfBCHm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 02:42:28 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so8030975lfh.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 23:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=akkTqEE5dC2Sv2Xon2DK4qQVEA38LLXAjbQqP/ga6hk=;
        b=ln1Wz5u1UGdty4xklQ1i6Ot19QStn9F0NmbuqnQps1FE1EJtAwQULv/8Efl5N0+yi9
         8k2PN4sdRYKOQuKj0maepsQi5MmPcHZPJP1JFXOeHtQvgNLw4zNJsFc6pV5pJSdEi4eA
         fJUar5He0LN2lmvu970nhxpZnjm2Iu1j6JLXy9F9oiG43gF1SW12XXx0ZEHwFV+W4B3j
         R6a4nBuJcd3i77ZXHIAgxMZRtvgwuOrCuutXSL3I9fzgwLbu7njfctaD0Ope4uD/rdHv
         qccXL822aIOBsY3ex5hwc4vnPn+uCTolptHAdfOxJlSQ5lAgMtkOuJ/VBnwPg0ZDor/q
         oU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=akkTqEE5dC2Sv2Xon2DK4qQVEA38LLXAjbQqP/ga6hk=;
        b=KT4kTmzkyQyRUV4KbPmwYzq0zEyk+ROL07tc6NyShxX9qKpYFcFnM8a4i8sv20RynH
         sfUtWgWxSYmQc7XkZ6Wiylefva7d297UzC0cyCKU9U0ChiXo9/o2g+02rOjUhBVClWLN
         5WenONG2KbtTiFogmYtzRtFosfKFoYyOY3750uVIa7jlpdqo1f2IBBy8uVXBJtzbt633
         aYFWyDYjWYV4e02qvZHpD4ndV/cwXbENpOj7DbhDLhjbCAnJGe3vFvM4VdCfVCH/CPQN
         6NQrNDE4ZbOQiW5CAWT1r3bXllJkqQHkjYRf0MfSN/qLANOP7YHE7Jm/2fmEJNn5YG3P
         lJDw==
X-Gm-Message-State: AHQUAuajkVVcHSHcx0ekPUjvVlifgnuv70SUHncMhpj2ucYb1RjZuMeI
        iLP/Cirly42g/BUVp5XAjPhwxg==
X-Google-Smtp-Source: AHgI3IZXixS1GgUESOJWN4myUqOjZPCdFGJjBuKCtqfX5j9D0RoTv21QLgVZwcNxs6FDKKkZFlbJuA==
X-Received: by 2002:a19:aa87:: with SMTP id t129mr2830689lfe.139.1549179745902;
        Sat, 02 Feb 2019 23:42:25 -0800 (PST)
Received: from [192.168.0.199] ([31.173.83.134])
        by smtp.gmail.com with ESMTPSA id q10-v6sm2125200ljj.3.2019.02.02.23.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 23:42:25 -0800 (PST)
Subject: Re: [PATCH net-next 10/12] net: hns3: don't allow user to change vlan
 filter state
To:     Huazhong Tan <tanhuazhong@huawei.com>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        huangdaode@hisilicon.com, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, linuxarm@huawei.com,
        Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>
References: <20190202143937.8924-1-tanhuazhong@huawei.com>
 <20190202143937.8924-11-tanhuazhong@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <bd350807-9b8f-6f9a-75d6-63321993b189@cogentembedded.com>
Date:   Sun, 3 Feb 2019 10:42:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190202143937.8924-11-tanhuazhong@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 02.02.2019 17:39, Huazhong Tan wrote:

> From: Jian Shen <shenjian15@huawei.com>
> 
> When user disables vlan filter, and adds vlan device, it won't
> notify the driver the update the vlan filter. In this case, when

    To update, perhaps?

> user enables vlan filter again, the packets with new vlan tag
> will be filtered by vlan filter.
> 
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Peng Li <lipeng321@huawei.com>
> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
[...]

MBR, Sergei
