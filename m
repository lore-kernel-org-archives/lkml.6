Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FFBC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AEB22084A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKBebF9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AEB22084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933419AbeGJMSq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:18:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39897 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932620AbeGJMSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:18:44 -0400
Received: by mail-lj1-f194.google.com with SMTP id t7-v6so16560814ljj.6;
        Tue, 10 Jul 2018 05:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OTUt25qtOh+ws7LD2He/O2BSA6/nfkQyG0awGM0qBM0=;
        b=LKBebF9GZrhBrnvNR4ngR1B3tMY7z9BgE+ewBYzIMHfw8ZV0fG9J0rR7WgZnOsIYHY
         cy4I1BECPq/K+LqrSsJEHT73/FiKI9yy19DbXinFFHIoOPEZsTfnXjn9sK/4b92wbevc
         2mZ+Z5xl/9HWHa6jTZ8eK132CJVd/7tRT974xOA/BqFDuI38K+MxCvcJW4KeuFz6qIln
         skzgRvlHzxuGxlIxZWcPJK8/PCWi/OW8YlXMi9WBPIaCA08Hck5AqQlzvPqyMdVYpNH9
         TRo9HGAxIQxvx3twB9q6pSzm49p8W72qt8tvykl/r7pAGVHTOpt4fG5My4BRpE6/UmUk
         knxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=OTUt25qtOh+ws7LD2He/O2BSA6/nfkQyG0awGM0qBM0=;
        b=N4IhiiCOvdE8Gu4epKdHHw/imfEt2ibLVYiVs/cQYazp4kcau0WodJAZQbBxkQRE+7
         IBO2OaJA7M0yv/pEyGjLSgTNwIoJu3EH//Kmv4NLcF75WVydrGyrv0TD8uU7jM6r3Mq7
         5utacxysn0tKFR32pLgc1OqpCVhJB3GzvwZfEpDzQNteMk1OhX1GsPmq+mKLyS5PpWnc
         cPa8dg++fWkqep80PNigURzWUv7Py3LNpf8z4ovwoUrdN4wbKNG1+OrKdCtdaZqzGm4K
         6E1k/VkN+BHveVmkbs6xPznLupTSCnJS2xj7ypaTAj1t0UbexGm3PEIyyFBBv/wRDZK4
         4X5g==
X-Gm-Message-State: APt69E3VcifO36yAH7afU8u8pclelI5zUKASZgxj594zSipEjVuVV772
        bOwa6yI/woTPWE5Ylb3dJiMCd2iq
X-Google-Smtp-Source: AAOMgpdTuI1WhF0kFZkN0+q4Gg07nl0qXhH93eUAQ1lx6ni4zfGqIHF2Cs5CbrBkmoeqnmhhNdYfqw==
X-Received: by 2002:a2e:59d1:: with SMTP id g78-v6mr16385475ljf.79.1531225122296;
        Tue, 10 Jul 2018 05:18:42 -0700 (PDT)
Received: from acerlaptop.localnet (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.gmail.com with ESMTPSA id u16-v6sm3910216lfi.12.2018.07.10.05.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 05:18:41 -0700 (PDT)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Subject: Re: [PATCH v4 0/5] Initial support for Samsung Galaxy S and Galaxy S 4G
Date:   Tue, 10 Jul 2018 14:18:39 +0200
Message-ID: <5549799.hqpipYcP1I@acerlaptop>
User-Agent: KMail/5.1.3 (Linux/4.15.0-24-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <20180710120504.GB6884@amd>
References: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com> <20180710120504.GB6884@amd>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 10, 2018 2:05:04 PM CEST Pavel Machek wrote:
> Hi!
> 
> > This patch series adds support for Samsung Galaxy S and Galaxy S 4G.
> > Both are commercial phone based on Aries family.
> 
> Thanks for doing this. What kind of userspace are your running?
> 
> (I do have N900 here running Debian and PostmarketOS, and Droid 4
> running Maemo Leste)

Currently i'm running arch linux arm (but wanted to try PostmarketOS also).

If anyone is interested/wanted to help:
https://github.com/PabloPL/linux -> all kernel development is done here (there are more working things than in this patchset)
https://github.com/xc-racer99/u-boot-galaxys4g -> here is initlal port of uboot for aries family. It can be flashed as kernel (more details in wiki)

> 
> Best regards,
> 							Pavel
> 							
> 
