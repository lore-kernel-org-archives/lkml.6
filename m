Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59B3C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 20:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8CD206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 20:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oV//3ksf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8CD206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeI3DGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 23:06:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35444 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727744AbeI3DGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 23:06:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id v133-v6so6816798pgb.2;
        Sat, 29 Sep 2018 13:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=pIREm9pIRvgOfyjyB+FWR/CUwTqNSb6e3QH1jZm1fW4=;
        b=oV//3ksfD6sXBKfJacjHAao3qc1DUW/EOUYrn4ZqNOvgDqAyQlelBXSHI/WNzCQ64x
         ZLWBQCchvJQNLDvwucIpLLPIOac/fqU4iMCV5sShS5CHv/Sb58Ivtw+f9jlyYDSU/yB3
         WoE/VnCVGKkRDCFXqRGLa+0D2d7nkxKHtiIqAg39OplzfjcOF3r+d5I8WN2PG1NuNclb
         8A5kHWfnVnGpWrb8Qg3hCZg3n5XF7O+wCU7BBN83g9+eQni54nUG5Du7SJGq1wMeK4/j
         PZq6k9kieVH3DCmr29jQj2vUhUvQDQFfnD4DeY0X2wtGPeSnRmHyNU0b7O2ArcE50uPO
         1JTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=pIREm9pIRvgOfyjyB+FWR/CUwTqNSb6e3QH1jZm1fW4=;
        b=XMNOCY6RI7U8EvM4csvXR1THrPN23+7YQmU2IaXeTElSRRgMplfyMp/m8yOwG1nKmQ
         bV2CvoqMDPwOWPvGetR7Zq6FQV+n2hPLZO2F/uz8ff1SYp1yyLU9TZ7zAhsso7xa2cjn
         1CkEFu5NzucransgPfrezn9sL+D49Gh5/wJvYKxGahgdXrcOARbiU/oj/FYqRCxMSFmt
         2hhMzAtdkW1+DlVgIEXMy0xdf0yqstFI1Bh+VEfDb1mHrGXG4xuO5K0ylIhinf4R/oSG
         v07JTX2w6uETzMWPDXPp/JOP/RwlOgeiz/jA9805rBN9LlTGhce0PYn/nLbbKAvH9jHw
         NVXw==
X-Gm-Message-State: ABuFfoiFMjGBU2CULNjGIZnyLk3Pw+xu8s3jzNrlqV5E6ftaOfJaJ5M+
        iKl6t5jz/O5OChVHgQQDkplLZxNA
X-Google-Smtp-Source: ACcGV60p0ILss46t+trY50/OSf5JgNxOxYcBZZ6JMD9TgG206YdPmcaAuFegJMzRb4/W9suM+y6I8Q==
X-Received: by 2002:a17:902:2d24:: with SMTP id o33-v6mr4468656plb.211.1538253395027;
        Sat, 29 Sep 2018 13:36:35 -0700 (PDT)
Received: from [192.168.14.54] ([12.70.68.218])
        by smtp.gmail.com with ESMTPSA id v84-v6sm2340360pfk.12.2018.09.29.13.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 13:36:33 -0700 (PDT)
Date:   Sat, 29 Sep 2018 13:36:29 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <1538197903-37168-1-git-send-email-zhongjiang@huawei.com>
References: <1538197903-37168-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] net: phy: Fix a unused function gcc warning.
To:     zhong jiang <zhongjiang@huawei.com>, davem@davemloft.net
CC:     andrew@lunn.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <E3868752-29CA-4D84-9E09-C7E238AFEF9E@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On September 28, 2018 10:11:43 PM PDT, zhong jiang <zhongjiang@huawei=2Eco=
m> wrote:
>Fix the following compile warning:
>
>drivers/net/phy/mdio-bcm-unimac=2Ec:321:12: warning:
>'unimac_mdio_suspend' defined but not used [-Wunused-function]
> static int unimac_mdio_suspend(struct device *d)
>            ^
>drivers/net/phy/mdio-bcm-unimac=2Ec:330:12: warning: 'unimac_mdio_resume'
>defined but not used [-Wunused-function]
> static int unimac_mdio_resume(struct device *d)
>
>Signed-off-by: zhong jiang <zhongjiang@huawei=2Ecom>

Thank you, Arnd already sent a patch for this which got accepted:

https://patchwork=2Eozlabs=2Eorg/patch/975088/
--=20
Florian
