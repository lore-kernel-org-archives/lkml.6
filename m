Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACBBC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C3123DE6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lA0FbKLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C3123DE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeGBOsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:48:42 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43961 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752185AbeGBOsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:48:39 -0400
Received: by mail-lf0-f68.google.com with SMTP id m12-v6so11689324lfc.10;
        Mon, 02 Jul 2018 07:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTHQDLVi6dKQz3GlkDB1pFF37+DXeW7OEAhd9Iap5ak=;
        b=lA0FbKLHM94Plq182uzrWn+uhmulSi7HAGOA6yLUSXMmRJDJyWSLFSXL8khuqgAJvr
         RyMlNwzlfWKBfdokFxRDPKDMKGxAXWAGfFcDOGD/47vAMg11IsQYkB2WCYpc7uYS4fkB
         Q/6p8Gw5kJO+OvVSDGoNMG9fYqQShJ2etJvnGhRvtfX1x+NP9ioQVJP04KkqJ7eZsbgk
         wLNs/0xwP/3jgzN+/H9XTfTFKzEQjoZ8Vb/F5Ikc9o6w3ySOGQN+I2KyNwLQHxS4iap+
         qrjMlU38ct8W/ATgbKJUW2Ye2eGeBlIgsZil9S4Ui97TQ5ok6scdrChQ1jhMaOeAtn2/
         ptcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTHQDLVi6dKQz3GlkDB1pFF37+DXeW7OEAhd9Iap5ak=;
        b=KjtZgPZ7Vksll3VLjGslh0k9DljCWsOccixS6ueBTWsshIG7yvF/O9xl0emu/rgUfU
         A7SqvUuH6Kewq3zSG3MqMHv8m+5YDITWsONb5Lfy3JlsIyh9vjbmTEEFqvxBLKoQ08KZ
         aN3uX4AFqn8SP68HRAx40FbqUnKVk3cqtuo1vyiaxsZGER7oHpCF1K6PUb7SuSza1Xq+
         /ovH7ZxnoOj6BtfZAZ2CRAaycm1ZK+H6ObyoWA1PJiQAEr9Iate12A0H/bygZLEfrYjo
         9m1ztTiDK64nsyE7148k210/Ru4CH5x02hhjG4i3Yb2xjeP52BI8E4A898Wrt4+YmoqV
         LmcQ==
X-Gm-Message-State: APt69E3KvvQqAQ5XJqDVqG/+0WXh69niLAZlJCI0k75W9rKXO2ZQ1z8Y
        5KWAt7lin+nn27dp0WaJ1iY=
X-Google-Smtp-Source: AAOMgpf3IBVQxwrukcl1aPLTlrAT+TQgjwtQgMG5YRY+7+4qXititxPB+d9B5veW95cXDyzmnUlLeA==
X-Received: by 2002:a19:dedb:: with SMTP id i88-v6mr17821901lfl.26.1530542917687;
        Mon, 02 Jul 2018 07:48:37 -0700 (PDT)
Received: from dimapc.localnet ([109.252.91.84])
        by smtp.gmail.com with ESMTPSA id d75-v6sm3221072lfg.76.2018.07.02.07.48.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 07:48:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v2 0/5] Initial support of Trusted Foundations on Tegra30
Date:   Mon, 02 Jul 2018 17:48:36 +0300
Message-ID: <11534185.70fb5jbPr6@dimapc>
In-Reply-To: <d99935be-797d-4676-c186-a045a590f01b@gmail.com>
References: <20180619110027.16935-1-digetx@gmail.com> <d99935be-797d-4676-c186-a045a590f01b@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 29 June 2018 22:37:02 MSK Peter Geis wrote:
> Good Afternoon,
> 
> I have tested these patches on the Ouya T3 device.
> They work great to enable the L2 cache controller, however they do not
> respect explicitly disabling the L2 cache controller via the kernel
> config nor device tree.
> 
> With CONFIG_CACHE_L2X0 disabled, but CONFIG_TRUSTED_FOUNDATIONS enabled,
> the L2 cache controller is silently enabled and allows all four cores to
> boot.
> 

I don't see how cache could be enabled with CONFIG_CACHE_L2X0 disabled, there 
is no code to do that. Could you elaborate please?

Secondary cores do not depend on the cache state, disabled cache shouldn't 
prevent them to boot.

> One must also disable CONFIG_TRUSTED_FOUNDATIONS to stop the L2 cache
> controller from spinning up.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> 




