Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627FAC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0115620833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFVvN3sT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0115620833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeILUJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:09:30 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39179 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbeILUJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:09:30 -0400
Received: by mail-lf1-f67.google.com with SMTP id v77-v6so2000172lfa.6;
        Wed, 12 Sep 2018 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EfmF5rnZsA8UZXxcsYOpARFBCLiQHgR/1Y1491vQUYQ=;
        b=bFVvN3sT786agduS8FqJdpkQcxxMsiUdiS1ElCP2sOnyQviYNKqR4HyVG1rJNItFxW
         QMx975k8srG+VnhpqLsYa7nDhAMw+DvR6jfPEsROzFtnSNyKgFsB6kjm6HnJPCnknn0r
         qim4GcpN7grODDaKyBEdr5jhd2tokdK+LVMWzqqkhzcYnhPM1mkcLwpRLA/3KdvmWe7z
         hAxR2U0AT2SUwcx1rbh5JWvttlzQ0Rt0lp7VnQLRskskDWPrY/o/pQjk3BS3ynKJ/AMP
         2khRbuJXKERFoTICQlVsQQngIicsRgNsbRzC4b6XlQUUw6O91a8fmC4By/C7zW+Fo/xY
         sJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EfmF5rnZsA8UZXxcsYOpARFBCLiQHgR/1Y1491vQUYQ=;
        b=KGmtlzkOuuBi30HrJYTOaM4t7sCfL4QXQG6xrqZOKXGfJ0hoXV/bjKE/lfSjEUoxYo
         Pe+bhSkwPW6o3f8ZBNEMw06EGxTeO5Vlt0OQGQco2md6LSl9Dt2cDp6zjk6BIYyTt38k
         8DQTdNXh0I6z1npWxu7LqvmhATGt6RMNAUtVdeCg/jt8qo2yFiVq1b7a+d5/7yVbg6z7
         scUHyeG+bOLoWiPqu8I3arFt/omMD+pGdYTkO68I9qCD1UE72ON0WOhRKvqpmco4eh7W
         soyGnOBTs0lE690PN2pEaGKna0+GpBWeaJnTB4NyqJxhYebin5GsxY08OsFOKzJaLUQy
         gKLQ==
X-Gm-Message-State: APzg51CFNoQb6jgfoBJz+E0g/wFckMCbk74zyjMV967V/F5XJaWNZsBt
        RykXELnPUpYpXXkBbf0Xtq51FPjUmII=
X-Google-Smtp-Source: ANB0VdYB+Dx3XxsvidfYF8iBN+uYfYEtMt/cbQHFhaFGDsyEty/a3x1Lkwndn8yItrRCXi3p7P2Icw==
X-Received: by 2002:a19:3855:: with SMTP id d21-v6mr1827010lfj.24.1536764672832;
        Wed, 12 Sep 2018 08:04:32 -0700 (PDT)
Received: from ?IPv6:2001:14bb:73:639a:d135:7d7c:caf7:1c82? (drqv51zl1s10p1948tk-4.rev.dnainternet.fi. [2001:14bb:73:639a:d135:7d7c:caf7:1c82])
        by smtp.gmail.com with ESMTPSA id u2-v6sm215769ljg.55.2018.09.12.08.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 08:04:32 -0700 (PDT)
Subject: Re: [PATCH v2] ethernet: hnae: drop adhoc assert() macros
To:     David Miller <davem@davemloft.net>
Cc:     igor.stoppa@huawei.com, huangdaode@hisilicon.com,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180908150142.27976-1-igor.stoppa@huawei.com>
 <20180911.230716.1048852895308106303.davem@davemloft.net>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <2f439541-154f-1f17-180e-db0d8f95e010@gmail.com>
Date:   Wed, 12 Sep 2018 18:04:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911.230716.1048852895308106303.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/18 09:07, David Miller wrote:
> From: Igor Stoppa <igor.stoppa@gmail.com>
> Date: Sat,  8 Sep 2018 18:01:42 +0300
> 
>> Replace assert() with a less misleading test_condition() using WARN()
>> Drop one check which had bitrotted and didn't compile anymore.
>>
>> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> 
> I'm still kind of not happy about this.
> 
> Make the driver use kernel interfaces like WARN_ON_ONCE()
> etc. directly instead of defining alias CPP macros private to the
> driver.
> 
> If it needs to be conditional upon DEBUG, we have pr_debug() and
> the likes as well.

WARN_ON_ONCE() will display the error message only once, but from its 
implementation it looks like it will evaluate the condition anyways, 
every time, unless the compiler can do some magic and somehow know that 
the condition was true already onece (/include/asm-generic/bug.h:146)

pr_debug() otoh, will print or not print, depending on 
CONFIG_DYNAMIC_DEBUG being set or not (/include/linux/printk.h:399)

but the logic we are trying to clean up here seems a bit different:

if (in_debug_mode && error_condition_is_verified)
	generate_warning()

Which, I guess, is meant to completely remove *any* test outside of 
debug mode.

That is why I used the test_condition() macro, instead of using directly 
WARN_ON_ONCE().  Admittedly, it probably would have been better to 
depend on CONFIG_DYNAMIC_DEBUG.

Neither using WARN_ON_ONCE(), nor pr_debug() seem to replicate the 
initial behavior of the code that is currently in the tree, with assert().

How would you suggest that I keep the same behavior, without the helper 
macro? I am probably missing it, but I do not see some facility that 
would support the double condition I described above.

--
thanks, igor
